// Refer to flutter_project/lib/screens/partner/runner_reimbursement_screen.dart for full code
import 'package:flutter/material.dart';
import '../../models/booking.dart';

class RunnerReimbursementScreen extends StatefulWidget {
  final Booking booking;
  const RunnerReimbursementScreen({Key? key, required this.booking}) : super(key: key);

  @override
  State<RunnerReimbursementScreen> createState() => _RunnerReimbursementScreenState();
}

class _RunnerReimbursementScreenState extends State<RunnerReimbursementScreen> {
  // Real-time calculation: Total Bill = (Hourly Labor Rate × Hours) + Actual Items Bill Cost
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Runner Memo: ${widget.booking.id}')),
      body: const Center(child: Text('Checklist ticking, camera memo upload, dynamic formula bill calculation')),
    );
  }
}