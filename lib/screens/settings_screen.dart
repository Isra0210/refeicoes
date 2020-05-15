import 'package:flutter/material.dart';
import 'package:refeicoes/models/settings.dart';
import '../components/main_drawer.dart';

class SettingsScreen extends StatefulWidget {

  final Settings settings;
  final Function(Settings) onsSettingsChanged;

  const SettingsScreen(this.settings, this.onsSettingsChanged);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Settings settings;

  @override
  void initState(){
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onsSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch(
                  'Sem Glutén',
                  'Só exibe refeições sem glúten!',
                  settings.isGlutenFree,
                  (value) => setState(() => settings.isGlutenFree = value),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem lactose!',
                  settings.isLactoseFree,
                  (value) => setState(() => settings.isLactoseFree = value),
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições veganas!',
                  settings.isVegan,
                  (value) => setState(() => settings.isVegan = value),
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições vegetariana!',
                  settings.isVegeratian,
                  (value) => setState(() => settings.isVegeratian = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
