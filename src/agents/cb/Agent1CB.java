package agents.cb;

import gov.nasa.xpc.XPlaneConnect;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ingescape.*;

public class Agent1CB implements IopListener, ServiceListener {
    private static Logger _logger = LoggerFactory.getLogger(Agent1CB.class);

    public Agent1CB() {

    }

    @Override
    public void handleIOP(Agent agent, Iop iop, String name, IopType type, Object value) {
        _logger.debug("**received input {} with type {} and value {}", name, type, value);

        if (iop == Iop.IGS_INPUT_T && type == IopType.IGS_DOUBLE_T){
            double myDouble = (Double) value;
            float inputDouble = (float) myDouble;
            _logger.debug("**received double {} with value {}, processing...", name, inputDouble);
            try(XPlaneConnect xpc = new XPlaneConnect())
            {
                xpc.sendDREF("sim/cockpit/switches/gear_handle_status", inputDouble);
            }
            catch (IOException e){
                System.out.println("ERROR : ");
                System.out.println(e.getMessage());
            }

        }

    }

    @Override
    public void handleCallToService(Agent agent, String senderAgentName, String senderAgentUUID,
                                    String serviceName, List<Object> arguments, String token) {
        _logger.debug("**received service call from {} ({}): {} (with token {})", senderAgentName, senderAgentUUID, serviceName, arguments, token);
    }
}