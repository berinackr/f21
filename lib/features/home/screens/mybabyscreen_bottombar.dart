import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/controller/auth_controller.dart';
import '../../../core/custom_styles.dart';
import 'chatgpt_screen.dart';

class MyBabyScreenBottombar extends ConsumerStatefulWidget {
  const MyBabyScreenBottombar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyBabyScreenBottombarState();
}

class _MyBabyScreenBottombarState extends ConsumerState<MyBabyScreenBottombar> {
  var titleList = [
    "1. Ay Gebelik",
    "2. Ay Gebelik",
    "3. Ay Gebelik",
    "4. Ay Gebelik",
    "5. Ay Gebelik",
    "6. Ay Gebelik",
    "7. Ay Gebelik",
    "8. Ay Gebelik",
    "9. Ay Gebelik",
    "1 Aylık Bebek",
    "2 Aylık Bebek",
    "3 Aylık Bebek",
    "4 Aylık Bebek",
    "5 Aylık Bebek",
    "6 Aylık Bebek",
    "7 Aylık Bebek",
    "8 Aylık Bebek",
    "9 Aylık Bebek",
    "10 Aylık Bebek",
    "11 Aylık Bebek",
    "12 Aylık Bebek",
    "13 Aylık Bebek",
    "14 Aylık Bebek",
    "15 Aylık Bebek",
    "16 Aylık Bebek",
    "17 Aylık Bebek",
    "18 Aylık Bebek",
    "19 Aylık Bebek",
    "20 Aylık Bebek",
    "21 Aylık Bebek",
    "22 Aylık Bebek",
    "23 Aylık Bebek",
    "24 Aylık Bebek",
  ];

  var infoList = [
    "Biberon Uygulamasına hoşgeldiniz! Bebeğinizin gelişim sürecine dair bilgileri burada bulabilirsiniz. İlk belirtileri henüz erken dönemde fark etmemiş olabilirsiniz. Birinci ayda hamilelik belirtileri gözle görülmez ve çoğu zaman fark edilmez. Yine de bu yolculuğun başlangıcını merak ettiyseniz uygulamamızda bu süreci daha yakından tanıyabilirsiniz. Bebeğiniz hücrelerden oluşan bir top şeklinde oluşmaya başlar ve rahim duvarına tutunur. Şimdilik bebeğiniz bir elma çekirdeği kadar küçüktür. Gebelik testi sonucunuzu pozitif çıkaran HCG hormonunuz salgılanmaya başlar. Hatta bu hormonun salgılanmaya başlaması ile gebelik testiniz pozitif cevap verecektir. Bebeğiniz, organlarının yavaş yavaş gelişmeye başladığı embriyo aşamasına ilerler. Gebe olduğunuzu fark ettiğiniz andan itibaren öncelikle alkol, sigara ve diğer tüm olumsuz unsurlardan arınmalısınız. Ayrıca düzeni bir beslenme planı ile günde yaklaşık on iki bardak su içmenin de en az bunun kadar önemli olduğunu unutmayınız.Heyecan verici bilgiler ve eğlenceli içeriklerle dolu bu yolculuğa hazır mısınız? Haydi, keşfedin ve hamileliğinizle ilgili daha fazla bilgi edinin!⭐Yaklaşık 80 gebelikten biri ikiz gebeliktir.",
    "Hoşgeldin ikinci ay! Şimdi bebeğiniz sadece 2 gram ağırlığında ve bu ayda bebeğinize Latince “genç” anlamına gelen, fetus adı verilmektedir.Parmaklarının oluşması için biraz daha beklemesi gerekiyor, ama eller ve ayaklar gelişim gösterir, hızlı bir şekilde büyümeye devam eder. Kalp vücuda kan pompalamaya başlamıştır. Beyin lobları ise hızlı gelişim gösterir. Göz kapakları da yavaş yavaş belirginleşmeye başladığından dolayı bebeğiniz ufak ufak hareket etmeye başlamış olmalı. Ay bitmeye başladığında yaklaşık olarak küçük bir çilek büyüklüğünde olacaktır. Ne kadar tatlı, değil mi? Bu ay, bu küçük çilekten haberdar olma ihtimalinizin çok yüksek olduğu bir aydır. Ve dolayısıyla doktor muayeneleriniz başlar. Doktor gözetmenliğinde ve önerilen ölçüde bebeğinizin omurilik yapısının gelişimi için folik asit kullanmaya başlamalısınız. Ve bu ayın ortalarına doğru kusma ve mide bulantısı şikayetlerinizde artış olacaktır. Bu sebeple sık sık ve az yemek yemeli, ağır ve yağlı yiyecekler yemekten kaçınmalısınız. Rafine şeker, asitli içecek, paketli gıda tüketimi yapıyorsanız sonlandırmalısınız. Bebeğinizin sekizinci haftada oluşmaya başlayan kemik ve dişlerinin gelişimi için kalsiyum çok önemlidir! Süt ürünleri ve yeşil yapraklı bitkiler bu bakımdan zengindir bu sebeple bol bol tüketmelisiniz. Ayrıca süt ürünlerinin yağ oranı yüksek olduğundan dolayı yağı alınmış olanları tercih etmelisiniz. Kusma ve bulantı durumunuzda, tüm dikkatinize rağmen değişiklik yoksa doktorunuzdan TİT tahlili isteyebilirsiniz. Son olarak anne-baba adayı olarak kan grubunuzu bilmiyorsanız, test yaptırmalısınız.Bu anlamlı ve desteği hak eden bir yolculuk, şimdiden zengin öğünler dileriz!⭐Gebelik sesinizi değiştirebilir!",
    "Merhaba üçüncü ay! Şu an fetüsün boyu yaklaşık 7-8 cm ve ağırlığı yaklaşık 14 gram kadardır. Bir limon veya mandalina büyüklüğündedir diyebiliriz. Kol, bacak ve parmaklar yavaş yavaş şekillenir. Derisinin altında omurga belirginleşmeye başlarken, organlar da çalışmaya başlar. Böbrekler, beyin, karaciğer ve bağırsaklar aktif hale geçer. Bu dönemde yüz hatları belirginleşirken, tırnaklar ve ses telleri de ortaya çıkar. Gövdesine oranla başı daha büyüktür. Parçalanan parmaklar artık ayrılır ve cinsiyet organı da kendini göstermeye başlar. Yani, artık bebeğinizin cinsiyetini öğrenmek ve bebek alışverişi için heyecanlanmaya başlayabilirsiniz. Bu süreçte her şey daha da heyecan verici hale geliyor! Gebeliğinizin bu ayında hormon değişimlerinden dolayı aşırı duygusal olabilir, küçük şeylere üzülebilirsiniz. Ve değişen vücut yapınız ile birlikte, anne adayı olarak düzenli beslenme planı oluşturmuş ve ona sadık bir şekilde devam ediyor olmalısınız. Günlük enerjinizin %12-15’i protein, %55-60’ı karbonhidrat ve %25-30’u yağlardan meydana gelmelidir. Ayrıca bu ay kusma ve bulantı şikayetlerinizde azalma görülecektir ve bu sizi rahatlatacaktır.Dilerseniz mide yanması ve sindirim güçlüğü için doktorunuzdan ilaç önerisi isteyebilirsiniz. Elbette ilaç kullanımı konusunda ağrı kesici dahi olsa doktorunuza danışmalısınız. 11. hafta ile 14. hafta arasında kesinlikle İkili Tarama Testi yaptırmalısınız. Bu test kromozomal anomalileri saptamaya yönelik bir testtir. Dilerseniz doğum öncesi kurslarını araştırabilirsiniz. Tüm bunlar olurken yeni bir heyecana başlamak için tam da sırası, küçük mandalinanız için artık isim düşünmeye başlayabilirsiniz!⭐Hamileyken kalbiniz büyür!",
    "Merhaba, en heyecanlı aylardan birindeyiz! Bu dönem, bebekler için gerçekten önemli bir aydır. Göz kırpma, kaş çatma ve parmak emme gibi sevimli hareketler başlar. Hem boyu hem de kilosu hızla gelişir. Başı ve vücudu artık eşit boyutlara sahiptir. Ayak tırnakları bile gelişmeye başlar. Dört aylık bebeğiniz, karnınızın içinde kollarını ve bacaklarını kullanarak aktif bir şekilde hareket eder. Bu hareketleri fark etmeniz için erken bir aydır. Kalbinin gelişimi devam eden bebeğiniz, bu dönemde ciğerlerindeki amniyotik sıvıyı atmaya odaklanır ve tat alma duyularını geliştirmek için çabalar.  Ve ek bilgi olarak, bebeğiniz bazı yiyecekleri anne karnında sizinle tadar. Bu ay ile birlikte iştah artışı olacaktır bu sebeple kilo kontrolüne özen göstermelisiniz. Meyve kan şekerinizi hızlıca yükseltir veya düşürür bu sebeple yanında muhakkak protein içeren bir besin tüketmelisiniz. Ayrıca anomaliyi(kansızlık) önlemek adına doktorunuzun önerisi kadar demir takviyesi almanızda fayda var. Yüksek topuklu ayakkabı giymemeli, dik durmaya özen göstermeli, ani ve zor hareketlerden kaçınmalı, rahat ve bol giysiler tercih etmelisiniz. Doktorunuzun talebine bağlı olarak ya üçlü yada dörtlü test yaptırmalısınız. Muhtemelen bu ay sonunda kızınız ya da oğlunuz olacağını öğrenmiş olacaksınız. Yaşayacağınız heyecan dolu anlardan biri olacağı kesin!⭐Gebelikte bebekler annelerinin yedikleri şeylerin tatlarını alabilirler!",
    "Merhaba 5. Aydasınız! Bebeğiniz artık parmak emme işlemine yutkunmayı da eklediğini biliyor muydunuz? Gebeliğin bu aşamasında, bebeğinizin derisini koruma altına alan bir tabaka olan "
        "verniks caseosa"
        " gelişmeye başlar. Ayrıca 5.aylık bebeklerin cildinden "
        "lanugo"
        " adı verilen ince tüyler çıkmaya başlar. Ancak endişelenmeyin, bu tüyler ilerleyen dönemlerde dökülecektir. Saçları ve kaşları da belirginleşen bebeğinizin beyni hızla gelişirken, ter bezleri de oluşmaya başlar. Ayrıca 5. ayda bebeğin bağırsaklarında siyah ve yapışkan bir madde olan "
        "meconium"
        " oluşur. Bu madde, bebeğinizin doğumunun ardından, ilk dışkıyla birlikte atılır. Dişleri oluşmaya başlar.Gebeliğin 4. ayının sonu ile 5. ayının ortası arasında bebeğin cinsiyeti belirginleşir. Bu da bebeğinize alışveriş yapmak için en doğru zaman olduğunu gösterir. Bu süreçte bebeğin gelişimi muhteşem bir şekilde ilerliyor! Artan sıvı kaybınızı gidermek adına süt, kefir, ayran gibi probiyotik kaynaklar tüketilmesiniz. Hareketlerinize dikkat etmeli, belinizi fazla zorlamamalı ve sürekli ayakta durarak iş yapmamalısınız. Beslenme programına uymaya devam etmelisiniz. Bebeğinizin hareketlenmeye başladığı ve ilk tekmeyi hissettiğiniz dönemlerde olmalısınız. Harika bir duygu olmalı! Ayrıntılı ultrason(Fetal Anomali Taraması) ile parmak yapısı, iç organlarının gelişimi, plasentanın durumu, rahim ağzı uzunluğunun belirlenmesi gibi parametreler incelenir ve normalden farklı bir durum olup olmadığı kontrol edilir.Bu ay bebeğiniz oldukça gelişir. Bu sebeple karın bölgenizde çatlaklar başlar. Badem yağı, kakao yağı veya hindistan cevizi yağı ile bu bölgeyi nemlendirmelisiniz. Bol bol egzersiz yapmanızın ve mümkünse tatile çıkmanızın tam vakti! ⭐Her 2000 bebekten biri dişli doğar!",
    "Hoş geldin 6. Ay! Bu ay genellikle gebeliğin en iyi dönemidir. Süratli bir kilo artışı yaşamadıysanız bu ay içinde epey kilo alabilirsiniz. Bebeğiniz acı, ekşi ve tatlıya tepki verir, yüz ifadeleri kazanır. Hareketleri artık daha belirgin hale gelir. Yumruk ve tekmeleriyle size kendini hatırlatır. Tüyler hala bebeğinizin üzerindedir, çünkü henüz dökülmezler. Bu aylarda bebeğinizin pankreası hızla gelişir ve hormonları değişir. Kalınlaşan kordon ise iletişim aracı olarak görev yapar. Onunla konuşmak, şarkılar söylemek için harika bir zaman! Derisi kalınlaşır, beyni hızla gelişir ve akciğerleri aktif hale gelmeye başlar. Ancak hala dış dünyaya tam anlamıyla hazır değil. Bu süreçte bebeğinin büyüme ve gelişme yolculuğu sürer. Hissettiğin hareketlerle birlikte bebeğin gerçekliği daha da güçlenir. Ayrıca bu dönemde hormonlarınızın etkisi ile diyabet hastası olma ihtimaliniz yükselir bu yüzden 24. ile 28. haftalar arasında Şeker Yükleme Testi yapılır.Bebeğinizin sizi daha güzel hale getirir!⭐Gebelikte kan miktarı %50 artar ve bu sebeple anne adaylarının ciltleri güzelleşir, yanakları pembeleşir.",
    "Merhaba 7. Ay! Bebeğiniz doğuma hazırlık yaparken nefes alışveriş hareketlerini sıklaştırır. Hareketleri artık hissedilebilir seviyede ve uyuma, hareket etme, hıçkırma gibi aktivitelere dalar. Beyin dokusu ve kıvrımları gelişmeye devam eder, kafatasında büyüme görülebilir. Kemikler önem kazanırken, cildi yumuşar ve kilo alır. Gözleri daha da güçlenir. Doğuma bir adım daha yaklaşıyorsunuz!⭐Bebeklerin doğdukları anda parmak izleri yoktur.Parmak izi ilk üç ayda oluşur.",
    "Hoş geldin 8. Ay! Bebeğinizin gerçek saçları bu dönemde oluşmaya başlar. Kemikler henüz tam sertleşmediği için doğum rahatça gerçekleşebilir ve erken doğumlarda da büyük bir sıkıntı yaşanmaz. Bebeğinizin gelişimi neredeyse tamamlanmış durumda olup, sadece sinir sistemi ve akciğerlerin tam gelişimi kalır. 5 aylık gelişimde ortaya çıkan "
        "lanugo"
        " adı verilen tüyler bu dönemde yok olmaya başlar. Bebeğiniz hala tekme atıp kilo almaya devam ederken, amniyotik sıvıdan da kurtulur. Baş aşağı pozisyonda olan bebeğinizde genellikle ilk bağırsak hareketleri gerçekleşir. Yaklaşan doğum için hazır mısınız?⭐Gebelerin vücudunda ortalama 6.6 litre su bulunur!",
    "Merhaba 9. Ay! Bebeğinizin akciğer gelişimi tamamlanır ve doğuma hazırlanır. Doğduğu anda vücut ısısını koruyacak yağ tabakası oluşur ve kilo alımı ve irileşme en üst düzeye ulaşır. Artık bebeğinizin sesini duymaya ve minik elleriyle sizin parmaklarınızı sıkmaya çok az kaldı. Bu uygulama ile bebeğinizin son aylarındaki gelişimini yakından takip edebilir, doğuma hazırlık sürecini daha iyi anlayabilirsiniz. Doğum anı yaklaşırken heyecan dorukta!9 aylık hamilelikte artık doğum her an olabilir. İşte doğum belirtileri: Yalancı kasılmaların sayısında artış, yuva kurma içgüdüsünde artış, düzenli kasılmaların başlaması ve her 10 veya 15 dakikada bir olması, düzenli kasılmaların zamanının uzaması, kasılma sıklığı ve şiddetinin artması, yürüdüğünüzde veya uzandığınızda kasılmaların şiddetinin artması, sırt ve karnınızın alt kısmında yani kasıklarınızda regl sancılarına benzeyen ağrılar hissetmeniz, ishal, rahim ağzında bulunan serviks yani mukus tıkacı yumuşadığı için kan gelmesi, sık sık tuvalete gitme ihtiyacı ve amniyon sıvısının az veya çok gelmesi (zarların yırtılması).Bu belirtiler olursa mutlaka doktorunuza haber verin.⭐Anneler yenilmez kahramanlardır!",
    "Doğum gününüzü kutlayın! İşte hayatınızın en büyük macerasına başladınız. Bebeğinizi sık sık besleyin ve onunla konuşun. Henüz kelimeleri anlamasa da seste rahatlık bulacaktır. Uyku düzeninizi bebeğinizin ki ile uyumlu hale getirin, çünkü bu dönemde uyku çok önemlidir. Bebekle etkileşim kurmak için şarkı söyleyin ve dans edin. Şu anda sizin en büyük hayranınız olduğunu unutmayın! Bebeğiniz için çeşitli renkler ve şekiller içeren yumuşak oyuncaklar alın. Onları keşfetmeye bayılacak.Şu sıralar göz kasları gelişmeye başlar. Ve bir aylık bebeğiniz sizin sesinizi ayırt edebilir! Emzirmeyle ilgili bir açıklama yapmak istiyorum: İlk günlerde bebeği yatarak emzirme, anne için daha rahat olabilir. Bu durumda bebek yan yatmış olan anneye dönük yatırılır. Anne, serbest kolu ve eli ile bebeği memesine yaklaştırabilir. Annenin ve bebeğin arkasının birer yastıkla desteklenmesi, bebeğin yerleşmesine yardımcı olur. Eğer anne oturarak emziriyorsa dik oturmalı veya hafifçe eğilmeli, ancak kucağı düz olmalıdır. Bunun için gerekirse emzirirken ayaklarının altına bir tabure konabilir. Bebeği emzirirken rahatça tutması için annenin kucağına da yastık konulabilir. Ve bir önemli nokta var ki bebeğiniz emme sırasında sadece meme ucunuzu kavramasın!",
    "Bebeğinizi sırt üstü yatırarak hareket etmeye çalıştığını izleyin. O küçük kollar ve bacaklar hızla güçlenecek! Ona masallar okuyun. Belki hikayeleri anlamasa da sesinizin ritmi ve tonu onu rahatlatacaktır. Bebeğinizi güneş ışığına maruz bırakın. Bu, D vitamini üretimine yardımcı olur ve bebeğinizin kemiklerinin sağlıklı olmasını sağlar. Kendinize de zaman ayırın ve biraz dinlenin. Bazen en iyi anne, dinlenmiş bir anne olmaktır! Bebeğinizin tuhaf ve komik yüz ifadelerini fotoğraflayın. Bu anıları ileride gülerek hatırlayacaksınız. Bebeğinizin mutluluk ya da kızgınlık duygularını ifade etme biçimi zenginleşir.Bu ayda bebeğiniz büyük cisimleri gözleriyle takip eder ve gözlerini diker. Yattığı yerde kafasını kaldırır. Ve artık szileri yani anne ve babasını tanır! NOT: Bu ay yaptıracağınız aşınızı lütfen unutmayınız!",
    "Bebeğiniz üç aylık oldu bile! Bebeğinizin yüzünün ifadesini taklit etmeyi deneyin. Bu, onun sosyal becerilerini geliştirmesine yardımcı olur. Ona basit şarkılar söyleyebilir ve ritimli müzikler çalabilirsiniz. Dans ederken neşeli anlar yaşayacaksınız! Bebeğinizi karnını üstte kalacak şekilde yüzükoyun yatırarak zaman geçiriniz. Bu, kaslarının güçlenmesine yardımcı olacaktır. Parmak boyasıyla sanat etkinlikleri yapabilirsiniz, hem eğlenceli hem de onun duyusal gelişimine katkı sağlayacaktır.Bebeğinizin yüzündeki ifadeleri taklit ederek onunla komik bir "
        "yüz dili"
        " oluşturabilirsiniz. Şimdi bebeğiniz insanları birbirinden ayırma yetisine sahiptir. Başını ve bedenini daha iyi kontrol edebilir, nesneleri tüm ayrıntılarıyla görebilir. Son olarak uyku ve beslenme düzeni gelişir.",
    "Bebeğinizi yan yatırarak destekleyebilir ve bu pozisyonda oyunlar oynayabilirsiniz. Bu, onun motor becerilerini geliştirmesine yardımcı olur. Renkli ve hareketli oyuncaklarla bebeğinizin ilgisini çekebilirsiniz. El ve göz koordinasyonunu geliştirecek etkileşimler sağlayabilirsiniz. Bebek için uyku rutinleri oluşturabilir, onun rahatlamasına ve daha iyi uyumasına yardımcı olabilirsiniz. Masaj yaparak bebeğinizin rahatlamasını sağlayabilir, nazik dokunuşlar onun hem fiziksel hem de duygusal sağlığına iyi gelir. Müzik, bebeğinizin duygusal gelişimini destekler ve eğlenceli bir deneyim sağlar. Ona farklı sesler ve müzikler dinletebilirsiniz. Bebeğiniz bu ayda artık ya diş çıkarmaya hazırlanır ya da çıkarır. Ve şimdi de ellerinde tuttuğu cismin konumunu değiştirebilir.NOT: Bu ay yaptıracağınız aşınızı lütfen unutmayınız!",
    "Bu ay bebeğinizin ilk dişleri çıkabilir, bu nedenle diş kaşıyıcılar ve soğutulmuş oyuncaklar kullanarak rahatlamasına yardımcı olabilirsiniz. Bebeğinizle beraber ellerinizi kullanarak basit oyunlar oynayabilirsiniz. Parmak oyunları ve el hareketleri onun dikkatini çekebilir. Bebeğinize yavaş yavaş katı yiyecekler tanıtmaya başlayın. İlk başta sebze ve meyve püreleri ile çok kısa tanıştırabilirsiniz. Bebeğinizle güvenli bir şekilde su içinde oynayabilirsiniz. Suyun hareketi ve hissi onun için eğlenceli olacaktır. Ayrıca 5 aylık bir bebek kalçasının üstünde destek almadan oturabilir ve başını dik tutabilir. Adını söylediğinizde tepki verecektir ve ufak ufak emeklemeye başlar. Ve artık daha yavaş kilo almaya başlar. İyi eğlenceler!",
    "Bebeğinizin oturabilme becerisini destekleyebilirsiniz. Yastık ve minderlerle destekleyici oturma alanları oluşturabilirsiniz.Parçalı oyuncaklarla oynamaya ilgi duyar çünkü el becerileri gelişecektir. Bloklarla kuleler yapmak ve onları yıkmak bebeğinizin el-göz koordinasyonunu geliştirecektir.İsimleri ve nesneleri tekrar etmek suretiyle bebeğinizin dil gelişimine katkıda bulunabilirsiniz. Sebzelerin ve meyvelerin çeşitliliğini artırarak bebeğinizin beslenmesini zenginleştirebilirsiniz. Bebeğiniz bu ayda neden-sonuç ilişkisi kurmaya ve bu doğrultuda davranmaya başlar.Mutluluk, sevgi, korku, sabırsızlık, heyecan gibi hissettiği duygular artar ve kendini mimikleriyle, vücut diliyle ya da çıkardığı seslerle ifade eder.Ve bu ay resmen ek gıdaya geçiş yapabilirsiniz! NOT: Bu ay yaptıracağınız aşınızı lütfen unutmayınız!",
    "Bebeğinizin emeklemeyi keşfetmesine olanak sağlayacak ortamlar hazırlayabilirsiniz. Oyuncaklarla dolu bir alanda güvenli bir şekilde hareket etmesine yardımcı olabilirsiniz. Bebeğinizin dikkatini çekecek öğrenme oyuncakları kullanarak, şekilleri yerleştirme, blokları yığma gibi etkinliklerle zekasını geliştirebilirsiniz. Tüm elini kullanmak yerine parmaklarını kullanmayı öğrenecektir.Bebeğinizin çeşitli dokuları keşfetmesini sağlayacak malzemeler sunabilir, yumuşak, sert, tüylü veya pürüzlü yüzeylerle etkileşime geçmesine destek olabilirsiniz. Bebeğinizin denge kurma yeteneği olgunlaşır. Yürüteç veya destekli yürüme araçlarıyla bebeğinizin ayakta durmayı denemesi faydalı olacaktır. Ancak güvenliği sağladığınızdan emin olmalısınız. İlk kelimelerini teşvik etmek için basit cümleler kullanarak bebeğinizle konuşabilirsiniz. Söylediklerinizi taklit etmesi için ona zaman vermelisiniz. Bol alıştırmalar!",
    "Bebeğinizin mobilyalara ve eşyalara tutunarak ayakta durma ve hareket etme becerisini destekleyebilirsiniz.Alçak mobilyalara, merdivenlere ve açabildiği çekmecelere tırmanmaya çalışmayı sever. Kitapları kullanarak bebeğinizin nesneleri gösterme ve isimlendirme becerisini geliştirebilirsiniz, kişiliği gelişmeye başlar.Bebeğinizin kendi kendine beslenme becerilerini teşvik edin. Parmak yiyecekleri vererek kendi kendine yemek yeme deneyimini yaşatmak için çabalayabilirsiniz. Yaratıcı oyunlarla bebeğinizin hayal gücünü destekleyebilirsiniz. Kuklalar, el kuklaları veya basit rol yapma oyunlarıyla eğlenceli anlar sizi bekliyor! Bebeğinizle müzikli oyunlar oynayabilir,  ritimli şarkılarla dans edin veya müzik aletleriyle beraber çalmayı deneyebilirsiniz. 8 aylık bebek gelişimi sırasında bebeğiniz sizi taklit ederek, nasıl davranacağını öğrenmeye başlar. Konuşmanızı olmasa da mimiklerinizle konuşmanızı taklit eder. Bütün hareketlerinizi izler ve yeri geldikçe tekrarlar. Örnek davranışlar serisi gelsin o zaman, iyi eğlenceler!",
    "Bebeğinizin yürümeye başladığı bu dönemde güvenli bir ortam sağlamaya özen gösterebilir, kenarları korumalı ve bebek kapılarıyla erişimi kontrol altında tutabilirsiniz. Küplerle veya oyuncak arabalarla yapılar inşa ederek bebeğinizin el becerilerini geliştirebilirsiniz. Farklı hayvanları taklit ederek bebeğinizin dikkatini çekmek çok kolay! Bu ay bebeğiniz seslerin geldiği yöne doğru yönelecektir. Ona hayvan seslerini öğretmek ve beraber oyunlar oynamak eğlenceli olacaktır. Bebeğinizin özbakım becerilerini teşvik edebilir, kendi başına elini yüzünü yıkama, kendi kendine yeme gibi aktiviteleri destekleyebilirsiniz. Bebeğinizin ve sizin yaratıcılığınızı beslemek için boya kalemleri veya parmak boyaları yeterli! İlk anne, baba, mama kelimelerini duymaya hazır olun! Ayrıca bebeğiniz bu dönemde her şeyi keşfetmeye başlar. Bu nedenle evdeki elektrik prizlerini kapalı tutmalı, deterjan, çamaşır suyu veya ilaç gibi tehlikeli maddeleri bebeğinizin ulaşamayacağı yerlerde saklamalısınız. ",
    "Kitap okuma rutininizi sürdürebilir ve bebeğinizin interaktif kitaplara ilgi göstermesine teşvik edebilirsiniz. Bebeğinizle parklara veya açık alanlara gitmek için zaman ayırmalı,  onun doğayı keşfetmesine ve enerjisini atmasına yardımcı olmalısınız.Yardımınızla yürümek için adımlar atmaya başlar.Bebeğiniz sallanarak veya mırıldanarak müziğe tepki verebilir, eşlik edebilir ve el sallama, alkışlama gibi eylemleri gerçekleştirebilir. İki kelimeyi birleştirerek basit cümleler kurabilir ve bebeğinizin konuşma becerilerini arttırabilirsiniz. Öyleyse size bol hecelemeli günler!",
    "Bebeğinizin nesneleri tutma ve bırakma becerisini geliştirmek için el-göz koordinasyonunu destekleyen oyuncaklar almalısınız. Bebeğinizle daha fazla etkileşimli oyunlar oynayabilir, örneğin "
        "saklambaç"
        " veya "
        "pat-a-cake"
        " gibi oyunlar ile  bebeğinizin dikkatini ve sosyal becerilerini geliştirebilirsiniz. Bebeğinizin keşfetmek için güvenli alanlara ihtiyacı olduğunu unutmayınız. Evinizde veya bahçenizde bebeğinizin rahatlıkla hareket edebileceği, keşfedebileceği bir ortam hazırlayabilirsiniz. Parmak yiyeceklerini bebeğinizin öğrenmesine ve beslenme becerilerini geliştirmesine olanak sağlamak için sunmaya devam etmelisiniz.Bebeğinizin hareketliliğini ve enerjisini yönlendirecek, dans etmek veya müzikle oynamak gibi etkinlikler yaparak, güzel bir uykuyu ikiniz de hak edebilirsiniz! Bebeğiniz nesneleri bilinçli olarak yerlerine koyar, kendi kendine kaşığı ağzına götürebilir, kendi ayakkabı ve çorabını çıkarabilir. Ve bazı nesne ve semboller arasında bağlantı kurabilir. Son olarak yaptığı her şeyi onaylamanızı bekler. İyi eğlenceler!",
    "Bebeğinizin yürüme becerisini daha da desteklemeli ve ona cesaret vermelisiniz. Destekleyici oyuncak arabalar veya yürüteçler kullanabilirsiniz. Bebeğinizin kelime hazinesini genişletmek için etrafta gördüğü nesneleri ve hayvanları onun için adlandırabilirisiniz.. Dokunma kitapları ve oyuncakları kullanarak bebeğinizin dokunsal hislerini keşfetmesine ve dokunma duyusunu geliştirmesine yardımcı olabilirsiniz. Basit hayal gücü oyunlarına ne dersiniz? Örneğin, oyuncak bebeklerle veya hayvanlarla, role bürünerek hikayeler anlatabilirsiniz. Telefon, araba gibi oyuncakları kullanmayı öğrenir. Bebeğinizin bağımsızlık duygusunu destekleyebilir ve kendi kendine giyinme veya ayakkabılarını bağlama gibi becerileri teşvik edebilirsiniz. Şimdi bebeğiniz bardaktan su içebilir, uyumak için direnebilir ve sizden ayrılırsa çok tepki gösterebilir. Kendisine söylenen pek çok şeyi anlar. Ruh hali sürekli değişir. Size ve tanıdıklarınıza ilgi gösterir. Ayırca espri anlayışı da gelişir!",
    "Bebeğinizin doğum gününü kutlayın! İlk yaşınıza girmesi büyük bir başarıdır! Bebeğinizin ellerini ve parmaklarını kullanarak basit şekiller çizmesine olanak sağlayabilirsiniz. Bebeğinizin sosyal becerilerini geliştirmek için oyun gruplarına veya oyun saatlerine katılabilirsiniz.  İki veya üç kelimeyi birleştirerek basit cümleler kurmasını teşvik edebilirsiniz.Bebeğinizin kendi kendine yeme becerilerini geliştirmek için küçük parçalara ayrılmış ve kolay tutulabilir yiyecekler sunmalısınız. İyi ki bizimlesin minik, iyi ki doğdun!",
    "Bebeğinizin el becerilerini geliştirmek için puzzle gibi yapboz oyuncakları kullanmalısınız. İç mekanlarda ve dışarıda bebeğinizin hareket etmesine ve enerjisini atmasına olanak sağlayacak alanlar yaratmalısınız. Bebeğinizin duygusal bağlantılar kurmasını teşvik etmelisiniz, sevgi ve güven dolu bir ortamda, sarılmalar ve öpücüklerle onun duygusal gelişimine destek olmalısınız. Basit şarkıları birlikte söyleyebilir ve hareketli müzikle dans etmek için zaman ayırabilirsiniz. Bebeğinizin çeşitli dokuları ve malzemeleri keşfetmesine olanak sağlamak için  farklı kumaşlar, kabartmalı kitaplar ve duyusal oyunlar kullanabilirsiniz.",
    "Bebeğinizin kendini ifade etmesine olanak sağlamak için kelime ve işaret dili kombinasyonunu kullanabilirsiniz. Bloklarla yapılar inşa ederek bebeğinizin el-göz koordinasyonunu ve problem çözme becerilerini geliştirmesine yardımcı olabilirsiniz. Günlük rutinlere devam etmeli ve bebeğinizin sorumluluk almasına olanak sağlamalısınız. Örneğin, kendi oyuncaklarını toplamasını veya masaya yardım etmesini isteyebilirsiniz. Bebeğinizle resim yapma veya boya yapma etkinlikleri devam etmeli. parmak boyaları veya büyük fırçalar kullanarak sanatı keşfetmesine izin vermelisiniz. Kitapları kullanarak hikayeler anlatıp, hayal gücünü destekleyebilirsiniz.",
    "Bebeğinizin duygusal bağımsızlığını destekleyip  aynı zamanda ona güvenli sınırlar ve kurallar da koymalısınız. Müzik aletleri veya ritimli oyuncaklarla müzikle etkileşimli oyunlar oynayabilirsiniz. Bebeğinizin ritim ve melodiye tepki vermesini gözlemleyerek eğlenceli vakitler geçirebilirsiniz. Farklı renkleri ve şekilleri tanıtmak için oyuncaklar veya çizimler kullanabilirsiniz. Örneğin, kırmızı top veya mavi daire gibi örneklerle bebeğinizin dikkatini çekebilirsiniz. Bebeğinizle dışarıda doğa yürüyüşlerine çıkabilir ve çevresini keşfetmesine olanak sağlayabilirsiniz. Bebeğinizin giyinme becerilerini geliştirmesine yardımcı olabilirsiniz.. Kolayca giyilebilen kıyafetler tercih etmeli ve ona kendi başına denemesine izin vermelisiniz. Sizlere bebeğinizle keyifli bir ay dileriz!",
    "Bebeğinizin hayal gücünü destekleyen oyuncaklarla oynamasına olanak sağlamalısınız, örneğin bebekleri beslemek veya telefon konuşması yapmak gibi rol yapma oyunlarına katılabilirsiniz. Bebeğinizin dil becerilerini desteklemek için ona farklı nesnelerin ve hayvanların isimlerini söyleyebilirsiniz. Bu kelime dağarcığını genişletmesine yardımcı olacak. Basit komutları anlamaya başlayan bebeğinizle birlikte oyunlar oynamalısınız. Örneğin, "
        "topu getir"
        " veya "
        "kucaklaşalım"
        " gibi basit talimatlar vererek onun anlama ve uygulama becerilerini desteklemelisiniz. Bebeğinizin sosyal etkileşimlerini artırmak için oyun gruplarına katılabilir veya diğer çocuklarla etkileşimde bulunabileceği ortamlar yaratabilirsiniz. Günlük rutinlerde bebeğinizin yardım etmesine ve sorumluluk almasına izin verebilir, örneğin masayı kurmak veya oyuncakları toplamak gibi görevleri onunla birlikte yapabilirsiniz. Birlikte dağıtma ve birlikte toplama zamanı!",
    "Bebeğinizin motor becerilerini geliştirmek için parkta veya bahçede oynamaya devam edebilirsiniz. Sallanma, kaydırağa binme veya top oynama gibi etkinliklere katılımını teşvik etmelisiniz. Bebeğinizin öğrenmeye olan ilgisini desteklemek için etkileşimli kitaplar kullanmalısınız. Resimleri göstererek hikayeler anlatabilir ve onun hikayeye katılmasını teşvik edebilirsiniz. Müzik ve dans etkinlikleriyle bebeğinizin ritim duygusunu ve beden farkındalığını geliştirebilirsiniz. Basit matematik kavramlarını bebeğinize keşf ettirebilirsiniz. Örneğin, oyuncaklarını sayarak veya blokları sıralayarak sayıları ve miktarları anlamasına katkıda bulunabilirsiniz. Bebeğinizin duygusal ifadelerini tanımasına ve ifade etmesine yardımcı olabilir,  sevinç, üzüntü veya korku gibi duyguları tanımlamayı deneyebilirsiniz. NOT: Bu ay yaptıracağınız aşılarınızı lütfen unutmayınız!",
    "Bebeğinizin hayal gücünü teşvik etmeli ve oyun oynaması için farklı karakterler ve roller sunmalısınız. Örneğin, doktorculuk veya market oyunu gibi etkinliklere katılmasını sağlayabilirsiniz. Bebeğinizin inisiyatif almasına ve kendi kararlarını vermesine izin vermelisiniz. Örneğin, kıyafet seçme veya oyuncak seçme gibi basit kararlarında ona özgürlük tanıyabilirsiniz. El-göz koordinasyonunu ve ince motor becerilerini desteklemek için parmak boyama, yapboz yapma veya boncuk dizme gibi etkinliklere katılmasına olanak sağlamalısınız. Bebeğinizle açık uçlu sorularla iletişim kurabilir ve onun düşünme ve ifade becerilerini geliştirmesine yardımcı olabilirsiniz. Çeşitli yiyecekleri ve tatları denemeye devam edebilir, bebeğinizin damak zevkini genişletmek için yeni tarifler öğrenebilirsiniz. Şimdiden afiyet olsun!",
    "Bebeğinizin oyun ve etkileşimde olduğu ortamlarda başkalarının sınırlarına saygı duymayı öğrenmesine yardımcı olmalısınız. Örneğin, paylaşma ve beklemeyi öğrenmesini destekleyebilirsiniz. Bebeğinizin duygusal ifadeleri anlamasına ve kendini ifade etmesine yardımcı olabilirsiniz. Duygusal durumları tanımlamak ve onun duygusal tepkilerini onaylamak onun duygusal gelişimini destekleyecek! Büyük hareketler ve fiziksel aktivitelerle bebeğinizin enerjisini yönlendirmelisiniz. Koşma, zıplama veya top oynama gibi etkinliklere katılması faydalı olacak. Bebeğinizin sözcük dağarcığını genişletmeye devam edebilir ve ona yeni kelimeler öğretebilirsiniz. Nesneleri adlandırmak ve basit cümleler kurmak için bebeğinizle etkileşimde bulunun. Bebeğinizin kendi kendine giyinme, ayakkabı bağlama gibi becerilerini kazanmaya başlamalı. Ona yardımcı olmalı, ancak bağımsızlığına da saygı göstermelisiniz. Mutlu bir ay dileriz!",
    "Bebeğinizin öz-bakım becerilerini önemli! Örneğin tuvalet eğitimi veya diş fırçalama gibi günlük rutinlere onu dahil etmeye başlayabilirsiniz. Hayal gücünü teşvik etmek için bebeğinizle hikaye anlatma ve rol yapma oyunları oynamaya devam! Basit matematik kavramlarını keşfetmeye devam etmeli, örneğin sayma, renk eşleme veya boyut farklılıklarını gözlemleme gibi etkinliklere katılmasını teşvik etmelisiniz. Bebeğinizle açık havada zaman geçirmek eğlenceli olacaktır ve doğa keşifleri yapmasına olanak sağlamalısınız. Bitkileri, hayvanları ve çevresini keşfetmesini izleyin!. Bebeğinizin duygusal gelişimini desteklemek için ona sevgi, şefkat ve empati göstermeye devam!",
    "Bebeğinizin özgüvenini desteklemeli ve başarılarına odaklanmalısınız. Ona küçük görevler vererek başarma hissini deneyimlemesine olanak sağlayabilirsiniz. Bebeğinizin hayal dünyasını beslemek için kurgusal hikayeler anlatmalı ve onunla birlikte resimler çizerek veya oyunlar oynayarak yaratıcılığını geliştirebilirsiniz. İletişim becerilerini geliştirmek için bebeğinizle daha karmaşık cümleler kullanmalı ve onunla diyalog kurmaya önem vermelisiniz. Bebeğinizin hareket kabiliyetini ve denge becerilerini geliştirmek için dans etme, jimnastik hareketleri yapma veya bisiklete binme gibi etkinliklere götürebilirsiniz. Bebeğinizin sorumluluk almasını destekleyerek ve günlük aktivitelerde ona görevler vererek kendi kendine yetebilme becerisini geliştirmesine yardımcı olmalısınız.",
    "Bebeğinizin sosyal becerilerini desteklemek için oyun gruplarına katılabilir ve diğer çocuklarla etkileşimde bulunmasına olanak sağlayabilirsiniz. Bebeğinizin isimleri hatırlama becerisini geliştirmek için aile fotoğraflarını gösterebilir ve yakınlarıyla video aramaları yaparak onun bağlantılarını güçlendirebilirsiniz. Bebeğinizle birlikte müzik yapma etkinlikleri yaparak, şarkılar söyleyerek ve enstrümanları keşfetmesine izin vererek ritmik zekasını güçlendirebilirsiniz. Bebeğinizle resim yapma, yapıştırma veya basit el işi projeleri yapma gibi yaratıcı etkinliklere katılabilirsiniz. Bebeğinizin hareket becerilerini geliştirmek için parkta veya bahçede koşma, zıplama, top oynama gibi fiziksel aktivitelere zaman ayırmalısınız. Bebeğinizin sözcük dağarcığını genişletmeye devam edebilir ve ona yeni kelimeler öğretebilirsiniz. Nesneleri adlandırarak ve basit cümleler kurarak iletişim becerilerini destekleyebilirsiniz. Bebeğinizin bağımsızlık ve özgürlük hissi geliştirmesi için günlük aktivitelerde ona yardımcı olmasına izin verin. Örneğin, giyinme, ayakkabı bağlama veya oyuncakları toplama gibi görevler vermelisiniz. Bebeğinizin hayal gücünü teşvik etmek için kuklalarla veya oyuncaklarla, hikayeler oluşturun ve rol yapma oyunlarına katılmasını destekleyebilirsiniz. Bebeğinizin duygusal gelişimini desteklemek için sevgi dolu bir ortam önemli, onun hislerini tanımasına ve ifade etmesine yardımcı olmalısınız. Bebeğinizle açık havada vakit geçirmeli, doğayı keşfetmesine olanak sağlamalı ve bitkileri, hayvanları tanımasına yardımcı olmalısınız.",
    "Bebeğinizin el becerilerini geliştirmek için oyuncakları yığma, bloklarla yapılar inşa etme veya parça-bütün ilişkisi kurma gibi etkinliklere katılmasını sağlamalısınız. Bebeğinizle birlikte resim yapma veya yapıştırma gibi basit el sanatlarıyla ilgili etkinlikler öneririz. Farklı malzemelerle deney yapmasına ve yaratıcılığını sergilemesine izin verebilirsiniz. Bebeğinizin motor becerilerini ve beden farkındalığını geliştirmek için oyun parkına gidebilir ve kayma, tırmanma veya sallanma gibi fiziksel etkinliklere katılmasını sağlayabilirsiniz. Bebeğinizin duygusal gelişimini desteklemek için onun hislerini tanımasına ve ifade etmesine yardımcı olmalı, duygusal bir destek sağlamak için sevgi dolu bir ortam yaratmalısınız. Bebeğinizin sosyal etkileşimlerini artırmak için diğer çocuklarla oynaması ve paylaşması için fırsatlar kollamak önemli! Oyun gruplarına veya çocuk etkinliklerine katılmasını sağlamak onu destekler. Bebeğinizin günlük rutinlerde daha fazla bağımsızlık kazanmasını desteklemelisiniz. Örneğin, kendisi giyinme, el yüz yıkama veya oyuncakları toplama gibi görevlere katılmasına olanak tanımalısınız. Bebeğinizle kitap okuma alışkanlığına devam! Hikayelerin içeriğini anlamasına ve yorumlamasına izin vermelisiniz. Bebeğiniz ile sizler için bu son bilgilendirme metnimiz. Umarız faydalı bir vakit geçirmişsinizdir. Size ve bebeğinize sağlıklı mutlu bir hayat dileriz. Hoşça Kalın!",
  ];

  var iconList = [
    Icon(
      Icons.calendar_month,
      color: Color.fromARGB(255, 255, 0, 0),
      size: 32,
    ),
    Icon(
      Icons.diamond,
      color: Color.fromARGB(255, 255, 59, 0),
      size: 36,
    ),
    Icon(
      Icons.pregnant_woman,
      color: Color.fromARGB(255, 255, 85, 0),
      size: 36,
    ),
    Icon(
      Icons.celebration,
      color: Color.fromARGB(255, 255, 115, 0),
      size: 36,
    ),
    Icon(
      Icons.local_florist,
      color: Color.fromARGB(255, 255, 166, 0),
      size: 36,
    ),
    Icon(
      Icons.local_restaurant_outlined,
      color: Color.fromARGB(255, 255, 209, 0),
      size: 36,
    ),
    Icon(
      Icons.shopping_basket_outlined,
      color: Color.fromARGB(255, 237, 255, 0),
      size: 36,
    ),
    Icon(
      Icons.music_note_rounded,
      color: Color.fromARGB(255, 207, 255, 0),
      size: 36,
    ),
    Icon(
      Icons.favorite,
      color: Color.fromARGB(255, 172, 255, 0),
      size: 36,
    ),
    Icon(
      Icons.cake,
      color: Color.fromARGB(255, 138, 255, 0),
      size: 36,
    ),
    Icon(
      Icons.face,
      color: Color.fromARGB(255, 69, 255, 0),
      size: 36,
    ),
    Icon(
      Icons.child_friendly,
      color: Color.fromARGB(255, 0, 255, 16),
      size: 36,
    ),
    Icon(
      Icons.spa_sharp,
      color: Color.fromARGB(255, 0, 255, 106),
      size: 36,
    ),
    Icon(
      Icons.face,
      color: Color.fromARGB(255, 0, 255, 166),
      size: 36,
    ),
    Icon(
      Icons.grade,
      color: Color.fromARGB(255, 0, 255, 231),
      size: 36,
    ),
    Icon(
      Icons.stream_sharp,
      color: Color.fromARGB(255, 0, 237, 255),
      size: 36,
    ),
    Icon(
      Icons.light_mode_outlined,
      color: Color.fromARGB(255, 0, 202, 255),
      size: 36,
    ),
    Icon(
      Icons.hotel_class,
      color: Color.fromARGB(255, 0, 151, 255),
      size: 36,
    ),
    Icon(
      Icons.filter_vintage,
      color: Color.fromARGB(255, 0, 117, 255),
      size: 36,
    ),
    Icon(
      Icons.looks,
      color: Color.fromARGB(255, 0, 87, 255),
      size: 36,
    ),
    Icon(
      Icons.eco,
      color: Color.fromARGB(255, 0, 48, 255),
      size: 36,
    ),
    Icon(
      Icons.cake,
      color: Color.fromARGB(255, 21, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.bedtime,
      color: Color.fromARGB(255, 89, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.yard_outlined,
      color: Color.fromARGB(255, 115, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.water_sharp,
      color: Color.fromARGB(255, 136, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.emoji_nature_sharp,
      color: Color.fromARGB(255, 171, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.all_inclusive,
      color: Color.fromARGB(255, 209, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.interests_outlined,
      color: Color.fromARGB(255, 243, 0, 255),
      size: 36,
    ),
    Icon(
      Icons.child_care,
      color: Color.fromARGB(255, 255, 0, 219),
      size: 36,
    ),
    Icon(
      Icons.insights,
      color: Color.fromARGB(255, 255, 0, 177),
      size: 36,
    ),
    Icon(
      Icons.filter_vintage_outlined,
      color: Color.fromARGB(255, 255, 0, 121),
      size: 36,
    ),
    Icon(
      Icons.grade,
      color: Color.fromARGB(255, 255, 0, 82),
      size: 36,
    ),
    Icon(
      Icons.filter_2,
      color: Color.fromARGB(255, 255, 0, 27),
      size: 36,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    CustomStyles().responsiveTheme(isDarkMode);
    double width = MediaQuery.of(context).size.width * 0.75;
    final user = ref.watch(userProvider);
    bool? isPregnant = user!.isPregnant;
    DateTime dateOfNow = new DateTime.now();
    int? babyAge;
    if (user!.babyBirthDate != null) {
      babyAge = dateOfNow.month - user.babyBirthDate!.month;
    } else {
      babyAge = -10;
    }
    double? monthController = user!.months;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BaslangicWidget(ref: ref),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Color(0xff46949B),
                    width: 1,
                  )),
              child: ListView.builder(
                  itemCount: iconList.length,
                  itemBuilder: (context, index) {
                    Color ResponsiveColor() {
                      if (isPregnant! && monthController == index + 1) {
                        return Color(0xff98CDD2);
                      } else if (isPregnant == false && babyAge! + 8 == index) {
                        return Color(0xff98CDD2);
                      } else {
                        return CustomStyles.fillColor;
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        showAlertDialog(context, infoList[index]);
                      },
                      child: Card(
                        color: ResponsiveColor(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 10,
                              child: (iconList[index]),
                            ),
                            Spacer(flex: 1),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titleList[index],
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: "YsabeauInfant",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Container(
                                    width: width,
                                    child: Text(
                                      infoList[index],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "YsabeauInfant",
                                        fontWeight: FontWeight.normal,
                                        color: CustomStyles.forumTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SoruMetni(),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: SorButonu(),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String info) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(33))),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(info),
              ],
            ),
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                // Onay butonuna tıklandığında yapılacak işlemler
                Navigator.of(context).pop();
                // Diğer işlemler...
              },
              child: Icon(
                Icons.check_circle_outline_sharp,
                color: Colors.green,
                size: 40,
              ),
            ),
          ),
        ],
      );
    },
  );
}

class BaslangicWidget extends StatefulWidget {
  final WidgetRef ref;
  const BaslangicWidget({super.key, required this.ref});

  @override
  State<BaslangicWidget> createState() => _BaslangicWidgetState();
}

class _BaslangicWidgetState extends State<BaslangicWidget> {
  @override
  Widget build(BuildContext context) {
    final user = widget.ref.watch(userProvider);

    return Container(
      child: Center(
        child: Text(
          "Merhaba ${user!.username.toString()}, bu ay bebeğin hakkında bilmen gerekenler var;",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "YsabeauInfant",
            fontWeight: FontWeight.bold,
            color: CustomStyles.forumTextColor,
          ),
        ),
      ),
    );
  }
}

class SoruMetni extends StatelessWidget {
  const SoruMetni({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Merak Ettiklerini Biberon Yapay Zekaya Sor ",
        style: TextStyle(
          fontSize: 17,
          fontFamily: "YsabeauInfant",
          fontWeight: FontWeight.bold,
          color: CustomStyles.forumTextColor,
        ),
      ),
    );
  }
}

// class SoruWidgeti extends StatefulWidget {
//   SoruWidgeti({super.key});
//   final TextEditingController controller = TextEditingController();
//
//   @override
//   State<SoruWidgeti> createState() => _SoruWidgetiState();
// }
//
// class _SoruWidgetiState extends State<SoruWidgeti> {
//   TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextField(
//         controller: _textEditingController,
//         keyboardType: TextInputType.multiline,
//         maxLines: 3,
//         decoration: InputDecoration(
//           hintText: "Sorunuzu yazınız...",
//           border: OutlineInputBorder(),
//         ),
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

class SorButonu extends StatelessWidget {
  const SorButonu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatGPTScreen()),
        );
      },
      child: const Text(
        "SOR",
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        fixedSize: Size(120, 60),
        primary: Color(0xffFFDEDE),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
    ));
  }
}
