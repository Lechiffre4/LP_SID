# Cours 2 - Modélisation ED

## Architectures désicionnelles :

Sources -> ETL(Préparation des données) -> Entrepôt de données -> Reporting(Analyse)

Grosses BDD(DWH) : SQL server, Oracle, Snowflake, Teradata

<b>Data Mart : Sous ensemble du data warehouse contenant toutes les données liées à un métier.</b>

<b>Métadonnées : Elles contiennent des infos concernant les données de l'entrepôt(provenance, structure, règle de transformations). Elles sont <span style="color:#FE3030"><u>indispensables</u></span>.</b>
</br></br>

Exemples : 
- Catalogue des objets déstinées aux users
- Audit des chargement(date de changement,origine ...)
- Description du modèle de données (tables,colonnes, liens ...)
- Description des contrats d'échange avec les systèmes sources
- Règles de gestion
- Fréquence des chargements
- etc ...



