import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                _buildExperienceSection(context),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: Colors.black,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(height: 20),
          Text(
            'Suheer Khan!',
            style: GoogleFonts.poppins(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "I flutter and chill",
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text(
            "Enthusiastic Flutter Developer with a commitment to building intuitive and visually appealing mobile applications, specializing in delivering seamless user experiences and efficient solutions.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey[400]),
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'ABOUT ME',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            """As an enthusiastic Flutter developer, I enjoy the balance of creativity and logic in app development. Currently focused on building engaging applications, I bring ideas to life by transforming concepts into smooth, responsive user experiences.""",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'Education',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildEducationItem(
            title: 'Flutter Development at SMIT',
            subtitle: 'May 2024 - Present, Karachi',
            description:
                'Currently learning Flutter App Development Application at SMIT. SMIT is an institute with well trained instructor who have industry experience.',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem({
    required String title,
    required String subtitle,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[400]),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[400]),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'PROJECTS',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                );
              } else {
                return Column(
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
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        'Made with ❤ by Suheer.',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildProjectTile(
      String title, String description, String bannerPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: AspectRatio(
              aspectRatio: 4 / 3,
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
