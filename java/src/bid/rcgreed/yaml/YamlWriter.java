package bid.rcgreed.yaml;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;

public class YamlWriter {
    final private int rank;
    final private Params params;
    final PrintStream print;
    public YamlWriter(Params p,OutputStream out){
        rank=0;
        params=p;
        print=new PrintStream(out);
    }
    private YamlWriter(int ra,Params p,PrintStream pr){
        rank=ra;
        params=p;
        print=pr;
    }
    public YamlWriter promoted(){
        return new YamlWriter(rank + 1,params,print);
    }
    public static class Params{
        public int indent;
    }
    public void renderIndent() throws YamlException{
        ByteArrayOutputStream buffer=new ByteArrayOutputStream(30);
        for(int x=0;x<rank *params.indent;x++){
            buffer.write(' ');
        }
        try {
            buffer.writeTo(print);
        } catch (IOException e) {
            throw new YamlException(e);
        }
    }
    public void done(){
        
    }
}