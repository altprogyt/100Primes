public class Prime {
    private int number;
    private long square;
    private int seq;

    public Prime(int seq, int number) {
        this.number = number;
        this.square = number * number;
        this.seq = 1 + seq;
    }
    public String print() {
        return String.format("%20s: %20s", this.seq, this.number);
    }
    public int getNumber() {
        return this.number;
    }
    public long getSquare() {
        return this.square;
    }
}
