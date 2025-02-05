import 'package:cloud_firestore/cloud_firestore.dart';
import 'location_service.dart';

class LocationSharingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> shareLocation(String userId) async {
    var location = await LocationService().getCurrentLocation();
    
    await _firestore.collection('locations').doc(userId).set({
      'latitude': location.latitude,
      'longitude': location.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
