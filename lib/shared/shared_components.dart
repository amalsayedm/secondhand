

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


String? token;

void navigateTo(context,Widget widget){

  Navigator.push(context, MaterialPageRoute(builder: (context){
    return widget;
  }));
}

void navigateAndFinish(context,Widget widget){

  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context){
    return widget;},),(Route<dynamic> route){return false;});
}


Widget defaultFormField(
    { required TextEditingController controller,
      required TextInputType inputType,
      Function(String)? onsubmit,
      Function? onTap,
      required String labeltext,
      required IconData prefixicon,
      required Function(String) validator,
      bool obscureText=false,
      IconData? suffexicon,
      Function? suffexPressed,
      Function(String)? onChange,
    }
    ) {
  return TextFormField(controller: controller,
    keyboardType: inputType,
    onFieldSubmitted: onsubmit,
    obscureText: obscureText,
    onTap:(){ onTap!();},
    style: TextStyle(fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      labelText: labeltext, border: OutlineInputBorder(),
      prefixIcon: Icon(prefixicon),
      suffixIcon: IconButton(
        icon: Icon(suffexicon), onPressed:(){ suffexPressed!();}),),
      validator: (s){validator(s!);},
    onChanged: onChange,

  );
}

  Widget defaultButton({required String buttonText,required Function onPressed}){
     return
       Container(height: 45,
         width: double.infinity,
         color: Color(0xFF6E86B4),
         child: MaterialButton(textColor: Color(0xFFCCCCCC),
           child: Text(buttonText.toUpperCase(),),
           onPressed:(){onPressed();},

         ),
       );
   }

   void toast(String message,Color color){
     Fluttertoast.showToast(
         msg:message,
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 5,
         backgroundColor: color,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }

   Widget divider(){
  return Container(width: double.infinity,height: 1,color: Colors.grey,);
   }




