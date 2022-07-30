class Assets {
  static String mario({required int count, required String format}) {
    return "assets/images/marios/mario$count.$format";
  }

  static String george({required int count, required String format}) {
    return "assets/images/george/george$count.$format";
  }

  static String image({required String name, required String format}) {
    return "assets/images/$name.$format";
  }
}
