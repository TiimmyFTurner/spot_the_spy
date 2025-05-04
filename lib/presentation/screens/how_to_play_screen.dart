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
        Text(
          "1. Roles Are Assigned",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """At the start of each game, some random players becomes the Spy. All other players receive the secret word (e.g., "Airport", "Restaurant").""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "2. Ask Each Other Questions",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """Players take turns asking short, subtle questions to one another (e.g., “Is it usually crowded there?”).
The goal is to confirm you know the word — without making it obvious.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text("3. Be Careful!", style: Theme.of(context).textTheme.titleLarge),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """If you're not the spy: try to find out who doesn’t know the word, but don't make the word too obvious.

If you are the spy: try to blend in and guess the word before being caught.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "4. Accuse or Guess",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """At any time, a player can accuse someone of being the spy. If everyone agrees, the accused must reveal their role.

If the spy is caught: other players win.

If the spy guesses the word correctly before getting caught: the spy wins!
.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "5. Timer Ends the Round",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """When the timer runs out, all players must vote on who the spy is. Then the spy gets one chance to guess the word.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 16),
        Text("📝 Tips", style: Theme.of(context).textTheme.headlineSmall),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """
Don’t ask questions that are too obvious.

The spy wins by either guessing the word or surviving the round without being caught.

Pay attention to vague or strange answers!""",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }

  Widget howToPlayFA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "۱. نقش‌ها تعیین می‌شوند",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """در ابتدای هر بازی، به‌صورت تصادفی چند تا از بازیکنان جاسوس می‌شوند. سایر بازیکنان یک کلمه مخفی یکسان دریافت می‌کنند (مثلاً "فرودگاه"، "رستوران").""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "۲. از همدیگر سؤال بپرسید",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """بازیکنان نوبتی از یکدیگر سؤال‌های کوتاه و غیرمستقیم می‌پرسند (مثلاً: «معمولاً شلوغه؟»)
هدف این است که نشان دهید کلمه را می‌دانید — بدون اینکه آن را لو بدهید.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text("۳. مراقب باشید!", style: Theme.of(context).textTheme.titleLarge),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """اگر جاسوس نیستید: سعی کنید کسی را که کلمه را نمی‌داند پیدا کنید، ولی کلمه را لو ندهید.

اگر شما جاسوس هستید: سعی کنید خودتان را لو ندهید و حدس بزنید کلمه چیست.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text("۴. اتهام یا حدس", style: Theme.of(context).textTheme.titleLarge),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """در هر لحظه، بازیکنی می‌تواند به فردی اتهام بزند که او جاسوس است. اگر همه موافق باشند، آن فرد باید نقش خود را فاش کند.

اگر جاسوس شناسایی شود: سایر بازیکنان برنده‌اند.

اگر جاسوس قبل از شناسایی، کلمه را درست حدس بزند: جاسوس برنده است!""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "۵. پایان با تایمر",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """وقتی تایمر تمام شود، همه بازیکنان باید رأی بدهند که فکر می‌کنند جاسوس کیست. سپس جاسوس فرصتی برای حدس زدن کلمه دارد.""",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 16),
        Text("📝 نکات", style: Theme.of(context).textTheme.headlineSmall),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            """سؤال‌های خیلی واضح نپرسید.

جاسوس با حدس زدن کلمه یا باقی‌ماندن تا پایان بدون لو رفتن برنده می‌شود.

به پاسخ‌های مبهم یا مشکوک توجه کنید!""",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
