package bid.rcgreed.yaml;


public interface YamlBase{
    void dump(YamlWriter print) throws YamlException;
    static public YamlBase fromInt(int value){
        return new YamlInt(value);
    }
    static public YamlBase fromString(String s){
        return new YamlString(s);
    }
    static public YamlBase fromFloat(float f){
        return new YamlFloat(f);
    }
}
final class YamlInt implements YamlBase{
    final private int value;
    public YamlInt(int val){
        value=val;
    }
    @Override
    public void dump(YamlWriter print) throws YamlException{
        
    }
}
final class YamlLong implements YamlBase{
    final private long value;
    public YamlLong(long val){
        value=val;
    }
    @Override
    public void dump(YamlWriter print) throws YamlException {
    }
}
final class YamlFloat implements YamlBase{
    final private float value;
    public YamlFloat(float val){
        value=val;
    }
    @Override
    public void dump(YamlWriter print) throws YamlException {
    }
}
final class YamlString implements YamlBase{
    final private String value;
    public YamlString(String val){
        value=val;
    }
    @Override
    public void dump(YamlWriter print) throws YamlException{

    }
}
