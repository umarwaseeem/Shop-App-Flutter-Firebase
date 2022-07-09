class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;

    // return super.toString();  // instance of http exception
  }

}


