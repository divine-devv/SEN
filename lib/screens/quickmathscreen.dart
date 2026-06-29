import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/algebraprovider.dart';

class QuickMathScreen extends StatefulWidget {
  const QuickMathScreen({super.key});
  @override State<QuickMathScreen> createState() => _QuickMathScreenState();
}
class _QuickMathScreenState extends State<QuickMathScreen> {
  bool _deg = true;

  static const _kBg=Color(0xFF001212);static const _kSci=Color(0xFF004D50);static const _kSciTx=Color(0xFF00BCD4);
  static const _kNum=Color(0xFF001515);static const _kOp=Color(0xFF00838F);static const _kOpTx=Color(0xFF00BCD4);
  static const _kFn=Color(0xFF001515);static const _kEq=Color(0xFF006064);static const _kAc=Color(0xFFB71C1C);
  Widget _key(String lbl, VoidCallback fn, {Color bg=_kNum,Color fg=Colors.white,int flex=1,double fs=15.0}) {
    return Expanded(flex:flex,child:Padding(padding:const EdgeInsets.all(1.6),child:Material(color:bg,borderRadius:BorderRadius.circular(4),child:InkWell(borderRadius:BorderRadius.circular(4),splashColor:Colors.white12,onTap:fn,child:Container(alignment:Alignment.center,child:Text(lbl,style:TextStyle(color:fg,fontSize:fs,fontWeight:FontWeight.w500,letterSpacing:-0.2)))))));
  }
  Widget _row(List<Widget> k)=>Expanded(child:Row(crossAxisAlignment:CrossAxisAlignment.stretch,children:k));
  Widget _chip(String t)=>Container(padding:const EdgeInsets.symmetric(horizontal:5,vertical:1),decoration:BoxDecoration(color:const Color(0xFF6A8C45).withValues(alpha:0.35),borderRadius:BorderRadius.circular(3)),child:Text(t,style:const TextStyle(color:Color(0xFF4A6228),fontSize:10,fontWeight:FontWeight.bold)));
  Widget _scaffold(String d,String e,bool deg,VoidCallback tg){
    return Scaffold(backgroundColor:_kBg,body:SafeArea(child:Column(children:[
      Container(width:double.infinity,color:const Color(0xFFCDD8A8),padding:const EdgeInsets.fromLTRB(14,10,14,12),child:Column(crossAxisAlignment:CrossAxisAlignment.end,children:[
        Row(children:[_chip(deg?'DEG':'RAD'),const Spacer(),GestureDetector(onTap:tg,child:Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:3),decoration:BoxDecoration(color:const Color(0xFF8CA870),borderRadius:BorderRadius.circular(4)),child:Text(deg?'→ RAD':'→ DEG',style:const TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.bold))))]),
        const SizedBox(height:6),
        Text(e.isEmpty?' ':e,style:const TextStyle(color:Color(0xFF4A6228),fontSize:13),textAlign:TextAlign.right,maxLines:1,overflow:TextOverflow.ellipsis),
        const SizedBox(height:2),
        Text(d,style:TextStyle(color:const Color(0xFF1A2A08),fontSize:41.0,fontWeight:FontWeight.w500,letterSpacing:-1.5),textAlign:TextAlign.right,maxLines:1,overflow:TextOverflow.ellipsis),
      ])),
      Expanded(child:Padding(padding:const EdgeInsets.all(3),child:Column(children:[
        _row([_key('sin', () => context.read<AlgebraProvider>().sci('sin'), bg:_kSci, fg:_kSciTx), _key('cos', () => context.read<AlgebraProvider>().sci('cos'), bg:_kSci, fg:_kSciTx), _key('tan', () => context.read<AlgebraProvider>().sci('tan'), bg:_kSci, fg:_kSciTx), _key('log', () => context.read<AlgebraProvider>().sci('log'), bg:_kSci, fg:_kSciTx), _key('ln', () => context.read<AlgebraProvider>().sci('ln'), bg:_kSci, fg:_kSciTx)]),
        _row([_key('asin', () => context.read<AlgebraProvider>().sci('asin'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('acos', () => context.read<AlgebraProvider>().sci('acos'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('atan', () => context.read<AlgebraProvider>().sci('atan'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('√x', () => context.read<AlgebraProvider>().sci('sqrt'), bg:_kSci, fg:_kSciTx), _key('x²', () => context.read<AlgebraProvider>().sci('x²'), bg:_kSci, fg:_kSciTx)]),
        _row([_key('sinh', () => context.read<AlgebraProvider>().sci('sinh'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('cosh', () => context.read<AlgebraProvider>().sci('cosh'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('tanh', () => context.read<AlgebraProvider>().sci('tanh'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('x³', () => context.read<AlgebraProvider>().sci('x³'), bg:_kSci, fg:_kSciTx), _key('1/x', () => context.read<AlgebraProvider>().sci('1/x'), bg:_kSci, fg:_kSciTx)]),
        _row([_key('n!', () => context.read<AlgebraProvider>().sci('n!'), bg:_kSci, fg:_kSciTx), _key('nPr', () => context.read<AlgebraProvider>().combo('nPr'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('nCr', () => context.read<AlgebraProvider>().combo('nCr'), bg:_kSci, fg:_kSciTx, fs:13.0), _key('π', () => context.read<AlgebraProvider>().sci('π'), bg:_kSci, fg:const Color(0xFFFFD54F)), _key('e', () => context.read<AlgebraProvider>().sci('e'), bg:_kSci, fg:const Color(0xFFFFD54F))]),
        _row([_key('AC',() => context.read<AlgebraProvider>().clear(),bg:_kAc,fg:Colors.white),_key('⌫',() => context.read<AlgebraProvider>().back(),bg:const Color(0xFF3A1818),fg:const Color(0xFFFF8A80)),_key('%',() => context.read<AlgebraProvider>().pct(),bg:_kFn,fg:Colors.white70),_key('|x|',() => context.read<AlgebraProvider>().sci('|x|'),bg:_kFn,fg:Colors.white60),_key('+/−',() => context.read<AlgebraProvider>().sign(),bg:_kFn,fg:Colors.white70)]),
        _row([_key('7',() => context.read<AlgebraProvider>().digit('7'),fs:20),_key('8',() => context.read<AlgebraProvider>().digit('8'),fs:20),_key('9',() => context.read<AlgebraProvider>().digit('9'),fs:20),_key('÷',() => context.read<AlgebraProvider>().oper('÷'),bg:_kOp,fg:_kOpTx,fs:18),_key('×',() => context.read<AlgebraProvider>().oper('×'),bg:_kOp,fg:_kOpTx,fs:18)]),
        _row([_key('4',() => context.read<AlgebraProvider>().digit('4'),fs:20),_key('5',() => context.read<AlgebraProvider>().digit('5'),fs:20),_key('6',() => context.read<AlgebraProvider>().digit('6'),fs:20),_key('−',() => context.read<AlgebraProvider>().oper('−'),bg:_kOp,fg:_kOpTx,fs:18),_key('(',(){}  ,bg:_kFn,fg:Colors.white54)]),
        _row([_key('1',() => context.read<AlgebraProvider>().digit('1'),fs:20),_key('2',() => context.read<AlgebraProvider>().digit('2'),fs:20),_key('3',() => context.read<AlgebraProvider>().digit('3'),fs:20),_key('+',() => context.read<AlgebraProvider>().oper('+'),bg:_kOp,fg:_kOpTx,fs:18),_key(')',(){}  ,bg:_kFn,fg:Colors.white54)]),
        _row([_key('0',() => context.read<AlgebraProvider>().digit('0'),flex:2,fs:20),_key('.',() => context.read<AlgebraProvider>().dot(),fs:20),_key('EXP',(){}  ,bg:_kFn,fg:Colors.white54,fs:12),_key('=',() => context.read<AlgebraProvider>().equals(),bg:_kEq,fg:Colors.white,fs:22)]),
      ]))),
    ])));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AlgebraProvider>();
    return _scaffold(c.display, c.expression, _deg, () => setState(() => _deg = !_deg));
  }
}
