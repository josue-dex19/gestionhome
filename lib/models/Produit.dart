class Produit{
  String type;
  int nombre;
  int prixUnitaire;
  int prixTotal;
  String autrePrecision;
  bool paye;
  int avance;
  int restePaye;

  Produit(this.type, this.nombre, this.prixUnitaire, this.prixTotal,
      this.autrePrecision, this.paye, this.avance, this.restePaye);
}