/**
  * Copyright (C) 2006, Laboratorio di Valutazione delle Prestazioni - Politecnico di Milano

  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.

  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.

  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */

/**
 * 2013. Modified for QN-Java project
 * 
 * [2013-06-28] add statusBar for Clock display 
 * 
 */

package jmt.gui.jmodel.mainGui;

import java.awt.BorderLayout;
import java.awt.Dimension;

import javax.swing.*;
import javax.swing.border.BevelBorder;

import agents.cb.Agent1CB;
import gov.nasa.xpc.XPlaneConnect;
import jmt.framework.gui.components.JMTFrame;
import jmt.framework.gui.components.JMTMenuBar;
import jmt.framework.gui.components.JMTToolBar;
import jmt.framework.gui.layouts.MultiBorderLayout;
import jmt.gui.common.resources.JMTImageLoader;
import jmt.gui.jmodel.controller.GraphMouseListner;
import jmt.gui.jmodel.controller.Mediator;

import org.jgraph.JGraph;

import qnactr.GUI.EntitiesViewer;
import qnactr.sim.GlobalUtilities;
import qnactr.sim.QnactrSimulation;
import qnactr.test.TestGUI;

import com.ingescape.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import gov.nasa.xpc.XPlaneConnect;

/**
 * MainWindow contains the main window of the jmodel project, it implements the
 * Singleton pattern. no need to create more then 1 main window!
 *

 * @author Federico Granata, Bertoli Marco
 * Date: 3-giu-2003
 * Time: 14.09.14

 */
public class MainWindow extends JMTFrame implements AgentEventListener, WebSocketEventListener{
	/**
	 * 
	 */

	/**
	 * Added by Berton July 17th to add Ingescape
	 */
	private static Logger _logger = LoggerFactory.getLogger(MainWindow.class);

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private static final String TITLE = "JSIMgraph - Advanced queueing network design tool";

	protected Mediator mediator;// mediator between components of the application
	protected JMTToolBar toolbar;//main toolbar
	protected JMTMenuBar menu;//main menu
	protected GraphMouseListner ml;//mouse listener of the JGraph
	protected JScrollPane scroll;//panel that contains the JGraph component

	protected JPanel mainPane;//panel that contains the "scroll"
	
	//QN-Java
	protected JPanel statusPanel;
	public JLabel statusLabel;

	public static boolean advanced = false;

	/** Creates the new Main window of the application.
	 *
	 */
	public MainWindow() {

		super(true);

		this.setIconImage(JMTImageLoader.loadImage("JMODELIcon").getImage());
		setTitle(TITLE);
		mediator = new Mediator(null, this);
		Mediator.advanced = advanced;

		//menu = new Menu(mediator);
		menu = mediator.createMenu();
		setJMenuBar(menu);



		toolbar = mediator.createToolbar();
		getContentPane().setLayout(new MultiBorderLayout());
		getContentPane().add(toolbar, BorderLayout.NORTH);
		getContentPane().add(mediator.getComponentBar(), BorderLayout.NORTH);
		mainPane = new JPanel(new BorderLayout());
		getContentPane().add(mainPane, BorderLayout.CENTER);



		ml = new GraphMouseListner(mediator);
		mediator.setMouseListner(ml);

		scroll = new JScrollPane();
		mainPane.add(scroll, BorderLayout.CENTER);
		centerWindow(800, 600);


		//QN-Java
		statusPanel = new JPanel();
		statusPanel.setBorder(new BevelBorder(BevelBorder.LOWERED));
		this.add(statusPanel, BorderLayout.SOUTH);
		statusPanel.setPreferredSize(new Dimension(this.getWidth(), 20));
		statusPanel.setLayout(new BoxLayout(statusPanel, BoxLayout.X_AXIS));
		statusLabel = new JLabel("Clock (s): ");
		statusLabel.setHorizontalAlignment(SwingConstants.LEFT);
		statusPanel.add(statusLabel);
		//statusLabel.setText("setText"); // use such codes to change lable text
		GlobalUtilities.mainWin = this;

		setVisible(true);

		//JOptionPane.showMessageDialog(null, "MainWindow()", "MainWindow.java", JOptionPane.INFORMATION_MESSAGE); // CAO

		//QN-Java test
		//TestGUI.createAndShowGUI();
		if (QnactrSimulation.entitiesViewerEnable) QnactrSimulation.createAndShowEntitiesViewerGUI();
		if (QnactrSimulation.taskVisualization2DEnable) QnactrSimulation.createAndShowTaskVisualization2DViewerGUI();
		if (QnactrSimulation.taskVisualization3DEnable) QnactrSimulation.createAndShowTaskVisualization3DViewerGUI();

		// added by Yelly, 
		// to skip all selection steps to simplify tests
		mediator.openModel_simple_test();
		mediator.startSimulation();

		new Thread(() -> startAgent(this)).start();
	}

	@Override
	public void handleAgentEvent(Agent agent, AgentEvent event, String uuid, String name, Object eventData) {
		_logger.debug("**received agent event for {} ({}): {} with data {}", name, uuid, event, eventData);
	}

	@Override
	public void handleWebSocketEvent(WebSocketEvent event, Throwable t) {
		if (t != null) { // (event == WebSocketEvent.IGS_WEB_SOCKET_FAILED)
			_logger.error("**received web socket event {} with exception {}", event, t.toString());
		}
		else {
			_logger.debug("**received web socket event {}", event);
		}
	}

	/** Sets the new Graph inside the scroll panel.
	 *
	 * @param newGraph
	 */
	public void setGraph(JGraph newGraph) {
		// 23/07/03 - Massimo Cattai //////////////////////////////////////////
		//removeEditor();
		mainPane.remove(scroll);
		// Old Code - remove(scroll);
		// 23/07/03 - end /////////////////////////////////////////////////////
		scroll = new JScrollPane(newGraph);
		// 23/07/03 - Massimo Cattai //////////////////////////////////////////
		mainPane.add(scroll, BorderLayout.CENTER);
		// Old Code - getContentPane().add(scroll);
		// 23/07/03 - end /////////////////////////////////////////////////////
		getContentPane().validate();
	}

	/* (non-Javadoc)
	 * @see jmt.framework.gui.components.JMTFrame#canBeClosed()
	 */
	@Override
	public boolean canBeClosed() {
		return !mediator.checkForSave("<html>Save changes before closing?</html>");
	}

	/* (non-Javadoc)
	 * @see jmt.framework.gui.components.JMTFrame#doClose()
	 */
	@Override
	protected void doClose() {
		// Ends simulation process if active
		mediator.stopSimulation();
		// Disposes resultsWindow (if present) and mainwindow
		if (mediator.getResultsWindow() != null) {
			mediator.getResultsWindow().dispose();
		}
		if (mediator.getPAProgressWindow() != null) {
			mediator.getPAProgressWindow().stopAnimation();
			mediator.getPAProgressWindow().dispose();
		}
	}

	/** Removes the current graph from the main window.
	 *
	 */
	public void removeGraph() {
		mainPane.remove(scroll);
		getContentPane().repaint();
	}

	public JScrollPane getScroll() {
		return scroll;
	}

	/** main function it activates the application .
	 *
	 * @param args
	 */
	public static void main(String[] args) {
		if ((args != null && args.length > 0) && (args[0] != null) && (args[0].equals("trek"))) {
			advanced = true;
		}
		
		//JOptionPane.showMessageDialog(null, "MainWindow.java main", "CAO debug", JOptionPane.ERROR_MESSAGE); // CAO
		SwingUtilities.invokeLater(() -> {
			MainWindow window = new MainWindow();
		});

	}

	private void startAgent(MainWindow mainWindow) {
		_logger.info("Start Java app 'IngeScape agent test'");
		_logger.info("is DEBUG enabled ? {}", _logger.isDebugEnabled());

		//JOptionPane.showMessageDialog(null, "MainWindow.java main", "CAO debug", JOptionPane.ERROR_MESSAGE); // CAO

		//Global globalContext = new Global("ws://132.207.231.96:5625");
		Global globalContext = new Global("ws://localhost:9009");
		globalContext.observeWebSocketEvents(mainWindow);

		Agent1CB agentCB = new Agent1CB();

		Agent a = globalContext.agentCreate("Cognitive_Model_Agent");
		a.observeAgentEvents(mainWindow);

		a.definition.setName("Cognitive_Model");
		a.definition.setDescription("QN-ACTR model of the Single Pilot");
		a.definition.setVersion("1.0");

		a.definition.inputCreate("ATC_msg", IopType.IGS_STRING_T);
		a.definition.inputCreate("CAS_status", IopType.IGS_BOOL_T);
		a.definition.inputCreate("FADEC_bug", IopType.IGS_BOOL_T);
		a.definition.inputCreate("N1_E1", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("N1_E2", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("N1_match_bug", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("kias", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("pitch", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("slip/skid", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("v/s", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("alarm", IopType.IGS_STRING_T);
		a.definition.inputCreate("l/g_status", IopType.IGS_STRING_T);
		a.definition.inputCreate("flaps_status", IopType.IGS_STRING_T);
		a.definition.outputCreate("Toggle_Brake", IopType.IGS_IMPULSION_T);
		a.definition.inputCreate("alt", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("pos_thrust_e1", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("pos_thrus_e2", IopType.IGS_DOUBLE_T);
		a.definition.inputCreate("light_status", IopType.IGS_BOOL_T);
		a.definition.inputCreate("chrono_time", IopType.IGS_INTEGER_T);

		a.observeInput("ATC_msg", agentCB);
		a.observeInput("CAS_status", agentCB);
		a.observeInput("FADEC_bug", agentCB);
		a.observeInput("N1_E1", agentCB);
		a.observeInput("N1_E2", agentCB);
		a.observeInput("N1_match_bug", agentCB);
		a.observeInput("kias", agentCB);
		a.observeInput("pitch", agentCB);
		a.observeInput("slip/skid", agentCB);
		a.observeInput("v/s", agentCB);
		a.observeInput("alarm", agentCB);
		a.observeInput("l/g_status", agentCB);
		a.observeInput("flaps_status", agentCB);
		a.observeInput("Toggle_Brake", agentCB);
		a.observeInput("alt", agentCB);
		a.observeInput("pos_thrust_e1", agentCB);
		a.observeInput("pos_thrus_e2", agentCB);
		a.observeInput("light_status", agentCB);
		a.observeInput("chrono_time", agentCB);

		a.definition.outputCreate("park_break", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("thrust", IopType.IGS_DOUBLE_T);
		a.definition.outputCreate("control", IopType.IGS_DATA_T);
		a.definition.outputCreate("l/g_toggle", IopType.IGS_DATA_T);
		a.definition.outputCreate("trim_yaw", IopType.IGS_DOUBLE_T);
		a.definition.outputCreate("push_m/w", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("fd_to_mode", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("speed_mode_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("heading_mode_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("atc_msg", IopType.IGS_STRING_T);
		a.definition.outputCreate("crew_msg", IopType.IGS_STRING_T);
		a.definition.outputCreate("AP_master_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("flaps_lever", IopType.IGS_DOUBLE_T);
		a.definition.outputCreate("l_throttle", IopType.IGS_DOUBLE_T);
		a.definition.outputCreate("r_throttle", IopType.IGS_DOUBLE_T);
		a.definition.outputCreate("chrono_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("eng_fire_switch", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("l_fuel_boost", IopType.IGS_STRING_T);
		a.definition.outputCreate("r_fuel_boost", IopType.IGS_STRING_T);
		a.definition.outputCreate("bottle_discharge", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("rotary_test", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("heading_set", IopType.IGS_INTEGER_T);
		a.definition.outputCreate("flc_set", IopType.IGS_INTEGER_T);
		a.definition.outputCreate("yaw_damper_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("deice_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("pax_safety_toggle", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("alti_set_std", IopType.IGS_IMPULSION_T);
		a.definition.outputCreate("l_gen_switch", IopType.IGS_STRING_T);
		a.definition.outputCreate("r_gen_switch", IopType.IGS_STRING_T);
		a.definition.outputCreate("l_ign_switch", IopType.IGS_STRING_T);
		a.definition.outputCreate("r_ign_switch", IopType.IGS_STRING_T);
		a.definition.outputCreate("fuel_transfer_knob", IopType.IGS_STRING_T);


		a.serviceInit("javaCall1", agentCB);
		a.serviceArgAdd("javaCall1", "kias", IopType.IGS_DOUBLE_T);

		a.start();
		a.serviceInit("javaCall1", agentCB);
		a.serviceArgAdd("javaCall1", "kias", IopType.IGS_DOUBLE_T);

		a.start();

		/*
		try (XPlaneConnect xpc = new XPlaneConnect())
		{
			while(true)
			{
				try {
					float[] landingGearStatus = xpc.getDREF("sim/cockpit/switches/gear_handle_status");

					a.outputSetDouble("landingGearStatus", landingGearStatus[0]);
				}
				catch (java.io.IOException ex) {
					_logger.error(ex.getMessage());
					break;
				}

				try
				{
					Thread.sleep(10000);
				}
				catch (InterruptedException ex) {}
			}
		}
		catch (java.net.SocketException ex) {
			_logger.error(ex.getMessage());
		}
		 */

	}

	/**
	 * Updates this window title adding the file name
	 * @param filename the file name or null to remove it.
	 */
	public void updateTitle(String filename) {
		if (filename != null) {
			setTitle(TITLE + " - " + filename);
		} else {
			setTitle(TITLE);
		}
	}
}
