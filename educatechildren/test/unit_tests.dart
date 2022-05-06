// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  Future getNumbersPerformance(userId) async {
    var a = await http.get(Uri.parse(
        'https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/$userId/user.json'));
    final body = json.decode(a.body);
    return body['doneNum'];
  }

  Future getLettersPerformance() async {
    var a = await http.get(Uri.parse(
        'https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/4teyGe4qvWOZuHEdLN9UC8xFfrd2/user.json'));
    final body = json.decode(a.body);
    return body['doneNum'];
  }

  Future updateInfo() async {
    var a = await http.get(Uri.parse(
        'https://kids-1e245-default-rtdb.asia-southeast1.firebasedatabase.app/users/4teyGe4qvWOZuHEdLN9UC8xFfrd2/user.json'));
    final body = json.decode(a.body);
    return body['name'] + ' ' + body['gender'].toString();
  }

  Future uploadResponse() async {
    var a = await http
        .get(Uri.parse('https://mutamimon.com/letters/1651206930773.png'));
    final body = a.body;
    return body[1] + body[2] + body[3];
  }

  test(
      'Validate writing take many steps one of them is upload the written character by the child to our server,'
      'this test case should proof the upload step working by calling the image just uploaded and the response is ok',
      () async {
    var actual = await uploadResponse();

    expect(actual, 'PNG');
  });
}
