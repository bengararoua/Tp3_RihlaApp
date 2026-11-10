Question1->Sans le Expanded, l'avatar se retrouve à droite du texte parce que sans Expanded pour forcer la Column à prendre tout l'espace disponible, la Row se contente de la largeur minimale requise par le texte.
Question2->prenom est déclaré final car une fois le widget créé avec une valeur, cette valeur ne doit plus jamais changer au cours de la vie du widget.
Question3->La différence entre cs.primary et Colors.teal est que cs.primary dépend du thème, tandis que Colors.teal est une couleur fixe.
Question4->On ne voit plus le dégradé ni l'image car le DecoratedBox est dessiné en premier, donc il se retrouve caché derrière l'image qui est dessinée par-dessus.
Question5-> l'image et le dégradé deviennent rectangulaires et débordent sur les coins
Question6->Pour réserver l'espace à droite du texte
Question7->Le Spacer a besoin de connaître la largeur disponible pour pousser le prix à droite.
Question8->il suffit d'ajouter une nouvelle Destination(...) dans lib/data/destinations.dart, et la boucle for du HomeScreen l'affichera toute seule.
Question9->Sans setState, l’écran reste inchangé mais la valeur se change en mémoire
Question10->Un getter est recalculé à chaque build(), ce qui garantit que la liste affichée correspond toujours à la valeur actuelle de _categorie, alors qu’une variable stockée devrait être mise à jour manuellement et risquerait de se désynchroniser.
Question11->HeroBanner reçoit sa destination en paramètre et n’a aucun état propre qui change, donc c’est HomeScreen qui est reconstruit et qui le recrée simplement à l’identique.
Question1:Palier6->en mettant en favori et puis filtrer et renver à tout ,le coeur est non sur la bonne carte
Question2:Palier6->le cœur reste sur la bonne carte, car la clé identifie chaque carte par son nom et Flutter réattache donc le bon State  à la bonne destination, quelle que soit sa position dans la liste filtrée.
Question1/tp4:Oui, le filtre est conservé, car Navigator.pop() dépile DetailScreen et revient à l'écran précédent sans le recréer
Question2/tp4:DetailScreen reçoit la destination via son constructeur grâce au mécanisme de passage de paramètres entre widgets.
Question3/tp4:l'effet d'encre (InkWell) peut dépasser les coins arrondis de la carte.
Question1/palier3/tp4:_formKey.currentState!.validate() vérifie tous les champs du formulaire et renvoie true si tous sont valides, sinon false.
Question2/palier3/tp4:inputFormatters filtrent la saisie pendant que l'utilisateur tape, tandis que validator vérifie la valeur saisie lors de la validation du formulaire.
Question3/palier3/tp4:dispose() libère les ressources des contrôleurs.
Question1/palier4/tp4:empêche la saisie manuelle de la date et oblige l'utilisateur à la choisir via le calendrier
Question2/palier4/tp4:_total est un getter calculé automatiquement à partir de _formule et du nombre de voyageurs, donc sa valeur est recalculée à chaque lecture après un setState.
Question1/palier5/tp4:null
Question2/palier5/tp4:VS Code affiche "Don't use BuildContext across async gaps".->Il signifie que le widget peut ne plus être affiché après await.
Question3/palier5/tp4:Une boîte de dialogue est aussi une route dans la pile de navigation ; 
Question1/palier0/tp5:le code 404 appartient à la famille des erreurs clients
Question2/palier0/tp5:Le serveur
Question3/palier0/tp5:La méthode GET n'a pas de corps car elle récupère une ressource existante contrairement au POST qui envoie des données dans son corps pour créer une nouvelle ressource.