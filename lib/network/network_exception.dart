class Failure {
  String? msg;

  Failure(this.msg);

  @override
  String toString() => msg ?? 'some error occured';
}
