public class construct3 extends Exception{
    String errorText;
    construct3(String text){ this.errorText = text;};

    public String getText(){return this.errorText;}

}
