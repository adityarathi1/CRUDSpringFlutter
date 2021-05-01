import 'package:http/http.dart' as http;

bool offline = false;

Future<String> callServer({String req, String service}) async {
  var url = "http://localhost:8080/student/";

  dynamic response;
  try {
    if (!offline) {
      response = await http.post(url + service, body: req);
    }
  } catch (e) {
    print(e.toString());
  }
  var jsonResponse =
      '{"status":false,"msg":"Unable to connect to server. Please check internet connection or contact admin."}';
  if (response != null && response.statusCode == 200) {
    jsonResponse = response.body;
    print('Response from http call : $jsonResponse.');
  } else {
    print('Request failed with status: $response.');
  }
  return jsonResponse;
}
