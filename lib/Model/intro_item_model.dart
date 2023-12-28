class Items {
  final String img;
  final String title;
  final String subTitle;

  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: 'images/Health-Insurance-Policy_Bajaj-Finserv.png',
    title: 'Welcome to Tameen App',
    subTitle: 'Get started with our insurance services!',
  ),
  Items(
    img: 'images/health-insurance-scaled.png',
    title: 'Protect Your Health',
    subTitle: 'Explore our comprehensive health insurance plans.',
  ),
  Items(
    img: 'images/product-insurance.png',
    title: 'Secure Your Possessions',
    subTitle: 'Safeguard your assets with our property insurance.',
  ),
];
