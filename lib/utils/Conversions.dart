class Conversion {
  static double btcToUsd(double btcValue, double price) {
    if (btcValue < 0) {
      throw new ArgumentError("BTC value cannot be negative");
    }
    return btcValue * price;
  }

  static double usdtobtc(double usdValue, double price) {
    if (usdValue < 0) {
      throw new ArgumentError("USD value cannot be negative");
    }
    return usdValue / price;
  }
}
