// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleModelAdapter extends TypeAdapter<SaleModel> {
  @override
  final int typeId = 4;

  @override
  SaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleModel(
      saleid: fields[0] as String,
      customerName: fields[1] as String,
      customerPh: fields[2] as String,
      customerAddress: fields[3] as String,
      pruduct_quantity: (fields[4] as List).cast<SellingProducts>(),
      totalPrice: fields[6] as int,
      discout: fields[5] as int,
      dateTime: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SaleModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.saleid)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.customerPh)
      ..writeByte(3)
      ..write(obj.customerAddress)
      ..writeByte(4)
      ..write(obj.pruduct_quantity)
      ..writeByte(5)
      ..write(obj.discout)
      ..writeByte(6)
      ..write(obj.totalPrice)
      ..writeByte(7)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
