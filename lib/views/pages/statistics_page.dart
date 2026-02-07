import 'package:carwan_dough/models/order_model.dart';
import 'package:carwan_dough/services/order_statistics_service.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  // Todo: as Stream_updated
  final List<OrderModel> orders;
  const StatisticsPage({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final stats = OrderStatistics(orders);
    final size = MediaQuery.of(context).size;
    final entries = stats.ordersPerDay.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.15, // total banner height
              width: size.width,
              child: Stack(
                children: [
                  /// 🔴 Red Banner
                  Container(
                    width: size.width,
                    height: size.height * 0.1,
                    padding: EdgeInsets.all(size.width * 0.05),
                    color: AppColors.red,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: size.height * 0.2,
                    ),
                  ),

                  /// 🌊 Wave at Bottom
                  Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/waves.png",
                      fit: BoxFit.cover,
                      height: size.height * 0.05,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Title
            // Text(
            //   "Statistics",
            //   style: AppStyles.fontHeadlineSmallW700DarkRed(context),
            // ),

            const SizedBox(height: 16),

            /// 🔹 Summary cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _StatCard(
                    title: "Orders",
                    value: stats.totalOrders.toString(),
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    title: "Revenue",
                    value: "${stats.totalRevenue.toStringAsFixed(2)} EGP",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 Pie Chart (Orders by Status)

            Column(
              children: [
                Text(
                  "Orders by Status",
                  style: AppStyles.fontTitleSmallW500DarkRed(context).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      // centerSpaceColor: AppColors.darkRed,
                      sectionsSpace: 2,
                      centerSpaceRadius: 30,
                      sections: stats.ordersByStatus.entries.map(
                        (entry) {
                          return PieChartSectionData(
                            color: getStatusColor(entry.key.trim().toLowerCase()), // text color,
                            value: entry.value.toDouble(),
                            title: entry.key,
                            radius: 70,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            /// 🔹 Line Chart (Orders per Day)

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Title
                  Text(
                    "Orders Over Time",
                    style: AppStyles.fontTitleSmallW500DarkRed(context).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🔹 Line Chart
                  /*   SizedBox(
                    height: 220,
                    child: LineChart(
                      LineChartData(
                        /// Grid
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 1,
                        ),

                        /// Border
                        borderData: FlBorderData(show: false),

                        /// Axis titles
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(fontSize: 10),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(fontSize: 10),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),

                        /// Tooltip
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (spots) {
                              return spots.map(
                                (spot) {
                                  return LineTooltipItem(
                                    'Day ${spot.x.toInt()}\nOrders: ${spot.y.toInt()}',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ),

                        /// Line
                        lineBarsData: [
                          LineChartBarData(
                            color: AppColors.darkRed,
                            isCurved: true,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.basil.withOpacity(0.15),
                            ),
                            spots: stats.ordersPerDay.entries.map((e) {
                              final day = DateTime.parse(e.key).day.toDouble();
                              return FlSpot(day, e.value.toDouble());
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
*/
                  /// 🔹 Bar Chart
                  SizedBox(
                    height: 220,
                    child: BarChart(
                      BarChartData(
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                'Day ${group.x}\nOrders: ${rod.toY.toInt()}',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),

                        /// Grid
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: 1,
                          drawVerticalLine: false,
                        ),

                        /// Axis titles
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, _) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),

                        borderData: FlBorderData(show: false),

                        /// Bars
                        barGroups: entries.map((e) {
                          final day = DateTime.parse(e.key).day;
                          return BarChartGroupData(
                            x: day,
                            barRods: [
                              BarChartRodData(
                                toY: e.value.toDouble(),
                                width: 14,
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.darkRed,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstant.heightNav),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkRed,
        ),
        child: Column(
          children: [
            Text(
              title,
              // style: AppStyles.fontBodySmall(context),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              // style: AppStyles.fontTitleLarge(context),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
