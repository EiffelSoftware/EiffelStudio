This is an implementation of "Barbershop" problem as described in 
"The Little Book of Semaphores" by Allen B. Downey Version 2.1.5.

Problem Description:
  
  A barbershop consists of a waiting room with n chairs, and the
  barber room containing the barber chair. If there are no customers
  to be served, the barber goes to sleep. If a customer enters the
  barbershop and all chairs are occupied, then the customer leaves
  the shop. If the barber is busy, but chairs are available, then the
  customer sits in one of the free chairs. If the barber is asleep, the
  customer wakes up the barber. Write a program to coordinate the
  barber and the customers.