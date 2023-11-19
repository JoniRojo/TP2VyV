import java.util.Random;

public class Producer extends Thread {
    private FlagCounter sharedFlag;

    public Producer ( FlagCounter sharedFlag ) {
        this.sharedFlag = sharedFlag;
    }

    public void run() {
        Random random = new Random();
        System.out.println(this.getName() + " started!");
        for ( int i = 0; i < 5; i++ ) {
            int timeSleep = random.nextInt(3000 - 1000) + 1000;
            try{
                System.out.println(this.getName() + " " + timeSleep + "ms sleeping");
                Thread.sleep(timeSleep);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }

            sharedFlag.increment();
            System.out.println(this.getName() + " raise flag");

            int checkCounter = sharedFlag.getCounter();
            System.out.println(this.getName() + " checking flag");
            if ( checkCounter == 1 ) {
                System.out.println(this.getName() + " enter");
                try {
                    System.out.println(this.getName() + " producing");
                    Thread.sleep(1000);
                    sharedFlag.decrement();
                    System.out.println(this.getName() + " lower flag");
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.out.println(this.getName() + " leave");
            } else {
                sharedFlag.decrement();
                System.out.println(this.getName() + " leave");
            }
        }
        System.out.println(this.getName() + " finished!");
    }
}
