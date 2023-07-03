class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs1 = [
    Song(
      title: 'Mışıl Mışıl',
      description: "Bebeğiniz mışıl mışıl uyusun",
      url: 'assets/audio/misil_misil.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Uyku Vakti',
      description: 'Uyku getiren tınılar',
      url: 'assets/audio/uyku_vakti.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Uyu Bebeğim',
      description: 'Çan sesleri',
      url: 'assets/audio/uyu_bebegim.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Rahatlatıcı Çan Sesi',
      description: 'Hemen uykuya dalın',
      url: 'assets/audio/sakin_canlar.mp3',
      coverUrl: '',
    ),
  ];

  static List<Song> songs2 = [
    Song(
      title: 'Sakin Ruh',
      description: "Ruhu dinlendiren melodi",
      url: 'assets/audio/sakin_ruh.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Doğa Sesi',
      description: 'Doğanın akışına kapıl',
      url: 'assets/audio/dogasesi.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Yağmur Sesi',
      description: 'Beyaz gürültü sayesinde rahatla',
      url: 'assets/audio/yagmursesi.mp3',
      coverUrl: '',
    ),
  ];

  static List<Song> songs3 = [
    Song(
      title: 'Mozart ve Keman',
      description: "Mozart'a eşlik eden keman",
      url: 'assets/audio/mozart_ve_keman.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Piyano Şöleni',
      description: 'Mükemmel piyano tınıları',
      url: 'assets/audio/piyano_söleni.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Rahatlatıcı Piyano',
      description: 'Piyano sesleri ile huzuru bul',
      url: 'assets/audio/rahatlatici_piyano.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Yumuşak Keman Sesleri',
      description: 'Keman ile rahatla',
      url: 'assets/audio/yumusak_keman.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Dinlendirici Piyano',
      description: 'Rahatlatıcı piyano sesleri',
      url: 'assets/audio/sakin_piyano.mp3',
      coverUrl: '',
    ),
  ];

  static List<Song> songs4 = [
    Song(
      title: 'Neşelen',
      description: "Neşelenme vakti",
      url: 'assets/audio/neselen.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Dans Et',
      description: 'Kendini ritme kaptır',
      url: 'assets/audio/dans_et.mp3',
      coverUrl: '',
    ),
    Song(
      title: 'Mutlu Ol',
      description: 'Mutlu hissettiren melodiler',
      url: 'assets/audio/mutlu_ol.mp3',
      coverUrl: '',
    ),
  ];
}
