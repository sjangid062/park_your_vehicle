class CarData {
  final String carNumber;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final double latitude;
  final double longitude;// Nullable DateTime for check-out time

  // Add a property for visibility
  bool isButtonVisible;

  CarData({
    required this.carNumber,
    required this.checkInTime,
    required this.latitude,
    required this.longitude,
    this.checkOutTime, // Make check-out time nullable
    this.isButtonVisible = true, // Default visibility to true
  });
}