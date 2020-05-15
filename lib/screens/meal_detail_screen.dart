import 'package:flutter/material.dart';
import 'package:refeicoes/models/meal.dart';

class MealDetailScreen extends StatelessWidget {

  final Function(Meal) onToggleFavoriteMeal;
  final bool Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavoriteMeal, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      color: Colors.blueGrey,
      margin: EdgeInsets.all(10),
      height: 300,
      width: 320,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          meal.title,
          textAlign: TextAlign.center,
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              _createSectionTitle(context, 'Ingredientes'),
              _createSectionContainer(
                ListView.builder(
                    itemCount: meal.ingredients.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        child: Card(
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Text(
                                meal.ingredients[index],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            color: Colors.black54),
                      );
                    }),
              ),
              _createSectionTitle(context, 'Passos'),
              _createSectionContainer(
                ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            meal.steps[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(meal) ? 
          Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () => onToggleFavoriteMeal(meal),//passando dados para a tela anterior
      ),
    );
  }
}
