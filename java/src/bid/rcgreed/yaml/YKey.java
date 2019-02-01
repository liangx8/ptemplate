package bid.rcgreed.yaml;
import java.io.InputStream;
public class YKey implements YamlRender{
    final Object keyValue;
    final Class<?> keyType;
    public YKey(Object val){
        keyValue=val;
        keyType=val.getClass();
    }
    public void render(InputStream inputStream){

    }
}