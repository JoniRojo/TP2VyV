public class FlagCounter {
    int counter = 0;

    public int getCounter() {
        return counter;
    }

    public synchronized void increment() {
        counter ++;
        System.out.printf(Thread.currentThread().getName() + " increment\n");
    }

    public synchronized void decrement() {
        counter --;
        System.out.printf(Thread.currentThread().getName() + " decrement\n");
    }

}