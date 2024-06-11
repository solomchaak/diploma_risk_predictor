import 'package:diploma_risk_predictor/app_button.dart';
import 'package:diploma_risk_predictor/app_input.dart';
import 'package:diploma_risk_predictor/input_label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool showRequiredMessage;
  late TextEditingController ageController;
  late TextEditingController bmiController;
  late TextEditingController physicalHealthController;
  late TextEditingController mentalHealthController;
  late TextEditingController sleepController;
  String result = 'невизначений';
  late Interpreter interpreter;
  List<String> isSmoking = ['Yes', 'No'];
  String selectedSmoking = 'No';
  List<String> isAlcoholDrinking = ['Yes', 'No'];
  String selectedAlcohol = 'No';
  List<String> hadStroke = ['Yes', 'No'];
  String selectedStroke = 'No';
  List<String> hasDiffWalking = ['Yes', 'No'];
  String selectedDiffWalking = 'No';
  List<String> hasPhysicalActivity = ['Yes', 'No'];
  String selectedPhysicalActivity = 'No';
  List<String> sex = ['Male', 'Female'];
  String selectedSex = 'Male';
  List<String> diabetic = [
    'No',
    'No, borderline diabetes',
    'Yes',
    'Yes(during pregnancy)'
  ];
  String selectedDiabetic = 'No';

  @override
  void initState() {
    super.initState();
    showRequiredMessage = false;
    ageController = TextEditingController();
    bmiController = TextEditingController();
    physicalHealthController = TextEditingController();
    mentalHealthController = TextEditingController();
    sleepController = TextEditingController();
    loadModel();
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/dnn_after_smote.tflite');
  }

  void performAction() {
    // int x = int.parse(numberController.text);

    // For ex: if input tensor shape [1,5] and type is float32
    var fake_input = [
      [
        0.0,
        1.0,
        1.0,
        0.0,
        1.0,
        0.0,
        0.0,
        1.0,
        1.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        1.0,
        0.0,
        0.0,
        0.0,
        1.0,
        0.0,
        0.0,
        1.0,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        1.0,
        0.0,
        1.0,
        0.0,
        0.140046,
        1.000000,
        1.0,
        0.173913
      ]
    ];
    var input = [
      [
        double.parse(bmiController.text),
        selectedSmoking == 'Yes' ? 1 : 0,
        selectedAlcohol == 'Yes' ? 1 : 0,
        selectedStroke == 'Yes' ? 1 : 0,
        double.parse(physicalHealthController.text),
        double.parse(mentalHealthController.text),
        selectedDiffWalking == 'Yes' ? 1 : 0,
        selectedSex == 'Male' ? 1 : 0,
        double.parse(ageController.text) ~/ 5 - 3,
        5,
        selectedDiabetic.contains('Yes') ? 1 : 0,
        selectedPhysicalActivity == 'Yes' ? 1 : 0,
        double.parse(sleepController.text),
      ]
    ];
    // var input = [[21.2, 0, 1, 0, 27.0, 25.0, 0, 1, 1, 0, 1, 7.0]];
    print(input);
    // var input = [x];

    // if output tensor shape [1,2] and type is float32
    // var output = List.filled(1 * 2, 0).reshape([1, 2]);
    List output = List.filled(1 * 1, 0).reshape([1, 1]);

    // inference
    interpreter.run(input, output);

    // output = [
    //   ['3']
    // ];
    print(output);
    setState(() {
      result = '${(output[0][0] * 100).round()} %';
      // result = '14%';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 188, 71, 221),
          title: Text('CVD Risk Estimator',
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 8),
                const InputLabel(label: 'Введіть ваш вік:'),
                TextInput(
                  label: '18-99',
                  errorText: (ageController.text.isEmpty ||
                              double.tryParse(ageController.text) == null ||
                              double.parse(ageController.text) < 18 ||
                              double.parse(ageController.text) > 99) &&
                          showRequiredMessage
                      ? 'Будь ласка, введіть вік правильно'
                      : null,
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'Яка ваша стать?'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: sex[0],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedSex,
                            onChanged: (value) {
                              setState(() {
                                selectedSex = value.toString();
                              });
                            },
                          ),
                          Text('Чоловіча',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: sex[1],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedSex,
                            onChanged: (value) {
                              setState(() {
                                selectedSex = value.toString();
                              });
                            },
                          ),
                          Text('Жіноча',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'Ви курите?'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: isSmoking[0],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedSmoking,
                            onChanged: (value) {
                              setState(() {
                                selectedSmoking = value.toString();
                              });
                            },
                          ),
                          Text('Так',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: isSmoking[1],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedSmoking,
                            onChanged: (value) {
                              setState(() {
                                selectedSmoking = value.toString();
                              });
                            },
                          ),
                          Text('Ні',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'Вживаєте алкоголь?'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: isAlcoholDrinking[0],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedAlcohol,
                            onChanged: (value) {
                              setState(() {
                                selectedAlcohol = value.toString();
                              });
                            },
                          ),
                          Text('Так',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: isAlcoholDrinking[1],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedAlcohol,
                            onChanged: (value) {
                              setState(() {
                                selectedAlcohol = value.toString();
                              });
                            },
                          ),
                          Text('Ні',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'У вас був інсульт?'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: hadStroke[0],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedStroke,
                            onChanged: (value) {
                              setState(() {
                                selectedStroke = value.toString();
                              });
                            },
                          ),
                          Text('Так',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: hadStroke[1],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedStroke,
                            onChanged: (value) {
                              setState(() {
                                selectedStroke = value.toString();
                              });
                            },
                          ),
                          Text('Ні',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'Чи є у вас труднощі з ходьбою?'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: hasDiffWalking[0],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedDiffWalking,
                            onChanged: (value) {
                              setState(() {
                                selectedDiffWalking = value.toString();
                              });
                            },
                          ),
                          Text('Так',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: hasDiffWalking[1],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedDiffWalking,
                            onChanged: (value) {
                              setState(() {
                                selectedDiffWalking = value.toString();
                              });
                            },
                          ),
                          Text('Ні',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const InputLabel(
                    label: 'Маєте регулярні фізичні навантаження?'),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: hasPhysicalActivity[0],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedPhysicalActivity,
                            onChanged: (value) {
                              setState(() {
                                selectedPhysicalActivity = value.toString();
                              });
                            },
                          ),
                          Text('Так',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                            value: hasPhysicalActivity[1],
                            activeColor:
                                const Color.fromARGB(255, 39, 146, 240),
                            groupValue: selectedPhysicalActivity,
                            onChanged: (value) {
                              setState(() {
                                selectedPhysicalActivity = value.toString();
                              });
                            },
                          ),
                          Text('Ні',
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'У вас є діабет?'),
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                        value: diabetic[0], child: const Text('Ні')),
                    DropdownMenuItem(
                        value: diabetic[1],
                        child: const Text('Ні, граничний діабет')),
                    DropdownMenuItem(
                        value: diabetic[2], child: const Text('Так')),
                    DropdownMenuItem(
                        value: diabetic[3],
                        child: const Text('Так, впродовж вагітності')),
                  ],
                  value: selectedDiabetic,
                  style: GoogleFonts.nunito(color: Colors.black, fontSize: 16),
                  iconEnabledColor: const Color.fromARGB(255, 39, 146, 240),
                  padding: const EdgeInsets.all(4),
                  iconSize: 28,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      selectedDiabetic = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 8),
                const InputLabel(label: 'Введіть ваш індекс маси тіла:'),
                TextInput(
                    label: 'Наприклад: 23.76',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: bmiController),
                const SizedBox(height: 8),
                const InputLabel(
                    label:
                        'Скільки днів на місяць ви почуваєтесь добре фізично?'),
                TextInput(
                    label: '0-30',
                    keyboardType: TextInputType.number,
                    controller: physicalHealthController),
                const SizedBox(height: 8),
                const InputLabel(
                    label:
                        'Скільки днів на місяць ви почуваєтесь добре ментально?'),
                TextInput(
                    label: '0-30',
                    keyboardType: TextInputType.number,
                    controller: mentalHealthController),
                const SizedBox(height: 8),
                const InputLabel(label: 'Середня тривалість сну на добу:'),
                TextInput(
                    label: 'Наприклад: 7.5',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: sleepController),
                const SizedBox(height: 8),

                AppButton(
                  label: 'Отримати передбачення',
                  fontSize: 18,
                  onPressed: () {
                    showRequiredMessage = true;
                    performAction();
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Результат: ',
                        style: GoogleFonts.nunito(
                            color: Colors.black, fontSize: 16)),
                    Text(result,
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ));
  }
}
