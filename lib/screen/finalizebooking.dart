import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
class FinalizeBooking extends StatefulWidget {
  @override
  _FinalizeBookingState createState() => _FinalizeBookingState();
}

class _FinalizeBookingState extends State<FinalizeBooking> {
  final _paymentItems = <PaymentItem>[];

  @override
  void initState() {
    _paymentItems.add(PaymentItem(
        amount: "50", label: "Ticket", status: PaymentItemStatus.final_price));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Asist"),
      ),
      body: Column(
        children: [
          Container(
            child: Text("Are You sure"),
          ),
          Container(
            child: GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
             height: 50,
             width: 300,
              style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (val) {},
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
