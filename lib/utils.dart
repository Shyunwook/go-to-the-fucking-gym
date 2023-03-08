class Utils {
  static String decimalParser(double num) {
    var rounded = double.parse(num.toStringAsFixed(1));
    var remain = rounded % 1;
    if (remain > 0) {
      return rounded.toStringAsFixed(1);
    } else {
      return rounded.toStringAsFixed(0);
    }
  }

  static String durationFormatter(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
