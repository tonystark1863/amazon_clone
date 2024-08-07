import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' ;

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> sales;
  const CategoryProductsChart({
    super.key,
    required this.sales,
    });


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: _buildBarGroups(),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles:false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const  textStyle = TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    );
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4.0, // Can be adjusted for spacing
                      child: Text(
                        sales[value.toInt()].label,
                        style: textStyle,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return sales
        .asMap()
        .map((index, order) {
          return MapEntry(
            index,
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  width: 20,
                  borderRadius: BorderRadius.circular(2),
                  toY: sales[index].earning,
                  gradient: const  LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.greenAccent],
                    begin: Alignment.center,
                    end: Alignment.topCenter
                  ),
                ),
              ],
            ),
          );
        })
        .values
        .toList();
  }

}