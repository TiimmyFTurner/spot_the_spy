import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_the_spy/l10n/app_localizations.dart';
import 'package:spot_the_spy/l10n/l10n.dart';

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
            child:
                Localizations.localeOf(context) == L10n.en
                    ? howToPlayEN()
                    : howToPlayFA(),
          ),
        ),
      ),
    );
  }

  Widget howToPlayEN() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),

        Text("Game Rules", style: Theme.of(context).textTheme.titleLarge),

        Card(
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Roles Are Assigned"),
            subtitle: Text(
              "At the start of each game, some players are randomly chosen as the Spy. "
              "All other players receive the same secret word (e.g., 'Airport', 'Restaurant').",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text("Ask Each Other Questions"),
            subtitle: Text(
              "Players take turns asking subtle questions (e.g., 'Is it usually crowded there?'). "
              "The goal is to show you know the word without making it too obvious.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.warning_amber_outlined),
            title: Text("Be Careful!"),
            subtitle: Text(
              "If you're not the spy: spot who doesn’t know the word without revealing it.\n"
              "If you're the spy: blend in and try to guess the word before you're caught.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.gavel_outlined),
            title: Text("Accuse or Guess"),
            subtitle: Text(
              "Any player can accuse someone of being the spy. If everyone agrees, the accused reveals their role.\n\n"
              "• If the spy is caught: other players win.\n"
              "• If the spy guesses the word correctly: the spy wins.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.hourglass_bottom),
            title: Text("Timer Ends the Round"),
            subtitle: Text(
              "When the timer runs out, everyone must vote who they think the spy is. "
              "After that, the spy has one chance to guess the word.",
            ),
          ),
        ),

        SizedBox(height: 24),

        Text("Scoring System", style: Theme.of(context).textTheme.titleLarge),

        Card(
          child: ListTile(
            leading: Icon(Icons.timer_outlined),
            title: Text("Timeout"),
            subtitle: Text(
              "The spy earns +1 point plus half of the round time limit if time runs out without being discovered.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.visibility_outlined),
            title: Text("Spy guesses the word"),
            subtitle: Text(
              "The spy gets +2 points plus 1 bonus point per full minute remaining.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text("Spy is caught"),
            subtitle: Text(
              "All other players get +1 point plus 1 bonus point per full minute left.",
            ),
          ),
        ),

        SizedBox(height: 24),

        Text("Tips", style: Theme.of(context).textTheme.titleLarge),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("• Don’t ask questions that are too obvious."),
                SizedBox(height: 4, width: double.infinity),
                Text(
                  "• The spy wins by either guessing the word or surviving the round.",
                ),
                SizedBox(height: 4),
                Text("• Pay attention to vague or strange answers."),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget howToPlayFA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),

        Text("قوانین بازی", style: Theme.of(context).textTheme.titleLarge),

        Card(
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("نقش‌ها تعیین می‌شوند"),
            subtitle: Text(
              "در ابتدای هر بازی، به‌صورت تصادفی چند نفر از بازیکنان به عنوان جاسوس انتخاب می‌شوند. "
              "سایر بازیکنان یک کلمه‌ی مخفی یکسان دریافت می‌کنند (مثلاً «فرودگاه»، «رستوران»).",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text("از همدیگر سؤال بپرسید"),
            subtitle: Text(
              "بازیکنان به نوبت سؤال‌های کوتاه و غیرمستقیم می‌پرسند (مثلاً «معمولاً شلوغه؟»). "
              "هدف این است که نشان دهید کلمه را می‌دانید بدون اینکه آن را لو بدهید.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.warning_amber_outlined),
            title: Text("مراقب باشید!"),
            subtitle: Text(
              "اگر جاسوس نیستید: سعی کنید کسی را که کلمه را نمی‌داند پیدا کنید، ولی کلمه را لو ندهید.\n"
              "اگر شما جاسوس هستید: سعی کنید خودتان را لو ندهید و کلمه را حدس بزنید.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.gavel_outlined),
            title: Text("اتهام یا حدس"),
            subtitle: Text(
              "هر بازیکنی می‌تواند در هر زمان به دیگری اتهام بزند که او جاسوس است. اگر همه موافق باشند، آن فرد باید نقش خود را فاش کند.\n\n"
              "• اگر جاسوس شناسایی شود: سایر بازیکنان برنده‌اند.\n"
              "• اگر جاسوس کلمه را درست حدس بزند: جاسوس برنده است.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.hourglass_bottom),
            title: Text("پایان با تایمر"),
            subtitle: Text(
              "وقتی تایمر تمام شود، بازیکنان رأی می‌دهند که چه کسی جاسوس است. "
              "سپس جاسوس یک فرصت برای حدس زدن کلمه خواهد داشت.",
            ),
          ),
        ),

        SizedBox(height: 24),

        Text("سیستم امتیازدهی", style: Theme.of(context).textTheme.titleLarge),

        Card(
          child: ListTile(
            leading: Icon(Icons.timer_outlined),
            title: Text("پایان زمان"),
            subtitle: Text(
              "جاسوس ۱ امتیاز می‌گیرد به‌علاوه نصف مدت کل زمان راند اگر تا پایان شناسایی نشده باشد.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.visibility_outlined),
            title: Text("حدس درست توسط جاسوس"),
            subtitle: Text(
              "جاسوس ۲ امتیاز می‌گیرد و برای هر دقیقه کامل باقی‌مانده، ۱ امتیاز اضافه دریافت می‌کند.",
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text("شناسایی جاسوس"),
            subtitle: Text(
              "سایر بازیکنان ۱ امتیاز دریافت می‌کنند به‌علاوه ۱ امتیاز اضافه برای هر دقیقه باقی‌مانده.",
            ),
          ),
        ),

        SizedBox(height: 24),

        Text("نکات", style: Theme.of(context).textTheme.titleLarge),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("• سؤال‌های خیلی واضح نپرسید."),
                SizedBox(height: 4, width: double.infinity),
                Text(
                  "• جاسوس با حدس زدن کلمه یا زنده ماندن تا پایان برنده می‌شود.",
                ),
                SizedBox(height: 4),
                Text("• به پاسخ‌های مبهم یا مشکوک توجه کنید!"),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
