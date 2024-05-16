import 'package:fitness_app/provider/payment_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PaymentHistoryProvider>(context, listen: false).loadPaymnet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Payment History",
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(30, 32, 33, 1),
        ),
        child: Consumer<PaymentHistoryProvider>(
          builder: (context, value, child) {
            return value.payment.isEmpty
                ? Center(
                    child: Text(
                      "No Payment Yet",
                      style: GoogleFonts.oswald(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: value.payment.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(30, 32, 33, 1)),
                        child: ListTile(
                          iconColor: Colors.white,
                          leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(232, 189, 112, 1),
                              ),
                              width: 45,
                              height: 45,
                              child: SvgPicture.asset(
                                "assets/images/crownn.svg",
                              )),
                          title: Text(
                            value.payment[index],
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            value.desc[index],
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            value.price[index], // Add your trailing text here
                            style: GoogleFonts.oswald(
                              color: Color.fromRGBO(65, 190, 34, 1),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
