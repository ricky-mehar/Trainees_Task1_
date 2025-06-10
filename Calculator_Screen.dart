import 'package:flup1/button_values.dart';
import 'package:flutter/material.dart';
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";
  String oprand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: SafeArea(bottom: false, child: Column(children: <Widget>[
          // output
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(16),
                child: Text("$number1$oprand$number2".isEmpty
                    ? "0"
                    : "$number1$oprand$number2",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          // buttons
          Wrap(
            children: Btn.buttonValues
                .map((value) => SizedBox(
                    width:value==Btn.n0?screenSize.width/2:screenSize.width / 4,
                    height:screenSize.width/16,
                    child: buildButton(value)),).toList(),
          )
        ],)
          ,)
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(100)),
        child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(child: Text(value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),)
            )
        ),
      ),
    );
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.per) {
      convertToPercetage();
      return;
    }
    if (value == Btn.calculate) {
      calculate();
      return;
    }
    apprndValue(value);
  }

  void calculate(){
    if(number1.isEmpty)return;
    if(oprand.isEmpty)return;
    if(number2.isEmpty)return;

    double num1=double.parse(number1);
    double num2=double.parse(number2);
    var result=0.0;
    switch(oprand){
      case Btn.add:
        result=num1+num2; break;
      case Btn.subtract:
        result=num1-num2; break;case Btn.add:
      result=num1+num2; break;
      case Btn.multiply:
        result=num1*num2; break;
      case Btn.divide:
        result=num1/num2; break;
      default:
    }
    setState(() {
      number1="$result";
      if(number1.endsWith(".0")){number1=number1.substring(0,number1.length-2);}
    });
    oprand="";
    number2="";
  }


  void convertToPercetage(){
    if(number1.isNotEmpty&&oprand.isNotEmpty&&number2.isNotEmpty){ }
    if(oprand.isNotEmpty){return;}
    final number = double.parse(number1) ;
    setState(() {
      number1="${(number/100)}";
      oprand="";
      number2="";
    });
  }

  void clearAll(){
    setState(() {
      number1="";
      oprand="";
      number2="";
    });

  }



  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if ( oprand.isNotEmpty){
        oprand="";
  }else if(number1.isNotEmpty){
      number1=number1.substring(0,number1.length-1);}
    setState(() {

    });
}



void apprndValue(String value){


    if(value!=Btn.dot&&int.tryParse(value)==null){
      if(oprand.isNotEmpty&&number2.isNotEmpty){
        //todo
      }
      oprand=value;
    }else if(number1.isEmpty||oprand.isEmpty){
      if(value==Btn.dot &&number1.contains(Btn.dot))return;
      if(value==Btn.dot &&(number1.isNotEmpty||number1 == Btn.n0)){
        value="0.";
      }
      number1 +=value;
    }else if(number2.isEmpty||oprand.isNotEmpty){
      if(value==Btn.dot &&number2.contains(Btn.dot))return;
      if(value==Btn.dot &&(number2.isNotEmpty||number2 == Btn.n0)){
        value="0.";
      }
      number2 +=value;
    }



    setState(() {
    });

}


Color getBtnColor(value){
    return [Btn.del, Btn.clr].contains(value)? Colors.blueGrey:[Btn.per,Btn.multiply,Btn.add,
      Btn.subtract,Btn.divide,Btn.calculate].contains(value)?Colors.orange:Colors.black87;
}

}

