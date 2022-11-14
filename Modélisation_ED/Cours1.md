# Cours 1 - Modélisation ED

 Big Data présent dans plein de secteurs : 
 Auto, energie, santé, industrie, vente, surveillance, domotique, agriculture, ...

 ## But d'un entrepôt : 
- présenter informations utile le + simple possible
- afficher le résultat rapidement (requete rapide) (plus de 10s = non fiable)
- Informations pertiantes avec le processus d'entreprise (regle défini par l'opérationel)

<b><u>Bill Inmon (1992) :</u></b>

Un entrepot de données est une collection de données thématiques, intégrées, non volatiles et historisées pour la prise de décisions.

---
### Technique TOP -> DOWN

<b>Atelier 1</b></br>
Recherche du niveau le + haut des interlocuteurs du projets.(souvent : direction générale)</br>
Cet interlocuteur défini les KPI et les actions à mener.</br>
Les services définissent les indicateurs de pilotage service.</br>
Les opérationels définissent les indicateurs opérationel.</br>

---

<u>Un entrepôt de données a une approche métier.</u>

Uniformiser les données/ définir un référentiel unique.</br>
Toutes les possibilitées doivent être prisent en compte (ex : genre non renseigné)
</br></br>
Traçabilité des informations : 
- la valeur d'un même indicateur sur une période donnée ne change pas en fonction du temps ( les transaction chargées ont eu lieu dans le passé)
- les données ne sont pas supprimées.

Données historisées :</br> 
Chargement des données de manière continue.
les données sont datées et associées à un référentiel temps.

---
### Données opérationnelles / décisionnelles 
Data warehouse -> pas de données opérationnelles.


