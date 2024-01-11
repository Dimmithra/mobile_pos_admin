class ItemSaveRespondeModel {
  String? status;
  String? success;
  String? message;
  Item? item;

  ItemSaveRespondeModel({this.status, this.success, this.message, this.item});

  ItemSaveRespondeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  String? itemcode;

  Item({this.itemcode});

  Item.fromJson(Map<String, dynamic> json) {
    itemcode = json['itemcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemcode'] = this.itemcode;
    return data;
  }
}
