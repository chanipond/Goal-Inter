import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:goalinter/data/book.dart';
import 'package:goalinter/states/book_service.dart';
import 'package:goalinter/utillity/my_constant.dart';

class CheckbookController extends GetxController{
  var dio = Dio();
  var book = '';
  Book_Model? book_model;
  
  var date = 'date'.obs;
  var typeField = 'typeField'.obs;

  getbook() async {
    try {
      var response = await dio.get('${MyConstant.domain}/goalinter_project/gettime.php?isAdd=true&date=$date&typeField=$typeField');
      print(response.data);
      // book = response.data;
      book_model = Book_Model.fromJson(response.data);
      
    }
    catch (e) {
      print('Error while getting data is $e');
    }
  }


}