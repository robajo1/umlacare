import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Report",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(child: Center(child: Text('5'))),
                  TableCell(child: Center(child: Text('3'))),
                  TableCell(child: Center(child: Text('1'))),
                  TableCell(child: Center(child: Text('1'))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Center(child: Text('Total'))),
                  TableCell(child: Center(child: Text('Taken'))),
                  TableCell(child: Center(child: Text('Missed'))),
                  TableCell(child: Center(child: Text('Snoozed'))),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Check Dashboard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Here you will find everything related to your active and past medicines.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Check History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(child: Center(child: Text('SUN'))),
                  TableCell(child: Center(child: Text('MON'))),
                  TableCell(child: Center(child: Text('TUE'))),
                  TableCell(child: Center(child: Text('WED'))),
                  TableCell(child: Center(child: Text('THU'))),
                  TableCell(child: Center(child: Text('FRI'))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Center(child: Text('1'))),
                  TableCell(child: Center(child: Text('2'))),
                  TableCell(child: Center(child: Text('3'))),
                  TableCell(child: Center(child: Text('4'))),
                  TableCell(child: Center(child: Text('5'))),
                  TableCell(child: Center(child: Text('6'))),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Morning 08:00 am',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Calpol 500mg Tablet'),
            subtitle: Text('Before Breakfast Day 01'),
            trailing: Text('Taken', style: TextStyle(color: Colors.green)),
          ),
          ListTile(
            title: Text('Calpol 500mg Tablet'),
            subtitle: Text('Before Breakfast Day 27'),
            trailing: Text('Missed', style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 20),
          Text(
            'Afternoon 02:00 pm',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text('Calpol 500mg Tablet'),
            subtitle: Text('After Food Day 01'),
            trailing: Text('Snoozed', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }
}
