class CurrentValue {
  CurrentValue.internal();
  static CurrentValue instance = CurrentValue.internal();

  factory CurrentValue() {
    return instance;
  }

  String currentTitle = '';
  String currentAuthor = '';
  String curerntThumbnail = '';
  Duration currentDuration = Duration.zero;
  double currentAudioSize = 0.0;

  Future<void> addCurrentValue(
      String T, String A, String I, Duration D, double S) async {
    currentTitle = T;
    currentAuthor = A;
    curerntThumbnail = I;
    currentDuration = D;
    currentAudioSize = S;
  }
}
