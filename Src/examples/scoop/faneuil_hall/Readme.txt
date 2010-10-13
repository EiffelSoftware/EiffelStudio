This is an implementation of "Faneuil Hall" problem as described in 
"The Little Book of Semaphores" by Allen B. Downey Version 2.1.5.

Problem Description:
  
  There are three kinds of threads: immigrants, spectators, and a one judge.
  Immigrants must wait in line, check in, and then sit down. At some point, 
  the judge enters the building. When the judge is in the building, 
  no one may enter, and the immigrants may not leave. Spectators may leave. 
  Once all immigrants check in, the judge can confirm the naturalization. 
  After the confirmation, the immigrants pick up their certificates of U.S. 
  Citizenship. The judge leaves at some point after the confirmation. 
  Spectators may now enter as before. After immigrants get their certificates, 
  they may leave.