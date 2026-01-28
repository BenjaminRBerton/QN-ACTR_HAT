package seev;

import java.util.*;

public class seev {

    // Singleton instance
    private static seev instance = null;

    // Default seed for reproducibility
    private static final long DEFAULT_SEED = 42L;

    // Random number generator
    private Random rng;

    // Cache for last drawn AOI (so X and Y come from same draw)
    private String lastDrawnAOI = null;

    // AOI class to hold name, probability, and coordinates
    static class AOI {
        String name;
        double probability;
        int x;
        int y;

        AOI(String name, double probability, int x, int y) {
            this.name = name;
            this.probability = probability;
            this.x = x;
            this.y = y;
        }
    }

    // List of Areas of Interest with their probabilities and coordinates
    private static final List<AOI> aoiList = Arrays.asList(
        new AOI("PFD", 0.050, 1260, 750),
        new AOI("ND", 0.050, 1880, 900),
        new AOI("E/WD", 0.100, 1600, 920),
        new AOI("CentralConsole", 0.050, 2020, 1330),
        new AOI("FlightManual", 0.7, 350, 990),
        new AOI("OutsideWindow", 0.050, 1120, 340)
    );

    // Private constructor for singleton pattern
    private seev() {
        this.rng = new Random(DEFAULT_SEED);
    }

    // Get singleton instance
    public static seev getInstance() {
        if (instance == null) {
            synchronized (seev.class) {
                if (instance == null) {
                    instance = new seev();
                }
            }
        }
        return instance;
    }

    // Static method to draw a random AOI using the singleton's RNG
    public static String drawRandomAOI() {
        return getInstance().drawAOI();
    }

    // Static method to draw a random AOI with a custom Random instance
    public static String drawRandomAOI(Random customRng) {
        double r = customRng.nextDouble(); // Random number in [0,1)
        double cumulative = 0.0;
        for (AOI aoi : aoiList) {
            cumulative += aoi.probability;
            if (r < cumulative) {
                return aoi.name;
            }
        }
        // fallback (should not happen if probabilities sum to 1)
        return aoiList.get(aoiList.size() - 1).name;
    }

    // Instance method to draw an AOI (caches result)
    private String drawAOI() {
        double r = rng.nextDouble(); // Random number in [0,1)
        double cumulative = 0.0;
        for (AOI aoi : aoiList) {
            cumulative += aoi.probability;
            if (r < cumulative) {
                lastDrawnAOI = aoi.name; // Cache it
                return aoi.name;
            }
        }
        // fallback (should not happen if probabilities sum to 1)
        lastDrawnAOI = aoiList.get(aoiList.size() - 1).name;
        return lastDrawnAOI;
    }

    // Get all AOIs (useful for iteration or inspection)
    public static List<AOI> getAOIList() {
        return Collections.unmodifiableList(aoiList);
    }

    // Seed the singleton's RNG (useful for reproducibility)
    public static void setSeed(long seed) {
        getInstance().rng.setSeed(seed);
    }

    // Get X coordinate for a specific AOI name
    public static int getAOIX(String aoiName) {
        for (AOI aoi : aoiList) {
            if (aoi.name.equals(aoiName)) {
                return aoi.x;
            }
        }
        System.out.println("Warning: AOI '" + aoiName + "' not found, returning -1");
        return -1;
    }

    // Get Y coordinate for a specific AOI name
    public static int getAOIY(String aoiName) {
        for (AOI aoi : aoiList) {
            if (aoi.name.equals(aoiName)) {
                return aoi.y;
            }
        }
        System.out.println("Warning: AOI '" + aoiName + "' not found, returning -1");
        return -1;
    }

    // Draw a NEW random AOI, cache it, and return its X coordinate
    // Call this FIRST when you need a new AOI
    public static int drawRandomAOI_X() {
        seev instance = getInstance();
        instance.drawAOI(); // Draw new AOI and cache it
        //System.out.println("Debug: drawRandomAOI_X() cached AOI: " + instance.lastDrawnAOI);
        return instance.getAOIX(instance.lastDrawnAOI);
    }

    // Get Y coordinate from the CACHED AOI, then RESET cache to null
    // Call this SECOND after drawRandomAOI_X() to get matching Y coordinate
    public static int getFromCachedAOI_Y() {
        seev instance = getInstance();
        if (instance.lastDrawnAOI == null) {
            //System.out.println("Warning: drawRandomAOI_Y() called but no AOI cached. Drawing new AOI.");
            return -1;
        }
        int y = instance.getAOIY(instance.lastDrawnAOI);
        instance.lastDrawnAOI = null; // RESET cache after use
        return y;
    }

    // Get the last drawn AOI name (does NOT reset cache)
    public static String getLastDrawnAOI() {
        return getInstance().lastDrawnAOI;
    }


    // Draw a random AOI and get both coordinates as an array [x, y]
    public static int[] drawRandomAOI_XY() {
        String aoiName = drawRandomAOI();
        return new int[] { getAOIX(aoiName), getAOIY(aoiName) };
    }

}
