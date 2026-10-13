Question1->Sans le Expanded, l'avatar se retrouve à droite du texte parce que sans Expanded pour forcer la Column à prendre tout l'espace disponible, la Row se contente de la largeur minimale requise par le texte.
Question2->prenom est déclaré final car une fois le widget créé avec une valeur, cette valeur ne doit plus jamais changer au cours de la vie du widget.
Question3->La différence entre cs.primary et Colors.teal est que cs.primary dépend du thème, tandis que Colors.teal est une couleur fixe.
Question4->On ne voit plus le dégradé ni l'image car le DecoratedBox est dessiné en premier, donc il se retrouve caché derrière l'image qui est dessinée par-dessus.
Question5-> l'image et le dégradé deviennent rectangulaires et débordent sur les coins
Question6->Pour réserver l'espace à droite du texte
Question7->Le Spacer a besoin de connaître la largeur disponible pour pousser le prix à droite.
Question8->il suffit d'ajouter une nouvelle Destination(...) dans lib/data/destinations.dart, et la boucle for du HomeScreen l'affichera toute seule.