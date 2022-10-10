public class Exemple3 {
    protected int Cage;
    protected int Cpoids;
    Exemple3()
    {
        Cage=0;
        Cpoids=0;
    }
    void SetAge(int age)
    {
        Cage=age;
    }
    int GetPoids()
    {
        return Cpoids;
    }
    void SetPoids(int poids)
    {
        Cpoids=poids;
    }
    void Crier()
    {
        System.out.println("Methode de la classe mammifere... Les mammiferes ont la parole! \n") ;
    }
    void Dormir()
    {
        System.out.println("Silence je dors \n");
    }
};


