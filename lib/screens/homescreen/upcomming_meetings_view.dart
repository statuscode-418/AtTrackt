import 'package:attrack/models/user_model.dart';
import 'package:attrack/screens/eventdetails_screen/eventdetails_screen.dart';
import 'package:attrack/services/firestore_storage/db_model.dart';
import 'package:flutter/material.dart';
import '../../components/eventcard.dart';
import '../../models/event_model.dart';

// ignore: must_be_immutable
class UpcommingMeetingsView extends StatelessWidget {
  UserModel user;
  final DBModel db;

  UpcommingMeetingsView({
    super.key,
    required this.user,
    required this.db,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF73FBFD),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          StreamBuilder<List<EventModel>>(
              stream: db.getUpcomingEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error : $snapshot.error'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No events found', style: TextStyle(fontSize: 20, color: Colors.white)),
                  );
                } else {
                  final events = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: events?.length,
                      itemBuilder: (context, index) {
                        final event = events?[index];
                        return EventCard(
                          user: user,
                          event: event!,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EventDetailsScreen(
                                  event: event,
                                  user: user,
                                  db: db,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
