/*
 * mt_support_additino.c
 *
 * Basically functions in the file is wrapper functions for MATISSE API.
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include "eif_eiffel.h"

#include "matisse_eif.h" 
#include "mt_support.h"


/*
 * DEBUGGING SWITCH
 * ... mindlessly simple, but it does the trick...just choose which of
 * the following two lines of code you want to keep
 */
// #define DEBUG_PRINTF(a)	 fprintf a;
#define DEBUG_PRINTF(a)	 {};


#define BUFFERSIZE 512

extern MtSTS Result;

/*
 ** Data structures used for MtSetSuccessors() function **
 */
typedef enum {REMOVE_SUCC, SUCC_OK, ADD_SUCC} MOpType;
typedef struct _MKeyListCmp MKeyListCmp;
struct _MKeyListCmp
{
  MtKey prev_key;
  MtKey key;
  MOpType op_type;
  MKeyListCmp *next;
};

void Mt_SetSuccessors(MtKey objet, MtKey relationship, MtSize size, MtKey * keys);



EIF_INTEGER c_mt_current_offset(void)
{
	return MT_CURRENT_OFFSET;
}

EIF_INTEGER c_mt_end_offset(void)
{
	return MT_END_OFFSET;
}

EIF_INTEGER c_mt_list_max_len(void)
{
	return MT_LIST_MAX_LEN;
}

/*
 * EIF_INTEGER c_get_max_cardinality_relationship(EIF_INTEGER relationship_oid)
 * relationship_oid: OID of relationship
 * 
 * return maximum cardinality of the relationship
 */
EIF_INTEGER c_get_max_cardinality_relationship(EIF_INTEGER relationship_oid)
{
	MtS32 cardinalities[2];
	MtSize size = 8;
	
	EIF_MT_LOG1("c_get_max_cardinality_relationship: %d", relationship_oid);
	CHECK_STS( MtGetValue(relationship_oid, "Mt Cardinality", NULL,
			(void *) cardinalities, NULL, &size, NULL));
	EIF_MT_LOG1("max cardinality: %d", cardinalities[1]);

	return (EIF_INTEGER) cardinalities[1];
}


/*
 * put_byte_array_to_file(FILE * file_pointer, MtU8 * byte_array, EIF_INTEGER count)
 *	byte_array ... Pointer to area of ARRAY[CHARACTER]
 *	count ... count of 'byte_array'
 *
 * Used by MT_OBJECT.
 * Write the byte array into the file.
 * Return the number of bytes written.
 */
EIF_INTEGER put_byte_array_to_file(FILE * file_pointer, MtU8 * byte_array, EIF_INTEGER count)
{
	int written_size;
	
	written_size = fwrite(byte_array, 1, count, file_pointer);
	return written_size;
}

/*
 * file_read_bytes(FILE * file_pointer, unsigned char * byte_array, EIF_INTEGER length) 
 *  byte_array ... Pointer to area of ARRAY[CHARACTER]
 *  length ... number of 'byte_array' to be read
 *
 * Used by MT_RAW_FILE
 * Read bytes into byte_array.
 * Return the number of bytes read from the file.
 */
EIF_INTEGER file_read_bytes(FILE * file_pointer, unsigned char * byte_array, EIF_INTEGER length) 
{
	int size_read;
	
	size_read = fread(byte_array, 1, length, file_pointer);
	return size_read;
}


/*
 * Redefine the function c_db_connect which is written by ISE
 */
//void c_db_connect(char * host_name, char * database_name, int priority, int wait_time)
//{
//	EIF_MT_LOG("nk_c_db_connect");
//	/* Result = MtConnect(&database, host_name, database_name,
//			MTMIN_RPC_PRIORITY, MTNO_WAIT, MT_DE); */
//	Result = MtConnect(&database, host_name, database_name,
//			priority, wait_time, MT_DE);
//	/* CHECK_STS(Result); */
//	/* Do not check status in the regular way */
//	EIF_MT_LOG("nk_c_db_connect done.");
//}


/*
 * c_remove_all_succs_ignerr(rid, oid, sts)
 *   rid: oid of relationship
 *   oid: oid of object
 *   sts: error status to be ignored
 *
 * Remove all successors of object, but ignore error 'sts'.
 * 'sts' is supposed to be MATISSE_NOSUCCESSORS.
 */
void c_remove_all_succs_ignerr(EIF_INTEGER rid, EIF_INTEGER oid, EIF_INTEGER sts)
{
	CHECK_STS_IGNERR(Mt_RemoveAllSuccessors(oid, rid), sts)
}

/*
 * c_remove_all_succs_ignore_nosuccessors(rid, oid)
 *   rid: oid of relationship
 *   oid: oid of object
 *
 * Remove all successors of object, but ignore error MATISSE_NOSUCCESSORS.
 */
void c_remove_all_succs_ignore_nosuccessors(EIF_INTEGER rid, EIF_INTEGER oid)
{
	CHECK_STS_IGNERR(Mt_RemoveAllSuccessors(oid, rid), MATISSE_NOSUCCESSORS)
}


void c_set_successors(EIF_INTEGER pred_oid, EIF_INTEGER rid, EIF_INTEGER size, EIF_OBJ keys)
{
	int * area;
	int i;
	
	area = (int *) eif_array_area(keys);
	
	EIF_MT_LOG3("c_set_successors: pred_oid: %d, rid: %d, size: %d", pred_oid, rid, size);
	for(i= 0; i < size; i++){
		EIF_MT_LOG2("%d-th: %d", i, area[i]);
	}
	
	Mt_SetSuccessors(pred_oid, rid, size, area);
}

/*
 * MtSetSuccessors and its related functions
 */
  
MKeyListCmp * MKeyListCmp_create(MtKey new_key, MOpType operation)
{
  MKeyListCmp * key_list = (MKeyListCmp *) malloc(sizeof(MKeyListCmp));
  if (!key_list)
   {
      fprintf(stderr, "out of memory !\n");
      exit(-1);
   }
  key_list->prev_key = (MtKey) 0;
  key_list->next = NULL;
  key_list->key = new_key;
  key_list->op_type = operation;
  return key_list;
}

void MKeyListCmp_initialise(MKeyListCmp * self, 
	MtKey *src_keys, MtSize src_size, 
	MtKey *dest_keys, MtSize dest_size)
{
  MKeyListCmp * current = self;
  MtSize i = 0;
  MKeyListCmp *dest_top = NULL;
  MKeyListCmp *dest_current = NULL;

  self->prev_key = (MtKey) 0;
  self->key = (MtKey) 0;
  self->next = NULL;

  /*
   * prepare source list
   */
  for(i=0; i<src_size; i++)
   {
      MKeyListCmp * key_info = MKeyListCmp_create(src_keys[i], ADD_SUCC);
      key_info->prev_key = current->key;
      current->next = key_info;
      current = key_info;
   }

  if (!dest_size)
      return;

  /*
   * prepare dest list
   */
  dest_top = MKeyListCmp_create(0, SUCC_OK);
  dest_current = dest_top;
  for(i=0; i<dest_size; i++)
   {
      MKeyListCmp * key_info = MKeyListCmp_create(dest_keys[i], REMOVE_SUCC);
      key_info->prev_key = dest_current->key;
      dest_current->next = key_info;
      dest_current = key_info;
   }

  /*
   * analyze
   */
  current = self->next;
  dest_current = dest_top->next;
  for(i=0; i<src_size; i++, current = current->next)
   {
      while(dest_current)
       {
         if (current->key == dest_current->key )
           {
	       dest_current->op_type = SUCC_OK;
               current->op_type = SUCC_OK;
               dest_current=dest_current->next;
               break;
           }
           dest_current = dest_current->next;
       }
   }

  /*
   * merge two lists
   */
  dest_current = dest_top->next;
  dest_top->next = NULL;

  current = self->next;		 /* put the top in stack */

  self->next = dest_current; 
  while(dest_current->next)
    dest_current = dest_current->next;
  dest_current->next = current;
}

void MKeyListCmp_delete(MKeyListCmp * key_list)
{
  if (key_list->next)
     MKeyListCmp_delete(key_list->next);
  free(key_list);
}

void MKeyListCmp_free(MKeyListCmp * key_list)
{
  if (key_list->next)
     MKeyListCmp_delete(key_list->next);
}

void MtSetSuccessors(MtKey objet, MtString
                            relationship_name,  MtSize size, MtKey * keys) 
{
   MtKey relationship;
   CHECK_STS(MtGetRelationship(&relationship, relationship_name));
   Mt_SetSuccessors(objet, relationship, size, keys);
}


void Mt_SetSuccessors(MtKey objet, MtKey relationship, MtSize size, MtKey * keys) 
{
   MtKey *old_keys;
   MtKey old_size;
   MKeyListCmp cmp_list;
   MKeyListCmp * current = NULL;

   /* MtSetContext(dbCPointer); */
   
   /* get all successors */
   CHECK_STS (Mt_MGetSuccessors(&old_size, &old_keys, objet, relationship));

   MKeyListCmp_initialise(&cmp_list, keys, size, old_keys, old_size);
 
   current = cmp_list.next;
   while (current)
    {
       switch(current->op_type)
       {
         case REMOVE_SUCC:
            CHECK_STS (Mt_RemoveSuccessors(objet, relationship,
                                               1, current->key));
/*	    printf("Mt_RemoveSuccessor %d \n", current->key ); */
            break;
         case SUCC_OK:
/*	    printf("SUCC_OK %d \n", current->key ); */
            break;
         case ADD_SUCC:
            if (current->prev_key)
             {
/*	       printf("Mt_AddSuccessor %d MTAFTER\n", current->key ); */
	       
               CHECK_STS(Mt_AddSuccessor(objet, relationship,
                              current->key, MT_AFTER, current->prev_key))
             }
            else {
/*	      printf("Mt_AddSuccessor %d MTFIRST\n", current->key ); */

	      CHECK_STS(Mt_AddSuccessor(objet, relationship,
                                            current->key, MT_FIRST))
	      }
	    
            break;
       }
       current = current->next;
    }

   MKeyListCmp_free(&cmp_list);
   if (old_size)
       free(old_keys);
/*   CHECK_RTN_MSI_STS( MATISSE_SUCCESS );*/
}
