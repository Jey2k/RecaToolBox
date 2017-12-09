#! /bin/sh
##############################
#Script permettant de configurer dans Recalbox
#Version beta 0.5
# RDV sur geekmag.fr/recalbox/ pour la version mise à jour
#19/11/2017

REP_SCRIPTS=/recalbox/scripts/geekmag_menu/scripts
trap "echo ' Control+C ne doit pas être utilisé! Pour quitter appuyez sur Q' ; sleep 5 ; clear ; continue " 1 2 3

#=========================================================================
shortcuts()
{
cat << EOU

Raccourcis d'accès au menu:

  user          gérer le profil des joueurs
  dl            Téléchargement de ROMS et BIOS

EOU

  exit
}

#-------------------------------------------------------------------------

APROPOS()
{
 $REP_SCRIPTS/ToolBox/menu_INFO_MAJ.sh
}

STEAM()
{
 $REP_SCRIPTS/EmulationStation/moonlight.sh
}

menu_SYSTEM()
{
 $REP_SCRIPTS/ToolBox/menu_SYSTEM.sh
}

DL_BIOS()
{
 $REP_SCRIPTS/ToolBox/Add_Bios.sh
}

DL_ROM()
{
 $REP_SCRIPTS/ToolBox/Ajout_Rom.sh
}

DL_THEMES()
{
 $REP_SCRIPTS/ToolBox/Ajout_Theme.sh
}

SWITCH_Intro_VIDEO()
{
 $REP_SCRIPTS/EmulationStation/Switch_Video_Intro.sh
}

CHANGE_PROFILE()
{
 #$REP_SCRIPTS/EmulationStation/Change_gamer_profile.sh
 echo "Version beta: cette fonction n'est pas encore active"
}

AJOUT_COLLECTION()
{
 $REP_SCRIPTS/ToolBox/Ajout_Collection.sh
}

SWITCH_Ordre_SYSTEM()
{ 
 $REP_SCRIPTS/EmulationStation/SWITCH_Ordre_SYSTEM.sh
}

#=========================Début_Menu_Utilisateur=================================
menu_user()
{
while true
do
clear
cat << "EOT"
-------------------------------------
     Choix d'un profil de gamer 
-------------------------------------

1 )  Créer un profil de joueur
2 )  Changer de profil
3 )  Supprimer un profil



r )  Retourner au menu précédent
q )  Quitter le menu

Entres la lettre correspondant à l option de ton choix et validez par Entree

EOT

read answer
clear
case "$answer" in
[1]*) echo "Version beta du script: cette fonction n'est pas encore active";;
[2]*) echo "Listage des profils"
	  CHANGE_PROFILE;;
[3]*) echo "Version beta du script: cette fonction n'est pas encore active";;

[Rr]*) menu_main  ;;
[Qq]*)  echo "Retour au menu principal" ; exit 0 ;;
*)      echo "Choisi un profil avec pour chacun sa collection de jeux et son thème" ;;
esac
echo ""
echo "Appuies sur Entrée pour revenir au menu gestion des utilisateurs"
read dummy
done
}
#=============================Fin_Menu_Utilisateur================================

#=============================Debut_Menu_DONWLOAD=================================
menu_DL()
{
while true
do
clear
cat << "EOT"
-------------------------------------
        MENU TELECHARGEMENT
-------------------------------------

1 )  Télécharger des ROMS
2 )  Télécharger des BIOS
3 )  Configurer Steam Link (Moonlight)

r )  Retour au menu principal
q )  Quitter le menu

Tu as besoin de télécharger quoi? des jeux ou des BIOS?

EOT

read answer
clear
case "$answer" in
[1]*)  echo "Chargement de la liste des ROMS "
	   DL_ROM;;
[2]*)  echo "Chargement de la liste des BIOS "
	   DL_BIOS;;
[3]*)  echo "Chargement de l'assistant de configuration Steam "
	   STEAM;;
[Rr]*) menu_main  ;;
[Qq]*)  echo "Sortie du menu telechargement" ; exit 0 ;;
*)      echo "Merci de sélectionner une option valide" ;;
esac
echo ""
echo "Appuies sur Entrer pour revenir au menu"
read dummy
done
}
#=============================FIN_MENU_DL====================================

#=============================Debut_Menu_Personnalisation====================
menu_CUSTOM()
{
while true
do
clear
cat << "EOT"
--------------------------------------
 MENU PERSONNALISATION de L'INTERFACE
--------------------------------------

1 )  Télécharger des Thèmes
2 )  Installer une collection 
     Permet de créer un menu regroupant tous les jeux d'une SAGA indépendamment de la plateforme)
3 )  Changer la video d'intro (splashscreen de démarrage)
4 )  Changer l'ordre d'affichage des consoles

r )  Retour au menu principal
q )  Quitter le menu

Tu as besoin de télécharger quoi? des jeux ou des BIOS?

EOT

read answer
clear
case "$answer" in
[1]*)  echo "Chargement de la liste des thèmes "
	   DL_THEMES;;
[2]*)  echo "Chargement de la liste des collections de jeux "
	   AJOUT_COLLECTION;;
[3]*)  echo "Chargement de la liste des vidéo d'intro "
	   SWITCH_Intro_VIDEO;;
[4]*)  #Chargement du menu pour switcher les fichiers de conf
	   SWITCH_Ordre_SYSTEM;;	   
[Rr]*) menu_main  ;;
[Qq]*)  echo "Sortie du menu de personnalisation" ; exit 0 ;;
*)      echo "Merci de sélectionner une option valide" ;;
esac
echo ""
echo "Appuies sur Entrer pour revenir au menu"
read dummy
done
}
#=============================FIN_MENU_Personnalsiation======================

menu_main()
{
RET=menu_main
while true
do
clear
cat << "EOT"
--------------------------------------
	   Menu principal
--------------------------------------

u )  Utilisateurs (gérer les profils)
j )  Jeux (téléchargement ROMS /BIOS + conf Steam)
p )  Personnaliser l'interface EMULATIONSTATION
s )  Système (USB / SD / NAS et IMG)
i )  Informations et Mise à jour


q )  Quitter (sortir du menu)

Sélectionnes l'option de ton choix pour personnaliser automatiquement ta Recalbox

EOT

read answer
clear
case "$answer" in
[Uu]*) menu_user ;;
[Jj]*) menu_DL ;;
[Pp]*) menu_CUSTOM ;;
[Ss]*) menu_SYSTEM ;;
[Ii]*) APROPOS ;;
[Qq]*)  echo "Bye ami gamer! A Bientôt sur GeekMag.fr pour les mises à jour" ; exit 0 ;;
*)      echo "Hey mec faut choisir une option qui existe :)" ;;
esac
echo ""
echo "Appuies sur enrée pour revenir"
read dummy
done
}


#gestion des parametres
while getopts h os
do case "$o" in
    h)      usage;;
    s)      shortcuts;;
    esac
done

echo $1

# common
[ $# -ge 2 ] && usage
[ $# -eq 0 ] && menu_main

# shortcuts
[ "$1" == "user" ] && menu_user
[ "$1" == "dl" ] && menu_DL
[ "$1" == "custom" ] && menu_CUSTOM
[ "$1" == "about" ] && APROPOS

echo "Accès direct à ce sous menu non trouvé"