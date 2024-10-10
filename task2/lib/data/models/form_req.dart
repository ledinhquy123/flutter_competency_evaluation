class FormReq {
  final DateTime? dateTime;
  final double? quantity;
  final String? pump;
  final double? revenue;
  final double? unitPrice;

  FormReq(
      {required this.dateTime,
      required this.quantity,
      required this.pump,
      required this.revenue,
      required this.unitPrice});
}
