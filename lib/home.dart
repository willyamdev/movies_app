import 'package:flutter/material.dart';
import 'package:testmoviesapp/appconfig.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Movies> moviesList = [
    Movies("Toy Story 4", "4,8", "assets/toystory4.png"),
    Movies("Godzilla II: Rei dos Monstros", "4,5", "assets/godzilla.png"),
    Movies("Vingadores: Ultimato", "4,9", "assets/vingadores.png"),
    Movies("O Rei Leão", "4,2", "assets/reileao.png"),
    Movies("Coringa", "4,8", "assets/coringa.png"),
  ];

  AppConfig appConfig;
  PageController pageController;

  AnimationController animationController;
  Animation<double> change;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    pageController = PageController(viewportFraction: 0.6);
    change = Tween<double>(begin: 0.6, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut));

    WidgetsBinding.instance.addPostFrameCallback((_) => _initilized());
  }

  _initilized() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(appConfig),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[_firstContainer(), _secondContainer()],
      ),
    );
  }

  _firstContainer() {
    return Expanded(
        flex: 4,
        child: Container(
          child: Column(
            children: <Widget>[_toolBar(), _titleContainer(), _searchBar()],
          ),
        ));
  }

  _secondContainer() {
    return Expanded(
      flex: 6,
      child: Container(
        child: Column(
          children: <Widget>[_tabBar(), _listMovies()],
        ),
      ),
    );
  }

  _toolBar() {
    return Expanded(
      flex: 0,
      child: Container(
        padding: EdgeInsets.only(top: 16, right: 16),
        width: double.infinity,
        child: ClipOval(
          child: SizedBox(
            width: appConfig.blockSizeHorizontal * 12,
            height: appConfig.blockSizeHorizontal * 12,
            child: Image.asset(
              "assets/minhfoto.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  _titleContainer() {
    return Expanded(
      flex: 0,
      child: Container(
          padding: EdgeInsets.all(16),
          child: Text(
            "Choose a movie for today",
            style: TextStyle(fontSize: appConfig.blockSizeHorizontal * 9.5),
          )),
    );
  }

  _searchBar() {
    return Expanded(
      flex: 0,
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 15,
            ),
            Text("Find a movie that interests you")
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _categoryListViewCell("Premiere"),
          _categoryListViewCell("Most popular"),
          _categoryListViewCell("Preview"),
        ],
      ),
    );
  }

  _categoryListViewCell(String txt) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16),
      child: Text(
        txt,
        style: TextStyle(fontSize: appConfig.blockSizeHorizontal * 5),
      ),
    );
  }

  _listMovies() {
    return Expanded(
      child: Container(
          child: PageView.builder(
              itemCount: moviesList.length,
              controller: pageController,
              itemBuilder: (c, i) {
                return AnimatedBuilder(

                    child: _moviesCell(moviesList[i]),
                    animation: change,
                    builder: (c, ch) {
                      return Transform.scale(
                        alignment: Alignment.bottomCenter,
                        scale: change.value,
                        child: _moviesCell(moviesList[i]),
                      );
                    });
              })),
    );
  }

  _moviesCell(Movies movie) {
    return Container(
        margin: EdgeInsets.only(right: 30, bottom: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(32),
            image: DecorationImage(
              image: AssetImage(movie.imagem),
              fit: BoxFit.cover,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 22,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.estelas,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, blurRadius: 2, spreadRadius: 2)
                  ]),
              margin: EdgeInsets.only(left: 20, bottom: 40),
              child: Text(
                movie.nome,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ));
  }
}

class Movies {
  String nome;
  String estelas;
  String imagem;

  Movies(this.nome, this.estelas, this.imagem);
}

class CustomBottomNavBar extends StatefulWidget {
  AppConfig appConfig;
  CustomBottomNavBar(this.appConfig);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  var selected = 0;

  List<IconData> bottomIcons = [
    Icons.local_movies,
    Icons.bookmark,
    Icons.calendar_today,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.appConfig.blockSizeHorizontal * 14,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomIcons.map((item) {
            var itemIndex = bottomIcons.indexOf(item);

            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = itemIndex;
                });
              },
              child: _navItem(item, selected == itemIndex),
            );
          }).toList()),
    );
  }

  _navItem(IconData item, bool select) {
    return Container(
      child: Icon(
        item,
        color: select ? Colors.black : Colors.grey,
        size: widget.appConfig.blockSizeVertical * 4,
      ),
    );
  }
}
