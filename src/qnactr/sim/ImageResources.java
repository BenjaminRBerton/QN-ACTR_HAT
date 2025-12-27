package qnactr.sim;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.imageio.ImageIO;

public class ImageResources
{
  public static BufferedImage biVisual;
  public static BufferedImage biAudio;
  public static BufferedImage biVocal;
  public static BufferedImage biLeftHand;
  public static BufferedImage biRightHand;
  public static BufferedImage biMouseCursor;
  
  static {
    
    try
    {
      biVisual = ImageIO.read ( new URL( GlobalUtilities.getQNJProjectURI().toString() + "QN-ACTR/ImageResources/Visual.jpg" ));
      biAudio = ImageIO.read ( new URL( GlobalUtilities.getQNJProjectURI().toString() + "QN-ACTR/ImageResources/Audio.jpg" ));
      biVocal = ImageIO.read ( new URL( GlobalUtilities.getQNJProjectURI().toString() + "QN-ACTR/ImageResources/Vocal.jpg" ));
      biLeftHand = ImageIO.read ( new URL( GlobalUtilities.getQNJProjectURI().toString() + "QN-ACTR/ImageResources/LeftHand.jpg" ));
      biRightHand = ImageIO.read ( new URL( GlobalUtilities.getQNJProjectURI().toString() + "QN-ACTR/ImageResources/RightHand.jpg" ));
      biMouseCursor = ImageIO.read ( new URL( GlobalUtilities.getQNJProjectURI().toString() + "QN-ACTR/ImageResources/MouseCursor.png" ));
      
    } catch (MalformedURLException e)
    {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (IOException e)
    {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    
    
  }
}
