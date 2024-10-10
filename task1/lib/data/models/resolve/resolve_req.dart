class ResolveReq {
  final DateTime startTime;
  final DateTime endTime;
  final Map<DateTime, double>? data;

  ResolveReq({
    required this.startTime,
    required this.endTime,
    required this.data,
  });
}
