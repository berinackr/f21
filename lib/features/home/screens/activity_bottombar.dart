import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';
import 'package:go_router/go_router.dart';

import '../../../core/custom_styles.dart';
import '../../../models/user_model.dart';
import '../../auth/controller/auth_controller.dart';

class ActivityScreenBottombar extends ConsumerStatefulWidget {
  const ActivityScreenBottombar({super.key});

  @override
  ConsumerState createState() => _ActivityScreenBottombarState();
}

class _ActivityScreenBottombarState
    extends ConsumerState<ActivityScreenBottombar> {
  //bebek 24 aylıktan büyük mü kontrolü
  bool _isBabyBiggerThan24Months = false;
  late final bool isPregnant;

  var etkinlik_list = [
    "Gebelik yolculuğunuzun ilk ayında, bebeğinizle bağınızı güçlendirmek için ona bir mektup yazın! Ona anne karnındaki maceraları ve hislerinizi anlatın, gelecekte birlikte yapmak istediğiniz şaşırtıcı planları paylaşın. Yazılan her harf, büyülü bir bağın başlangıcı olacak. Bebeğinize eğlenceli bir selam gönderin!",
    "Bebeğiniz ve sizin için sakin, huzurlu bir gebelik dönemi en güzelidir. Sizi sakinleştirecek bir etkinlik planı: Bir bitki yetiştirmeye başlayabilirsiniz. Bu hem fiziksel hem de ruhsal sağlığınızı olumlu yönde etkileyecktir. Evinizin balkonunda veya bahçenizde dilediğiniz sayıda ve çeşitte bitki alarak işe koyulun. Bu bitkileri ekerken bir kare paylaşmanızı rica ediyoruz. Bebeğinizin ve bitkinin büyümeye beraber başlaması bu dönemi keyifli hale getirecektir.",
    "Bebeğinize kavuşmanızı daha 7 ay var. Peki bebekler hakkında neler biliyorsunuz? Kendinize bebek gelişimi ve bakımı hakkında güzel bir kitap almanın tam sırası! Bebeğinize daha iyi yardımcı olabilmek, şimdiki ve ilerleyen dönemlerde sizi neler beklediğini öğrenmek ve bilinçli bir anne adayı olmak için harika bir etkinlik! Sana bu konularda yardımcı olacak başucu kitabını seç ve bizimle keyifli bir okuma anını paylaş.",
    "Yeni bir ay, yeni bir etkinlik! Bu kez farklı olacak sanırım. Bu ay bebeğinizin cinsiyetini öğreneceksiniz ve heyecanlısınız. Göbeğinize bebeğiniz kız olacaksa sevimli ve güzel bir çiçek, erkek olacaksa yakışıklı ve tatlı bir araba çizerek bizimle paylaş. Bebeğiniz bu ay cinsiyetini göstermemekte ısrarcıysa kocaman bir soru işaretine ne dersiniz?",
    "Gebelikte en güzel aktivitelerden birisi ile tanışmaya hazır mısınız? Belki de tanışmışsınızdır. Yoga hareketleriyle kan dolaşımınızı arttırarak bebeğinizin daha iyi beslenmesini ve gelişmesini sağlayabilirsiniz.  Dilerseniz evde küçük bir ekipman edinerek, dilerseniz bir yoga kursuna giderek işe koyulabilirsiniz.(Evde yoga yapacaksanız, asgari haftada iki gün öneririz.) Yoga sonrası keyifli  bir anını bizimle paylaş! Sağlıklı bir ay olsun!",
    "Bu ay en sevdiğimiz şeylerden birini yapıyoruz. Ne mi? Bebeğinizin odasını dekore etmeliyiz! Dilediğiniz şekilde, renkte ister bol oyuncaklı, ister yalın ve hoş bir dekorasyon yapmak size kalmış! Bebeğinize en yakışanı seçeceğinizden eminiz.Odayı dekore etmeye başla, bizimle keyifli bir anını paylaş.Şimdiden kolay gelsin!",
    "Bu ay hamileliğiniz daha da ilerledi. Sizi rahat ve güzel bir doğum yapmak için yürüyüşe davet ediyoruz. İyi hissettiğiniz bir günde ,sakin ve keyifli bir yürüyüş ile güzel vakit geçireceksiniz! Gebelikteki şişlikler düzenli egzersiz ve yürüyüşler  ile azalacaktır. Bizimle yürüyüş rotanın ve senin olduğun bir anını  paylaş! Yürüyüşe piknik ile noktalamak keyifli olacaktır, bizden tavsiye!",
    "Bebeğiniz ve siz umarız iyisinizdir,  daha yorucu bir dönemden geçmektesiniz. Biraz daha dinlenebileceğiniz ve size huzur verecek aktiviteler yapacağınız bir ay dileriz. Bu ay yapacağımız etkinliğe bayılacaksınız! Bebeğinizin o minik ayakları sıcak kalsın diye minik bir patik örmeye ne dersiniz? Dilediğiniz renkte bir ip alarak işe koyulun. Bebeğinizin tenine zarar vermeyecek bir ip olması çok önemli!  Elinizin emeği tatlı bir patik harika olacak! Bizimle patiği ördüğün keyifli bir anını paylaşmayı unutma",
    "Doğuma az kaldı diyebiliriz. Çok heyecanlı bir ay! Umarız siz ve bebeğiniz sağlıklı ve iyi bir doğum süreci yaşarsınız. Bu ay son gebelik döneminiz. Bu yolculuğun sonuna yaklaştınız! Bizimle şık, kendini güzel bulduğun ve dilediğin yerde çekildiğin bu aya ait bir fotoğrafını paylaş. Bu son ayı da yine güzel kare ile bitir! Bu arada, her son bir başlangıçtır! Belki biraz daha yorucu fakat çok çok eğlenceli ve keyifli günler gelecek!",
    "Dokuz aylık beraberlikten sonra işte karşınızda bebeğiniz! Umarız sağlıklı bir doğum geçirmişsinizdir ve bebeğiniz çok iyidir. Bebeğiniz şimdi de kucağınızda büyümeye devam edecek. Onun her güzel anına tanıklık etmek isteyeceksiniz. Sizlerden bu yeni hayatınızda bebeğiniz hakkında duygularınızı ve düşüncelerinizi belirttiğiniz anlamlı bir kaç paragraf yazmanızı istiyoruz. Güzel bir ay olsun!",
    "Bu ay bebeğiniz için temalı bir fotoğraf çekimi yapmalıyız, çok heyecanlı! Bebeğinizi düz ve rahatsız olmayacağı bir yere yatırın ve havuç renginde yani turuncu renkte bir örtü ile kundaklayın. Kundaklarken tıpkı havuca benzer şekilde ayak kısmından örtüyü biraz daha uzatıp sarabilirsiniz. Bebeğinizi çok sıkmadığınızdan emin olun. Kafasına minik berelerinden yeşil olanını takıp başının üstüne de havucun üst kısmındaki yaprakları andıracak yapraklar ekleyin. İpucu verelim:  Maydanoz veya dereotu iyi olurdu. Şimdi minik bebeğiniz tatlı minik bir havuca benzemeli. Yanına dilediğiniz yeşil renkte bir nesne ile “2” rakamı yazarak fotoğraf çekin ve bizimle paylaşın. Nasıl göründüğünü şimiden merak ediyoruz. Keyifli bir ay olsun!",
    "Temalı fotoğraf serimizin üçüncüsü geliyor! Bebeğiniz üç aylık oldu bile! Bebeğinizi düz bir alan yatırmalısınız ve rahat olmalı. Bu ay ki temamız biraz farklı, öncelikle mavi renkte herhangi bir nesne bulup, bebeğinizin yanına bunun ile “3” rakamı yazmalısınız. Şimdi son bir iş kaldı bebeğinizin diğer yanına geçerek minicik eline bir şemsiye tutuşturun, dilerseniz bebeğinizin cinsiyetine göre pembe veya mavi şemsiye kullanabilirsiniz. Tam fotoğraflık bir kare oldu! Bu güzel fotoğrafı bizlerle paylaşın. Eğlenceli ve bol bol bebeğinizi keşfedeceğiniz bir ay olsun!",
    "Merhabalar! Umarız bebeğiniz ve siz gayet iyi ve sağlıklısınızdır. Bebeğiniz bu ay daha bilgili olacak! Bu ay ki etkinliğimiz bilge bir minik yaratmak. Bebeğinizi rahat edebileceği güvenli düz bir zemine yatırın. Evinizde bulunan bir kaç kitabı alarak bebeğinizin yanına götürün. Bebeğinizi dilerseniz kitabı açıp ortasına yatırabilir, dilerseniz kitapları yastık gibi kullanarak konumlandırabilirsiniz. Her nasıl olursa olsun bebeğiniz kafasının acımaması için bir minik yastık kullanmanızı tavsiye ediyoruz. Bir de okuma gözlüğü taktığınızda minik bilge hazır olacak. Bu etkinliği o uyurken sakince yapmanız sizin işinizi kolaylaştıracaktır. Bu karenin yanına kalemlere “4” rakamı çizmeyi unutmayın! Bu tatlı kareyi bizimle paylaşın.Güzel bir ay olsun!",
    "Selamlar! Yeni bir ay başlıyor ve heyecan dolu anlar bizi bekliyor! Bu ay serimize güzel bir tema daha ekleniyor: Balonlar! Bebeğinize düz bir alana güvende olacak şekilde yatırın ve yan tarafına bebeğinizin renkli giysileri ile “5” rakamını yazın. Daha sonra öteki yanına geçerek eline beş farklı renkte balon tutuşturun. Bebeğiniz balonlar ile tanışacağı için biraz heyecanlı ve sabit durmak istemeyebilir! Bu zor görev için şimdiden başarılar.Dilerseniz beyaz renkli herhangi bir örtü benzeri eşya kullanarak bulut ekleyebilirsiniz. Fotoğrafınızı paylaşmayı lütfen unutmayın!",
    "Bebeğiniz gün geçtikçe büyüyor. Sanırım bu ay sizlere yemek masasında eşlik edebilir çünkü ek gıdaya başlayabilir. Bunu bir etkinlik ile kutlamalıyız! Bu ayın etkinliği için gerekenler; bebeğinizin sığacağı ve rahatsız olmayacağı bir sepet ile bir kaç mevsime uygun meyve-sebze. Sepeti düz bir zemine bıraktıktan sonra içine bebeğinizi rahat edebileceği bir pozisyonda yerleştirin. Sepet ile bebeğiniz arasına yumuşak bir örtü koymanızı öneririz. Sepetin kenarlarına ve bebeğinizin üstüne elinizdeki meyve-sebzeleri yerleştirin. İşte sizin için en harika sepet! Şimdi bebeğinizi biraz neşelendirip güzel bir kare yakalama zamanı! Eğlenceli fotoğraflarınızı bekliyoruz. Tadımların getireceği yüz ifadeleri de eğlenceli olacaktır.Öyleyse bol tadımlar!",
    "Bu tema en güzellerinden biri! Bebeğinizi temiz minik bir kovanın daha iyisi saksıya benzer bir kovanın içine oturtun, başına bandana gibi takılabilecek, bebeğinizin kafasını sıkmayacak ve çiçeğin yapraklarını andıracak renkli bir nesne yerleştirin. Biraz geri çekilip baktığınızda bebeğiniz saksıda bir çiçeğe mi benziyor? Tam isabet! Dilerseniz yine konsepte uygun bir nesne ile “7” rakamını kullanabilirsiniz. Biraz da çiçeğinizi güldürebilirseniz harika bir kare olacak! Muhteşem konsept fotoğraflarınızı bekliyoruz. Heyecan verici bir etkinlik olsun. Mutlu bir ay dileriz.",
    "Sekizinci aya geldik bile! Bebeğinize ve size şimiden sağlıklı ve mutlu bir ay dileriz. Bu ay bebeğiniz için harika bir etkinliğimiz var! Bebeğinizi düz ve güvenli bir zemine oturtun. Bebeğinizi dilediğiniz sevimli bir hayvan dönüştürün! Panda, kurbağa,civciv, tavşan, kedi, kuş, aslan aklınıza ne geliyorsa… En tatlı anını fotoğraflayarak bizimle paylaşın. Dilerseniz diğer minik sevimli hayvan oyuncakları da temaya eşlik edebilir.",
    "Temalı fotoğraf serimize devam ediyoruz. Bu hem eğlenceli hem de bebeğiniz ve sizin iletişiminizi-bağınızı güçlendiren etkinliklerde şimdi sıra sizde. Bu ay ki konsept ne mi? Siz karar vereceksiniz. Dilediğiniz konseptte bir an yalayıp bizimle paylaşın. Bir anne olarak yaratıcılığınızı konuşturma zamanı!",
    "Bir önceki ayda harika iş çıkardınız, herkese tebrikler! Bu ay bebeğiniz biraz daha büyüdü ve artık yürümek için çabalıyor. Güzel bir heyecan yaşayabilirsiniz! Bu ay kızınızı/oğlunuzu prenses/prens ilan ediyoruz! Düz ve tek renk bir zemine bebeğinizi oturtun. Kızınız varsa tütü giydirip başına bir taç takabilirsiniz. Oğlunuz varsa bir papyon takabilir ve sarı kartondan basit bir kral tacı çizerek kesip başına bir taç takabilirsiniz. İşte prenses ve prensler hazır! En güzel/En yakışıklı fotoğraflarınızı bekliyoruz. Güzel bir ay olsun!",
    "Yeniden merhaba. Bebeğiniz büyümeye devam ediyor haliyle oyuncak sayısında da epey artış vardır. Bu ay ki etkinlikte düz ve tek renk bir zeminde bebeğinizi oturtun ve etrafına oyuncaklarını yerleştirin. Oyuncakları ister dağınık ister “11” rakamını oluşturacak şekilde yerleştirin. Dilerseniz bebeğinizin bir oyuncağını incelerken ki o meraklı bakışlarını veya en sevdiği oyuncağı ile bağını yakalayabilirsiniz. Bu eğlenceli anı bizimle paylaşın. Sağlıklı ve güzel bir ay dileriz.",
    "Selamlar! Bu ay ki etkinliği tahmin edebileceğinizi düşünüyoruz. Bebeğiniz bu ay ilk yaşına basıyor. Onun ilk yaşını kutlamak çok eğlenceli ve keyifli olacak. Ne çabuk büyüdü değil mi? Bebeğinizin doğum gününü kutladığınız en mutlu anlarınızdan birisini bizimle paylaşın. Bizlerde tatlı bebeğinizin doğum gününü kutluyor, sağlıklı ve mutlu bir gelecek diliyoruz. Happy Birthday to your baby!",
    "Umarız bebeğiniz ve siz iyisinizdir. Bu ay ki etkinliğimiz çekirdek ailenizi kapsıyor. Bebeğiniz, siz, baba varsa kardeşler ellerinizi boyamaya ne dersiniz? Bu etkinlikte isteyen istediği renk ile avuç içini ve parmaklarının iç tarafını boyuyor, daha sonra resim kağıdına elini kurumadan bastırıyor. Ailede kimler var, hangi renkler en sevilenler görelim mi? Yaptığınız bu resim ile dilerseniz ailenizle birlikte fotoğraf çekilerek paylaşın. Çok güzel aile fotoğrafları olacak!",
    "Merhabalar! Bu ayın aileniz için güzel geçmesini dileriz. Etkinliklerimize şimdi yine anne ve bebeği katarak  devam edeceğiz. Bu ay anne ördek ve civcivi olmak ister misiniz? Bu ayın etkinliği dilediğiniz bir hayvanı seçip bebeğinizi ve kendinizi o sevimli hayvana benzetmeye çalışmak olacak. Tam vakvaklarken fotoğrafınızı çekmeyi ve eğlenmeyi unutmayın, yoksa miyavlarken mi demeliydim? Basit bit bıyık ile kedigillerden bile olabilirsiniz, fikirler size kalmış! Bol eğlenceler o zaman!",
    "Selamlar! Bu ay bebeğiniz ile bir keşif oyunu oynayacağız! Tabi dilerseniz siz de eşlik edebilirsiniz. Bebeğinizi düz ve yakın durabileceği sabit bir aynanın karşısına oturtunuz. Arkasını desteyebilir veya aynanın ona zarar vermeyeceğinden emin olmalısınız. Bebeğiniz kendini aynada keşfetmeye başlayacaktır. Onun o heyecanlı ve şaşkın bir anını fotoğraflayarak bizimle paylaşın! Şimdiden Bol keşifler!",
    "Herkese merhaba! Bu ayın çok güzel geçmesini ve sağlıklı ve heyecanlı bir ay olmasını dileriz. bu ay bebeğiniz ve sizi birak ıslatmaya karar verdik. Mevsime göre havuz, şişme havuz, küvet hangisi sizin için uygunsa suyu doldurmaya başlayın! Bebeğinizin dikkatini çekebilecek ve suda batmayacak renkli birkaç oyuncak veya nesne suya atın. Şimdi bebeğiniz bu nesneleri yakalamaya çalışacak ve el-göz kordinasyonu sağlaması gerekecek. Onun bu mutlu ve gelişen anını bizimle fotoğraf çekerek paylaşın!",
    "Bu ay ki etkinliğimizde çok keyifli vakitler geçireceksiniz! Bebeğinize ait bir sanat eserine ne dersiniz? Bu ay yenebilir-yıkanabilir bebek boya kalemleri ve bir resim defteri ile şapkaya ihtiyacımız var! Bebeğinizi düz bi zemine oturtun veya destekli yatırın, önüne resim defterini açın ve kalemleri bırakın. Bakalım neler olacak! Belki biraz ona sanat eserinde ve çizmekte yardımcı olabilirsiniz. Bebeğinizin eğlendiği ve başında sanatçıların taktığı yan duran bir şapka ile fotoğrafını çekin ve bizimle paylaşın. Mutlu bir ay olsun!",
    "Selamlar! Etkinliğimiz biraz bebeğinizi zorlayabilir, ee hazine avcısı olmak kolay değil! Bu ay bebeğinizin sevdiği ve biraz iri oyuncaklarını bebeğinizi ucunu, köşesini ufak bir yerini görebileceği şekilde bir odaya gizliyoruz. Ve şimdi hazine avı başlasın! Bebeğiniz oyuncakları bulmaya çalışacak, belki ilki için ona yardımcı olabilirsiniz. Ganimetlerini topladıktan sonra, bebeğinize bir korsan göz bandı takarak mutlu olduğu bir anın fotoğrafını çekin ve bizimle paylaşın!",
    "Herkese mutlu bir ay dileriz! Bu ay ki etkinliğimiz biraz da yetişkinlerle ilgili desek? Bu ay bebek ya da büyük herkesin hoşuna giden o yastık ve battaniyelerle ev yapma etkinliği var! Gerekli battaniye, minder ve yastıkları toplayın ve çadır benzeri bebeğinizin ve sizin içine girebileceğiniz eğlenceli bir ortam hazırlayın. Bu çok eğlenceli kareyi fotoğraflayarak bizlerle paylaşmayı unutmayın! İyi eğlenceler!",
    "Güzel geçen etkinliklerimize bir yenisi daha ekleniyor! Bu ay siz annelerle biraz üreteceğiz. Bebeğiniz büyüdü ve meraklı, kaşif bir miniğe dönüştü. Bebeğinize minik birkaç tane parmak kuklası yaparak onun merakını azaltmaya ve dikkat çekmeye ne dersiniz? Bebeğinize kağıttan veya bezden 5 tane istediğiniz şekilde parmak kuklası hazırlayın. Bu kuklaları bir elinizin parmaklarınıza geçirin ve fotoğraflayın. Dilerseniz bebeğinize elinizi gösterdiğinizdeki ilginç tepkisi ile de bir kare paylaşabilirsiniz. En iyi kuklaları anneler yapar!",
    "Kuklalar harikaydı anneler! Hepsini çok beğendik! Şimdi sırada yine kesme yine renkler var. Bu ay küçükken öğrendiğimiz ve uçak yapımı olarak bilinen uçaklardan yapacağız. Renkli kağıtlar kullanarak veya dilediğiniz renklere kağıtları boyayarak küçüklü büyüklü 5-10 tane basit uçak yapın. Havanın fena olmadığı ve rüzgarında bulunduğu bir günde dışarı çıkın ve bebeğinizle bu uçurtmaları tepe sayılabilecek bir yerden aşağı doğru uçurun. Bu etkinlik için eşiniz veya arkadaşlarınızdan destek alabilirsiniz. Hem bebeğiniz ile ilgilenmek hem uçurtma uçurtmak hem de fotoğraflamak biraz zor olabilir.  Bu eğlenceli anı bizimle paylaşın. Keyifli uçuşlar!",
    "Selamlar! Bu etkinliğimizde sizleri yormama kararı aldık! Birkaç etkinliktir anneler çok girişken şimdi sıra bebeklerinizde! Bu ayn sabunlu su ile yapılan şu basit baloncuk yapan oyuncaktan bir iki tane alınız. Ve birinden de destek alarak iki kişi bebeğinizin üstüne bu baloncukları üfleyin! Bebeğiniz çok eğlenecek! Bu anı fotoğraflayarak bizlerle paylaşın. Tüm ay eğlenceli geçer umarız!",
    "Bebeğiniz ve sizler için tasarladığımız bu etkinlik serüvenimiz ne yazık ki bitmek üzere. Bu ay bebeğinize bir oyuncak yapmaya ne dersiniz? Bebeğinize ister kartondan ister bezden isterseniz başka bir materyalden yaratıcı bir oyuncak yapın! Onu geliştirecek, renki bir el yapımı oyuncak harika olacak! Bebeğinizin bu oyuncak ile oynarken fotoğrafını çekin ve bizimle paylaşın. Yaratıcılık işi siz annelerde! Şimdiden kolay gelsin!",
    "Bu ay bebeğiniz 2 yaşına basıyor. Bu süreçte bir çok eğlenceli vakit geçirdik! Sizlere çok teşekkür ederiz. Güzel bir doğum günü karesi ile vedalaşma vakti geldi. Umarız bebeğinizin sağlıklı, mutlu ve başarılı bir yaşamı olur. Doğum gününü kutlarız ve güzel bir ay dileriz. Hoşça kalın!",
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    return LayoutBuilder(builder: (context, viewportConstraints) {
      return Scaffold(
        bottomSheet: _isBabyBiggerThan24Months
            ? BottomSheet(
                backgroundColor:
                    isDarkMode ? Colors.transparent : CustomStyles.primaryColor,
                //shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                constraints:
                    BoxConstraints(maxWidth: viewportConstraints.maxWidth),
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  "Etkinliklerimiz yalnızca gebelik dönemindeki anneler ve 24 aydan küçük bebekler için tasarlanmıştır. Yeni etkinlikler için takipte kalın!"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                onClosing: () {},
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        extendBodyBehindAppBar: true,
        body: GameLevelsScrollingMap.scrollable(
          direction: Axis.horizontal,
          width: double.maxFinite,
          imageWidth: 3000,
          imageUrl: "assets/images/map_horizontal.png",
          svgUrl: "assets/images/map_horizontal.svg",
          points: points,
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fillTestData();
  }

  List<PointModel> points = [];
  int current = 0;
  void fillTestData() {
    UserModel? user = ref.read(userProvider);
    int babyMonths = calculateBabyMonth(user!.babyBirthDate!);
    isPregnant = user.isPregnant!;
    print("RECOX : babyMont $babyMonths");
    print("RECOX : isPregantn ${user.isPregnant!}");
    if (isPregnant) {
      current = user.months!.toInt();
      //hamile olduğu durumda
      for (int i = 1; i < 10; i++) {
        if (i < current) {
          points.add(PointModel(100, pastActivity(i, true))); //TODO tamamlanan
        } else if (current == i) {
          points.add(
              PointModel(100, currentActivity(i, true))); //TODO şuanki aktivite
        } else {
          points.add(PointModel(
              100, lockedActivity(i, true))); //TODO kiilitli aktivite
        }
      }
      for (int i = 1; i < 25; i++) {
        points.add(
            PointModel(100, lockedActivity(i, false))); //TODO kiilitli aktivite
      }
    } else {
      if (babyMonths <= 24) {
        //bebek 24 aylıktan küçük
        current = babyMonths; //Şuan bu değer 1
      } else {
        setState(() {
          _isBabyBiggerThan24Months = true;
          current = 34;
        });
      }
      //hamile olmadığı durumda
      for (int i = 1; i < 10; i++) {
        points.add(PointModel(100, pastActivity(i, true))); //TODO tamamlanan
      }
      for (int i = 1; i < 25; i++) {
        if (i < current) {
          points.add(PointModel(100, pastActivity(i, false))); //TODO tamamlanan
        } else if (current == i) {
          points.add(PointModel(
              100, currentActivity(i, false))); //TODO şuanki aktivite
        } else {
          points.add(PointModel(
              100, lockedActivity(i, false))); //TODO kiilitli aktivite
        }
      }
    }
  }

  Widget lockedActivity(int ay, bool isPregnant) {
    //TODO kilitli aktivite
    String baslik = "Gebelik $ay.Ay Etkinliği";
    String btnYazisi = "\nGebelik\n $ay.Ay";
    if (!isPregnant) {
      baslik = "Bebeğimin $ay. Ay Etkinliği";
      btnYazisi = "\nBebeğim\n$ay.Ay";
    }
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/map_horizontal_point(3).png",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
          Text(btnYazisi,
              style: const TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.grey,
          builder: (BuildContext context) {
            return Container(
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      baslik,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ListTile(
                    title: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.lock_outline, size: 80),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: null,
                        child: Text('Etkinliğe Başla'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget currentActivity(int ay, bool isPregnant) {
    String baslik = "Gebelik $ay. Ay Etkinliği";
    String btnYazisi = "\nGebelik\n$ay.Ay";
    int index = ay - 1;
    if (!isPregnant) {
      baslik = "Bebeğimin $ay Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$ay.Ay";
      index = ay + 8;
    }
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/map_horizontal_point.png",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
          Text(btnYazisi,
              style: const TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.purpleAccent,
          builder: (BuildContext context) {
            return Container(
              //color: Colors.white,
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        baslik,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        etkinlik_list[index],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text('Kapat'),
                          onPressed: () {
                            Navigator.pop(context); // Modal sayfasını kapat
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.lightGreenAccent),
                          ),
                          child: const Text('Etkinliğe Başla',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            context.push(
                                "/home/$index/${getActivityType(index)}/$isPregnant");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget pastActivity(int ay, bool isPregnant) {
    String baslik = "Gebelik $ay. Ay Etkinliği";
    String btnYazisi = "\nGebelik\n$ay.Ay";
    int index = ay - 1;
    if (!isPregnant) {
      baslik = "Bebeğimin $ay Aylık Etkinliği";
      btnYazisi = "\nBebeğim\n$ay.Ay";
      index = ay + 8;
    }
    return InkWell(
      hoverColor: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/map_horizontal_point(2).png",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
          Text(btnYazisi,
              style: const TextStyle(color: Colors.black, fontSize: 20))
        ],
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.green[400],
          builder: (BuildContext context) {
            return Container(
              //color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        baslik,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        etkinlik_list[index],
                        style: const TextStyle(
                          fontSize: 15,
                          //color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text('Kapat'),
                          onPressed: () {
                            Navigator.pop(context); // Modal sayfasını kapat
                          },
                        ),
                        const Text(
                          "   Etkinlik Tamamlandı",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(Icons.check_circle_outline, size: 25)
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  int calculateBabyMonth(DateTime babyBirthDate) {
    Duration diff = DateTime.now().difference(babyBirthDate);
    return (diff.inDays / 30).ceil(); //yaklaşık olarak her ayı 30 gün aldım
  }

  String getActivityType(int index) {
    if (index == 0 || index == 9) {
      return 'text_activity';
    } else {
      return 'photo_activity';
    }
  }
}
