import 'package:flutter/material.dart';

class DashKeypad extends StatelessWidget {
  final void Function(String) onDigit, onOp;
  final VoidCallback onEquals, onClear, onSign, onPct, onDot, onBack;
  final void Function(String)? onSci, onCombo;
  const DashKeypad({super.key, required this.onDigit, required this.onOp,
      required this.onEquals, required this.onClear, required this.onSign,
      required this.onPct, required this.onDot, required this.onBack,
      this.onSci, this.onCombo});

  Widget _key(BuildContext ctx, String lbl, VoidCallback fn,
      {bool op = false, bool fn2 = false}) {
    final cs = Theme.of(ctx).colorScheme;
    final bg = op ? cs.primary : fn2 ? cs.secondary : cs.surfaceContainerHigh;
    final fg = op ? cs.onPrimary : fn2 ? cs.onSecondary : cs.onSurface;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: fn,
          style: ElevatedButton.styleFrom(
            backgroundColor: bg, foregroundColor: fg, elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(lbl, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  Widget _keyWide(BuildContext ctx, String lbl, VoidCallback fn) {
    final cs = Theme.of(ctx).colorScheme;
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: fn,
          style: ElevatedButton.styleFrom(
            backgroundColor: cs.surfaceContainerHigh, foregroundColor: cs.onSurface,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 22, top: 16, bottom: 16),
          ),
          child: Text(lbl, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(children: [
        if (onSci != null) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              for (final l in ['sin','cos','tan','asin','acos','atan','sinh','cosh','tanh'])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: ActionChip(
                    label: Text(l), onPressed: () => onSci!(l),
                  ),
                ),
            ]),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              for (final l in ['log','ln','√','x²','x³','n!','π','e','nPr','nCr'])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: ActionChip(
                    label: Text(l),
                    onPressed: () => (l=='nPr'||l=='nCr') ? onCombo!(l) : onSci!(l),
                  ),
                ),
            ]),
          ),
        ],
        Expanded(child: Column(children: [
          Expanded(child: Row(children: [
            _key(context,'AC',onClear,fn2:true), _key(context,'+/−',onSign,fn2:true),
            _key(context,'%',onPct,fn2:true),   _key(context,'÷',()=>onOp('÷'),op:true),
          ])),
          Expanded(child: Row(children: [
            _key(context,'7',()=>onDigit('7')), _key(context,'8',()=>onDigit('8')),
            _key(context,'9',()=>onDigit('9')), _key(context,'×',()=>onOp('×'),op:true),
          ])),
          Expanded(child: Row(children: [
            _key(context,'4',()=>onDigit('4')), _key(context,'5',()=>onDigit('5')),
            _key(context,'6',()=>onDigit('6')), _key(context,'−',()=>onOp('−'),op:true),
          ])),
          Expanded(child: Row(children: [
            _key(context,'1',()=>onDigit('1')), _key(context,'2',()=>onDigit('2')),
            _key(context,'3',()=>onDigit('3')), _key(context,'+',()=>onOp('+'),op:true),
          ])),
          Expanded(child: Row(children: [
            _keyWide(context,'0',()=>onDigit('0')),
            _key(context,'.',onDot),             _key(context,'=',onEquals,op:true),
          ])),
        ])),
      ]),
    );
  }
}
