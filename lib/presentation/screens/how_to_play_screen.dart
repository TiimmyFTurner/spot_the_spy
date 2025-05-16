import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';

class HowToPlayScreen extends ConsumerStatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  ConsumerState createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends ConsumerState<HowToPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.howToPlay),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: howToPlay(),

          ),
        ),
      ),
    );
  }

  Widget howToPlay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),

        Text(
          AppLocalizations.of(context)!.howToPlay_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        Card(
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(AppLocalizations.of(context)!.rolesAssigned_title),
            subtitle: Text(AppLocalizations.of(context)!.rolesAssigned_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text(AppLocalizations.of(context)!.askQuestions_title),
            subtitle: Text(AppLocalizations.of(context)!.askQuestions_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.warning_amber_outlined),
            title: Text(AppLocalizations.of(context)!.beCareful_title),
            subtitle: Text(AppLocalizations.of(context)!.beCareful_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.gavel_outlined),
            title: Text(AppLocalizations.of(context)!.accuseOrGuess_title),
            subtitle: Text(AppLocalizations.of(context)!.accuseOrGuess_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.hourglass_bottom),
            title: Text(AppLocalizations.of(context)!.timerEnds_title),
            subtitle: Text(AppLocalizations.of(context)!.timerEnds_desc),
          ),
        ),

        SizedBox(height: 24),

        Text(
          AppLocalizations.of(context)!.scoringSystem_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        Card(
          child: ListTile(
            leading: Icon(Icons.timer_outlined),
            title: Text(AppLocalizations.of(context)!.timeout_title),
            subtitle: Text(AppLocalizations.of(context)!.timeout_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.visibility_outlined),
            title: Text(AppLocalizations.of(context)!.spyGuesses_title),
            subtitle: Text(AppLocalizations.of(context)!.spyGuesses_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text(AppLocalizations.of(context)!.spyCaught_title),
            subtitle: Text(AppLocalizations.of(context)!.spyCaught_desc),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text(AppLocalizations.of(context)!.wrongGuess_title),
            subtitle: Text(AppLocalizations.of(context)!.wrongGuess_desc),
          ),
        ),

        SizedBox(height: 24),

        Text(
          AppLocalizations.of(context)!.tips_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.tips_bullet_1),
                SizedBox(height: 4, width: double.infinity),
                Text(AppLocalizations.of(context)!.tips_bullet_2),
                SizedBox(height: 4),
                Text(AppLocalizations.of(context)!.tips_bullet_3),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
