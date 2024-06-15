import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioPartidosPage extends StatefulWidget {
  const CalendarioPartidosPage({Key? key}) : super(key: key);

  @override
  _CalendarioPartidosPageState createState() => _CalendarioPartidosPageState();
}

class _CalendarioPartidosPageState extends State<CalendarioPartidosPage> {
  DateTime _selectedDay = DateTime.now(); // Fecha seleccionada por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de Partidos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildCalendarContent(),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              'Fecha seleccionada: ${_selectedDay.toString()}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarContent() {
    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month', 
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });
      },
    );
  }
}
