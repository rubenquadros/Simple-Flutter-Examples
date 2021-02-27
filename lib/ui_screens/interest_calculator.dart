import 'package:flutter/material.dart';

class InterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterestState();
}

class _InterestState extends State<InterestCalculator> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _selectedCurrency = '';
  var _totalAmount = '';
  var _principalController = TextEditingController();
  var _roiController = TextEditingController();
  var _termController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  final _minimumPadding = 5.0;

  @override
  void initState() {
    super.initState();
    _selectedCurrency = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Simple Interest'),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(_minimumPadding * 10),
                    child: Image(
                      image: AssetImage('images/bank.png'),
                      width: 125.0,
                      height: 125.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_minimumPadding * 2),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _principalController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          labelText: 'Principal amount',
                          hintText: 'Enter principal eg. 10000',
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Sans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please enter principal amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_minimumPadding * 2),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _roiController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: 'In percentage',
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Sans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minimumPadding,
                          bottom: _minimumPadding,
                          left: _minimumPadding * 2,
                          right: _minimumPadding * 2),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _termController,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Time in years',
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please enter term';
                              }
                              return null;
                            },
                          )),
                          Container(
                            width: _minimumPadding * 5,
                          ),
                          Expanded(
                              child: DropdownButton(
                                  items: _currencies
                                      .map((value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Sans',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (String selectedValue) =>
                                      _currencySelected(selectedValue),
                                  value: _selectedCurrency))
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding,
                        left: _minimumPadding * 2,
                        right: _minimumPadding * 2),
                    child: Row(
                      children: [
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text('Calculate',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sans',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400)),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                _totalAmount = _calculateTotalAmount();
                              }
                            });
                          },
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Colors.white,
                          child: Text('Reset',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sans',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400)),
                          onPressed: () {
                            setState(() {
                              _resetFields();
                            });
                          },
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(_minimumPadding * 2),
                    child: Text(_totalAmount,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Sans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                  )
                ],
              ))),
    );
  }

  void _currencySelected(String inputValue) {
    setState(() {
      _selectedCurrency = inputValue;
    });
  }

  String _calculateTotalAmount() {
    var principalAmount = double.parse(_principalController.text);
    var roi = double.parse(_roiController.text);
    var term = double.parse(_termController.text);
    var result = principalAmount + (principalAmount * roi * term) / 100;
    return 'After $term years you will be paying $_selectedCurrency $result';
  }

  void _resetFields() {
    _principalController.text = '';
    _roiController.text = '';
    _termController.text = '';
    _totalAmount = '';
    _selectedCurrency = _currencies[0];
  }
}
