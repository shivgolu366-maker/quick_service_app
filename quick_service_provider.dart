import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/service_item.dart';
import '../models/booking.dart';
import '../models/partner.dart';
import '../models/checklist_item.dart';
import '../models/subscription_package.dart';
import '../constants/mock_data.dart';

class QuickServiceProvider with ChangeNotifier {
  List<ServiceItem> _services = [];
  List<SubscriptionPlan> _subscriptionPlans = [];
  List<ServicePackage> _servicePackages = [];
  List<Booking> _bookings = [];
  Booking? _activeBooking;
  Partner _activePartner = MockData.mockPartner;
  bool _isSosActive = false;
  String _selectedCategory = 'All';

  bool _hasIncomingJob = false;
  Booking? _incomingJob;
  int _incomingJobTimerSeconds = 30;
  Timer? _jobCountdownTimer;

  QuickServiceProvider() {
    _services = List.from(MockData.servicesCatalog);
    _subscriptionPlans = List.from(MockData.subscriptionPlans);
    _servicePackages = List.from(MockData.servicePackages);

    final initialService = _services.firstWhere((s) => s.id == 'srv-sabji-mandi');
    final initialBooking = Booking(
      id: 'QS-89211',
      service: initialService,
      status: BookingStatus.inProgress,
      bookingType: 'instant',
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      startOtp: '5192',
      assignedPartner: _activePartner,
      taskDescription: 'Early morning wholesale sabji mandi purchase with cash memo upload.',
      checklist: [
        ChecklistItem(id: 'chk-1', name: 'Aloo (Potato)', quantity: '2 kg', isPurchased: true, category: 'sabji'),
        ChecklistItem(id: 'chk-2', name: 'Pyaaz (Onion)', quantity: '2 kg', isPurchased: true, category: 'sabji'),
        ChecklistItem(id: 'chk-3', name: 'Tamatar (Tomato)', quantity: '1 kg', isPurchased: true, category: 'sabji'),
        ChecklistItem(id: 'chk-4', name: 'Amul Taza Doodh', quantity: '2 packet', isPurchased: false, category: 'kirana'),
      ],
      reimbursement: RunnerReimbursement(
        billPhotoUrl: 'https://images.unsplash.com/photo-1554415707-9e4c19a42f63?auto=format&fit=crop&w=400&q=80',
        billPhotoName: 'mandi_cash_memo_receipt.jpg',
        totalItemsAmount: 285.0,
        memoNotes: 'Purchased fresh wholesale vegetables from Mandi Gate 2 stall.',
        uploadedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      pricing: BookingPricing(
        pricingType: 'hourly',
        hourlyLaborRate: 149.0,
        hoursSpent: 1.0,
        laborSubtotal: 149.0,
        actualItemsCost: 285.0,
        totalAmount: 434.0,
      ),
      isRecurring: true,
      recurrenceFrequency: 'weekly',
    );

    _bookings.add(initialBooking);
    _activeBooking = initialBooking;
  }

  List<ServiceItem> get services => _services;
  List<SubscriptionPlan> get subscriptionPlans => _subscriptionPlans;
  List<ServicePackage> get servicePackages => _servicePackages;
  List<Booking> get bookings => _bookings;
  Booking? get activeBooking => _activeBooking;
  Partner get activePartner => _activePartner;
  bool get hasIncomingJob => _hasIncomingJob;
  Booking? get incomingJob => _incomingJob;
  int get incomingJobTimerSeconds => _incomingJobTimerSeconds;

  void togglePartnerOnline() {
    _activePartner = _activePartner.copyWith(isOnline: !_activePartner.isOnline);
    notifyListeners();
  }

  void toggleChecklistItem(String bookingId, String itemId) {
    final idx = _bookings.indexWhere((b) => b.id == bookingId);
    if (idx != -1) {
      final updatedList = _bookings[idx].checklist.map((item) {
        if (item.id == itemId) return item.copyWith(isPurchased: !item.isPurchased);
        return item;
      }).toList();
      _bookings[idx] = _bookings[idx].copyWith(checklist: updatedList);
      if (_activeBooking?.id == bookingId) _activeBooking = _bookings[idx];
      notifyListeners();
    }
  }

  void submitRunnerReimbursement({
    required String bookingId,
    required double itemsBillAmount,
    required String billPhotoUrl,
    String? memoNotes,
    double hoursSpent = 1.0,
  }) {
    final idx = _bookings.indexWhere((b) => b.id == bookingId);
    if (idx != -1) {
      final curr = _bookings[idx];
      final double hourlyRate = curr.pricing.hourlyLaborRate;
      final double laborSubtotal = hourlyRate * hoursSpent;
      // Formula: Total Bill = (Hourly Labor Rate × Hours) + Actual Items Bill Cost
      final double totalBill = laborSubtotal + itemsBillAmount - curr.pricing.discount;

      final updated = curr.copyWith(
        reimbursement: RunnerReimbursement(
          billPhotoUrl: billPhotoUrl,
          totalItemsAmount: itemsBillAmount,
          memoNotes: memoNotes,
          uploadedAt: DateTime.now(),
        ),
        pricing: BookingPricing(
          pricingType: curr.pricing.pricingType,
          hourlyLaborRate: hourlyRate,
          hoursSpent: hoursSpent,
          laborSubtotal: laborSubtotal,
          actualItemsCost: itemsBillAmount,
          discount: curr.pricing.discount,
          totalAmount: totalBill,
        ),
      );

      _bookings[idx] = updated;
      if (_activeBooking?.id == bookingId) _activeBooking = updated;
      notifyListeners();
    }
  }
}