#include <stdio.h>
#include <stdlib.h>
#include <matisse.h>
#include "eiffel.h"
#include "garcol.h"

#define BUFFERSIZE 512
typedef struct {
	MtType type;
	MtSize rank;
	MtSize dimensions[8];
	void* value;
} Value;

MtSTS result;
MtDatabase database;
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
public EIF_INTEGER c_mts32()
/*--------------------------------------------*/
{
return(MTS32);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtnil()
/*--------------------------------------------*/
{
return(MTNIL);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtdouble()
/*--------------------------------------------*/
{
return(MTDOUBLE);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtfloat()
/*--------------------------------------------*/
{
return(MTFLOAT);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtchar()
/*--------------------------------------------*/
{
return(MTCHAR);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtstring()
/*--------------------------------------------*/
{
return(MTSTRING);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtasciichar()
/*--------------------------------------------*/
{
return(MTASCIICHAR);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtasciistring()
/*--------------------------------------------*/
{
return(MTASCIISTRING);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mts32_list()
/*--------------------------------------------*/
{
return(MTS32_LIST);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtdouble_list()
/*--------------------------------------------*/
{
return(MTDOUBLE_LIST);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtfloat_list()
/*--------------------------------------------*/
{
return(MTFLOAT_LIST);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtstring_list()
/*--------------------------------------------*/
{
return(MTSTRING_LIST);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtasciistring_list()
/*--------------------------------------------*/
{
return(MTASCIISTRING_LIST);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mts32_array()
/*--------------------------------------------*/
{
return(MTS32_ARRAY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtdouble_array()
/*--------------------------------------------*/
{
return(MTDOUBLE_ARRAY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtfloat_array()
/*--------------------------------------------*/
{
return(MTFLOAT_ARRAY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtstring_array()
/*--------------------------------------------*/
{
return(MTSTRING_ARRAY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtasciistring_array()
/*--------------------------------------------*/
{
return(MTASCIISTRING_ARRAY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtmin_tran_priority()
/*--------------------------------------------*/
{
return(MTMIN_TRAN_PRIORITY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtmax_tran_priority()
/*--------------------------------------------*/
{
return(MTMAX_TRAN_PRIORITY);
}
/*--------------------------------------------*/
public EIF_INTEGER c_mtread()
/*--------------------------------------------*/
{
return(MTREAD);
}

/*--------------------------------------------*/
public EIF_INTEGER c_mtwrite()
/*--------------------------------------------*/
{
return(MTWRITE);
}

/*--------------------------------------------*/
public EIF_INTEGER c_mtdirect()
/*--------------------------------------------*/
{
return(MTDIRECT);
}

/*--------------------------------------------*/
public EIF_INTEGER c_mtreverse()
/*--------------------------------------------*/
{
return(MTREVERSE);
}

/*--------------------------------------------*/
public EIF_INTEGER c_mtascend()
/*--------------------------------------------*/
{
return(MTASCEND);
}

/*--------------------------------------------*/
public EIF_INTEGER c_mtdescend()
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
public EIF_INTEGER c_keys_count()
/*--------------------------------------------*/
{
return(keys_count);
}

/*--------------------------------------------*/
public EIF_INTEGER c_ith_key(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
return(keys[i-1]);
}

/*--------------------------------------------*/
public void c_free_keys()
/*--------------------------------------------*/
{
free(keys);
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
public void c_get_value(oid,aid)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
result = Mt_MGetValue(oid,aid,&vtype,&value,&vrank,&dvalue);
}

/*--------------------------------------------*/
public void c_free_value(oid,aid)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
free(value);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_integer_value()
/*--------------------------------------------*/
{
EIF_INTEGER* one_integer;
one_integer = (EIF_INTEGER*) value;
return(*one_integer);
}

/*--------------------------------------------*/
public EIF_DOUBLE c_get_double_value()
/*--------------------------------------------*/
{
EIF_DOUBLE* one_double;
one_double = (EIF_DOUBLE*) value;
return(*one_double);
}

/*--------------------------------------------*/
public EIF_REAL c_get_real_value()
/*--------------------------------------------*/
{
EIF_REAL* one_real;
one_real = (EIF_REAL*) value;
return(*one_real);
}

/*--------------------------------------------*/
public EIF_CHARACTER c_get_char_value()
/*--------------------------------------------*/
{
EIF_CHARACTER* one_character;
one_character = (EIF_CHARACTER*) value;
return(*one_character);
}

/*--------------------------------------------*/
public EIF_POINTER c_get_string_value()
/*--------------------------------------------*/
{
return((char*)value);
}

/*--------------------------------------------*/
public EIF_INTEGER c_value_type()
/*--------------------------------------------*/
{
return(vtype);
}

/*--------------------------------------------*/
public EIF_INTEGER c_ith_list_integer(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_INTEGER* one_integer;
one_integer = (EIF_INTEGER*) ((MtS32*)value+(i-1));
return(*one_integer);
}

/*--------------------------------------------*/
public EIF_DOUBLE c_ith_list_double(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_DOUBLE* one_double;
one_double = (EIF_DOUBLE*) ((MtDouble*)value+(i-1));
return(*one_double);
}

/*--------------------------------------------*/
public EIF_REAL c_ith_list_real(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
EIF_REAL* one_real;
one_real = (EIF_REAL*) ((MtFloat*)value+(i-1));
return(*one_real);
}

/*--------------------------------------------*/
public EIF_POINTER c_ith_list_string(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
char** one_string;
one_string = (char**) ((char**)value+(i-1));
return(*one_string);
}

/*--------------------------------------------*/
public void c_set_value_integer(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type,value,rank;
{
MtS32 ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
public void c_set_value_double(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_DOUBLE value;
EIF_INTEGER rank;
{
MtDouble ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
public void c_set_value_real(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_REAL value;
EIF_INTEGER rank;
{
MtFloat ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
public void c_set_value_char(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_CHARACTER value;
EIF_INTEGER rank;
{
MtChar ivalue = value;
result = Mt_SetValue(oid,aid,type,&ivalue,rank);
}

/*--------------------------------------------*/
public void c_set_value_string(oid,aid,type,value,rank)
/*--------------------------------------------*/
EIF_INTEGER oid,aid,type;
EIF_POINTER value;
EIF_INTEGER rank;
{
MtString ivalue=value;
result = Mt_SetValue(oid,aid,MTSTRING,(void*)ivalue,0);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_attribute(attribute_name)
/*--------------------------------------------*/
char* attribute_name;
{
MtKey aid;
result = MtGetAttribute(&aid,attribute_name);
return(aid);
}

/*--------------------------------------------*/
public void c_check_attribute(attribute_id,object_id)
/*--------------------------------------------*/
EIF_INTEGER attribute_id,object_id;
{
result = Mt_CheckAttribute(attribute_id,object_id);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_dimension(object_id,attribute_id,rank)
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
public EIF_INTEGER c_type_value(aid)
/*--------------------------------------------*/
EIF_INTEGER aid;
{
MtType tv=0,stype;
MtS32 *ltypes;
result = MtMGetValue(aid,"Mt Type",&stype,(void*)&ltypes,NULL,NULL);
if (ltypes) tv = *ltypes;
return(tv);
}

/************************/
/*	Mt_CLASS	*/
/************************/

/*--------------------------------------------*/
public EIF_INTEGER c_get_class_from_name(name)
/*--------------------------------------------*/
char* name;
{
MtKey key;
result = MtGetClass(&key,name);
return(key);
}

/*--------------------------------------------*/
public EIF_INTEGER c_create_object(name)
/*--------------------------------------------*/
char* name;
{
MtKey key;
result = MtCreateObject(&key,name);
return(key);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_class_from_object(object_id)
/*--------------------------------------------*/
EIF_INTEGER object_id;
{
MtKey cid;
result = MtGetClassFromObject(&cid,object_id);
return(cid);
}

/*--------------------------------------------*/
public void c_get_all_attributes(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllAttributes(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
public void c_get_all_relationships(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllRelationships(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
public void c_get_all_i_relationships(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllIRelationships(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
public void c_get_all_subclasses(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllSubclasses(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
public void c_get_all_superclasses(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
result = Mt_MGetAllSuperclasses(&keys_count,&keys,class_id);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_instances_number(class_id)
/*--------------------------------------------*/
EIF_INTEGER class_id;
{
MtSize instances_number;
result = Mt_GetInstancesNumber(&instances_number,class_id);
return(instances_number);
}

/*--------------------------------------------*/
public EIF_POINTER c_object_name(object_id)
/*--------------------------------------------*/
EIF_INTEGER object_id;
{
MtType stype;
MtSize ssize=32;
result = MtGetValue(object_id,"Mt Name",&stype,(void*)name,NULL,&ssize,0);
return(name);
}

/*--------------------------------------------*/
public void c_create_num_objects(n,oid)
/*--------------------------------------------*/
EIF_INTEGER n,oid;
{
keys = (MtKey*) malloc(n*sizeof(MtKey));
result = Mt_CreateNumObjects(n,keys,oid);
}

/************************/
/*	MT_CLASS_STREAM	*/
/************************/

/*--------------------------------------------*/
public EIF_POINTER c_open_class_stream(class_id)
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
public void c_get_objects_from_ep(attribute_id,class_id,entry_point_name)
/*--------------------------------------------*/
EIF_INTEGER attribute_id,class_id;
char *entry_point_name;
{
result = Mt_MGetObjectsFromEP(&keys_count,&keys,entry_point_name,attribute_id,class_id);
}

/*--------------------------------------------*/
public void c_lock_objects_from_ep(lock,ep_name,attribute_id,class_id)
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
public EIF_POINTER c_open_ep_stream(ep_name,attribute_id,class_id)
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
public EIF_INTEGER c_get_index(index_name)
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
public EIF_POINTER c_open_index_stream(index_name,class_name,direction)
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
public EIF_INTEGER c_max_buffered_objects()
/*--------------------------------------------*/
{
return(MtGetConfigurationInfo(MTMAX_BUFFERED_OBJECTS));
}

/*--------------------------------------------*/
public EIF_INTEGER c_max_index_criteria_number()
/*--------------------------------------------*/
{
return(MtGetConfigurationInfo(MTMAX_INDEX_CRITERIA_NUMBER));
}

/*--------------------------------------------*/
public EIF_INTEGER c_max_index_key_length()
/*--------------------------------------------*/
{
return(MtGetConfigurationInfo(MTMAX_INDEX_KEY_LENGTH));
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_total_read_bytes()
/*--------------------------------------------*/
{
MtLargeSize total;
result = MtGetTotalReadBytes(&total);
return(total);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_total_write_bytes()
/*--------------------------------------------*/
{
MtLargeSize total;
result = MtGetTotalWriteBytes(&total);
return(total);
}

/*--------------------------------------------*/
public EIF_INTEGER c_get_wait_time()
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
public EIF_INTEGER c_get_message(selector)
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
public EIF_BOOLEAN c_predefined_msp(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtBool is_predefined_msp;
result = MtPredefinedMSP(&is_predefined_msp,oid);
return(is_predefined_msp);
}

/*--------------------------------------------*/
public void c_check_instance(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
result = MtCheckInstance(oid);
}

/*--------------------------------------------*/
public void c_remove_value(oid,aid)
/*--------------------------------------------*/
EIF_INTEGER oid,aid;
{
result = Mt_RemoveValue(oid,aid);
}

/*--------------------------------------------*/
public void c_remove_object(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
result = MtRemoveObject(oid);
}

/*--------------------------------------------*/
public void c_remove_all_successors(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_RemoveAllSuccessors(oid,rid);
}

/*--------------------------------------------*/
public EIF_INTEGER c_object_size(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtSize osize;
result = MtObjectSize(&osize,oid);
return(osize);
}

/*--------------------------------------------*/
public void c_print_to_file(oid,file_pointer)
/*--------------------------------------------*/
EIF_INTEGER oid;
EIF_POINTER file_pointer;
{
result = MtPrint(oid,(FILE*)file_pointer);
}


/*--------------------------------------------*/
public EIF_BOOLEAN c_type_p(oid,cid)
/*--------------------------------------------*/
EIF_INTEGER oid,cid;
{
MtBool typep;
result = Mt_TypeP(&typep,oid,cid);
return(typep);
}

/*--------------------------------------------*/
public void c_get_all_added_succs(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetAllAddedSuccs(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
public void c_get_all_rem_succs(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetAllRemSuccs(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
public void c_get_successors(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetSuccessors(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
public void c_get_predecessors(oid,rid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid;
{
result = Mt_MGetPredecessors(&keys_count,&keys,oid,rid);
}

/*--------------------------------------------*/
public void c_free_object(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
MtKey key;
key = oid;
result = MtFreeObjects(1,&key);
}

/*--------------------------------------------*/
public void c_add_successor_first(oid,rid,soid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid,soid;
{
result = Mt_AddSuccessor(oid,rid,soid,MTFIRST);
}

/*--------------------------------------------*/
public void c_add_successor_append(oid,rid,soid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid,soid;
{
result = Mt_AddSuccessor(oid,rid,soid,MTAPPEND);
}

/*--------------------------------------------*/
public void c_add_successor_after(oid,rid,soid,ooid)
/*--------------------------------------------*/
EIF_INTEGER oid,rid,soid,ooid;
{
result = Mt_AddSuccessor(oid,rid,soid,MTAFTER,ooid);
}

/*--------------------------------------------*/
public void c_lock_object(oid,lock)
/*--------------------------------------------*/
EIF_INTEGER oid,lock;
{
result = MtLockObjects(1,oid,lock);
}

/*--------------------------------------------*/
public void c_load_object(oid)
/*--------------------------------------------*/
EIF_INTEGER oid;
{
result = MtLoadObjects(1,oid);
}

/********************************/
/*	MT_OBJECT_ATT_STREAM	*/
/********************************/

/*--------------------------------------------*/
public EIF_POINTER c_open_object_att_stream(oid)
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
public EIF_POINTER c_open_object_irel_stream(oid)
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
public EIF_POINTER c_open_object_rel_stream(oid)
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
public void c_check_property(pid,oid)
/*--------------------------------------------*/
EIF_INTEGER pid,oid;
{
result = Mt_CheckProperty(pid,oid);
}

/************************/
/*	Mt_RELATIONSHIP	*/
/************************/

/*--------------------------------------------*/
public EIF_INTEGER c_get_relationship_from_name(name)
/*--------------------------------------------*/
char* name;
{
MtKey key;
result = MtGetRelationship(&key,name);
return(key);
}

/*--------------------------------------------*/
public void c_check_relationship(relationship_id,object_id)
/*--------------------------------------------*/
EIF_INTEGER relationship_id,object_id;
{
result = Mt_CheckRelationship(relationship_id,object_id);
}


/********************************/
/*	MT_RELATIONSHIP_STREAM	*/
/********************************/

/*--------------------------------------------*/
public EIF_POINTER c_open_relationship_stream(oid,rid)
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
public EIF_POINTER c_open_irelationship_stream(oid,rid)
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
public EIF_INTEGER c_next_object(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
MtKey key;
result = MtNextObject(sid,&key);
return(key);
}

/*--------------------------------------------*/
public EIF_INTEGER c_next_property(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
MtKey key;
MtBool specified_p;
result = MtNextProperty(sid,&key,&specified_p);
return(key);
}

/*--------------------------------------------*/
public void c_close_stream(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
result = MtCloseStream(sid);
}



/************************/
/*	MT_TIME_STREAM	*/
/************************/

/*--------------------------------------------*/
public EIF_POINTER c_time_enum_start()
/*--------------------------------------------*/
{
MtStream rstream;
result = MtTimeEnumStart(&rstream);
return(rstream);
}

/*--------------------------------------------*/
public void c_time_enum_end(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
result = MtTimeEnumEnd(sid);
}

/*--------------------------------------------*/
public void c_next_time(sid)
/*--------------------------------------------*/
EIF_POINTER sid;
{
result = MtNextTime(sid,buffer,BUFFERSIZE);
}

/************************/
/*	DB_CONTROL_MAT	*/
/************************/

/*--------------------------------------------*/
public void c_connect(host_name,database_name)
/*--------------------------------------------*/
char* host_name;
char* database_name;
{
result = MtConnect(&database,host_name,database_name,0,0,MTFALSE);
}

/*--------------------------------------------*/
public void c_set_context()
/*--------------------------------------------*/
{
result = MtSetContext(database);
}

/*--------------------------------------------*/
public void c_set_no_context()
/*--------------------------------------------*/
{
result = MtNoContext();
}

/*--------------------------------------------*/
public void c_disconnect()
/*--------------------------------------------*/
{
result = MtDisconnect(database);
}

/*--------------------------------------------*/
public void c_start_transaction(priority)
/*--------------------------------------------*/
EIF_INTEGER priority;
{
result = MtStartTransaction(priority);
if MtSuccess(result) transaction_count++;
}

/*--------------------------------------------*/
public void c_commit_transaction()
/*--------------------------------------------*/
{
result = MtCommitTransaction(NULL,NULL);
if MtSuccess(result) transaction_count--;
}

/*--------------------------------------------*/
public void c_rollback()
/*--------------------------------------------*/
{
result = MtAbortTransaction();
if MtSuccess(result) transaction_count--;
}

/*--------------------------------------------*/
public void c_set_time(time_name)
/*--------------------------------------------*/
char* time_name;
{
result = MtSetTime(time_name);
}


/*--------------------------------------------*/
public void c_end_time()
/*--------------------------------------------*/
{
result = MtEndTime();
}

/*--------------------------------------------*/
public EIF_INTEGER c_transaction_count()
/*--------------------------------------------*/
{
return(transaction_count);
}

/************************/
/*	DB_STATUS_MAT	*/
/************************/

/*--------------------------------------------*/
public EIF_INTEGER c_invalid_object()
/*--------------------------------------------*/
{
return(mtInvalidObject);
}

/*--------------------------------------------*/
public EIF_POINTER c_error()
/*--------------------------------------------*/
{
return(MtError());
}

/*--------------------------------------------*/
public EIF_INTEGER c_is_ok()
/*--------------------------------------------*/
{
return(MtSuccess(result));
}

/*--------------------------------------------*/
public EIF_BOOLEAN c_is_check_error()
/*--------------------------------------------*/
{
return(MtCheckErrorP(result));
}

/*--------------------------------------------*/
public void c_perror(head)
/*--------------------------------------------*/
char* head;
{
MtPError(head);
}

/*--------------------------------------------*/
public EIF_POINTER c_full_error()
/*--------------------------------------------*/
{
return(mtErrorStr);
}

/*--------------------------------------------*/
public EIF_INTEGER c_failure()
/*--------------------------------------------*/
{
return(MtFailure(result));
}

/*--------------------------------------------*/
public EIF_INTEGER c_result()
/*--------------------------------------------*/
{
return(result);
}

/*--------------------------------------------*/
public EIF_INTEGER c_matisse_success()
/*--------------------------------------------*/
{
MtSTS one_success = MATISSE_SUCCESS;
return(one_success);
}

/************************/
/*	HANDLE_MAT	*/
/************************/

/*--------------------------------------------*/
public void c_set_wait_time(wait_time)
/*--------------------------------------------*/
EIF_INTEGER wait_time;
{
result=MtSetWaitTime(wait_time);
}


/************************/
/*	MT_ATTACH	*/
/************************/

/*--------------------------------------------*/
public void clip(rp,rname,rargs)
/*--------------------------------------------*/
EIF_POINTER rp,rname,rargs;
{
MtServiceDef function[1];
function[0].name = rname;
function[0].fct =(MtServiceFct)rp;
result = MtInitialize(1,function);
}

/*--------------------------------------------*/
public void c_call_service_function(oid,aid,at_object)
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

uint32 *flags ;
EIF_INTEGER *oids;
int flags_index=0,oids_index=0;

/*--------------------------------------------*/
public void c_save_idf_table(c)
/*--------------------------------------------*/
EIF_INTEGER c;
{
MtSetValue(c,"flags",MTU32_ARRAY,flags,1,flags_index);
MtSetValue(c,"oids",MTS32_ARRAY,oids,1,oids_index);
}

/*--------------------------------------------*/
public void c_init_flags(c)
/*--------------------------------------------*/
EIF_INTEGER c;
{
flags = (uint32*) malloc(c*sizeof(uint32));
}

/*--------------------------------------------*/
public void c_init_oids(c)
/*--------------------------------------------*/
EIF_INTEGER c;
{
oids =(EIF_INTEGER*) malloc(c*sizeof(EIF_INTEGER));
}

/*--------------------------------------------*/
public void c_put_flag(obj)
/*--------------------------------------------*/
EIF_OBJ obj;
{
uint32 oflags;
EIF_OBJ object;
object = obj;
oflags = HEADER(object)->ov_flags;
*(flags+flags_index) = oflags;
flags_index++;
}


/*--------------------------------------------*/
public void c_put_oid(id)
/*--------------------------------------------*/
EIF_INTEGER id;
{
*(oids+oids_index) = id;
oids_index++;
}


/*--------------------------------------------*/
public void c_free_flags()
/*--------------------------------------------*/
{
free(flags);
flags_index = 0;
}

/*--------------------------------------------*/
public void c_free_oids()
/*--------------------------------------------*/
{
free(oids);
oids_index = 0;
}

/*--------------------------------------------*/
public EIF_INTEGER c_ith_oid(i)
/*--------------------------------------------*/
EIF_INTEGER i;
{
return(*(oids+i));
}

/*--------------------------------------------*/
public void c_load(one_key)
/*--------------------------------------------*/
EIF_INTEGER one_key;
{
Value* oids_result, *flags_result;
EIF_INTEGER i=0;

oids_result = (Value*)malloc(sizeof(Value));
c_free_oids();
MtMGetValue(one_key,"oids",&(oids_result->type),&(oids_result->value),&(oids_result->rank),NULL); 
for (i=0;i<oids_result->rank;i++)
	MtGetDimension(one_key,"oids",i,&(oids_result->dimensions[i]));
if (oids_result->type=MTS32_ARRAY) 
	{
	oids_index=oids_result->dimensions[0];
	oids =(EIF_INTEGER*) malloc(oids_index*sizeof(EIF_INTEGER));
	for (i=0;i<oids_index;i++)
		*(oids+i) = (EIF_INTEGER)*((EIF_INTEGER*)(oids_result->value)+i);
	};

flags_result = (Value*)malloc(sizeof(Value));
c_free_flags();
MtMGetValue(one_key,"flags",&(flags_result->type),&(flags_result->value),&(flags_result->rank),NULL); 
for (i=0;i<flags_result->rank;i++)
	MtGetDimension(one_key,"flags",i,&(flags_result->dimensions[i]));
if (flags_result->type=MTU32_ARRAY) 
	{
	flags_index=flags_result->dimensions[0];
	flags =(uint32*) malloc(flags_index*sizeof(uint32));
	for (i=0;i<flags_index;i++)
		*(flags+i) = (uint32)*((uint32*)(flags_result->value)+i);
	};


}

/*--------------------------------------------*/
public EIF_INTEGER c_oids_index()
/*--------------------------------------------*/
{
return(oids_index);
}

/*--------------------------------------------*/
public EIF_INTEGER c_flags_index()
/*--------------------------------------------*/
{
return(flags_index);
}

public EIF_BOOLEAN c_is_ith_special(i)
EIF_INTEGER i;
{
  return((*(flags+i)&EO_SPEC)!=NULL);
}

public EIF_BOOLEAN c_ith_is_special(i)
EIF_INTEGER i;
{
  return((*(flags+i)&EO_SPEC)!=NULL);
}

public EIF_REFERENCE c_ith_special(i)
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

if (special_result->type=MTS32) 
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

public EIF_REFERENCE c_ith_normal(i)
EIF_INTEGER i;
{
long nb_char;
uint32 normal_flags=*(flags+i);
char * new_object = (char *) 0;

#ifndef WORKBENCH
nb_char = esize[(uint16)(normal_flags&EO_TYPE)];
#else
nb_char = esystem[(uint16)(normal_flags&EO_TYPE)].size;
#endif
new_object = emalloc(normal_flags&EO_TYPE);
return(new_object);
}




