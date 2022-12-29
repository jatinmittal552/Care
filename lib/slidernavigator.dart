import 'package:flutter/cupertino.dart';
import 'package:practice/customSilder.dart';
class SliderNavigator extends ChangeNotifier{
  double _isprogress =0;
  double get isprogress => _isprogress;
  void changer(double val){
    _isprogress=val*100;
    notifyListeners();

  }

}