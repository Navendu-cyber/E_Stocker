// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 3;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      productid: fields[0] as String,
      productName: fields[1] as String,
      brand: fields[2] as String,
      color: fields[3] as String,
      stockcount: fields[4] as int,
      buyprice: fields[5] as int,
      sellprice: fields[6] as int,
      imageProduct: fields[7] as String,
      category: fields[8] as String,
      barcodeId: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.productid)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.stockcount)
      ..writeByte(5)
      ..write(obj.buyprice)
      ..writeByte(6)
      ..write(obj.sellprice)
      ..writeByte(7)
      ..write(obj.imageProduct)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.barcodeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
