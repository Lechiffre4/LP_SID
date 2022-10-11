public class Testexcep {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try
        {
            tableau t2=new tableau (-2);
            tableau t=new tableau (5);

            double elem;
            elem=t.elemindi(3) ;
            System.out.println(elem);
            elem=t.elemindi(10) ; // lève une exception, indice trop grand
            System.out.println(elem);

        }
        catch (vect_lim l)
        {
            System.out.println("exception limite, indice " + l.getind()+ " en dehors du tableau ");
            System.exit (-1);
        }
        catch (vect_crea c)
        {
            System.out.println("exception lors de la création, le nombre d'éléments " + c.getnb()+ " est négatif");
            System.exit (-1);
        }
        catch (Exception e)
        {
            System.out.println(e);
            System.out.println(e.getMessage());

        }
        finally
        {
            System.out.println("Termine!");
        }

    }

}

