package qnactr.objectDesigner;

import gov.nasa.xpc.XPlaneConnect;
import qnactr.sim.QnactrSimulation;

import java.io.IOException;
import java.net.SocketException;

public class World3D_Template_Piloting_Xplane_Method {
    public QnactrSimulation sim;


    public World3D_Template_Piloting_Xplane_Method(QnactrSimulation Sim) {
        sim = Sim;
        //testXplaneConnection();
    }

    public static void testXplaneConnection() {
        System.out.println("X-Plane Connect example program");
        System.out.println("Setting up simulation...");
        try (XPlaneConnect xpc = new XPlaneConnect()) {
            float[] data;
            // Ensure connection established.
            xpc.getDREF("sim/test/test_float");

            xpc.sendDREF("sim/cockpit2/engine/actuators/ignition_on", (float) 0);
            xpc.sendDREF("sim/cockpit2/engine/actuators/ignition_key", (float) 0);
            System.out.println("Ignition Switch Off.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/switches/avionics_power_on");
            if (data[0] != (float) 0)
                xpc.sendDREF("sim/cockpit2/switches/avionics_power_on", (float) 0);
            System.out.println("Avionics Switch Off.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/electrical/battery_on");
            if (data[0] != (float) 0)
                xpc.sendDREF("sim/cockpit2/electrical/battery_on", (float) 1);
            System.out.println("Battery Switch On.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/fuel/fuel_quantity");
            System.out.format("Fuel Quantity is %f KG.\n", data[0]);
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/controls/flap_ratio");
            if (data[0] != (float) 0)
                xpc.sendDREF("sim/cockpit2/controls/flap_ratio", (float) 0);
            System.out.println("Flaps Up.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/engine/actuators/throttle_ratio_all");
            if (data[0] != (float) 0.25)
                xpc.sendDREF("sim/cockpit2/engine/actuators/throttle_ratio_all", (float) 0.1);
            System.out.println("Throttle 1/4 Inch.");
            mySleep(1000);

            xpc.sendDREF("172/engine/mixture_ratio_0", (float) 0);
            System.out.println("Mixture Cutoff.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/switches/beacon_on");
            if (data[0] != (float) 1)
                xpc.sendDREF("sim/cockpit2/switches/beacon_on", (float) 1);
            System.out.println("Beacon Light On.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/engine/actuators/fuel_pump_on");
            if (data[0] != (float) 1)
                xpc.sendDREF("sim/cockpit2/engine/actuators/fuel_pump_on", (float) 1);
            System.out.println("Fuel Pump On.");
            mySleep(1000);

            xpc.sendDREF("172/engine/mixture_ratio_0", (float) 1);
            System.out.println("Mixture Full 5 Sec.");
            mySleep(5000);

            xpc.sendDREF("172/engine/mixture_ratio_0", (float) 0);
            System.out.println("Mixture Idle.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/engine/actuators/fuel_pump_on");
            if (data[0] != (float) 1)
                xpc.sendDREF("sim/cockpit2/engine/actuators/fuel_pump_on", (float) 0);
            System.out.println("Fuel Pump Off.");
            mySleep(1000);

            xpc.sendDREF("sim/cockpit2/engine/actuators/ignition_on", (float) 4);
            long t = System.currentTimeMillis();
            long end = t + 3000;
            float i = 0;
            while (System.currentTimeMillis() < end) {
                i = i + 0.017f;
                xpc.sendDREF("172/engine/mixture_ratio_0", (float) i);
                xpc.sendDREF("sim/cockpit2/engine/actuators/ignition_key", (float) 4);
                mySleep(50);
            }
            System.out.println("Starter Switch On and Mixture Advance");
            mySleep(1000);

            xpc.sendDREF("sim/cockpit2/engine/actuators/ignition_on", (float) 3);
            xpc.sendDREF("sim/cockpit2/engine/actuators/ignition_key", (float) 3);
            System.out.println("Starter Switch to Both.");
            mySleep(1000);

            data = xpc.getDREF("sim/cockpit2/switches/avionics_power_on");
            if (data[0] != (float) 1)
                xpc.sendDREF("sim/cockpit2/switches/avionics_power_on", (float) 1);
            System.out.println("Avionics Switch On.");
            mySleep(1000);
        } catch (SocketException ex) {
            System.out.println("Unable to set up the connection. (Error message was '" + ex.getMessage() + "'.)");
        } catch (IOException ex) {
            System.out.println("Something went wrong with one of the commands. (Error message was '" + ex.getMessage() + "'.)");
        }
        System.out.println("Exiting");
    }

    public static void mySleep(long millis) {
        try {
            Thread.sleep(millis);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }


}


