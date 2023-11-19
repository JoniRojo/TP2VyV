public class Main {

    public static void main(String[] args) {
        FlagCounter sharedFlag = new FlagCounter();

        Thread prod1 = new Producer(sharedFlag);
        Thread prod2 = new Producer(sharedFlag);

        prod1.start();
        prod2.start();
    }
}
