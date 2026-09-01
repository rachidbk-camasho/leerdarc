import '../models/models.dart';

/// All learning content for Leer Darija.
/// Darija is written in Latin transliteration (the way it's commonly typed/
/// spoken by learners) with Arabic script alongside, and Dutch translations.
class DarijaContent {
  static const List<DarijaLevel> levels = [basis, a1, a2];

  // ---------------------------------------------------------------------
  // BASIS
  // ---------------------------------------------------------------------
  static const basis = DarijaLevel(
    id: 'basis',
    title: 'Basis',
    description: 'De eerste woordjes om mee te beginnen',
    emoji: '🌱',
    lessons: [
      Lesson(
        id: 'basis_groeten',
        title: 'Groeten',
        subtitle: 'Zeg hallo en dag',
        emoji: '👋',
        cards: [
          DarijaCard(darijaLatin: 'Salam', darijaArabic: 'سلام', dutch: 'Hallo'),
          DarijaCard(darijaLatin: 'Salam alaykoum', darijaArabic: 'السلام عليكم', dutch: 'Vrede zij met u', note: 'Formele begroeting'),
          DarijaCard(darijaLatin: 'Sbah lkhir', darijaArabic: 'صباح الخير', dutch: 'Goedemorgen'),
          DarijaCard(darijaLatin: 'Msa lkhir', darijaArabic: 'مسا الخير', dutch: 'Goedenavond'),
          DarijaCard(darijaLatin: 'Kif dayer?', darijaArabic: 'كيف داير؟', dutch: 'Hoe gaat het?', note: 'Tegen een man'),
          DarijaCard(darijaLatin: 'Kif dayra?', darijaArabic: 'كيف دايرة؟', dutch: 'Hoe gaat het?', note: 'Tegen een vrouw'),
          DarijaCard(darijaLatin: 'Labas', darijaArabic: 'لاباس', dutch: 'Het gaat goed'),
          DarijaCard(darijaLatin: 'Bslama', darijaArabic: 'بسلامة', dutch: 'Tot ziens'),
        ],
      ),
      Lesson(
        id: 'basis_beleefdheid',
        title: 'Beleefdheid',
        subtitle: 'Alsjeblieft, dank je, sorry',
        emoji: '🙏',
        cards: [
          DarijaCard(darijaLatin: 'Afak', darijaArabic: 'عفاك', dutch: 'Alsjeblieft'),
          DarijaCard(darijaLatin: 'Shukran', darijaArabic: 'شكرا', dutch: 'Dank je'),
          DarijaCard(darijaLatin: 'Bla jmil', darijaArabic: 'بلا جميل', dutch: 'Geen dank'),
          DarijaCard(darijaLatin: 'Smeh liya', darijaArabic: 'سمح ليا', dutch: 'Sorry / pardon'),
          DarijaCard(darijaLatin: 'Iyeh', darijaArabic: 'إيه', dutch: 'Ja'),
          DarijaCard(darijaLatin: 'La', darijaArabic: 'لا', dutch: 'Nee'),
          DarijaCard(darijaLatin: 'Wakha', darijaArabic: 'وخا', dutch: 'Oké / prima'),
        ],
      ),
      Lesson(
        id: 'basis_cijfers',
        title: 'Cijfers 1-10',
        subtitle: 'Leer tellen in het Darija',
        emoji: '🔢',
        cards: [
          DarijaCard(darijaLatin: 'Wahed', darijaArabic: 'واحد', dutch: 'Een (1)'),
          DarijaCard(darijaLatin: 'Jouj', darijaArabic: 'جوج', dutch: 'Twee (2)'),
          DarijaCard(darijaLatin: 'Tlata', darijaArabic: 'تلاتة', dutch: 'Drie (3)'),
          DarijaCard(darijaLatin: "Rb3a", darijaArabic: 'ربعة', dutch: 'Vier (4)'),
          DarijaCard(darijaLatin: 'Khamsa', darijaArabic: 'خمسة', dutch: 'Vijf (5)'),
          DarijaCard(darijaLatin: 'Setta', darijaArabic: 'ستة', dutch: 'Zes (6)'),
          DarijaCard(darijaLatin: "Sb3a", darijaArabic: 'سبعة', dutch: 'Zeven (7)'),
          DarijaCard(darijaLatin: 'Tmnya', darijaArabic: 'تمنية', dutch: 'Acht (8)'),
          DarijaCard(darijaLatin: "Ts3oud", darijaArabic: 'تسعود', dutch: 'Negen (9)'),
          DarijaCard(darijaLatin: "3achra", darijaArabic: 'عشرة', dutch: 'Tien (10)'),
        ],
      ),
      Lesson(
        id: 'basis_vraagwoorden',
        title: 'Vraagwoorden',
        subtitle: 'Wat, waar, wanneer, wie',
        emoji: '❓',
        cards: [
          DarijaCard(darijaLatin: 'Ashnou?', darijaArabic: 'أشنو؟', dutch: 'Wat?'),
          DarijaCard(darijaLatin: 'Fin?', darijaArabic: 'فين؟', dutch: 'Waar?'),
          DarijaCard(darijaLatin: 'Fuqash?', darijaArabic: 'فوقاش؟', dutch: 'Wanneer?'),
          DarijaCard(darijaLatin: "3lash?", darijaArabic: 'علاش؟', dutch: 'Waarom?'),
          DarijaCard(darijaLatin: 'Shkoun?', darijaArabic: 'شكون؟', dutch: 'Wie?'),
          DarijaCard(darijaLatin: 'Kifash?', darijaArabic: 'كيفاش؟', dutch: 'Hoe?'),
          DarijaCard(darijaLatin: 'Shhal?', darijaArabic: 'شحال؟', dutch: 'Hoeveel?'),
        ],
      ),
      Lesson(
        id: 'basis_kleine_woorden',
        title: 'Kleine woordjes',
        subtitle: 'Handig in elk gesprek',
        emoji: '✨',
        cards: [
          DarijaCard(darijaLatin: 'Iwa', darijaArabic: 'إيوا', dutch: 'Nou / oké dan'),
          DarijaCard(darijaLatin: 'Bezzaf', darijaArabic: 'بزاف', dutch: 'Veel'),
          DarijaCard(darijaLatin: 'Shwiya', darijaArabic: 'شوية', dutch: 'Beetje'),
          DarijaCard(darijaLatin: 'Daba', darijaArabic: 'دابا', dutch: 'Nu'),
          DarijaCard(darijaLatin: 'Ghedda', darijaArabic: 'غدا', dutch: 'Morgen'),
          DarijaCard(darijaLatin: "L'bareh", darijaArabic: 'البارح', dutch: 'Gisteren'),
          DarijaCard(darijaLatin: 'Hna', darijaArabic: 'هنا', dutch: 'Hier'),
          DarijaCard(darijaLatin: 'Temma', darijaArabic: 'تما', dutch: 'Daar'),
        ],
      ),
    ],
  );

  // ---------------------------------------------------------------------
  // A1
  // ---------------------------------------------------------------------
  static const a1 = DarijaLevel(
    id: 'a1',
    title: 'A1',
    description: 'Eenvoudige gesprekken over jezelf en je dag',
    emoji: '🟢',
    lessons: [
      Lesson(
        id: 'a1_familie',
        title: 'Familie',
        subtitle: 'Praat over je gezin',
        emoji: '👨‍👩‍👧',
        cards: [
          DarijaCard(darijaLatin: 'Baba', darijaArabic: 'بابا', dutch: 'Vader / Papa'),
          DarijaCard(darijaLatin: 'Yemma', darijaArabic: 'يما', dutch: 'Moeder / Mama'),
          DarijaCard(darijaLatin: 'Khouya', darijaArabic: 'خويا', dutch: 'Mijn broer'),
          DarijaCard(darijaLatin: 'Khti', darijaArabic: 'ختي', dutch: 'Mijn zus'),
          DarijaCard(darijaLatin: 'Weld', darijaArabic: 'ولد', dutch: 'Zoon / jongen'),
          DarijaCard(darijaLatin: 'Bnt', darijaArabic: 'بنت', dutch: 'Dochter / meisje'),
          DarijaCard(darijaLatin: 'Jdd', darijaArabic: 'جد', dutch: 'Opa'),
          DarijaCard(darijaLatin: 'Jdda', darijaArabic: 'جدة', dutch: 'Oma'),
        ],
      ),
      Lesson(
        id: 'a1_eten_drinken',
        title: 'Eten & drinken',
        subtitle: 'Bestel iets lekkers',
        emoji: '🍽️',
        cards: [
          DarijaCard(darijaLatin: 'Khobz', darijaArabic: 'خبز', dutch: 'Brood'),
          DarijaCard(darijaLatin: 'Atay', darijaArabic: 'أتاي', dutch: 'Muntthee'),
          DarijaCard(darijaLatin: 'Qahwa', darijaArabic: 'قهوة', dutch: 'Koffie'),
          DarijaCard(darijaLatin: 'Ma', darijaArabic: 'ما', dutch: 'Water'),
          DarijaCard(darijaLatin: 'Tajine', darijaArabic: 'طاجين', dutch: 'Tajine'),
          DarijaCard(darijaLatin: 'Kouskous', darijaArabic: 'كسكس', dutch: 'Couscous'),
          DarijaCard(darijaLatin: 'Hout', darijaArabic: 'حوت', dutch: 'Vis'),
          DarijaCard(darijaLatin: 'Djaj', darijaArabic: 'دجاج', dutch: 'Kip'),
          DarijaCard(darijaLatin: 'Fakiha', darijaArabic: 'فاكهة', dutch: 'Fruit'),
        ],
      ),
      Lesson(
        id: 'a1_kleuren',
        title: 'Kleuren',
        subtitle: 'Benoem kleuren',
        emoji: '🎨',
        cards: [
          DarijaCard(darijaLatin: 'Hmer', darijaArabic: 'حمر', dutch: 'Rood'),
          DarijaCard(darijaLatin: 'Khder', darijaArabic: 'خضر', dutch: 'Groen'),
          DarijaCard(darijaLatin: 'Zreq', darijaArabic: 'زرق', dutch: 'Blauw'),
          DarijaCard(darijaLatin: 'Sfer', darijaArabic: 'صفر', dutch: 'Geel'),
          DarijaCard(darijaLatin: 'Kehel', darijaArabic: 'كحل', dutch: 'Zwart'),
          DarijaCard(darijaLatin: 'Byed', darijaArabic: 'بيض', dutch: 'Wit'),
          DarijaCard(darijaLatin: 'Bni', darijaArabic: 'بني', dutch: 'Bruin'),
        ],
      ),
      Lesson(
        id: 'a1_dagen',
        title: 'Dagen van de week',
        subtitle: 'Van zondag tot zaterdag',
        emoji: '📅',
        cards: [
          DarijaCard(darijaLatin: "Nhar l7ad", darijaArabic: 'نهار الحد', dutch: 'Zondag'),
          DarijaCard(darijaLatin: 'Nhar ttnin', darijaArabic: 'نهار الاتنين', dutch: 'Maandag'),
          DarijaCard(darijaLatin: 'Nhar ttlat', darijaArabic: 'نهار الثلاث', dutch: 'Dinsdag'),
          DarijaCard(darijaLatin: "Nhar larb3", darijaArabic: 'نهار الأربع', dutch: 'Woensdag'),
          DarijaCard(darijaLatin: 'Nhar lkhmis', darijaArabic: 'نهار الخميس', dutch: 'Donderdag'),
          DarijaCard(darijaLatin: "Nhar jjem3a", darijaArabic: 'نهار الجمعة', dutch: 'Vrijdag'),
          DarijaCard(darijaLatin: 'Nhar ssebt', darijaArabic: 'نهار السبت', dutch: 'Zaterdag'),
        ],
      ),
      Lesson(
        id: 'a1_bestellen',
        title: 'In het café',
        subtitle: 'Bestel eten en drinken',
        emoji: '☕',
        cards: [
          DarijaCard(darijaLatin: 'Bghit...', darijaArabic: 'بغيت...', dutch: 'Ik wil...'),
          DarijaCard(darijaLatin: "3afak, 3tini...", darijaArabic: 'عفاك، عطيني...', dutch: 'Alsjeblieft, geef me...'),
          DarijaCard(darijaLatin: 'Shhal hadi?', darijaArabic: 'شحال هادي؟', dutch: 'Hoeveel kost dit?'),
          DarijaCard(darijaLatin: "L7sab, 3afak", darijaArabic: 'الحساب، عفاك', dutch: 'De rekening, alsjeblieft'),
          DarijaCard(darijaLatin: 'Bnina!', darijaArabic: 'بنينة!', dutch: 'Smakelijk!'),
          DarijaCard(darijaLatin: 'Ana 3atshan', darijaArabic: 'أنا عطشان', dutch: 'Ik heb dorst'),
          DarijaCard(darijaLatin: 'Ana jiaan', darijaArabic: 'أنا جيعان', dutch: 'Ik heb honger'),
        ],
      ),
    ],
  );

  // ---------------------------------------------------------------------
  // A2
  // ---------------------------------------------------------------------
  static const a2 = DarijaLevel(
    id: 'a2',
    title: 'A2',
    description: 'Redzaam op de souk, straat en in gesprek',
    emoji: '🔵',
    lessons: [
      Lesson(
        id: 'a2_souk',
        title: 'Op de souk',
        subtitle: 'Winkelen en afdingen',
        emoji: '🛍️',
        cards: [
          DarijaCard(darijaLatin: 'Bshhal?', darijaArabic: 'بشحال؟', dutch: 'Wat kost dit?'),
          DarijaCard(darijaLatin: 'Ghali bezzaf', darijaArabic: 'غالي بزاف', dutch: 'Erg duur'),
          DarijaCard(darijaLatin: 'Rkhis', darijaArabic: 'رخيص', dutch: 'Goedkoop'),
          DarijaCard(darijaLatin: 'Naqqes shwiya', darijaArabic: 'نقص شوية', dutch: 'Doe er iets af', note: 'Bij afdingen'),
          DarijaCard(darijaLatin: "Wash 3andek...?", darijaArabic: 'واش عندك...؟', dutch: 'Heb je...?'),
          DarijaCard(darijaLatin: 'Bghit njarreb', darijaArabic: 'بغيت نجرب', dutch: 'Ik wil het passen/proberen'),
          DarijaCard(darijaLatin: "Hada bezzaf 3liya", darijaArabic: 'هادا بزاف عليا', dutch: 'Dat is te veel voor mij'),
        ],
      ),
      Lesson(
        id: 'a2_de_weg',
        title: 'De weg vragen',
        subtitle: 'Vind je weg in de stad',
        emoji: '🧭',
        cards: [
          DarijaCard(darijaLatin: 'Fin kayn...?', darijaArabic: 'فين كاين...؟', dutch: 'Waar is...?'),
          DarijaCard(darijaLatin: 'Nishan', darijaArabic: 'نيشان', dutch: 'Rechtdoor'),
          DarijaCard(darijaLatin: 'Lymin', darijaArabic: 'اليمين', dutch: 'Rechts'),
          DarijaCard(darijaLatin: 'Lisar', darijaArabic: 'الشمال', dutch: 'Links'),
          DarijaCard(darijaLatin: 'Qrib', darijaArabic: 'قريب', dutch: 'Dichtbij'),
          DarijaCard(darijaLatin: "B3id", darijaArabic: 'بعيد', dutch: 'Ver'),
          DarijaCard(darijaLatin: 'Dor', darijaArabic: 'دور', dutch: 'Draai / sla af'),
        ],
      ),
      Lesson(
        id: 'a2_gevoelens',
        title: 'Gevoelens',
        subtitle: 'Zeg hoe je je voelt',
        emoji: '💛',
        cards: [
          DarijaCard(darijaLatin: 'Farhan', darijaArabic: 'فرحان', dutch: 'Blij'),
          DarijaCard(darijaLatin: 'Mqelleq', darijaArabic: 'مقلق', dutch: 'Bezorgd / gestrest'),
          DarijaCard(darijaLatin: "3eyyan", darijaArabic: 'عيان', dutch: 'Moe'),
          DarijaCard(darijaLatin: 'Zaafan', darijaArabic: 'زعفان', dutch: 'Boos'),
          DarijaCard(darijaLatin: 'Khayef', darijaArabic: 'خايف', dutch: 'Bang'),
          DarijaCard(darijaLatin: 'Mabsout', darijaArabic: 'مبسوط', dutch: 'Tevreden / blij'),
        ],
      ),
      Lesson(
        id: 'a2_klein_gesprek',
        title: 'Een klein gesprek',
        subtitle: 'Maak kennis met iemand',
        emoji: '💬',
        cards: [
          DarijaCard(darijaLatin: 'Mnin nta?', darijaArabic: 'منين نتا؟', dutch: 'Waar kom je vandaan?', note: 'Tegen een man'),
          DarijaCard(darijaLatin: 'Ana mn Holanda', darijaArabic: 'أنا من هولاندا', dutch: 'Ik kom uit Nederland'),
          DarijaCard(darijaLatin: 'Chnou smiytek?', darijaArabic: 'شنو سميتك؟', dutch: 'Wat is je naam?'),
          DarijaCard(darijaLatin: 'Smiyti...', darijaArabic: 'سميتي...', dutch: 'Mijn naam is...'),
          DarijaCard(darijaLatin: "Bghit nt3llem darija", darijaArabic: 'بغيت نتعلم الدارجة', dutch: 'Ik wil Darija leren'),
          DarijaCard(darijaLatin: 'Farhan bik', darijaArabic: 'فرحان بيك', dutch: 'Leuk je te ontmoeten', note: 'Tegen een man'),
        ],
      ),
    ],
  );
}
