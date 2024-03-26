class Conversion {
  static double btcToUsd(double btcValue) {
    if (btcValue < 0) {
      throw new ArgumentError("BTC value cannot be negative");
    }
    return btcValue * 69855;
  }

  static double usdtobtc(double usdValue) {
    if (usdValue < 0) {
      throw new ArgumentError("USD value cannot be negative");
    }
    return usdValue / 69855;
  }
}
