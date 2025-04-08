// ignore_for_file: deprecated_member_use, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMedicinesScreen extends StatefulWidget {
  @override
  _AddMedicinesScreenState createState() => _AddMedicinesScreenState();
}

class _AddMedicinesScreenState extends State<AddMedicinesScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  String? _selectedTime;
  String? _medicineName;
  String? _quantity;
  String? _totalCount1;
  String? _totalCount2;
  String? _startDate;
  String? _endDate;
  String? _frequency;
  String? _timesPerDay;
  List<bool> _doseSelected = [false, false, false];
  List<String?> _doseTimings = [null, null, null];
  String? _selectedColor;

  List<String> _timesPerDayOptions = ['One Time', 'Two Times', 'Three Times'];
  List<String> _timingOptions = ['Morning', 'Afternoon', 'Night'];
  List<Color> _colorOptions = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  Future<void> addMedicineForCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

      await userRef.collection('medicine').add({
        'name': _medicineName,
        'Color': _selectedColor,
        'type': _selectedType,
        'when': _selectedTime,
        'startDate': DateTime.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicines'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search Medicine Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a medicine name';
                  }
                  return null;
                },
                onSaved: (value) => _medicineName = value,
              ),
              SizedBox(height: 20),
              Text('Compartment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(child: Text('${index + 1}')),
                  );
                },
              ),
              SizedBox(height: 20),
              Text('Colour',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: _colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color.value.toRadixString(16);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        border: _selectedColor == color.value.toRadixString(16)
                            ? Border.all(color: Colors.black, width: 3)
                            : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: ['Tablet', 'Capsule', 'Cream', 'Liquid'].map((type) {
                  return ChoiceChip(
                    label: Text(type),
                    selected: _selectedType == type,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedType = type;
                        } else {
                          _selectedType = null;
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Quantity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Take 1/2 Pill',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
                onSaved: (value) => _quantity = value,
              ),
              SizedBox(height: 20),
              Text('Total Count',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '01',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      onSaved: (value) => _totalCount1 = value,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '100',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      onSaved: (value) => _totalCount2 = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Set Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Today',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a start date';
                        }
                        return null;
                      },
                      onSaved: (value) => _startDate = value,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an end date';
                        }
                        return null;
                      },
                      onSaved: (value) => _endDate = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Frequency of Days',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Everyday',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the frequency';
                  }
                  return null;
                },
                onSaved: (value) => _frequency = value,
              ),
              SizedBox(height: 20),
              Text('How many times a Day',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _timesPerDay,
                items: _timesPerDayOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _timesPerDay = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select how many times a day';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              if (_timesPerDay != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    _timesPerDayOptions.indexOf(_timesPerDay!) + 1,
                    (index) {
                      return Column(
                        children: [
                          CheckboxListTile(
                            title: Text('Dose ${index + 1}'),
                            value: _doseSelected[index],
                            onChanged: (bool? value) {
                              setState(() {
                                _doseSelected[index] = value ?? false;
                              });
                            },
                          ),
                          if (_doseSelected[index])
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: DropdownButtonFormField<String>(
                                value: _doseTimings[index],
                                items: _timingOptions.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _doseTimings[index] = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Select Timing',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (_doseSelected[index] &&
                                      (value == null || value.isEmpty)) {
                                    return 'Please select a timing';
                                  }
                                  return null;
                                },
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              SizedBox(height: 20),
              Text('Before Food / After Food / Before Sleep',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children:
                    ['Before Food', 'After Food', 'Before Sleep'].map((option) {
                  return ChoiceChip(
                    label: Text(option),
                    selected: _selectedTime == option,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedTime = option;
                        } else {
                          _selectedTime = null;
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        addMedicineForCurrentUser();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
