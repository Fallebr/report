class Item {
  int _id, _pemasukan, _pengeluaran, _pendapatan;
  String _code;

  String get code => this._code;

  set code(String value) => this._code = value;

  int get id => this._id;
  set id(int value) => this._id = value;

  int get pemasukan => this._pemasukan;
  set pemasukan(int value) => this._pemasukan = value;

  int get pengeluaran => this._pengeluaran;
  set pengeluaran(int value) => this._pengeluaran = value;

  int get pendapatan => this._pendapatan;
  set pendapatan(int value) => this._pendapatan = value;

  Item(this._code, this._pemasukan, this._pengeluaran, this._pendapatan);

  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._code = map['code'];
    this._pemasukan = map['pemasukan'];
    this._pengeluaran = map['pengeluaran'];
    this._pendapatan = map['pendapatan'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['code'] = this._code;
    map['pemasukan'] = this._pemasukan;
    map['pengeluaran'] = this._pengeluaran;
    map['pendapatan'] = this._pendapatan;
    return map;
  }
}
