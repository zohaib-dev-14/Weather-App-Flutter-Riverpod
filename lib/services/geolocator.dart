
import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {


   //^ check karta h k kia user n already location ka access diya h APP INFO se
   LocationPermission locationPermission = await Geolocator.checkPermission();


   //^ agar nahin dia access to request karo dobara k location de dy
   if (locationPermission == LocationPermission.denied) {
    locationPermission = await Geolocator.requestPermission();
    // ^ agar still na dey access to show kara do location permissions are denied
    if (locationPermission == LocationPermission.denied) {
      return Future.error("Location Permissions are denied");
    }
   }

  //^ agar don't ask again and deny pe simultaneously click kardy to chor do and keh do bas denied forever, ab jab tak manually app info se jaye ga nahin kuch nahin hoga
   if (locationPermission == LocationPermission.deniedForever) {
    return Future.error("Location permissions are denied forever, we can't handle your request!");
   }

   return await Geolocator.getCurrentPosition();
}