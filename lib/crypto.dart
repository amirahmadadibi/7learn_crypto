class Crypto {
  String id;
  String name;
  String symbol;
  double changeInPersent;
  double priceUSD;
  double marketCapUsd;
  int rank;

  Crypto(this.id, this.name, this.symbol, this.changeInPersent, this.priceUSD,
      this.marketCapUsd, this.rank);

  factory Crypto.fromJson(Map<String, dynamic> data) {
    return Crypto(
        data['id'],
        data['name'],
        data['symbol'],
        double.parse(data['changePercent24Hr']),
        double.parse(data['priceUsd']),
        double.parse(data['marketCapUsd']),
        int.parse(data['rank']));
  }
}
