import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suyaa_mobile/presentation/component/buddle/speech_buddle.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  final texts = ['ポチッ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: texts,
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O2()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper3.png'),
            Image.asset('asset/introduction/Bottom1-1.png')
          ]),
        ),
      ),
    );
  }
}

next(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

class O2 extends StatelessWidget {
  const O2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const [
          'おはようございます朝8時20分を回りました　天気予報の時間です 今日は昨日よりも全国的に',
        ],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O3()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper1.png'),
            Image.asset('asset/introduction/Bottom1-1.png')
          ]),
        ),
      ),
    );
  }
}

class O3 extends StatelessWidget {
  const O3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const [
          'ザーーーー',
        ],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O4()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom1-1.png')
          ]),
        ),
      ),
    );
  }
}

class O4 extends StatelessWidget {
  const O4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const [
          'パチ',
          'もしもし、聞こえますか？2020年代のみなさん聞こえますか？',
          '私たちは少し未来、2XXXの人間です。あなたたちに頼みがあります。',
          '私たちは激しい競争と効率化の末、睡眠というものを持たないように進化しました。メリットもありましたが、睡眠と同時に大切な[何か]も失ってしまってしまいました。'
        ],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O5()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom1-1.png')
          ]),
        ),
      ),
    );
  }
}

class O5 extends StatelessWidget {
  const O5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const [
          'しかしそれが[何か]を今や思い出すことができません、それを思い出す助けになってほしいのです',
          '今から箱を送ります、その中に入っている生物を育てることが、私たちが、記憶を取り戻す手がかりになるでしょう。',
          'それでは、何卒よろしくお願いします'
        ],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O6()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom1-2.png')
          ]),
        ),
      ),
    );
  }
}

class O6 extends StatelessWidget {
  const O6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const ['ピンポーン カチャカチャ'],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O7()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom1-3.png')
          ]),
        ),
      ),
    );
  }
}

class O7 extends StatelessWidget {
  const O7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const ['カチャカチャ カチャカチャ'],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O8()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom2-1.png')
          ]),
        ),
      ),
    );
  }
}

class O8 extends StatelessWidget {
  const O8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const ['(玄関の前に箱が置かれていた。箱は驚くほど白い。どこから開けるんだろう)'],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const O9()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom3-1.png')
          ]),
        ),
      ),
    );
  }
}

class O9 extends StatelessWidget {
  const O9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const ['(？？？...えっ箱が透けた。この箱は中に入ってるのはなんだ、これは卵...?)'],
        onEnd: () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const Oa()))),
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset('asset/introduction/Upper2.png'),
            Image.asset('asset/introduction/Bottom3-2.png')
          ]),
        ),
      ),
    );
  }
}

class Oa extends StatelessWidget {
  const Oa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: const ['....'],
        onEnd: () => context.push('/auth'),
        child: Container(
          color: const Color.fromARGB(255, 255, 248, 187),
          child: Center(child: Image.asset('asset/introduction/Bottom3-2.png')),
        ),
      ),
    );
  }
}
