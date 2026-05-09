class GetSplashDelay {
  final int nim;

  GetSplashDelay(this.nim);

  Future<void> call() async {
    int delay = nim % 10;

    if (delay == 0) delay = 5;

    await Future.delayed(Duration(seconds: delay));
  }
}
