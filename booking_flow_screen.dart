// Refer to flutter_project/lib/screens/customer/booking_flow_screen.dart for full code
import 'package:flutter/material.dart';
import '../../models/service_item.dart';
import '../../models/checklist_item.dart';

class BookingFlowScreen extends StatefulWidget {
  final ServiceItem service;
  final ServiceSubOption? selectedSubOption;

  const BookingFlowScreen({Key? key, required this.service, this.selectedSubOption}) : super(key: key);

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  // Contains instant vs scheduled, shopping checklist editor, subscription toggle, and order placement
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.service.title}')),
      body: const Center(child: Text('Checkout flow with instant dispatch & checklist')),
    );
  }
}