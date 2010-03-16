/* The following has been taken from eGTK.				 */
/* It is the C part of a weak reference implementation for SE.		 */
/* If I understand it correctly, `id_table' will never shrink.		 */
/* Thats why this implementation is suboptimal, but word on the street */
/* is that SE will gain native weak references really soon now.	 */
/* As soon as they are there, we should use those and dump this.	 */

/*
   Copyright 1999 Richie Bielak and others
   Licensed under Eiffel Forum Freeware License, version 1;
   (see forum.txt)
*/

#include <stdio.h>
#if defined(__APPLE__) || defined(__FreeBSD__)
#include <stdlib.h>
#else
#include <malloc.h>
#endif

#define SIZE_INCREMENT 1024

/* This is really an pointer to an array of pointers             */
/* Size of pointers can is not always 4 bytes (eg. on the Alpha) */
/* so be careful with sizes of things.                           */
static int **id_table = NULL;

/* Capacity in integers */
static int id_table_capacity = 0;
static int next_id = 0;

/***************************************/
/* Assign a new ID to an Eiffel object */
/***************************************/
int ewg_new_id (void *object) 
{
  /* Allocate a new table if needed */
  if (id_table == NULL) 
  {
    id_table = (int **) malloc (SIZE_INCREMENT * sizeof (int *));
    id_table_capacity = SIZE_INCREMENT;
  }
  /* Bump ID to the next one */
  next_id++;
  /* If table too small, realloc */
  if (next_id > id_table_capacity) 
  {
    id_table_capacity = id_table_capacity + SIZE_INCREMENT;
    id_table = (int **) realloc (id_table, id_table_capacity * sizeof(int *));
  }
  /* Store the Eiffel reference */
  id_table [next_id] = (int *) object;
  return next_id;
}

void *ewg_id_object (int id) 
{
  void *result;

  if (id <= next_id)
  {
    result = (void *)id_table [id];
  }
  else
  {
    result = NULL;
  }
  return result;
}

void ewg_free_id (int id) 
{
  if (id <= next_id)
  {
    id_table[id] = 0;
  }
}
