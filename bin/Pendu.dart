import 'dart:math';
import 'dart:io';
import 'dart:core';
import 'dart:collection';
import 'dart:async'; 
import 'dart:isolate';

final int NB_ERREURS_MAX = 30; //Le nombre d'erreur maximale toélérées
void main() {
  //print("Hello, World!");
  
  int i; //Une variable de boucle
  var tabMots = ["ablation","hypocrisie","interminable","revolution","erudit","feudiste","accueil","explosion","reliure","niais","petit","piquet","blond","punk"];//Tableau contenant tous les mots a trouver.
  Random rand=new Random(); //Déclaration de l'objet rand, qui servira a utiliser des nombre aléatoire.
  int nbAleatoire=rand.nextInt(tabMots.length); //Cette variable contient un nombre compris entre 0 et la valeur de la taille du tableau des mots a chercher.
  String motADeviner=tabMots[nbAleatoire]; //On insère dans la variable motAdeviner le mots qui a été tiré au hasard
  int longueurMotAChercher=motADeviner.length; //On stock dans cette variable la longueur du mot a Deviner.
  var tabMotAChercher = new List(longueurMotAChercher); //On créer un tableau de caractère de même taille que la longueur du mot a chercher
  //tabMotAChercher=new char [longueurMotAChercher];
  var lettreSaisie; //Servira pour la saisie de la lettre
  bool motTrouve=false; //Nous permettra de savoir si le mot est trouve ou pas.
  int nbLettresBonnes=0; //Le nombre de bonnes lettres trouvés.
  bool bonneLettre=false; //Nous permettra de savoir si l'utilisateur a entrée une lettre qui se trouve dans le mot ou non?
  int erreur=0; //Le nombre d'erreur.
  bool identique=false; //Nous permettra de savoir si l'utilisateur a saisi une lettre identique, qui est déjà afficher a l'écran dans le mot.
  int k=0;//Permettra de décaler les cases du tableau de lettres fausse de 1 a chaque erreur.
  bool difference;//Nous permettra de juger si la lettre que l'utilisateur a saisi est différente ou non du mot.
  bool identique2=false; //Nous permettra de savoir si l'utilisateur a saisi une lettre identique, qui n'est pas contenu dans le mot mais qui a été déjà saisie par l'utilisateur.
  var verifSaisie = new List(NB_ERREURS_MAX);//Ce tableau contiendra toutes les lettre fausses saisie par l'utilisateur, sa taille est égal au nombre d'erreur.
  //verifSaisie=new char [NB_ERREURS_MAX];
  
  
  //ENTETE
  
  print("*********************************\n");
  print("*Bienvenue dans le jeu du pendu!*\n");
  print("*********************************\n");
  print("");
  //FIN ENTETE


  //On insère les différents lettres du mots a l'aide de cette boucle
  print("Voici le mot a trouver: ");
  for (i=0;i<tabMotAChercher.length;i++){
    
    if (i==0){ //On insére la première lettre du mot dans la case 0
      
      tabMotAChercher[i]=motADeviner.substring(i, i+1);
    }
    else if (i==tabMotAChercher.length-1){ //On insère la dernière lettres du mot dans la dernière case
      
      tabMotAChercher[i]=motADeviner.substring(i, i+1);
    }
    else{
      
      tabMotAChercher[i]='-'; //Pour le reste entre on insère des tirets
    }
    
    print(tabMotAChercher[i]); //Affichage des caractères.
  }
 
  print("-----------------------------------\n");
  
  
  do{
  
  var tabLettres = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
  Random randL =new Random(); //Déclaration de l'objet rand, qui servira a utiliser des nombre aléatoire.
  int nbAleatoireL=randL.nextInt(tabLettres.length);
  String lettreADeviner=tabLettres[nbAleatoireL];//choix automatique et random fait pas l'ordinateur
    nbLettresBonnes=0; //Pour l'instant aucune lettre est bonnes.
    bonneLettre=false; //Idem.
    //do{ //Tant que l'utilisateur a saisi des lettres qu'il a déjà saisi auparavant on execute les instruction ci dessous.
      if ((identique!=false) || (identique2!=false)){ 
        
        
        print("-------------------------------------");
        print("ERREUR:Cette lettre a deja ete saisie dans le mot");
        print("-------------------------------------");
        print("RAPPEL: le mot a chercher est: ");
        
        for (i=0;i<tabMotAChercher.length;i++){ //On réaffiche le mot a chercher en cas de saisie de lettre déjà saisie.
          
          print(tabMotAChercher[i]);
        }
       print ("\n");
      }
     //section lettre entrée automatiquement par la variable randL
      lettreSaisie=lettreADeviner;
      difference=true; 
      
      identique=false;
      identique2=false;
      for (i=0;i<NB_ERREURS_MAX;i++){ //Cette boucle parcours le tableau des lettres érronés, si la lettre saisie aléatoirement est déjà contenu dans le tableau alors on considère cette lettre saisie a été saisie auparavant.
        
        if (verifSaisie[i]==lettreSaisie){
          
          identique2=true;
        }
      }
      
      for (i=1;i<tabMotAChercher.length-1;i++){//Si la lettre saisie aléatoirement est une lettre qui est contenu dans le mot ou si la lettre saisie  se trouve dans le tableau des lettres fausses déjà saisie, alors difference devient faux. L'ordinateur a donc juste.
        
        if ((lettreSaisie==motADeviner.substring(i, i+1)) || (identique2==true)){
          
          difference=false;
          
        }
      }
      
      if (difference==true){ //Si difference est vrai cela signifie que l'ordinateur s'est trompé on met alors la lettre fausse dans le tableau des lettres fausses VerifSaisie.
        
        
        verifSaisie[k]=lettreSaisie;
        
        k=k+1;
        
      }
      
      for (i=1;i<tabMotAChercher.length-1;i++){//On regarde si la lettre saisie par l'ordinateur n'est pas déjà visible a l'écran.
        
        if (lettreSaisie==tabMotAChercher[i]){
          
          identique=true;
        }
        
      }

     
   // }while((identique!=false) || (identique2!=false));
    for (i=1;i<tabMotAChercher.length-1;i++){
        if (lettreSaisie==motADeviner.substring(i, i+1)){
         tabMotAChercher[i]=lettreSaisie;//S'il ya correspondance alors on remplace le tirer par la lettre.
         bonneLettre=true;//Cela est donc une bonne lettre
        } 
      }
    
    if (bonneLettre!=true){ //Si l'utilisateur s'est trompé alors on lui ajoute une erreur
      erreur=erreur+1;
      print("Aucune lettre ne correspond a votre saisie il vous reste : ");
      print(NB_ERREURS_MAX-erreur);
      print(" Chances! ");
      print("\n");
    }
     if (erreur!=NB_ERREURS_MAX){
      
      
      for (i=1;i<tabMotAChercher.length-1;i++){
        
        
        
        if (tabMotAChercher[i]==motADeviner.substring(i, i+1)){ //On comptabilise le nombre de bonnes lettre trouvé.
          
          nbLettresBonnes=nbLettresBonnes+1;
          
          
        } 
        
        if (nbLettresBonnes==motADeviner.length-2){ //Si le nombre de bonnes lettres correspond au nombre de tirets dans le mots alors MotTrouve prends vrai l'utilisateur a gagner.
          
          motTrouve=true;
          
          print("Vous avez trouvez le mot feliciations!\n");
          print("Le mot etait: ");
          print(motADeviner);
        }
      }
      }
  
     if (motTrouve!=true){
       
       
       print("Vous avez trouve en tout "); //Si le mot n'est pas trouvé alors on affiche le nombre de lettre trouvé en tout
       print(nbLettresBonnes);
       print(" lettres.\n");
       print("Maintenant le mot devient: ");
       
       for (i=0;i<tabMotAChercher.length;i++){
        print(tabMotAChercher[i]); //On affiche le mot après que l'ordinateur est trouver une des lettres 
       }
       
     }
     print("-----------------------------------\n");

  }while((motTrouve==false) && (erreur!=NB_ERREURS_MAX))  ; // On execute les blocs d'instruction du dessus tant que le joueur n'a pas perdu ou tant que le mot a trouver n'est pas trouvé.
  
  
  //gestion des erreurs
  if (erreur==NB_ERREURS_MAX){ //Quand on atteint le nombre d'erreur max le joueur perds... 
    print("-----------------------------------\n");
    print("Fin de partie vous avez perdu!\n");
    print("");
    print("Le mot etait: "+motADeviner+"\n");

}

}
