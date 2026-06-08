class Test{
    static int max(int x, int y){
        if(x > y){
            return x;
        }else{
            return y;
        }
    }
    public static void main(String[] args) {
        String[] sa = new String[3];
        sa[0] = "java";
        sa[1] = "Ruby";
        sa[2] = "C#";
        for(String str:sa){
            System.out.println(str);
        }
    }
}