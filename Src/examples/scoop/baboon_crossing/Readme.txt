This is an implementation of "Baboon Crossing" problem as described in 
"The Little Book of Semaphores" by Allen B. Downey Version 2.1.5.

Problem Description:
  
  There is a deep canyon somewhere in Kruger National Park, South Africa, 
  and a single rope that spans the canyon. Baboons can cross the canyon by 
  swinging hand-over-hand on the rope, but if two baboons going in opposite 
  directions meet in the middle, they will fight and drop to their deaths.
  Furthermore, the rope is only strong enough to hold 5 baboons. If there are 
  more baboons on the rope at the same time, it will break. 
  Assuming that we can teach the baboons to use semaphores, we would like 
  to design a synchronization scheme with the following properties:
  
    � Once a baboon has begun to cross, it is guaranteed to get to the other 
    side without running into a baboon going the other way.
    
    � There are never more than 5 baboons on the rope.