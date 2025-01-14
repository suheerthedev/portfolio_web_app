import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:portfolio_web_app/home/home_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: _buildResponsiveAppBar(context, model),
          drawer: _buildDrawer(context, model),
          body: SingleChildScrollView(
            controller: model.scrollController,
            child: Column(
              children: [
                _buildHeader(context, model),
                _buildAboutSection(context),
                _buildEducationSection(context),
                _buildProjectsSection(context),
                _buildFooter(context),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildResponsiveAppBar(BuildContext context, HomeViewModel model) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        'Suheer Khan',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: MediaQuery.of(context).size.width > 600
          ? _buildNavbarActions(model)
          : null,
    );
  }

  List<Widget> _buildNavbarActions(HomeViewModel model) {
    return [
      _buildNavbarItem("About me", () => model.scrollToSection(500)),
      const SizedBox(width: 20),
      _buildNavbarItem("Contact", () async {
        const email = 'khansuheer1@gmail.com';
        final Uri url = Uri.parse('mailto:$email');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      }),
    ];
  }

  Drawer _buildDrawer(BuildContext context, HomeViewModel model) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 70),
              child: Text(
                'Suheer Khan',
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'About me',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              model.scrollToSection(500);
            },
          ),
          ListTile(
            title: Text(
              'Contact',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            onTap: () async {
              Navigator.pop(context);
              const email = 'khansuheer1@gmail.com';
              final Uri url = Uri.parse('mailto:$email');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeViewModel model) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      color: Colors.black,
      constraints: BoxConstraints(minHeight: screenHeight * 0.8),
      padding: EdgeInsets.symmetric(vertical: screenWidth > 1000 ? 50 : 30),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 20),
              Text(
                'Suheer Khan!',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth > 1000 ? 36 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "I flutter and chill",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth > 1000 ? 24 : 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Enthusiastic Flutter Developer with a commitment to building intuitive and visually appealing mobile applications, specializing in delivering seamless user experiences and efficient solutions.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth > 1000 ? 18 : 15,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavbarItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      color: Colors.grey[900],
      constraints: BoxConstraints(minHeight: screenHeight * 0.6),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ABOUT ME',
                style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "As an enthusiastic Flutter developer, I enjoy the balance of creativity and logic in app development. Currently focused on building engaging applications, I bring ideas to life by transforming concepts into smooth, responsive user experiences.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      color: Colors.black,
      constraints: BoxConstraints(minHeight: screenHeight * 0.8),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Education',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildEducationTile(
                'Flutter Development',
                'May 2024 - Present, Saylani Mass IT Training Program',
                'Currently learning Flutter App Development Application at SMIT. SMIT is an institute with well-trained instructors who have industry experience.',
              ),
              _buildEducationTile(
                'Bachelor of Science in Computer Science',
                '2024 - 2028, Mohammad Ali Jinnah University',
                'I am currently pursuing a Bachelor’s degree in Computer Science at Mohammad Ali Jinnah University. This program is helping me build a strong foundation in programming, data structures, and software development.',
              ),
              _buildEducationTile(
                'Intermediate in Computer Science',
                '2023, Government For Men College',
                'I completed my Intermediate in Computer Science in 2023 from Government For Men College.',
              ),
              _buildEducationTile(
                'Matriculation in of Computer Science',
                '2021, Little Folkr’s Paradise School',
                'I completed my Matriculation in Computer Science in 2021 at Little Folkr’s Paradise School, building a foundation in technology and computer science.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      color: Colors.grey[900],
      constraints: BoxConstraints(minHeight: screenHeight * 0.8),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Text(
                'PROJECTS',
                style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildProjectTile(
                      'Newsflix',
                      'A news app that fetches latest news articles from various sources.',
                      'assets/images/newsflix_banner.svg'),
                  _buildProjectTile(
                      'Weather Now',
                      'A weather app displaying current weather data based on location.',
                      'assets/images/weather_banner.svg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures full-width
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Connect with me',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedinIn,
                    color: Colors.white),
                iconSize: 24,
                onPressed: () =>
                    _launchURL('https://linkedin.com/in/suheer-khan/'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram,
                    color: Colors.white),
                iconSize: 24,
                onPressed: () =>
                    _launchURL('https://instagram.com/suheer.khan/'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook,
                    color: Colors.white),
                iconSize: 24,
                onPressed: () =>
                    _launchURL('https://facebook.com/sk.suheerkhan/'),
              ),
              IconButton(
                icon:
                    const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                iconSize: 24,
                onPressed: () => _launchURL('https://github.com/suheerthedev/'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Made with ❤ by Suheer',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildProjectTile(
      String title, String description, String bannerPath) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SvgPicture.asset(
                  bannerPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}

Widget _buildEducationTile(String title, String subtitle, String description) {
  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    ),
  );
}
