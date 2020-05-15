import 'package:flutter/material.dart';
import 'package:refeicoes/utils/app_routes.dart';
import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem(this.category);

  void _selectCategory(BuildContext context){//metodo de navegacao
    //Construindo a rota nomeda, mas agora passando a categoria via argumento 
    Navigator.of(context).pushNamed(
      AppRoutes.CATEGORIES_MEALS,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(//faz com que o widget se torne clicavel
      onTap: () => _selectCategory(context),//função que de click que ira efetuar alguma ação
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.6),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
