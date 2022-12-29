import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier{
  bool _iscollapased = false;
  bool get iscollapsed => _iscollapased;
   void toggleIsCollapased(){
     _iscollapased =! iscollapsed;
     notifyListeners();
   }
}