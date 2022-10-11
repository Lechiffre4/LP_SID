public class Chien extends Exemple3
{
    protected String Crace;
    Chien()
    {
        super();
        Crace="";
    }
    String GetEspece()
    {
        return Crace;
    }
    void SetEspece(String race)
    {
        Crace=race;
    }
    void BougerLaQueue()
    {
        System.out.println("Methode de la classe chien ... Fretillement de la queue \n");
    }
    int GetAge()
    {
        //On utilise un attribut protected de la classe de base
        return Cage;
    }
    void Dormir()
    {
        super.Dormir();
        System.out.println("Et comme je suis un chien, n'approchez pas de ma panière! \n");
    }
}