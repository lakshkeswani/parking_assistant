// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
// class FinalizeBooking extends StatefulWidget {
//   @override
//   _FinalizeBookingState createState() => _FinalizeBookingState();
// }
//
// class _FinalizeBookingState extends State<FinalizeBooking> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Parking Asist"),),
//       body:  Column(
//         children: [
//           Container(
//             child: Text("Are You sure"),
//           ),
//           Container(
//             child: GooglePayButton(
//               paymentConfigurationAsset: 'default_payment_profile_google_pay.json',
//               paymentItems: _paymentItems,
//               style: GooglePayButtonStyle.black,
//               type: GooglePayButtonType.pay,
//               margin: const EdgeInsets.only(top: 15.0),
//               onPaymentResult: onGooglePayResult,
//               loadingIndicator: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
