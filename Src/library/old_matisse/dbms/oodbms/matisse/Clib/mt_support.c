#include <stdio.h>
#include <stdlib.h>
#include <matisse.h>
#include <mtscli.h>	// admin connection
#include "eif_eiffel.h"
#include "eif_garcol.h"
#include "mt_support.h"
#include "matisse_store.h"

/*
 * DEBUGGING SWITCH
 * ... mindlessly simple, but it does the trick...just choose which of
 * the following two lines of code you want to keep
 */
// #define DEBUG_PRINTF(a)	 fprintf a;
#define DEBUG_PRINTF(a)	 {};


#define BUFFERSIZE 512
typedef struct {
	MtType type;
	MtSize rank;
	MtSize dimensions[8];
	void* value;
} Value;

MtSTS result=0;
MtDatabase database;

STS admin_sts;			// admin connection last op status
RPC_HANDLE admin_handle;	// admin connection handle
char admin_msg[MSGLOG_BUFLEN];  // admin connection sts message

char name[32];
char buffer[BUFFERSIZE];
void *value;
MtSize vrank;
MtType vtype; 
MtBool dvalue;
int transaction_count =0 ;

/************************/
/*	MATISSE_CONST	*/
/************************/
/*--------------------------------------------*/
EIF_INTEGER c_mts32()
/*--------------------------------------------*/
{
return(MTS32);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtnil()
/*--------------------------------------------*/
{
return(MTNIL);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtdouble()
/*--------------------------------------------*/
{
return(MTDOUBLE);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtfloat()
/*--------------------------------------------*/
{
return(MTFLOAT);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtchar()
/*--------------------------------------------*/
{
return(MTCHAR);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtstring()
/*--------------------------------------------*/
{
return(MTSTRING);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtasciichar()
/*--------------------------------------------*/
{
return(MTASCIICHAR);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtasciistring()
/*--------------------------------------------*/
{
return(MTASCIISTRING);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mts32_list()
/*--------------------------------------------*/
{
return(MTS32_LIST);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtdouble_list()
/*--------------------------------------------*/
{
return(MTDOUBLE_LIST);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtfloat_list()
/*--------------------------------------------*/
{
return(MTFLOAT_LIST);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtstring_list()
/*--------------------------------------------*/
{
return(MTSTRING_LIST);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtasciistring_list()
/*--------------------------------------------*/
{
return(MTASCIISTRING_LIST);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtu8_array()
/*--------------------------------------------*/
{
return(MTU8_ARRAY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mts32_array()
/*--------------------------------------------*/
{
return(MTS32_ARRAY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtdouble_array()
/*--------------------------------------------*/
{
return(MTDOUBLE_ARRAY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtfloat_array()
/*--------------------------------------------*/
{
return(MTFLOAT_ARRAY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtstring_array()
/*--------------------------------------------*/
{
return(MTSTRING_ARRAY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtasciistring_array()
/*--------------------------------------------*/
{
return(MTASCIISTRING_ARRAY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtmin_tran_priority()
/*--------------------------------------------*/
{
return(MTMIN_TRAN_PRIORITY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtmax_tran_priority()
/*--------------------------------------------*/
{
return(MTMAX_TRAN_PRIORITY);
}
/*--------------------------------------------*/
 EIF_INTEGER c_mtread()
/*--------------------------------------------*/
{
return(MTREAD);
}

/*--------------------------------------------*/
 EIF_INTEGER c_mtwrite()
/*--------------------------------------------*/
{
return(MTWRITE);
}

/*--------------------------------------------*/
 EIF_INTEGER c_mtdirect()
/*--------------------------------------------*/
{
return(MTDIRECT);
}

/*--------------------------------------------*/
 EIF_INTEGER c_mtreverse()
/*--------------------------------------------*/
{
return(MTREVERSE);
}

/*--------------------------------------------*/
 EIF_INTEGER c_mtascend()
/*--------------------------------------------*/
{
return(MTASCEND);
}

/*--------------------------------------------*/
 EIF_INTEGER c_mtdescend()
/*--------------------------------------------*/
{
return(MTDESCEND);
}

/************************/
/*	keys management	*/
/************************/

MtSize keys_count;
MtKey *keys;
/*--------------------------------------------*/
 EIF_INTEGER c_keys_count()
/*--------------------------------------------*/
{
return(keys_count);
}

/*--------------------------------------------*/
 EIF_INTEGER c_ith_key(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
return(keys[i-1]);
}


static int	keys_malloced;  // TRUE if keys malloced in this
				// file rather than by MT API call

/*--------------------------------------------*/
 void c_free_keys()
/*--------------------------------------------*/
{
    if (keys != NULL) {
	DEBUG_PRINTF((stderr, "c_free_keys() - keys == 0x%lx\n", keys))
	if (keys_malloced) {
	    free(keys);
	    keys_malloced = FALSE;
	} else
	    MtMFree(keys);
	keys = NULL;
    }
    else
        DEBUG_PRINTF((stderr, "c_free_keys() - nothing to do; keys == 0x%lx\n", keys))
}

/*--------------------------------------------*/
EIF_REFERENCE eif_array_area (obj)
/*--------------------------------------------*/
EIF_OBJ obj;
/*
 * Starting address of area associated with Eiffel object `obj'.
 * Object `obj' owns a reference to a special object or is a special
 * object.
 * Returns Void if no special object found.
 *
 */
{
   uint32 flags;
	EIF_OBJ object;
	char *o_ptr, *o_ref;
	long refer_count;
 
	object = obj;
	flags = HEADER(object)->ov_flags;
	if (flags & EO_SPEC) {
special: 
		if (!(flags & EO_REF) && (flags & EO_COMP))
			return (object + OVERHEAD);
		else return (object);
	}

	refer_count = References(flags & EO_TYPE);
	for (
		o_ptr = object; refer_count > 0 ;
		refer_count--, o_ptr = (char *)(((char **) o_ptr) +1)
	) {
		o_ref = *(char **)o_ptr;
      if (o_ref != (char *) 0) {
			object = o_ref;		
			flags = HEADER(object)->ov_flags;
			if (flags & EO_SPEC) {
				goto special;
			}
		}
	}
	return (NULL);
}

/*--------------------------------------------*/
long eif_array_count (obj)
/*--------------------------------------------*/
EIF_OBJ obj;
/* 
 * Number of allocated cells for `obj' with obj of type
 * ARRAY or SPECIAL else returns 0.
 *
 */
{
	union overhead *zone;
	uint32 flags;
	char *o_ref, *o_ptr;
	long refer_count;
	EIF_OBJ object;

	object = obj;
 	zone = HEADER(object);
	flags = zone->ov_flags;
	if (flags & EO_SPEC) {
special:
   	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
   	return (*(long *) o_ref);
	}	
	else {
		refer_count = References(flags & EO_TYPE);
		for (
			o_ptr = object; refer_count > 0 ;
			refer_count--, o_ptr = (char *)(((char **) o_ptr) +1)
		) {
			o_ref = *(char **)o_ptr;
			if (o_ref != (char *) 0) {
				object = o_ref;		
				zone = HEADER(object);
				flags = zone->ov_flags;
				if (flags & EO_SPEC) {
					goto special;
				}
			}
		}
		return ((long) 0);
	}
}

/************************/
/*	MT_ATTRIBUTE	*/
/************************/


/*--------------------------------------------*/
 void c_get_value(oid,aid)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
    result = Mt_MGetValue(oid,aid,&vtype,&value,&vrank,&dvalue);
    DEBUG_PRINTF((stderr, "MT malloc value() == 0x%lx\n", value))
}

/*--------------------------------------------*/
 void c_free_value(oid,aid)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
    if (value != NULL){
        DEBUG_PRINTF((stderr, "c_free_value() - value == 0x%lx\n", value))
	MtMFree(value);
	value = NULL;
    }
    else
        DEBUG_PRINTF((stderr, "c_free_value() - nothing to do; value == 0x%lx\n", value))

}

/*--------------------------------------------*/
 EIF_INTEGER c_get_integer_value()
/*--------------------------------------------*/
{
EIF_INTEGER* one_integer;
one_integer = (EIF_INTEGER*) value;
return(*one_integer);
}

/*--------------------------------------------*/
 EIF_DOUBLE c_get_double_value()
/*--------------------------------------------*/
{
EIF_DOUBLE* one_double;
one_double = (EIF_DOUBLE*) value;
return(*one_double);
}

/*--------------------------------------------*/
 EIF_REAL c_get_real_value()
/*--------------------------------------------*/
{
EIF_REAL* one_real;
one_real = (EIF_REAL*) value;
return(*one_real);
}

/*--------------------------------------------*/
 EIF_CHARACTER c_get_char_value()
/*--------------------------------------------*/
{
EIF_CHARACTER* one_character;
one_character = (EIF_CHARACTER*) value;
return(*one_character);
}

/*--------------------------------------------*/
 EIF_POINTER c_get_string_value()
/*--------------------------------------------*/
{
return((char*)value);
}

/*--------------------------------------------*/
 EIF_INTEGER c_value_type()
/*--------------------------------------------*/
{
return(vtype);
}

/*--------------------------------------------*/
 EIF_INTEGER c_ith_list_character(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_CHARACTER* one_character;
one_character = (EIF_INTEGER*) ((MtU8*)value+(i-1));
return(*one_character);
}

/*--------------------------------------------*/
 EIF_INTEGER c_ith_list_integer(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_INTEGER* one_integer;
one_integer = (EIF_INTEGER*) ((MtS32*)value+(i-1));
return(*one_integer);
}

/*--------------------------------------------*/
 EIF_DOUBLE c_ith_list_double(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_DOUBLE* one_double;
one_double = (EIF_DOUBLE*) ((MtDouble*)value+(i-1));
return(*one_double);
}

/*--------------------------------------------*/
 EIF_REAL c_ith_list_real(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_REAL* one_real;
one_real = (EIF_REAL*) ((MtFloat*)value+(i-1));
return(*one_real);
}

/*--------------------------------------------*/
 EIF_POINTER c_ith_list_string(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
char** one_string;
one_string = (char**) ((char**)value+(i-1));
return(*one_string);
}

/*--------------------------------------------*/
 void c_set_value_integer(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type,value,rank;
{
MtS32 ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
 void c_set_value_double(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_DOUBLE value;
EIF_INTEGER rank;
{
MtDouble ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
 /* this function used only for testing passing of floats - it can be 
    deleted at anytime.
  */
 void c_test_value_real(oid,aid,type,value,rank)
/*--------------------------------------------*/
int oid,aid,type;
int value;
int rank;
{
fprintf(stderr, "c_test_value_real() called ok - oid:%d, aid:%d, type:%d, value:%e, rank:%d\n", oid,aid,type,value,rank);
fprintf(stderr, "c_test_value_real() called ok - oid:%d, aid:%d, type:%d, value:%d, rank:%d\n", oid,aid,type,value,rank);
fprintf(stderr, "c_test_value_real() args as hex 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n", *((int*)(&oid)),*((int*)(&oid)+1),*((int*)(&oid)+2),*((int*)(&oid)+3),*((int*)(&oid)+4),*((int*)(&oid)+5));
}

/*--------------------------------------------*/
 void c_set_value_real(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
//float value;
EIF_INTEGER value;
EIF_INTEGER rank;
{
//MtFloat ivalue = value;
MtS32 ivalue = value;
	DEBUG_PRINTF((stderr, "c_set_value_real() called ok - oid:%d, aid:%d, type:%d, value:%f, rank:%lx\n", oid,aid,type,value,rank))
	DEBUG_PRINTF((stderr, "c_set_value_real() args as hex 0x%0lx 0x%0lx 0x%0lx 0x%0lx 0x%0lx\n", *((int*)(&oid)),*((int*)(&oid)+1),*((int*)(&oid)+2),*((int*)(&oid)+3),*((int*)(&oid)+4)))
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
	DEBUG_PRINTF((stderr, "Mt_SetValue() called ok - oid:%d, aid:%d, type:%d, &ivalue:0x%lx, rank:%d\n", oid,aid,type,&ivalue,rank))
}

/*--------------------------------------------*/
 void c_set_value_char(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_CHARACTER value;
EIF_INTEGER rank;
{
MtChar ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
 void c_set_value_string(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_POINTER value;
EIF_INTEGER rank;
{
MtString ivalue=value;
result = Mt_SetValue(oid,aid,MTSTRING,(void*)ivalue,0);
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_attribute(attribute_name)
/*--------------------------------------------*/
char* attribute_name;
{
MtKey aid;
result = MtGetAttribute(&aid,attribute_name);
return(aid);
}

/*--------------------------------------------*/
 void c_check_attribute(attribute_id,object_id)
/*--------------------------------------------*/
EIF_INTEGER attribute_id,object_id;
{
result = Mt_CheckAttribute(attribute_id,object_id);
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_dimension(object_id,attribute_id,rank)
/*--------------------------------------------*/
EIF_INTEGER object_id,attribute_id,rank;
{
MtSize odimension;
result = Mt_GetDimension(object_id, attribute_id, rank, &odimension);
return(odimension);
}

/*--------------------------------------------*/
void c_set_value_array_numeric(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_OBJ value;
EIF_INTEGER rank;
{
long u;
void *area;
u = eif_array_count (value);
area = (void *) eif_array_area (value);
result = Mt_SetValue(oid,aid,type,(void*)area,rank,u);
}

/*--------------------------------------------*/
 EIF_INTEGER c_type_value(aid)
/*--------------------------------------------*/
EIF_INTEGER aid;
{
    MtType tv=0,stype;
    MtS32 *ltypes;

    result = MtMGetValue(aid,"Mt Type",&stype,(void*)&ltypes,NULL,NULL);

    if (ltypes) {
        tv = *ltypes;
	MtMFree(ltypes); // AMP:Another memory leak fixed!!!
    }

    return(tv);
}

/************************/
/*	Mt_CLASS	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_get_class_from_name(name)
/*--------------------------------------------*/
char* name;
{
MtKey key;
result = MtGetClass(&key,name);
return(key);
}

/*--------------------------------------------*/
 EIF_INTEGER c_create_object(name)
/*--------------------------------------------*/
char* name;
{
MtKey key;
result = MtCreateObject(&key,name);
return(key);
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_class_from_object(object_id)
/*--------------------------------------------*/
EIF_INTEGER object_id;
{
MtKey cid;
result = MtGetClassFromObject(&cid,object_id);
return(cid);
}

/*--------------------------------------------*/
 void c_get_all_attributes(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllAttributes(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
 void c_get_all_relationships(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllRelationships(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
 void c_get_all_i_relationships(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllIRelationships(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
 void c_get_all_subclasses(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllSubclasses(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
 void c_get_all_superclasses(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllSuperclasses(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_instances_number(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
MtSize instances_number;
result = Mt_GetInstancesNumber(&instances_number,class_id);
return(instances_number);
}

/*--------------------------------------------*/
 EIF_POINTER c_object_name(object_id)
/*--------------------------------------------*/
EIF_INTEGER object_id;
{
MtType stype;
MtSize ssize=32;
result = MtGetValue(object_id,"Mt Name",&stype,(void*)name,NULL,&ssize,0);
return(name);
}

/*--------------------------------------------*/
 void c_create_num_objects(n,oid)
/*--------------------------------------------*/
EIF_INTEGER n,oid;
{
    keys = (MtKey*) malloc(n*sizeof(MtKey));
    DEBUG_PRINTF((stderr, "malloc() - keys == 0x%lx\n", keys))
    result = Mt_CreateNumObjects(n,keys,oid);
    keys_malloced = TRUE;
}

/************************/
/*	MT_CLASS_STREAM	*/
/************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_class_stream(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
MtStream rstream;
result = Mt_OpenClassStream(&rstream,class_id);
return(rstream);
}

/************************/
/*	MT_ENTRYPOINT	*/
/************************/

/*--------------------------------------------*/
 void c_get_objects_from_ep(attribute_id,class_id,entry_point_name)
/*--------------------------------------------*/
EIF_INTEGER attribute_id,class_id;
char *entry_point_name;
{
result = Mt_MGetObjectsFromEP(&keys_count,&keys,entry_point_name,attribute_id,class_id);
}

/*--------------------------------------------*/
 void c_lock_objects_from_ep(lock,ep_name,attribute_id,class_id)
/*--------------------------------------------*/
EIF_INTEGER lock;
char *ep_name;
EIF_INTEGER attribute_id,class_id;
{
result = Mt_LockObjectsFromEP(lock,ep_name,attribute_id,class_id);
}

/********************************/
/*	MT_ENTRYPOINT_STREAM	*/
/********************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_ep_stream(ep_name,attribute_id,class_id)
/*--------------------------------------------*/
char* ep_name;
EIF_INTEGER attribute_id,class_id;
{
MtStream rstream;
result = Mt_OpenEPStream(&rstream,ep_name,attribute_id,class_id);
return(rstream);
}

/************************/
/*	MT_INDEX	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_get_index(index_name)
/*--------------------------------------------*/
char* index_name;
{
MtKey index_key;
result = MtGetIndex(&index_key,index_name);
return(index_key);
}

/************************/
/*	MT_INDEX_STREAM	*/
/************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_index_stream(index_name,class_name,direction,
 				 crit_start_array,crit_end_array)
/*--------------------------------------------*/
char* index_name, *class_name;
EIF_INTEGER direction;
EIF_OBJ crit_start_array, crit_end_array; /* ARRAYs of POINTER to STRING */
{
    MtStream rstream;
    void **area_start_crit, **area_end_crit;
    MtSize count_start_crit;

    count_start_crit = eif_array_count (crit_start_array);
    area_start_crit = (void **) eif_array_area (crit_start_array);
    area_end_crit = (void **) eif_array_area (crit_end_array);

    result = MtOpenIndexStream(&rstream,index_name,class_name,direction,
			   count_start_crit,area_start_crit,area_end_crit);

/* 
 * the following shows that the eiffel calling code works fine. Reinstate
 * it if you have doubts...
 *
DEBUG_PRINTF((stderr,"Args to MtOpenIndexStream\n"))
DEBUG_PRINTF((stderr,"	index_name: %s\n", index_name))
DEBUG_PRINTF((stderr,"	class_name: %s\n", class_name))
DEBUG_PRINTF((stderr,"	direction: %d\n", direction))
DEBUG_PRINTF((stderr,"	nr criteria: %d\n", count_start_crit))
DEBUG_PRINTF((stderr,"	start criteria: %s\n", (char *)(area_start_crit[0])))
DEBUG_PRINTF((stderr,"	end criteria: %s\n", (char *)(area_end_crit[0])))
DEBUG_PRINTF((stderr,"Result: %lx\n", result))
 *
 */

    return(rstream);
}

/*--------------------------------------------*/
 EIF_POINTER c_open_index_stream1(index_name,class_name,direction)
/*--------------------------------------------*/
char* index_name, *class_name;
EIF_INTEGER direction;
{
MtStream rstream;
result = MtOpenIndexStream(&rstream,index_name,class_name,direction,NULL,NULL,NULL);
return(rstream);
}

/************************/
/*	MT_INFO	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_max_buffered_objects()
/*--------------------------------------------*/
{
return(MtGetConfigurationInfo(MTMAX_BUFFERED_OBJECTS));
}

/*--------------------------------------------*/
 EIF_INTEGER c_max_index_criteria_number()
/*--------------------------------------------*/
{
return(MtGetConfigurationInfo(MTMAX_INDEX_CRITERIA_NUMBER));
}

/*--------------------------------------------*/
 EIF_INTEGER c_max_index_key_length()
/*--------------------------------------------*/
{
return(MtGetConfigurationInfo(MTMAX_INDEX_KEY_LENGTH));
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_total_read_bytes()
/*--------------------------------------------*/
{
MtLargeSize total;
result = MtGetTotalReadBytes(&total);
return(total);
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_total_write_bytes()
/*--------------------------------------------*/
{
MtLargeSize total;
result = MtGetTotalWriteBytes(&total);
return(total);
}

/*--------------------------------------------*/
 EIF_INTEGER c_get_wait_time()
/*--------------------------------------------*/
{
MtWait wait_time;
result = MtGetWaitTime(&wait_time);
return(wait_time);
}

/************************/
/*	MT_MESSAGE	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_get_message(selector)
/*--------------------------------------------*/
char* selector;
{
MtKey key;
result = MtGetMessage(&key,selector);
return(key);
}

/************************/
/*	Mt_OBJECT	*/
/************************/


/*--------------------------------------------*/
 EIF_BOOLEAN c_predefined_msp(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtBool is_predefined_msp;
result = MtPredefinedMSP(&is_predefined_msp,oid);
return(is_predefined_msp);
}

/*--------------------------------------------*/
 void c_check_instance(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
result = MtCheckInstance(oid);
}

/*--------------------------------------------*/
 void c_remove_value(oid,aid)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
result = Mt_RemoveValue(oid,aid);
}

/*--------------------------------------------*/
 void c_remove_object(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
result = MtRemoveObject(oid);
}

/*--------------------------------------------*/
 void c_remove_all_successors(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_RemoveAllSuccessors(oid,rid);
}

/*--------------------------------------------*/
 EIF_INTEGER c_object_size(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtSize osize;
result = MtObjectSize(&osize,oid);
return(osize);
}

/*--------------------------------------------*/
 void c_print_to_file(oid,file_pointer)
/*--------------------------------------------*/
EIF_INTEGER oid;
EIF_POINTER file_pointer;
{
result = MtPrint(oid,(FILE*)file_pointer);
}


/*--------------------------------------------*/
 EIF_BOOLEAN c_type_p(oid,cid)
/*--------------------------------------------*/
EIF_INTEGER oid,cid;
{
MtBool typep;
result = Mt_TypeP(&typep,oid,cid);
return(typep);
}

/*--------------------------------------------*/
 void c_get_all_added_succs(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetAllAddedSuccs(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
 void c_get_all_rem_succs(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetAllRemSuccs(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
 void c_get_successors(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetSuccessors(&keys_count,&keys,oid,rid);
DEBUG_PRINTF((stderr,"Mt_MGetSuccessors; keys=%lx result=%lx\n",keys, result))
}

/*--------------------------------------------*/
 void c_get_predecessors(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetPredecessors(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
 void c_free_object(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
    MtKey key;
    key = oid;
    result = MtFreeObjects(1,&key);
}

/*--------------------------------------------*/
 void c_add_successor_first(oid,rid,soid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid,soid;
{
result = Mt_AddSuccessor(oid,rid,soid,MTFIRST);
}

/*--------------------------------------------*/
 void c_add_successor_append(oid,rid,soid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid,soid;
{
result = Mt_AddSuccessor(oid,rid,soid,MTAPPEND);
}

/*--------------------------------------------*/
 void c_add_successor_after(oid,rid,soid,ooid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid,soid,ooid;
{
result = Mt_AddSuccessor(oid,rid,soid,MTAFTER,ooid);
}

/*--------------------------------------------*/
 void c_lock_object(oid,lock)
/*--------------------------------------------*/
EIF_INTEGER oid,lock;
{
result = MtLockObjects(1,oid,lock);
}

/*--------------------------------------------*/
 void c_load_object(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
result = MtLoadObjects(1,oid);
}

/********************************/
/*	MT_OBJECT_ATT_STREAM	*/
/********************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_object_att_stream(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtStream rstream;
result = MtOpenObjAttStream(&rstream,oid);
return(rstream);
}

/********************************/
/*	MT_OBJECT_IREL_STREAM	*/
/********************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_object_irel_stream(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtStream rstream;
result = MtOpenObjIRelStream(&rstream,oid);
return(rstream);
}

/********************************/
/*	MT_OBJECT_REL_STREAM	*/
/********************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_object_rel_stream(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtStream rstream;
result = MtOpenObjRelStream(&rstream,oid);
return(rstream);
}

/************************/
/*	Mt_PROPERTY	*/
/************************/

/*--------------------------------------------*/
 void c_check_property(pid,oid)
/*--------------------------------------------*/
EIF_INTEGER pid,oid;
{
result = Mt_CheckProperty(pid,oid);
}

/************************/
/*	Mt_RELATIONSHIP	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_get_relationship_from_name(name)
/*--------------------------------------------*/
char* name;
{
MtKey key;
result = MtGetRelationship(&key,name);
return(key);
}

/*--------------------------------------------*/
 void c_check_relationship(relationship_id,object_id)
/*--------------------------------------------*/
EIF_INTEGER relationship_id,object_id;
{
result = Mt_CheckRelationship(relationship_id,object_id);
}


/********************************/
/*	MT_RELATIONSHIP_STREAM	*/
/********************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_relationship_stream(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
MtStream rstream;
result = Mt_OpenRelStream(&rstream,oid,rid);
return(rstream);
}

/********************************/
/*	MT_IRELATIONSHIP_STREAM	*/
/********************************/

/*--------------------------------------------*/
 EIF_POINTER c_open_irelationship_stream(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
MtStream rstream;
result = Mt_OpenIRelStream(&rstream,oid,rid);
return(rstream);
}


/************************/
/*	Mt_STREAM	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_next_object(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
MtKey key;
result = MtNextObject(sid,&key);
return(key);
}

/*--------------------------------------------*/
 EIF_INTEGER c_next_property(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
MtKey key;
MtBool specified_p;
result = MtNextProperty(sid,&key,&specified_p);
return(key);
}

/*--------------------------------------------*/
 void c_close_stream(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
result = MtCloseStream(sid);
}



/************************/
/*	MT_TIME_STREAM	*/
/************************/

/*--------------------------------------------*/
 EIF_POINTER c_time_enum_start()
/*--------------------------------------------*/
{
MtStream rstream;
result = MtTimeEnumStart(&rstream);
return(rstream);
}

/*--------------------------------------------*/
 void c_time_enum_end(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
result = MtTimeEnumEnd(sid);
}

/*--------------------------------------------*/
 void c_next_time(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
result = MtNextTime(sid,buffer,BUFFERSIZE);
}

/************************/
/*	DB_CONTROL_MAT	*/
/************************/

/*--------------------------------------------*/
/* 
 * MUST BE CALLED AFTER c_db_connect() to pick up database context. This
 * allows multiple contexts to be created, each stored in an Eiffel object
 */
EIF_POINTER c_database()
/*--------------------------------------------*/
{
    return database;
}

/*--------------------------------------------*/
/* MUST BE CALLED BEFORE c_set_context */
c_set_database(db)
MtDatabase db;
/*--------------------------------------------*/
{
    database = db;
}

/*--------------------------------------------*/
/* 
 * MUST BE CALLED AFTER c_start_transaction(), c_commit_transaction() and
 * c_rollback() . This allows multiple contexts to be created, each stored 
 * in an Eiffel object
 */
EIF_INTEGER c_transaction_count()
/*--------------------------------------------*/
{
return(transaction_count);
}

/*--------------------------------------------*/
/* MUST BE CALLED BEFORE c_set_context() */
c_set_transaction_count(trans_count)
EIF_INTEGER trans_count;
/*--------------------------------------------*/
{
transaction_count = trans_count;
}

/*--------------------------------------------*/
 void c_db_connect(host_name,database_name)
/*--------------------------------------------*/
char* host_name;
char* database_name;
{
result = MtConnect(&database,host_name,database_name,0,0,MTFALSE);
}

/*--------------------------------------------*/
 void c_set_context()
/*--------------------------------------------*/
{
result = MtSetContext(database);
}

/*--------------------------------------------*/
 void c_set_no_context()
/*--------------------------------------------*/
{
result = MtNoContext();
}

/*--------------------------------------------*/
 void c_disconnect()
/*--------------------------------------------*/
{
result = MtDisconnect(database);
}

/*--------------------------------------------*/
 void c_start_transaction(priority)
/*--------------------------------------------*/
EIF_INTEGER priority;
{
result = MtStartTransaction(priority);
if MtSuccess(result) transaction_count++;
}

/*--------------------------------------------*/
 void c_commit_transaction()
/*--------------------------------------------*/
{
result = MtCommitTransaction(NULL,NULL);
if MtSuccess(result) transaction_count--;
}

/*--------------------------------------------*/
 void c_rollback()
/*--------------------------------------------*/
{
result = MtAbortTransaction();
if MtSuccess(result) transaction_count--;
}

/*--------------------------------------------*/
 void c_set_time(time_name)
/*--------------------------------------------*/
char* time_name;
{
result = MtSetTime(time_name);
}


/*--------------------------------------------*/
 void c_end_time()
/*--------------------------------------------*/
{
result = MtEndTime();
}


/*--------------------------------------------*/
/* 
 * MUST BE CALLED AFTER c_admin_connect() to pick up admin context. This
 * allows multiple contexts to be created, each stored in an Eiffel object
 */
EIF_POINTER c_admin_handle()
/*--------------------------------------------*/
{
    return admin_handle;
}

/*--------------------------------------------*/
/* MUST BE CALLED BEFORE c_set_context */
c_set_admin_handle(hdl)
RPC_HANDLE hdl;
/*--------------------------------------------*/
{
    admin_handle = hdl;
}

/*--------------------------------------------*/
 void c_admin_connect(char *host_name, char *database_name)
/*--------------------------------------------*/
{
    admin_sts = mts_rpc_connect(&admin_handle, host_name, database_name, "mtsoper", 1024, 0);
}

/*--------------------------------------------*/
 void c_admin_disconnect()
/*--------------------------------------------*/
{
    admin_sts = mts_rpc_disconnect(admin_handle);
}

/*--------------------------------------------*/
void c_admin_collect_and_wait()
/*--------------------------------------------*/
{
    RPC_HANDLE oos_handle;

    /* save the current connection context */
    admin_sts = mts_rpc_handle(&oos_handle);
    if (sts_failure (admin_sts))
        return;

    admin_sts = mts_rpc_set_handle(admin_handle);
    if (sts_failure (admin_sts))
        return;

    /* do collect as a background operation */
    admin_sts = mts_collect (MTS_COLLECT_LEVEL_2);
    if (sts_failure (admin_sts))
        return;

    /* wait until the collect is completed */
    admin_sts = mts_wait_for_adm_operation (MTS_ADMOP_COLLECT_VERSIONS);
    if (sts_failure (admin_sts))
        return;

    admin_sts = mts_rpc_set_handle(oos_handle);
    if (sts_failure (admin_sts))
        return;
}

/*--------------------------------------------*/
 EIF_BOOLEAN c_admin_sts_success()
/*--------------------------------------------*/
{
    return(sts_success(admin_sts));
}

/*--------------------------------------------*/
 EIF_INTEGER c_admin_sts()
/*--------------------------------------------*/
{
    return(admin_sts);
}

/*--------------------------------------------*/
 EIF_POINTER c_admin_sts_msg()
/*--------------------------------------------*/
{
    sts_msg(admin_msg, admin_sts);
    return(admin_msg);
}

/************************/
/*	DB_STATUS_MAT	*/
/************************/

/*--------------------------------------------*/
 EIF_INTEGER c_invalid_object()
/*--------------------------------------------*/
{
return(mtInvalidObject);
}

/*--------------------------------------------*/
 EIF_POINTER c_error()
/*--------------------------------------------*/
{
return(MtError());
}

/*--------------------------------------------*/
 EIF_INTEGER c_is_ok()
/*--------------------------------------------*/
{
return(MtSuccess(result));
}

/*--------------------------------------------*/
 EIF_BOOLEAN c_is_check_error()
/*--------------------------------------------*/
{
return(MtCheckErrorP(result));
}

/*--------------------------------------------*/
 void c_perror(head)
/*--------------------------------------------*/
char* head;
{
MtPError(head);
}

/*--------------------------------------------*/
 EIF_POINTER c_full_error()
/*--------------------------------------------*/
{
return(mtErrorStr);
}

/*--------------------------------------------*/
 EIF_INTEGER c_failure()
/*--------------------------------------------*/
{
return(MtFailure(result));
}

/*--------------------------------------------*/
 EIF_INTEGER c_result()
/*--------------------------------------------*/
{
return(result);
}

/*--------------------------------------------*/
 EIF_INTEGER c_matisse_success()
/*--------------------------------------------*/
{
MtSTS one_success = MATISSE_SUCCESS;
return(one_success);
}


/************************/
/*	HANDLE_MAT	*/
/************************/

/*--------------------------------------------*/
 void c_set_wait_time(wait_time)
/*--------------------------------------------*/
EIF_INTEGER wait_time;
{
result=MtSetWaitTime(wait_time);
}


/************************/
/*	MT_ATTACH	*/
/************************/

/*--------------------------------------------*/
 void clip(rp,rname,rargs)
/*--------------------------------------------*/
EIF_POINTER rp,rname,rargs;
{
MtServiceDef function[1];
function[0].name = rname;
function[0].fct =(MtServiceFct)rp;
result = MtInitialize(1,function);
}

/*--------------------------------------------*/
 void c_call_service_function(oid,aid,at_object)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
eif_adopt(at_object);
/*result = Mt_CallServiceFunction(aid,oid,eif_access(at_object));*/
eif_wean(at_object);
}

/************************/
/*	MATISSE_IDF_TABLE*/
/************************/

static int *translation_table;

uint32 *flags ;
EIF_INTEGER *oids;
int flags_index=0,oids_index=0;

/*--------------------------------------------*/
 void c_free_flags()
/*--------------------------------------------*/
{
    if (flags != NULL) {
	DEBUG_PRINTF((stderr, "c_free_flags() - flags == 0x%lx\n", flags))
	free(flags);
	flags = NULL;
	flags_index = 0;
    }
    else
        DEBUG_PRINTF((stderr, "c_free_flags() - nothing to do; flags == 0x%lx\n", flags))
}

void malloc_flags(sz)
int sz;
{
    flags = (uint32*)malloc(sz);
    DEBUG_PRINTF((stderr, "malloc_flags() - flags == 0x%lx\n", flags))
}


/*--------------------------------------------*/
 void c_free_oids()
/*--------------------------------------------*/
{
    if (oids != NULL){
	DEBUG_PRINTF((stderr, "c_free_oids() - oids == 0x%lx\n", oids))
	free(oids);
	oids = NULL;
	oids_index = 0;
	DEBUG_PRINTF((stderr, "c_free_oids: oids_index RESET to 0\n"))
    }
    else
	DEBUG_PRINTF((stderr, "c_free_oids() - nothing to do; oids == 0x%lx\n", oids))
}

void malloc_oids(sz)
int sz;
{
    oids = (EIF_INTEGER*) malloc(sz);
    DEBUG_PRINTF((stderr, "malloc_oids() - oids == 0x%lx\n", oids))
}

/*--------------------------------------------*/
 void c_save_idf_table(c)
/*--------------------------------------------*/
EIF_INTEGER c;
{
    DEBUG_PRINTF((stderr, "c_save_idf_table: storing oids & flags; oids_index == %ld\n", oids_index))
    MtSetValue(c,"flags",MTU32_ARRAY,flags,1,flags_index);
    MtSetValue(c,"oids",MTS32_ARRAY,oids,1,oids_index);
}

/*--------------------------------------------*/
 void c_init_flags(c)
/*--------------------------------------------*/
EIF_INTEGER c;
{
    malloc_flags(c*sizeof(uint32));
}

/*--------------------------------------------*/
 void c_init_oids(c)
/*--------------------------------------------*/
EIF_INTEGER c;
{
    malloc_oids(c*sizeof(EIF_INTEGER));
}

/*--------------------------------------------*/
 void c_put_flag(obj)
/*--------------------------------------------*/
EIF_OBJ obj;
{
    uint32 oflags;
    EIF_OBJ object;
    object = obj;
    oflags = HEADER(object)->ov_flags;

DEBUG_PRINTF((stderr, "c_put_flag; flags_index = %d\n", flags_index))
    translation_table = (int *) access_current_table ();
DEBUG_PRINTF((stderr, "\ttransation_table = 0x%lx\n", translation_table))
    // *(flags+flags_index) = oflags;
    *(flags+flags_index) = translation_table [oflags&EO_TYPE];
    flags_index++;
}


/*--------------------------------------------*/
 void c_put_oid(id)
/*--------------------------------------------*/
EIF_INTEGER id;
{
    *(oids+oids_index) = id;
    oids_index++;
    DEBUG_PRINTF((stderr, "c_put_oid: oids_index++ == %ld\n", oids_index))
}


/*--------------------------------------------*/
 EIF_INTEGER c_ith_oid(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
return(*(oids+i));
}

/*--------------------------------------------*/
 void c_load(one_key)
/*--------------------------------------------*/
EIF_INTEGER one_key;
{
    Value* oids_result, *flags_result;
    EIF_INTEGER i=0;

    oids_result = (Value*)malloc(sizeof(Value));
oids_result->value = (void*)NULL;	// shouldn't be necessary...

    MtMGetValue(one_key,"oids",&(oids_result->type),&(oids_result->value),&(oids_result->rank),NULL); 
    for (i=0;i<oids_result->rank;i++)
	MtGetDimension(one_key,"oids",i,&(oids_result->dimensions[i]));

    c_free_oids();
    if (oids_result->type == MTS32_ARRAY) {
	oids_index=oids_result->dimensions[0];
	DEBUG_PRINTF((stderr, "c_load: oids_index RESET == %ld\n", oids_index))
	malloc_oids(oids_index*sizeof(EIF_INTEGER));
	for (i=0;i<oids_index;i++)
	    *(oids+i) = (EIF_INTEGER)*((EIF_INTEGER*)(oids_result->value)+i);
    };
// shouldn't have to do this test - it should just work!
if (oids_result->value != (void*)NULL)
    MtMFree(oids_result->value);
free(oids_result);

    flags_result = (Value*)malloc(sizeof(Value));
flags_result->value = (void*)NULL;	// shouldn't be necessary...
    MtMGetValue(one_key,"flags",&(flags_result->type),&(flags_result->value),&(flags_result->rank),NULL); 

    for (i=0;i<flags_result->rank;i++)
	MtGetDimension(one_key,"flags",i,&(flags_result->dimensions[i]));

    c_free_flags();
    if (flags_result->type == MTU32_ARRAY) {
	flags_index=flags_result->dimensions[0];
	malloc_flags(flags_index*sizeof(uint32));
	for (i=0;i<flags_index;i++)
	    *(flags+i) = (uint32)*((uint32*)(flags_result->value)+i);
    };
// shouldn't have to do this test - it should just work!
if (oids_result->value != (void*)NULL)
    MtMFree(flags_result->value);
free(flags_result);
}

/*--------------------------------------------*/
 EIF_INTEGER c_oids_index()
/*--------------------------------------------*/
{
return(oids_index);
}

/*--------------------------------------------*/
 EIF_INTEGER c_flags_index()
/*--------------------------------------------*/
{
return(flags_index);
}

 EIF_BOOLEAN c_is_ith_special(i)
EIF_INTEGER i;
{
  return((*(flags+i)&EO_SPEC)!=NULL);
}

 EIF_BOOLEAN c_ith_is_special(i)
EIF_INTEGER i;
{
  return((*(flags+i)&EO_SPEC)!=NULL);
}

 EIF_REFERENCE c_ith_special(i)
EIF_INTEGER i;
{
Value* special_result;
uint32 special_size=0;
EIF_INTEGER special_count=0;
char * new_object = (char *) 0;
char*ref;
long nb_char;
MtType special_count_type=MTS32;
MtSize ssize;
union overhead *zone;
MtSize a_rank;
MtSize a_size;

a_size = sizeof(special_count);
special_result = (Value*)malloc(sizeof(Value));
MtMGetValue(*(oids+i),"eif_size",&(special_result->type),&(special_result->value),&(special_result->rank),NULL); 

if (special_result->type == MTS32) 
	{
	special_size=*(uint32*)(special_result->value);
	};
free(special_result);

MtGetValue(*(oids+i),"eif_count",&special_count_type,&special_count,&a_rank,&a_size,NULL); 

new_object = spmalloc(special_size&B_SIZE);
zone=HEADER(new_object);
zone->ov_flags |= (*(flags+i)) & (EO_SPEC|EO_TYPE|0x00ff0000);
ref = new_object + (zone->ov_size&B_SIZE)-LNGPAD(2);
*(EIF_INTEGER*)ref = special_count;
*(EIF_INTEGER*)(ref+sizeof(EIF_INTEGER))=(EIF_INTEGER)(special_size&B_SIZE);

return(new_object);
}



EIF_REFERENCE c_ith_normal(EIF_INTEGER i)
{
	long nb_char;
	uint32 normal_flags=*(flags+i);
	char * new_object = (char *) 0;
	
#ifndef WORKBENCH
	nb_char = esize[(uint16)(normal_flags&EO_TYPE)];
#else
	nb_char = esystem[(uint16)(normal_flags&EO_TYPE)].size;
#endif
	translation_table = (int *) access_old_table ();	/* Get the table which from the dtype saved
															 * in the Matisse Database will generate the
															 * corresponding dtype for the current system */
	DEBUG_PRINTF((stderr, "normal_flags&EO_TYPE: %ld\n", normal_flags&EO_TYPE))
	DEBUG_PRINTF((stderr, "translation table entry: %ld\n", translation_table[normal_flags&EO_TYPE]))
	DEBUG_PRINTF((stderr, "----\n"))

	new_object = emalloc(translation_table [normal_flags&EO_TYPE]);
	return(new_object);
}


 EIF_REFERENCE c_ith_normal_object(i)
EIF_INTEGER i;
{
EIF_OBJ eif_obj;
EIF_TYPE_ID eif_type;
MtKey cid;
MtType stype;
MtSize ssize=32;
long nb_char;
uint32 normal_flags=*(flags+i);
char * new_object = (char *) 0;

	DEBUG_PRINTF((stderr, "oid == 0x%lx\n", c_ith_oid(i) ))

result = MtGetClassFromObject(&cid,c_ith_oid(i));

result = MtGetValue( cid,"Mt Name",&stype,(void*)name,NULL,&ssize,0);

	DEBUG_PRINTF((stderr, "class name == %s\n", (char *)(name)  ))

eif_type = eif_type_id( (char *)(name) );

	DEBUG_PRINTF((stderr, "eif_type_id == %d\n", eif_type ))

eif_obj = eif_create( eif_type );

	DEBUG_PRINTF((stderr, "eif_obj == 0x%1x\n", eif_obj  ))

	return eif_obj;

}

