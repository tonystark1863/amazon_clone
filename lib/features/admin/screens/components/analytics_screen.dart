import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_products_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings; 


  @override
  void initState() {
    super.initState();
    getAnalytics();
  }

  getAnalytics() async{
    final data  =  await adminServices.fetchAnalytics(context);
    totalSales =  data['totalEarnings'];
    earnings = data['sales'];
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return totalSales == null || earnings == null
    ? const LinearProgressIndicator()
    : Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Gross Income : Rs.${earnings![0].earning}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 450,
          child: CategoryProductsChart(sales: earnings!)
        )
      ],
    );
  }
}