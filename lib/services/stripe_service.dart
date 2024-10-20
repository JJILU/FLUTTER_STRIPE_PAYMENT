import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:striperpayers/consts.dart';

class StripeService {
  // define a private constructor
  StripeService._();

  // store instance of StripeService
  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentInt(10, "usd");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Japhet Kapele",
        ),
      );
      await _processPaymet();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentInt(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      // data to be sent
      Map<String, dynamic> data = {
        "amount": _calculateAmmount(amount),
        "currency": currency,
      };
      // make post request to endpoint v1/payment_intents
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      // what to do with response returned
      if (response.data != null) {
        // print(response.data);
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPaymet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        final paymentCanceled = true;
        print('Payment flow was canceled: ${e.error.localizedMessage}');
        // Handle payment cancellation
      } else {
        print('Stripe error: ${e.error.localizedMessage}');
        // Handle other Stripe errors
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
      // Handle any other exceptions
    }
  }

  // transforms dollars to cents
  String _calculateAmmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
