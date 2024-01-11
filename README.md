
<a name="_hlk155557390"></a>**PROJEKT INŻYNIERSKI**


„System zarządzania lokalem gastronomicznym”

**Jakub Górka**

**Nr albumu 295796**

**Kierunek:** Informatyka

**Specjalność:** <wpisać właściwą>







**PROWADZĄCY PRACĘ**

**dr hab. inż. Piotr Gaj**

**KATEDRA Systemów Rozproszonych i Urządzeń Informatyki**

**Wydział Automatyki, Elektroniki i Informatyki**







**GLIWICE Rok 2023**





**Tytuł pracy:**

System zarządzania lokalem gastronomicznym

**Streszczenie:**

Praca koncentruje się na stworzeniu aplikacji mobilnej przeznaczonej do efektywnego zarządzania restauracją. Analiza dziedziny, a następnie opis wymagań funkcjonalnych oraz niefunkcjonalnych przygotowuje do implementacji aplikacji. Specyfikacja wewnętrzna oraz specyfikacja zewnętrzna przedstawiają sposób implementacji aplikacji oraz scenariusze korzystania z funkcjonalności. Projekt został zakończony testami, które opisane zostały w ostatnim rozdziale. 

**Słowa kluczowe:**

Aplikacja mobilna, system zarządzania, gastronomia

**Thesis title:**

Restaurant management system

**Abstract:**

**---- Uzupełnić po zatwierdzeniu polskiego streszczenia**

(Thesis abstract – to be copied into an appropriate field during electronic submission, in English.)

**Keywords:**

Mobile application, management system, gastronomy




# **Spies treści**
# **Spis treści**
[**ROZDZIAŁ 1  WSTĘP	7****](#_toc155891486)**

[**1.1**	**Cel pracy	7****](#_toc155891487)

[**1.2**	**Zakres pracy	7****](#_toc155891488)

[**1.3**	**Wkład autora	8****](#_toc155891489)

[**ROZDZIAŁ 2   ANALIZA DZIEDZINY	9****](#_toc155891490)

[**2.1**	**Kontekst problemu	9****](#_toc155891491)

[**2.2**	**Znane rozwiązania	9****](#_toc155891492)

[**ROZDZIAŁ 3   WYMAGANIA I NARZĘDZIA	13****](#_toc155891493)

[**3.1.**	**Wymagania funkcjonalne	13****](#_toc155891494)

[**3.2.**	**Wymagania niefunkcjonalne	15****](#_toc155891495)

[**3.3.**	**Przypadki użycia	16****](#_toc155891496)

[**3.4.**	**Narzędzia	17****](#_toc155891497)

[**ROZDZIAŁ 4  SPECYFIKACJA ZEWNĘTRZNA	19****](#_toc155891498)

[**4.1 Wymagania sprzętowe	19****](#_toc155891499)

[**4.2 Sposób instalacji oraz aktywacji	19****](#_toc155891500)

[**4.3 Kategorie użytkowników	19****](#_toc155891501)

[**4.3.1 Gość**	19](#_toc155891502)

[**4.3.2 Użytkownik zalogowany**	20](#_toc155891503)

[**4.3.3 Administrator**	20](#_toc155891504)

[**4.4 Sposób obsługi	20****](#_toc155891505)

[**4.4.1 Logowanie**	20](#_toc155891506)

[**4.4.2 Utworzenie nowej restauracji**	21](#_toc155891507)

[**4.4.3 Dodanie wpisu do raportu z wybranego dnia**	22](#_toc155891508)

[**4.4.4 Rozpoczęcie oraz zakończenie dnia pracy**	25](#_toc155891509)

[**4.4.5 Sprawdzenie sumy przepracowanych godzin**	27](#_toc155891510)

[**4.4.6 Dodanie nowej faktury do Menadżera Faktur**	28](#_toc155891511)

[**ROZDZIAŁ 5  SPECYFIKACJA WEWNĘTRZNA	30****](#_toc155891512)

[**5.1 Przedstawienie Idei	30****](#_toc155891513)

[**5.2 Architektura systemu	30****](#_toc155891514)

[**5.2.1 Aplikacja mobilna**	30](#_toc155891515)

[**5.2.2 Baza danych**	30](#_toc155891516)

[**5.3 Opis struktury danych	31****](#_toc155891517)

[**ROZDZIAŁ 6  WERYFIKACJA I WALIDACJA	32****](#_toc155891518)

[**6.1 Testowanie	32****](#_toc155891519)

[**6.2 Walidacja	34****](#_toc155891520)

[**6.3 Wykryte i usunięte błędy	35****](#_toc155891521)

[**ROZDZIAŁ 7  PODSUMOWANIE I WNIOSKI	38****](#_toc155891522)

[**7.1 Możliwe kierunki rozwoju aplikacji	38****](#_toc155891523)

[**BIBLIOGRAFIA	40****](#_toc155891524)

[**SPIS SKRÓTÓW I SYMBOLI	44****](#_toc155891525)

[**ŹRÓDŁA	45****](#_toc155891526)

[**LISTA DODATKOWYCH PLIKÓW, UZUPEŁNIAJĄCYCH TEKST PRACY	46****](#_toc155891527)

[**SPIS RYSUNKÓW	47****](#_toc155891528)


**


Imię i Nazwisko Autora

<a name="_toc155736302"></a><a name="_toc155891486"></a>**Rozdział 1

Wstęp**
====================================================================
W obecnych czasach technologia jest wszechobecna, towarzyszy nam na każdym kroku i przenika każdy aspekt naszego życia. Nie inaczej jest w branży gastronomicznej, przedsiębiorcy stale rozglądają się za nowościami, które uproszczą pracę lub przełożą się na wydajność prowadzenia firmy. Praca poświęcona jest stworzeniu systemu zarządzania lokalem gastronomicznym, który w założeniu ma na usprawniać procesy związanych z prowadzeniem firmy – zbieraniem danych o zarobkach, wydatkach, zarządzaniem personelem. Aplikacja została zaprojektowana w taki sposób aby mogła być wykorzystywana w szeroko pojętej grupie HoReCa<sup>1</sup>, sprawdzi się zarówno w małej gastronomi, dużych restauracjach, gastronomii sieciowej oraz w gastronomi, która jest częścią większego lokalu usługowego np. stacje paliw, kasyna. Zdalny dostęp do danych za pomocą aplikacji pozwali na zarządzanie wieloma lokalami jednocześnie na odległość. 

1. <a name="_toc155891487"></a>**Cel pracy**

Celem pracy jest zaprojektowanie i implementacja aplikacji, która umożliwi efektywne zarządzanie lokalem gastronomicznym przez zbieranie a następnie prezentacje danych związanych z utargami, wydatkami – codziennymi oraz zbieranie danych o fakturach, czasem pracy pracowników. Umożliwi to właścicielom oraz menadżerom zdalne zarządzanie i analizę działania firmy.

1. <a name="_toc155891488"></a>**Zakres pracy**

W ramach pracy zostaną dokładnie przeanalizowane wymagania funkcjonalne oraz niefunkcjonalne. Następnie przeprowadzone zostaną etapy projektowania, implementacji, a następnie testowania.



1. <a name="_toc155891489"></a>**Wkład autora**

Autor zaprojektował w pełni działającą aplikacje przy użyciu języka Swift oraz SwiftUI. Aplikacja była jednocześnie testowana w rzeczywistej restauracji z 14 użytkownikami – pracownikami restauracji.




Imię i Nazwisko Autora
<a name="_toc155736303"></a><a name="_toc155891490"></a>**Rozdział 2 

Analiza dziedziny**
=====================================================================

1. <a name="_toc155891491"></a>**Kontekst problemu**

Wprowadzanie do restauracji nowoczesnych narzędzi informatycznych, takich jak np. kioski zamówień obsługiwane przez samodzielnie przez klientów, pozwalają na zautomatyzowanie wielu procesów, co przekłada się na oszczędność czasu. W stale rozwijającej się branży gastronomicznej ważne jest aby maksymalizować wydajność, a dzięki temu minimalizować wydatki. Ograniczenie zbędnych kosztów pozwala na konkurowanie z innymi lokalami gastronomicznymi będącymi na rynku pod względem ceny jednocześnie utrzymując jakość produktów oraz usług na najwyższym poziomie. Przedstawiana aplikacja upraszcza kontrole wydatków przez właściciela lub menadżera, który w prosty i szybki sposób może zdalnie sprawdzić wydatki lokalu w danym dniu oraz czas pracy każdego pracownika. Faktury często przemieszczają się między lokalem, a firmą odpowiedzialną za księgowość w naszej firmie, przez co wiele dokumentów jest niepotrzebnie kserowanych. Aplikacja z  menadżerem faktur, w którym możemy wprowadzić przychodzące do naszej firmy dokumenty pozwala na wgląd w nasze dokumenty w każdym momencie oraz łatwe zarządzanie płatnościami. Na rynku istnieje wiele podobnych rozwiązań, niestety wiele z nich jest niekompletna lub przestarzała. W celu uproszczenia zarządzania wymagane jest korzystanie z wielu produktów, które często nie są dostosowane do dzisiejszych realiów gastronomi, są nieintuicyjne w obsłudze, niedostosowane do urządzeń mobilnych, w dodatku drogie.

1. <a name="_toc155891492"></a>**Znane rozwiązania**

Najpopularniejszym rozwiązaniem na rynku jest rodzina produktów GASTRO od LSI Software, która jest na rynku od 1993 roku. „GASTRO POS”, czyli jeden z produktów rodziny GASTRO to pierwszy polski program gastronomiczny obsługiwany przez ekrany dotykowy. Firma podaje, że jest obecna w 18 tysiącach lokali gastronomicznych.


Rysunek 2.1: Grafika przedstawiająca rodzinę produktów GASTRO

GASTRO POS – to program sprzedaży, który umożliwia wybór pozycji towarowych, kompletowanie zamówień oraz realizację sprzedaży


Rysunek 2.2: Grafika przedstawia menu główne programu GASTRO POS

GASTRO SZEF – jest rozszerzeniem funkcjonalności programu GASTRO POS, na podstawie sprzedaży zrealizowanej na stanowiskach sprzedażowych umożliwia m.in. generowanie raportów utargów, wydatków, sprzedaży konkretnych produktów.


Rysunek 2.3: Grafika przedstawia wygląd programu GASTRO SZEF

mojeGASTRO – rozszerzenie produktu GASTRO SZEF, umożliwia zdalny dostęp do danych zebranych w GASTRO SZEF poprzez dedykowaną stronę internetową.

Rysunek 2.4: Grafika przedstawia wygląd strony internetowej mojeGASTRO

Zalety:

\- bardzo rozbudowana lista produktów rozszerzająca możliwości systemu,

\- producent zapewnia wsparcie oprogramowania od 30 lat.

Wady:

\- bardzo wysoki próg startowy przy chęci rozpoczęcia korzystania z oprogramowania GASTRO, do korzystania z systemu niezbędne zakupienie urządzeń – m.in. komputer, monitory dotykowe, drukarki zamówień,

\- wysoki koszt zakupu oprogramowania (ceny aktualne na rok 2023) - odpowiednio dla produktów: GASTRO SZEF około 2200zł, GASTRO POS około 2200zł,

\- jeżeli istnieje zainteresowanie zdalnym dostęp za pomocą mojeGASTRO wymagana jest dodatkowa comiesięczna płatna subskrypcja,

\- płatna aktualizacja oprogramowania, w celu aktualizacji niezbędne jest wezwanie informatyka firmy pośredniczącej w sprzedaży programów, które jest dodatkowym koszem

\- brak aplikacji mobilnej przeznaczonej do zarządzania lokalem gastronomicznym.
Imię i Nazwisko Autora


Imię i Nazwisko Autora
<a name="_toc155736304"></a><a name="_toc155891493"></a>**Rozdział 3 

Wymagania i narzędzia**
=====================================================================

W niniejszym rozdziale przedstawione zostały wymagania funkcjonalne oraz niefunkcjonalne. Dodatkowo, omówiony został model przypadków użycia, ukazując scenariusze, w jakich użytkownicy mogą korzystać z aplikacji. Ostatecznie, opisane zostały narzędzia, jakie zostały wykorzystane podczas implementacji projektu.
1. ## <a name="_toc155891494"></a>**Wymagania funkcjonalne**
Wymagania funkcjonalne definiują konkretne funkcjonalności, jakie system musi spełniać, aby sprostać oczekiwaniom użytkowników i osiągnąć zamierzone cele projektowe. Kluczowe funkcjonalności projektu obejmują:

1) **Obsługa użytkowników**
   1) Możliwość rejestracji użytkownika

System umożliwia potencjalnym użytkownikom dokonanie rejestracji, wymagane jest wprowadzenie: imienia, nazwiska, adresu email, hasła.

1) Możliwość zalogowania użytkownika

Zarejestrowani użytkownicy mają możliwość zalogowania się do swojego konta, aplikacja zapamiętuje dane logowania po zamknięciu aplikacji.

1) **Zarządzanie restauracjami**
   1) Prezentacja listy restauracji, do których należy użytkownik

Użytkownikowi prezentowane jest menu z listą restauracji, do których użytkownik przynależy, wybiera restauracje, której szczegóły chce przeglądać.

1) Możliwość stworzenia nowej restauracji

Użytkownik tworzy nową restauracje o wybranej nazwie, po stworzeniu dostaje role administratora restauracji.

1) Możliwość przyjęcia lub odrzucenia zaproszenia do dołączenia do restauracji

Na liście restauracji pojawia się zaproszenie do restauracji, użytkownik może zaproszenie przyjąć lub odrzucić.

1) **Zarządzanie pracownikami**
   1) Prezentacja listy pracowników

System umożliwia wyświetlenie listy wszystkich pracowników przypisanych do danej restauracji.

1) Możliwość zaproszenia użytkownika do istniejącej restauracji

Administrator restauracji ma możliwość zaproszenia nowego użytkownika do restauracji.

1) Wyświetlenie listy dni, w których wybranego miesiąca pracownik był w pracy

Użytkownik może sprawdzić historie obecności pracownika w pracy, z informacjami o czasie rozpoczęcia pracy, czasie zakończenia pracy, sumie przepracowanych godzin.

1) Wyświetlenie sumy przepracowanych godzin w wybranym miesiącu

System podsumowuje liczbę przepracowanych godzin w wybranym miesiącu.

1) **Raporty dzienne**
   1) Wybranie dnia, z którego wyświetla się raport

Użytkownik ma możliwość wybrania dnia, z którego chce przejrzeć raport.

1) Możliwość dodania informacji o aktualnym utargu

Użytkownik ma możliwość dodanie danych o aktualnym utargu, w systemie zapisywane jest kto dodał informacje, oraz o której godzinie.

1) Wyświetlenie listy wprowadzonych danych o utargu

W aplikacji prezentowana jest lista przedstawiająca wprowadzone wcześniej dane

1) Możliwość dodania nowego wydatku z kasy lub wpłaty do kasy

Użytkownik może wprowadzić dane o nowym wydatku lub wpłacie do kasy, wymagane podanie tytułu wpłaty/wypłaty, kwoty, możliwość dodania dodatkowego opisu, system zapisuje też przez kogo zostały wprowadzone dane oraz o której godzinie.

1) Wyświetlenie listy wpłat oraz wydatków

W aplikacji prezentowana jest lista wprowadzonych wcześniej wpłat oraz wydatków

1) Możliwość rozpoczęcia dnia pracy

Pracownik może rozpocząć swoją pracę, od momentu rozpoczęcia pracy liczony jest czas pracy. W celu rozpoczęcia pracy pracownik musi zrobić zdjęcie przedstawiające swoją twarz, co umożliwia potwierdzenie obecności w miejscu pracy.

1) Wyświetlenie listy pracowników danego dnia 

Wyświetlana jest lista prezentująca którzy pracownicy danego dnia byli w pracy

1) **Menadżer faktur**
   1) Wyświetlanie listy przyjętych w wybranym miesiącu faktur z podziałem na firmy.

Prezentacja listy faktur przyjętych w wybranym miesiącu, z podziałem na firmy. 

O każdej fakturze prezentowana jest informacja o dacie wystawienia, dacie płatności, kwocie, zdjęcie faktury

1) Dodanie nowej faktury do listy

Użytkownik ma możliwość wprowadzenia nowej faktury, wymagane są informacje o dacie wystawienia faktury, dacie płatności, kwocie, dodatkowo możliwość wprowadzenia dodatkowego opisu oraz zrobienia zdjęcia faktury. 
1. ## <a name="_toc155891495"></a>**Wymagania niefunkcjonalne**
Wymagania niefunkcjonalne to cechy i ograniczenia systemu, które nie dotyczą bezpośrednio jego funkcjonalności, ale wpływają na jakość, wydajność, niezawodność, bezpieczeństwo itp. Opisują one, w jaki sposób system działa lub jakie posiada cechy.

1) **Wydajność bazy danych**

System powinien optymalizować zapytania do bazy danych w celu nieprzekraczania założonego limitu 50 tysięcy zapytań dziennie.

System może obsługiwać 200 użytkowników jednocześnie.

1) **Optymalizacja zapytań**

Kod aplikacji powinien być zoptymalizowany pod kątem minimalizacji wysyłanych zapytań do bazy danych, w celu otrzymania wyników w najkrótszym możliwie czasie.

1) **Możliwość rozszerzenia**

W przypadku rozwoju aplikacji usługa bazy danych powinna być gotowa do łatwego rozszerzenia w celu obsługi większej ilości zapytań

1) **Użyteczność**

Interfejs użytkownika powinien być prosty oraz intuicyjny do obsługi dla każdego użytkownika bez potrzeby przeprowadzania szkolenia z przedstawiającego działanie aplikacji.

1) **Dostępność usług Firebase**

System powinien uwzględniać dostępność usług Firebase (takich jak Firestore) i w przypadku ewentualnych przerw w świadczeniu tych usług, informować użytkowników o możliwych zakłóceniach w korzystaniu z aplikacji.
1. ## <a name="_toc155891496"></a>**Przypadki użycia**
Diagram przypadków użycia to narzędzie, które przedstawia interakcje pomiędzy różnymi aktorami a systemem. Jest używany do zidentyfikowania, zrozumienia i opisania funkcji oraz interakcji, jakie zachodzą między różnymi uczestnikami, a systemem. Ten rodzaj diagramu pomaga w definiowaniu funkcji systemu z perspektywy użytkownika, ukazując, jak system będzie używany w praktyce.


Rysunek 3.1: Diagram przypadków użycia

1. ## <a name="_toc155891497"></a>**Narzędzia**
W trakcie implementacji projektu wykorzystano szereg narzędzi i technologii, które wspierały proces tworzenia oraz testowania aplikacji. Poniżej przedstawiono główne narzędzia użyte w ramach pracy nad projektem:

1) **Xcode**

Xcode to oficjalnie środowisko programistyczne Apple Inc., przeznaczone do tworzenia aplikacji na systemy iOS, iPadOS, macOS, watchOS, tvOS. Środowisko oferuje kompleksowe wsparcie dla Swift oraz SwiftUI. 

1) **Swift**

Swift to potężny i nowoczesny język programowania stworzony przez Apple, który zdobył popularność dzięki swojej przejrzystej i czytelnej składni. Wprowadzony w 2014 roku jako następca Objective-C, Swift jest zoptymalizowany pod kątem wydajności, co sprawia, że jest efektywny zarówno dla tworzenia aplikacji na platformy iOS, iPadOS, macOS, watchOS i tvOS.

Wykorzystane Biblioteki:

\- FirebaseDatabase – biblioteka zawierająca funkcje umożliwiające współpracę z bazą danych na platformie Firebase

\- Firebase Auth – biblioteka służąca do obsługi autentykacji użytkowników, obsługa rejestracji oraz logowania.

1) **SwiftUI**

SwiftUI to framework do tworzenia interfejsów użytkownika UI stworzony przez Apple Inc. w celu tworzenia aplikacji na platformy Apple (iOS, iPadOS, macOS, watchOS, tvOS). Został zaprezentowany w 2019 roku i od tego czasu jest stale rozwijany. SwiftUI wyróżnia się tym, że framework zajmuje się implementacją interfejsu, który został przez dewelopera opisany za pomocą kodu.

1) **Firebase**

Firebase to produkt, który powstał w 2011 roku jako platforma do tworzenia aplikacji mobilnych, w 2014 roku przejęty przez firmę Google, stale rozwijany skupiony na integracji w innymi produktami Google.

1. **Firestore Firestore Database**

Usługa bazy danych, przechowuje dane w formacie przypominającym JSON, dzięki czemu jest prosty do zrozumienia. Obsługuje wiele platform dzięki czemu umożliwia tworzenia produktów pod wiele systemów operacyjnych.



1. **Firebase Authentication**

Usługa autentykacji wproawdzona przez Firebase, udostępnia wiele metod logowania m.in. logowanie za pomocą konta Google, Apple, Facebook, Github i wiele innych. Zapewnia możliwości takie jak weryfikacja e-mail, resetowanie hasła oraz zapobieganie nieautoryzowanemu dostępowi.

1) **Apple App Store Connect**

Platforma firmy Apple, służy do zarządzania procesem przesyłania stworzonej apliacji do sklepu App Store. Umożliwia monitorowanie statystyk, interakcje z użytkownikami oceniającymi aplikacje w sklepie oraz udostępnianie wersji beta.

1) **Apple Testflight**

Umożliwia deweloperom przeprowadzenie testów beta swoich aplikacji przed oficjalnym wypuszczeniem do sklepu App Store. Platforma jest zintegrowana z App Store Connect, pozwala udostępniać wybraną wersje do testów dla konkretnych użytkowników. Testerzy mają możliwość przesyłania opinii oraz zgłaszania błędów, system zbiera dane o awariach apliacji. 

1) **Github**

GitHub został założony w 2008 roku przez Chrisa Wanastratha i Toma Prestona. Od tego czasu stał się jedną z najpopularniejszych platform do hostowania projektów opartych na systemie kontroli wersji Git.



Imię i Nazwisko Autora
<a name="_toc155736305"></a><a name="_toc155891498"></a>**Rozdział 4

Specyfikacja zewnętrzna**
====================================================================
W rozdziale przedstawiono wymagania sprzętowe niezbędne do uruchomienia aplikacji oraz sposób instalacji aplikacji. Opisane zostały również kategorie użytkowników występujących w systemie oraz sposób obsługi.  

<a name="_toc155891499"></a>**4.1 Wymagania sprzętowe**

Aplikacja przeznaczona jest dla smartfonów firmy Apple Inc.

W celu pobrania oraz uruchomienia aplikacji niezbędne jest posiadanie urządzenia z oprogramowaniem iOS 16.0 lub nowszym oraz posiadanie konta Apple ID w celu zalogowania się z sklepie systemowym App Store.

Do korzystania z aplikacji wymagane jest stabilne połączenie z internetem.

`	`**<a name="_toc155891500"></a>4.2 Sposób instalacji oraz aktywacji**

Aplikację można pobrać i zainstalować z systemowego sklepu Apple App Store. Po zainstalowaniu w celu uzyskania dostępu do funkcjonalności wymagane jest zalogowanie się lub utworzenie nowego konta.

`	`**<a name="_toc155891501"></a>4.3 Kategorie użytkowników**

Aplikacja wyróżnia trzy kategorie użytkowników, którzy mają dostęp do różnych funkcjonalności aplikacji

<a name="_toc155891502"></a>**4.3.1 Gość**

Osoba, która nie zalogowała się, ma dostęp do funkcjonalności rejestracji oraz logowania.

`	`<a name="_toc155891503"></a>**4.3.2 Użytkownik zalogowany**

Zalogowani użytkownicy posiadają uprawnienia do większości funkcjonalności zapewnianych przez aplikację m.in. dodawanie raportów dziennych, przeglądanie przepracowanych godzin, dodawanie faktur do menadżera faktur.

`	`<a name="_toc155891504"></a>**4.3.3 Administrator**

Konto administratora rozszerza funkcjonalności konta zalogowanego użytkownika. Administrator dodatkowo ma możliwość m.in. dodawania użytkowników do restauracji, modyfikacji czasu pracy pracownika w danym dniu.

`	`**<a name="_toc155891505"></a>4.4 Sposób obsługi**

W niniejszym podrozdziale przedstawione zostaną kluczowe procesy obsługi restauracji.

`	`**<a name="_toc155891506"></a>4.4.1 Logowanie**

Po uruchomieniu aplikacji użytkownikowi ukazuje się ekran logowania (rys 4.1), w celu zalogowania wymagane jest uzupełnienie adresu email, hasła (rys 4.2), a następnie zalogowanie zielonym przyciskiem. Po pomyślnym zalogowaniu ukazuje się lista restauracji.

||||
| :-: | :-: | :-: |
|Rysunek 4.1: Ekran logowania widoczny po uruchomieniu aplikacji|Rysunek 4.2: Ekran logowania po uzupełnieniu danych logowania|Rysunek 4.3: Ekran listy restauracji widoczny po pomyślnym zalogowaniu|

Aplikacja zapamiętuje dane logowania, jeżeli użytkownik nie wyloguje się ręcznie, po ponownym uruchomieniu aplikacji system automatycznie zaloguje się na poprzednio używane konto.

`	`**<a name="_toc155891507"></a>4.4.2 Utworzenie nowej restauracji**

W celu dodania nowej restauracji użytkownik musi nacisnąć przycisk „plus” w prawym górnym rogu ekranu nad listą restauracji (rys 4.4). 

Rysunek 4.4: Widok listy restauracji – przycisk dodania restauracji w prawym górnym rogu

Następnie należy wpisać nazwę nowej restauracji (rys 4.5 oraz rys 4.6).

|||
| :-: | :-: |
|Rysunek 4.5: Okienko dodawania restauracji – wymagane uzupełnienie nazwy|Rysunek 4.6: Okienko dodawania restauracji – po uzupełnieniu nazwy|

Po zatwierdzeniu na liście restauracji pojawia się utworzona przez nas restauracja (rys 4.7).

Rysunek 4.7: Widok listy restauracji po dodaniu nowej restauracji.

`	`**<a name="_toc155891508"></a>4.4.3 Dodanie wpisu do raportu z wybranego dnia**

W celu dodania wpisu do raportu wybieramy interesującą nas kategorię: utarg, wydatki lub wpłaty (Rys 4.8).

Rysunek 4.8: Główny widok raportu, widoczne kategorie

Użytkownikowi wyświetla się lista wcześniej dodanych np. wydatków, aby dodać nowy wykorzystujemy przycisk „Dodaj” (Rys 4.9).

Rysunek 4.9: Lista wydatków

Następnie wymagane jest uzupełnienie danych oraz potwierdzenie dodania za pomocą przycisku „Potwierdź” (Rys 4.10 oraz Rys 4.11).

|||
| :-: | :-: |
|<p>Rysunek 4.10: Formularz dodania nowego wydatku przed uzupełnieniem</p><p></p>|<p>Rysunek 4.11: Formularz dodania nowego wydatku po uzupełnieniu</p><p></p>|

Dodany przez użytkownika wydatek wraz z wszystkimi wprowadzonymi danymi widoczny jest na liście. Widnieje również informacja, przez kogo zostały wprowadzone dane (Rys 4.12).

Rysunek 4.12: Lista wydatków – widoczny nowo dodany wydatek

Aktualizuje się również główny widok raportu, przy kategorii „Wydatki” widoczna jest  zaktualizowana suma wydatków (Rys 4.13)


Rysunek 4.13: Główny widok raportu po wprowadzeniu nowego wydatku


`	`**<a name="_toc155891509"></a>4.4.4 Rozpoczęcie oraz zakończenie dnia pracy**

Użytkownik w celu rozpoczęcia swojej pracy musi przejść do kategorii „Pracownicy”, którą znajdzie na głównym widoku raportu (Rys 4.15).

Rysunek 4.15: Główny widok raportu

Użytkownikowi ukazuje się lista pracowników, którzy rozpoczęli już swoją pracę w danym dniu (Rys 4.16). W celu rozpoczęcia dnia użytkownik korzysta z przycisku „Rozpocznij pracę”.

Rysunek 4.16: Widok listy pracowników

Uruchamia się kamera selfie telefonu, z którego korzysta użytkownik na górze przedstawiona jest informacja, o kto i o której rozpoczyna pracę (Rys 4.17). Po zrobieniu zdjęcia za pomocą przycisku na dole ekranu rozpoczyna się liczyć czas pracy.

Rysunek 4.17: Widok kamery telefonu

Użytkownik pojawia się w raporcie na liście pracowników wraz z informacją, o której rozpoczął pracę (Rys 4.18). Przedstawiona jest również informacja, że nadal jest w pracy. W celu zakończenia pracy użytkownik wykorzystuje przycisk „Zakończ pracę”, wtedy na raporcie wyświetla się czas zakończenia pracy (Rys 4.19) oraz podliczony zostaje łączny czas pracy.

Rysunek 4.18: Widok listy pracowników po rozpoczęciu pracy przez pracownika

Rysunek 4.19: Widok listy pracowników po zakończeniu pracy przez pracownika

`	`**<a name="_toc155891510"></a>4.4.5 Sprawdzenie sumy przepracowanych godzin**

Użytkownik w celu sprawdzenia ilości przepracowanych godzin musi wybrać na dolnym menu zakładkę „Pracownicy”, ukaże się wtedy lista pracowników (Rys 4.20). 

Rysunek 4.20: Lista pracowników

Po kliknięciu w wybranego pracownika wyświetla nam się lista dni, w których był w pracy z informacjami: godzina rozpoczęcia pracy, godzina zakończenia pracy, suma przepracowanych godzin. Na dole ekranu widoczne jest podsumowanie godzin w wybranym miesiącu. Na górze ekranu jest możliwość wyboru miesiąca, który użytkownik może sprawdzić. (Rys 4.21)

Rysunek 4.21: Widok dni pracy wybranego wcześniej pracownika

`	`**<a name="_toc155891511"></a>4.4.6 Dodanie nowej faktury do Menadżera Faktur**

W celu dodania nowej faktury do Menadżera Faktur użytkownik na dolnym menu wybiera zakładkę „Faktury”, użytkownikowi wyświetla się lista dodanych wcześniej firm (Rys 4.22). Na górze użytkownik ma możliwość wybrania miesiąca, dla którego chce przeglądać dodane wcześniej faktury lub dodać nową. Następnie wybiera firmę, dla której chce dodać nową fakturę.

Rysunek 4.22: Lista firm dodanych do Menadżera Faktur

Na ekranie ukazuje się lista faktur dodanych dla danej firmy w wybranym miesiącu. W celu dodania nowej użytkownik wykorzystuje przycisk „plus” (Rys 4.23).

Rysunek 4.23: Lista faktur danej firmy w wybranym miesiącu

Użytkownik uzupełnia dane w formularzu dodawanej faktury (Rys 4.24 oraz Rys 4.25): numer faktury, data wystawienia faktury, termin płatności faktury, kwota, notatka (opcjonalna), zdjęcie faktury (opcjonalne – Rys. 4.26). Następnie potwierdza przyciskiem „Dodaj”

||||
| :-: | :-: | :-: |
|<p>Rysunek 4.24: Formularz dodania faktury przed uzupełnieniem</p><p></p>|<p>Rysunek 4.25: Formularz dodania faktury po uzupełnieniu</p><p></p>|<p>Rysunek 4.26: Widok aparatu wykorzystywany w celu dodania zdjęcia faktury</p><p></p>|
Po dodaniu faktura wyświetla się na liście faktur (Rys 4.27) po kliknięciu w wybraną fakturę powiększa się zrobione wcześniej zdjęcie faktury (Rys 4.28).

|||
| :-: | :-: |
|Rysunek 4.27 – Lista faktur po dodaniu nowej faktury|Rysunek 4.28 – Powiększone zdjęcia dodanej wcześniej faktury|
**<a name="_toc155736306"></a><a name="_toc155891512"></a>Rozdział 5

Specyfikacja wewnętrzna**
====================================================================
Rozdział przedstawia analizę architektury systemu oraz opis struktur danych.

<a name="_toc155891513"></a>**5.1 Przedstawienie Idei**

Główną ideą podczas powstawania aplikacji był przejrzysty, intuicyjny interfejs, który będzie łatwy w obsłudze dla każdego potencjalnego użytkownika. Drugim ważnym aspektem była szybka i niezawodna baza danych.

<a name="_toc155891514"></a>**5.2 Architektura systemu**

<a name="_toc155891515"></a>**5.2.1 Aplikacja mobilna**

Głównym elementem przedstawionego projektu jest aplikacja mobilna napisana w języku Swift z wykorzystaniem SwiftUI. Język Swift jest językiem programistycznym dedykowanym do rozwiązań przeznaczonych na urządzenia firmy Apple Inc. W projekcie wykorzystany został Swift 5.9, co umożliwia korzystanie z najnowszych funkcji oraz bibliotek jednocześnie zapewniając bezpieczeństwo na najwyższym możliwym poziomie. Integracja Swift z frameworkiem SwiftUI pozwala tworzenie rozbudowanej aplikacji i płynną interakcje z użytkownikiem.

<a name="_toc155891516"></a>**5.2.2 Baza danych**

Aplikacja korzysta z Firebase Cloud Firestore Database, które jest niezawodnym i łatwo skalowalnym rozwiązaniem do przechowywania danych. Zaletą rozwiązania jest szybkość i prostota implementacji w naszym projekcie. Firebase Firestore jest oparte na modelu NoSQL, dane przechowywane są w formie kolekcji oraz dokumentów, co pozwala na efektywne zarządzanie nimi i możliwość łatwego dostosowania do ewentualnych zmian w strukturze bazy danych.




<a name="_toc155891517"></a>**5.3 Opis struktury danych**

Dane w przedstawianym projekcie przechowywane są w bazie danych Firebase Cloud Firestore Database. Struktura bazy danych oparta jest na NoSQL, dane przechowywane są w formie kolekcji oraz dokumentów, co przypomina format JSON. Baza danych posiada dwie główne gałęzie „Restaurants” (Rys 5.1) oraz „Users” (Rys 5.2).


Rysunek 5. 1: Kolekcja „Restaurants” na przykładzie restauracji „Restauracja Demo”


Rysunek 5.2: Kolekcja „Users” na przykładzie użytkownika „Demo 1”








<a name="_toc155736307"></a><a name="_toc155891518"></a>**Rozdział 6

Weryfikacja i walidacja**
====================================================================
Rozdział przedstawia sposób testowania aplikacji wraz z informacją o sprzęcie na jakim była testowana.

<a name="_toc155891519"></a>**6.1 Testowanie**

Testy aplikacji zostały przeprowadzone dwuetapowo, pierwszym etapem było testowanie każdej funkcjonalności bezpośrednio po jej wdrożeniu do aplikacji za pomocą symulatora dostępnego w środowisku XCode (Rysunek 6.1), do tego celu wykorzystywane były symulatory kilku telefonów z różnymi wersjami oprogramowania systemowego:

\- iPhone 13 Pro Max, iOS 17.1.1

\- iPhone 8, iOS 16.7.2

\- iPhone 15 Pro, iOS 17.0.1

Rysunek 6.1: Aplikacja uruchomiona w symulatorze – iPhone 15 Pro, iOS 17.0.1

Kolejnym krokiem po ukończeniu pierwszego etapu testów było wdrożenie aplikacji do pierwszej restauracji. Aplikacja została udostępniona z wykorzystaniem Apple TestFlight do restauracji posiadającej 12 pracowników w wieku od 18 do 39 lat. Podczas trwania drugiego etapu testów aplikacja została zainstalowana na 6 różnych urządzeniach z różnymi wersjami oprogramowania systemowego (Rys 6.2):

\- iPhone 13 Pro Max, iOS 17.1.1

\- iPhone 13, iOS 17.2.1

\- iPhone 11 Pro, iOS 17.1.2

\- iPhone 14, iOS 17.2.1

\- iPhone 14 Pro Max, iOS 17.2.1

\- iPhone 8 Plus, iOS 16.7.2

Rysunek 6.2: Urządzenia wykorzystane do drugiego etapu testów

Łącznie zostało udostępnione 11 wersji aplikacji do testów dla użytkowników (Rys 6.3).

Rysunek 6.3: Wersje udostępnione podczas drugiego etapu testów

`	`**<a name="_toc155891520"></a>6.2 Walidacja**

Podczas logowania oraz rejestracji następuje walidacja wprowadzonych danych, która odbywa się po stronie Google Firebase Authentication [1]. Użytkownik wypełnia formularz logowania lub rejestracji (Rys 6.4), po wciśnięciu przycisku „Dalej” system komunikuje się z Firebase Authentication (Rys 6.5), które następnie zwraca nam dane zalogowanego użytkownika bądź w formie kodu błędu informacje o napotkanym problemie podczas próby logowania. 


Rysunek 6.4: Formularz logowania w aplikacji


Rysunek 6.5: Kod funkcji odpowiadającej logowanie się użytkownika z pomocą Firebase Authentication

Najważniejsze kody błędów:

|**Code**|**Meaning**|
| :- | :- |
|FIRAuthErrorCodeOperationNotAllowed|Indicates that email and password accounts are not enabled. Enable them in the Auth section of the [Firebase console](https://console.firebase.google.com/).|
|FIRAuthErrorCodeInvalidEmail|Indicates the email address is malformed.|
|FIRAuthErrorCodeUserDisabled|Indicates the user's account is disabled.|
|FIRAuthErrorCodeWrongPassword|Indicates the user attempted sign in with a wrong password.|
|FIRAuthErrorCodeNetworkError|Indicates a network error occurred during the operation.|
|FIRAuthErrorCodeUserNotFound|Indicates the user account was not found. This could happen if the user account has been deleted.|
|FIRAuthErrorCodeUserTokenExpired|Indicates the current user’s token has expired, for example, the user may have changed account password on another device. You must prompt the user to sign in again on this device.|
|FIRAuthErrorCodeTooManyRequests|Indicates that the request has been blocked after an abnormal number of requests have been made from the caller device to the Firebase Authentication servers. Retry again after some time.|
|FIRAuthErrorCodeInvalidAPIKey|Indicates the application has been configured with an invalid API key.|
|FIRAuthErrorCodeAppNotAuthorized|Indicates the App is not authorized to use Firebase Authentication with the provided API Key. go to the Google API Console and check under the credentials tab that the API key you are using has your application’s bundle ID whitelisted.|
|FIRAuthErrorCodeKeychainError|Indicates an error occurred when accessing the keychain. The NSLocalizedFailureReasonErrorKey and NSUnderlyingErrorKey fields in the NSError.userInfo dictionary will contain more information about the error encountered.|
|FIRAuthErrorCodeInternalError|Indicates an internal error occurred. Please [report the error](https://firebase.google.com/support) with the entire NSError object.|


<a name="_toc155891521"></a>**6.3 Wykryte i usunięte błędy**

Najważniejszym błędem, wykrytym podczas całego procesu powstawania aplikacji był błąd funkcji odpowiedzialnej ze obliczanie czasu pracy. System przewiduje możliwość rozpoczęcia oraz zakończenia pracy co 15 minut (Rys 6.7) np. 12:00, 12:15, 12:30, 12:45, 13:00…. Użytkownik powinien w aplikacji rozpocząć swój dzień pracy najpóźniej równo o godzinie rozpoczęcia pracy, w przeciwnym razie system będzie liczył przepracowany czas od następnego dostępnego okna rozpoczęcia pracy. Pracownik może zaznaczyć zakończenie pracy nie wcześniej niż o godzinie najbliższego okna rozliczenia czasu pracy.


Rysunek 6.7: Fragment funkcji odpowiedzialnej za liczenie czasu pracy

Podczas powstawania funkcji powstał błąd, podczas rozpoczęcia pracy o godzinie np. 7:55 funkcja błędnie zaokrąglała godzinę do 7:00 zamiast 8:00, co przełożyło się na błędne wyliczenia czasu pracy użytkowników. Problem udało się rozwiązać dokonując korekty w kodzie funkcji (Rys 6.8).

Rys 6.8: Fragment kodu, w którym występował błąd



<a name="_toc155736308"></a><a name="_toc155891522"></a>**Rozdział 7

Podsumowanie i wnioski**
====================================================================
Celem pracy było zaprojektowanie oraz implementacja aplikacji mobilnej wspierającej zarządzanie lokalem gastronomicznym. Motywacją było uproszczenie zarządzania restauracją jednocześnie przekładając się na oszczędność czasu oraz zwiększenie wydajności pracy firmy.

Cel udało się zrealizować z założonymi w wymaganiach funkcjonalnościami. Gotowa aplikacja sprawdza się w zarządzaniu czasem pracy pracowników. Poza obliczaniem czasu pracy na podstawie czasu rozpoczęcia oraz zakończenia pracy, przekłada się na zmniejszenie ilości spóźnień pracowników, dzięki kontroli czasu rozpoczęcia pracy. Kompletowanie dziennych raportów w aplikacji pozwala właścicielowi lub menadżerowi firmy na szybką kontrole dziennych wydatków oraz utargów. Zawarty w aplikacji menadżer faktur poza obliczaniem miesięcznych należności dla konkretnej firmy pozwala na zdalny wgląd w faktury.

<a name="_toc155891523"></a>**7.1 Możliwe kierunki rozwoju aplikacji**

Aplikacja pozostawia duże pole do dalszego rozwoju, poniżej wymienione zostały najważniejsze z potencjalnych przyszłych ścieżek rozwoju:

- Stworzenie odpowiednika programu w postaci aplikacji mobilnej przeznaczonej na system Android
- Dodanie nowych funkcjonalności:
  - Generowanie miesięcznych podsumowań, wyliczanie miesięcznego zysku
  - Generowanie miesięcznych raportów w formacie do druku
  - Menadżer urlopów pracowników
  - Menadżer umów zawartych z pracownikami
  - Moduł do zarządzania stanem magazynowym
  - Możliwość zarządzania rezerwacjami stolików
  - Zarządzanie grafikami pracy
  - System powiadomień o ważnych wydarzeniach – spóźnienie pracownika, zmiana w grafiku pracy itp.
  - Analiza trendów sprzedaży




# <a name="_toc155736309"></a><a name="_toc155891524"></a>**Bibliografia**
1. Google Firebase Authentication – Dokumentacja z 2023-12-05 https:   <https://firebase.google.com/docs/auth/ios/errors> (dostęp: 10.12.2023r) 
1. Google Firebase Cloud Firestore – Dokumentacja z 2023-12-05 https: <https://firebase.google.com/docs/firestore> (dostęp: 08.12.2023r)
1. Apple Swift – Dokumentacja https: <https://developer.apple.com/documentation/swift> (dostęp: 20.10.2023r)
1. Apple SwiftUI – Dokumentacja https: <https://developer.apple.com/documentation/swiftui/> (dostęp: 21.10.2023r)
1. Apple Human Interface Guidelines https: <https://developer.apple.com/design/human-interface-guidelines> (dostęp 25.10.2023r)




















Dodatki




# <a name="_toc155736310"></a><a name="_toc155891525"></a>**Spis skrótów i symboli**
*HoReCa*	od słów Hotel, Restaurant, Cafe, czyli branża obejmująca hotele, restauracje i kawiarnie, działająca w sektorze usług gastronomicznych i noclegowych.

*iOS* 	iPhone Operating System

*UI* 	Interfejs Użytkownika





#

# <a name="_toc155736311"></a><a name="_toc155891526"></a>**Źródła**
Jeżeli w pracy konieczne jest umieszczenie długich fragmentów kodu źródłowego,

należy je przenieść do tego miejsca.





# <a name="_toc155736312"></a><a name="_toc155891527"></a>**Lista dodatkowych plików, uzupełniających tekst pracy**
W systemie, do pracy dołączono dodatkowe pliki zawierające:

- źródła programu,
- dane testowe
- film pokazujący działanie opracowanego oprogramowania lub zaprojektowanego i wykonanego urządzenia,
- itp. 


# <a name="_toc155736313"></a><a name="_toc155891528"></a>**Spis rysunków**
**2.1		Grafika przedstawiająca rodzinę produktów GASTRO										10**

**2.2		Grafika przedstawia menu główne programu GASTRO POS									10**

**2.3		Grafika przedstawia wygląd programu GASTRO SZEF										11**

**2.4		Grafika przedstawia wygląd strony internetowej mojeGASTRO								11**

**3.1		Diagram przypadków użycia																16**

**4.1		Ekran logowania widoczny po uruchomieniu aplikacji										20**

**4.2		Ekran logowania po uzupełnieniu danych logowania										20**

**4.3		Ekran listy restauracji widoczny po pomyślnym zalogowaniu									20**

**4.4		Widok listy restauracji 																	21**

**4.5		Okienko dodawania restauracji – wymagane uzupełnienie nazwy							21**

**4.6		Okienko dodawania restauracji – po uzupełnieniu nazwy									21**

**4.7		Widok listy restauracji po dodaniu nowej restauracji										22**

**4.8		Główny widok raportu, widoczne kategorie												22**

**4.9		Lista wydatków																			23**

**4.10	Formularz dodania nowego wydatku przed uzupełnieniem									23**

**4.11	Formularz dodania nowego wydatku po uzupełnieniu										24**

**4.12	Lista wydatków – widoczny nowo dodany wydatek											24**

**4.13	Główny widok raportu po wprowadzeniu nowego wydatku									24**

**4.15	Główny widok raportu																	25**

**4.16	Widok listy pracowników																	25**

**4.17	Widok kamery telefonu																	26**

**4.18	Widok listy pracowników po rozpoczęciu pracy przez pracownika							26**

**4.19	Widok listy pracowników po zakończeniu pracy przez pracownika							26**

**4.20 	Lista pracowników																		27**

**4.21	Widok dni pracy wybranego wcześniej pracownika											27**

**4.22	Lista firm dodanych do Menadżera Faktur													28**

**4.23	Lista faktur danej firmy w wybranym miesiącu												28**

**4.24	Formularz dodania faktury przed uzupełnieniem											29**

**4.25	Formularz dodania faktury po uzupełnieniu												29**

**4.26	Widok aparatu wykorzystywany w celu dodania zdjęcia faktury								29**

**4.27	Lista faktur po dodaniu nowej faktury														29**

**4.28	Powiększone zdjęcia dodanej wcześniej faktury												29**

**5.1		Kolekcja „Restaurants” na przykładzie restauracji „Restauracja Demo”						31**

**5.2		Kolekcja „Users” na przykładzie użytkownika „Demo 1”										31**

**6.1		Aplikacja uruchomiona w symulatorze – iPhone 15 Pro, iOS 17.0.1							32**

**6.2		Urządzenia wykorzystane do drugiego etapu testów										33**

**6.3		Wersje udostępnione podczas drugiego etapu testów										33**

**6.4		Formularz logowania w aplikacji															34**

**6.5		Kod funkcji odpowiadającej logowanie się użytkownika										34**

**6.7		Fragment funkcji odpowiedzialnej za liczenie czasu pracy									36**

**6.8		Fragment kodu, w którym występował błąd												37**
