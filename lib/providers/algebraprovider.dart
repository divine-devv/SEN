import 'dart:math' as math;
import 'package:flutter/material.dart';

class AlgebraProvider extends ChangeNotifier {
  String _display = '0';
  String _expression = '';
  double _operand = 0;
  String _op = '';
  bool _fresh = false;

  String get display => _display;
  String get expression => _expression;

  void digit(String d) {
    if (_fresh) { _display = d; _fresh = false; }
    else { _display = _display == '0' ? d : _display + d; }
    notifyListeners();
  }

  void dot() {
    if (_fresh) { _display = '0.'; _fresh = false; notifyListeners(); return; }
    if (!_display.contains('.')) { _display += '.'; notifyListeners(); }
  }

  void oper(String op) {
    _operand = double.tryParse(_display) ?? 0;
    _op = op; _expression = '$_display $op'; _fresh = true;
    notifyListeners();
  }

  void equals() {
    if (_op.isEmpty) return;
    final b = double.tryParse(_display) ?? 0;
    late double r;
    switch (_op) {
      case '+': r = _operand + b; break;
      case '−': r = _operand - b; break;
      case '×': r = _operand * b; break;
      case '÷': r = b != 0 ? _operand / b : double.nan; break;
      default: r = b;
    }
    _expression += ' $_display =';
    _display = _fmt(r); _op = ''; _fresh = true;
    notifyListeners();
  }

  void clear() {
    _display = '0'; _expression = ''; _operand = 0; _op = ''; _fresh = false;
    notifyListeners();
  }

  void sign() {
    if (_display == '0' || _display == 'Error') return;
    _display = _display.startsWith('-') ? _display.substring(1) : '-$_display';
    notifyListeners();
  }

  void pct() {
    final v = double.tryParse(_display) ?? 0;
    _display = _fmt(v / 100); notifyListeners();
  }

  void back() {
    if (_display == 'Error') { _display = '0'; notifyListeners(); return; }
    if (_display.length <= 1) { _display = '0'; } else {
      _display = _display.substring(0, _display.length - 1);
      if (_display == '-') _display = '0';
    }
    notifyListeners();
  }

  String _fmt(double r) {
    if (r.isNaN || r.isInfinite) return 'Error';
    if (r == r.truncateToDouble() && r.abs() < 1e15) return r.toInt().toString();
    return r.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  void sci(String fn) {
    final x = double.tryParse(_display) ?? 0;
    late double r;
    switch (fn) {
      case 'sin':  r = _sinD(x); break;
      case 'cos':  r = _cosD(x); break;
      case 'tan':  r = _tanD(x); break;
      case 'asin': r = _asinD(x); break;
      case 'acos': r = _acosD(x); break;
      case 'atan': r = _atanD(x); break;
      case 'sinh': r = (_e(x)-_e(-x))/2; break;
      case 'cosh': r = (_e(x)+_e(-x))/2; break;
      case 'tanh':
        final s = (_e(x)-_e(-x))/2; final c = (_e(x)+_e(-x))/2;
        r = c != 0 ? s/c : double.nan; break;
      case 'log':  r = x > 0 ? math.log(x)/math.ln10 : double.nan; break;
      case 'ln':   r = x > 0 ? math.log(x) : double.nan; break;
      case 'sqrt': r = x >= 0 ? math.sqrt(x) : double.nan; break;
      case 'x²': r = x*x; break;
      case 'x³': r = x*x*x; break;
      case '1/x':  r = x != 0 ? 1/x : double.nan; break;
      case '|x|':  r = x.abs(); break;
      case 'n!':
        if (x<0||x!=x.floorToDouble()){ _display='Error'; notifyListeners(); return; }
        r = _fact(x.toInt()).toDouble(); break;
      case 'π': _display=math.pi.toString(); _fresh=true; notifyListeners(); return;
      case 'e':   _display=math.e.toString(); _fresh=true; notifyListeners(); return;
      default: return;
    }
    _display = _fmt(r); _fresh = true; notifyListeners();
  }

  void combo(String type) {
    if (_op == 'nPr' || _op == 'nCr') {
      final r = double.tryParse(_display) ?? 0;
      final ni = _operand.toInt(); final ri = r.toInt();
      if (_operand < 0 || r < 0 || r > _operand) { _display='Error'; _op=''; notifyListeners(); return; }
      final nFact = _fact(ni).toDouble();
      final nrFact = _fact(ni-ri).toDouble();
      _display = type=='nPr' ? _fmt(nFact/nrFact) : _fmt(nFact/(nrFact*_fact(ri)));
      _op=''; _fresh=true;
    } else {
      _operand = double.tryParse(_display) ?? 0;
      _op = type; _expression = '$_display $type'; _fresh=true;
    }
    notifyListeners();
  }

  double _sinD(double d) => math.sin(d*math.pi/180);
  double _cosD(double d) => math.cos(d*math.pi/180);
  double _tanD(double d) => math.tan(d*math.pi/180);
  double _asinD(double d) => math.asin(d)*180/math.pi;
  double _acosD(double d) => math.acos(d)*180/math.pi;
  double _atanD(double d) => math.atan(d)*180/math.pi;
  double _e(double x) => math.exp(x);
  int _fact(int n) => n <= 1 ? 1 : n * _fact(n-1);


  final List<String> _history = [];
  List<String> get history => List.unmodifiable(_history);
}
