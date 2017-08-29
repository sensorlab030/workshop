import java.util.*;

class BpmCalculator {
 
  private int sampleCount = 1000;      
  private ArrayList<HBEntry> samples = new ArrayList<HBEntry>(sampleCount);
  
  /**
   * Add a ECG value with the accompanying timestamp
   */
  public void addValue(float value, long time) {
    
    synchronized(samples) {
      
      // Add new value
      samples.add(new HBEntry(value, time));
      
      // Keep size of list to sampleCount
      if (samples.size() > sampleCount) {
        samples.remove(0);
      }
      
    }

  }
  
  /**
   * Calculate the threshold above which peaks are counted as
   * heartbeats
   */
  public float getPeakThreshold() {
    
    // Collect average and max
    float avgSum = 0;
    float max = Float.MIN_NORMAL;    
    synchronized(samples) {
      for (HBEntry e: samples) {
       avgSum += e.value;
       if (e.value > max) {
         max = e.value;
       }
      }    
    }
    float avg = avgSum / (float) samples.size();
    
    // Determine the threshold for peaks
    float threshold = avg + (max - avg) * 0.25f;
    
    return threshold;
    
  }
  
  /**
   * Calculate the BPM as a floating point value
   */
  private float getBpm() {
    
    // Get the threshold for the peaks
    float threshold = getPeakThreshold();
    
    // Count the beats (number of peaks above threshold)
    int beats = 0;
    boolean inBeat = false;
    synchronized(samples) {
      for (HBEntry e: samples) {
  
        // Rising edge of beat/peak
        if (e.value > threshold && !inBeat) {
          beats++;
        }
        
        // Only want to detect distinct beats/peaks
        inBeat = (e.value > threshold);
      
      } 
    }
    
    // Get the duration of all samples (in ms)
    long sampleTime = samples.get(samples.size() - 1).timestamp - samples.get(0).timestamp;
    
    // Convert beats in sampleTime to bpm (1 minute / sampleTime * beatsInSample)
    float bpm = 60000f / (float) sampleTime * (float) beats; 
    
    return bpm;

  }

  /** 
   * Change the sampleCout value (more samples
   * is a more stable number, but also less fast to
   * detect change)
   */
  public void setSampleCount(int sampleCount) {
    this.sampleCount = sampleCount;
    
    synchronized(samples) {
      
      // Keep size of list to sampleCount
      if (samples.size() > sampleCount) {
        samples.remove(0);
      }
      
    }
  }
  
  public int getSampleCount() {
    return sampleCount;
  }
   
  /**
   * Small container for one sample with it's
   * timestamp
   */
  private class HBEntry {
    public float value;
    public long timestamp;    
    
    public HBEntry(float value, long timestamp) {
      this.value = value;
      this.timestamp = timestamp;
    }
    
  }
    
}