// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selling_products.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellingProductsAdapter extends TypeAdapter<SellingProducts> {
  @override
  final int typeId = 5;

  @override
  SellingProducts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SellingProducts(
      productId: fields[0] as String,
      productQuantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SellingProducts obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellingProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
