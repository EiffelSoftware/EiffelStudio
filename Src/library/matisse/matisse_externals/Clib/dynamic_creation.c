/*
 * dynamic_creation.c
 *
 *  Support dynamic creation of Eiffel objects using CECIL functions
 *
 * Created: Mar. 98
 * Author: Kazuhiro Nakao
 *
 */
 
#include <stdio.h>
#include <string.h>
#include "eif_eiffel.h"
#include "eif_internal.h"
#include "matisse_eif.h"
#include "dynamic_creation.h"

#define DEBUG_PRINTF(a) fprintf a;

extern keys_count;

EIF_PROC search_make_proc_for(int cid, char * type_name, int * proc_type)
{
	EIF_MT_LOG1("search_make_proc: cid = %d", cid);
	if (strcmp(MT_ARRAY, type_name) == 0) {
		*proc_type = 4;
		EIF_MT_LOG("search_make_proc: MT_ARRAY");
		return eif_proc("make", cid);
	} else if (strcmp(MT_ARRAYED_LIST, type_name) == 0) {
		*proc_type = 2;
		EIF_MT_LOG("search_make_proc: MT_ARRAYED_LIST");
		return eif_proc("make", cid);
	} else if (strcmp(MT_LINKED_LIST, type_name) == 0) {
		*proc_type = 1;
		EIF_MT_LOG("search_make_proc: MT_LINKED_LIST");
		return eif_proc("make", cid);
	} else if (strcmp(MT_LINKED_STACK, type_name) == 0) {
		*proc_type = 1;
		EIF_MT_LOG("search_make_proc: MT_LINKED_STACK");
		return eif_proc("make", cid);
	} else if (strcmp(MT_HASH_TABLE, type_name) == 0) {
		//int ht_cid;
		
		//ht_cid = eif_generic_id("HASH_TABLE");
		//ht_cid = eif_type(cid);
		*proc_type = 2;
		EIF_MT_LOG("search_make_proc: MT_HASH_TABLE");
		return eif_proc("make", cid);
//		return eif_proc("make", eif_generic_id("HASH_TABLE"));
	} else {
		/* This is default. */
		EIF_MT_LOG("search_make_proc warning: class name is ");
		EIF_MT_LOG(type_name);
		*proc_type = 1;
		return eif_proc("make", cid);
	}
}


//char * get_eiffel_class_name(MtType att_value_type)
int get_eiffel_class_id(MtType att_value_type)
{
	switch(att_value_type) {
	case MT_S32_ARRAY:
	case MT_U32_ARRAY:
	case MT_S16_ARRAY:
	case MT_U16_ARRAY:
		return eif_type_id("INTEGER");
	case MT_U8_ARRAY:
		return eif_type_id("CHARACTER");
	case MT_FLOAT_ARRAY:
		return eif_type_id("REAL");
	case MT_DOUBLE_ARRAY:
		return eif_type_id("DOUBLE");
	case MT_ASCII_STRING_ARRAY:
	case MT_STRING_ARRAY:
		return eif_type_id("STRING");
	default:
		return -1;
	}
}

EIF_OBJ create_container_object(int container_type_id, int pred_oid, int rel_oid, const char * type_name)
{
//	EIF_MT_LOG1("
	if (strcmp(MT_HASH_TABLE, type_name) == 0) {
		MtKey ht_obj;  /* hash_table object */
		MtSize num_succs = 1;
		
		CHECK_STS(Mt_GetSuccessors(&num_succs, &ht_obj, pred_oid, rel_oid));
		if (num_succs == 0) {
			// We can not create MT_HASH_TABLE object, because it's actual generic
			// parameters are unknown. i.e. MT_HASH_TABLE[Reference, ...] is totally
			// different from MT_HASH_TABLE[INTEGER, ..] or something else.
			return (eif_create(eif_type_id("NONE"))); 
		} else {
			MtType att_key_type, att_value_type;
//			MtS32 properties_type = 0;
//			MtSize size;
			char * ht_name;  /* hash_table name */
			int key_type, value_type;
			int eif_ht_type;
			int ht_type;
			int16 typearr[4];
			
			CHECK_STS(MtGetValue(ht_obj, HASH_TABLE__att_keys, &att_key_type, 
					NULL, NULL, NULL, NULL));
			CHECK_STS(MtGetValue(ht_obj, HASH_TABLE__att_values, &att_value_type, 
					NULL, NULL, NULL, NULL));
			
			if (att_key_type == MT_NIL) {
				if (att_value_type == MT_NIL) {
					ht_name = MT_RR_HASH_TABLE;
					key_type = DTYPE_GEN(eif_type_id(HT_REFERENCE_TYPE));
					value_type = DTYPE_GEN(eif_type_id(HT_REFERENCE_TYPE));
				} else {
					ht_name = MT_AR_HASH_TABLE;
					key_type = DTYPE_GEN(eif_type_id(HT_REFERENCE_TYPE));
					value_type = DTYPE_GEN(get_eiffel_class_id(att_value_type));
				}
			} else {
				if (att_value_type == MT_NIL) {
					ht_name = MT_RA_HASH_TABLE;
					key_type = DTYPE_GEN(get_eiffel_class_id(att_key_type));
					value_type = DTYPE_GEN(eif_type_id(HT_REFERENCE_TYPE));
				} else {
					ht_name = MT_AA_HASH_TABLE;
					key_type = DTYPE_GEN(get_eiffel_class_id(att_key_type));
					value_type = DTYPE_GEN(get_eiffel_class_id(att_value_type));
				}
			}
			
			ht_type = DTYPE_GEN(eif_type_id (ht_name));

			typearr[0] = -1;
			typearr [1] = ht_type;
			typearr [2] = value_type;
			typearr [3] = key_type;
			typearr [4] = 0;
//			size = sizeof(MtS32); 			
//			CHECK_STS(MtGetValue(ht_obj, HASH_TABLE__properties_type, NULL, 
//					&properties_type, NULL, &size, NULL));
//			EIF_MT_LOG2("ht_obj = %d, properties_type = %d", ht_obj, properties_type);
//
//			if (properties_type == HASH_TABLE_RR_TYPE) {
//				ht_name = MT_RR_HASH_TABLE;
//				key_type = eif_type_id(HT_REFERENCE_TYPE);
//				value_type = eif_type_id(HT_REFERENCE_TYPE);
//			} else {
//			if (properties_type == HASH_TABLE_AR_TYPE) {
//				ht_name = MT_AR_HASH_TABLE;
//				key_type = eif_type_id(HT_REFERENCE_TYPE);
//				value_type = get_eiffel_class_id(att_value_type);
//			} else {
//			if (properties_type == HASH_TABLE_RA_TYPE) {
//				ht_name = MT_RA_HASH_TABLE;
//				key_type = get_eiffel_class_id(att_key_type);
//				value_type = eif_type_id(HT_REFERENCE_TYPE);
//			} else {
//			if (properties_type == HASH_TABLE_AA_TYPE) {
//				ht_name = MT_AA_HASH_TABLE;
//				key_type = get_eiffel_class_id(att_key_type);
//				value_type = get_eiffel_class_id(att_value_type);
//			} else {
//			if (properties_type == HASH_TABLE_UNKNOWN_TYPE) {
//				ht_name = MT_HASH_TABLE;
//				key_type = get_eiffel_class_id(att_key_type);
//				value_type = get_eiffel_class_id(att_value_type);
//			}}}}}
			
			EIF_MT_LOG2("key_type_name = %d, value_type_name = %d", key_type, value_type);
//			eif_ht_type = eif_generic_id(ht_name, eif_type_id("STRING"), eif_type_id("INTEGER"));
//			eif_ht_type = eif_generic_id(ht_name, eif_type_id(value_type_name), eif_type_id(key_type_name));
			/* Old way to create a generic class:
			 * eif_ht_type = eif_generic_id(ht_name, value_type, key_type);*/
			eif_ht_type = eif_compound_id ((int16 *) 0, (char *)0 , (int16) ht_type, typearr); 
			EIF_MT_LOG1("eif_ht_type = %d", eif_ht_type);
			EIF_MT_LOG1("ht_name = %s", ht_name);
			/* EIF_MT_LOG1("mt hash_table generic id %d", eif_generic_id("MT_HASH_TABLE", eif_type_id("STRING"), eif_type_id("INTEGER")));
			EIF_MT_LOG1("aa mt hash_table generic id %d", eif_generic_id("MT_AA_HASH_TABLE", eif_type_id("STRING"), eif_type_id("INTEGER")));
			EIF_MT_LOG1("ramt hash_table generic id %d", eif_generic_id("HASH_TABLE_SUB_SUB", eif_type_id("STRING"), eif_type_id("REAL")));
			EIF_MT_LOG1("armt hash_table generic id %d", eif_generic_id("HASH_TABLE_SUB_SUB", eif_type_id("STRING"), eif_type_id("DOUBLE")));
			EIF_MT_LOG1("rr mt hash_table generic id %d", eif_generic_id("HASH_TABLE_SUB_SUB", eif_type_id("STRING"), eif_type_id("CHARACTER")));
			EIF_MT_LOG1("hash_table generic id %d", eif_generic_id("HASH_TABLE", eif_type_id("STRING"), eif_type_id("INTEGER"))); */
			return (henter(RTLN(eif_ht_type)));
		}
	/* } else if (strcmp(???, type_name) == 0) {
	  .... */
	} else {
		int16 typearr [4];

		typearr [0] = -1;
		typearr [1] = DTYPE_GEN(container_type_id);
		typearr [2] = DTYPE_GEN(eif_type_id("MT_STORABLE"));
		typearr [3] = -1;
		
		return (henter(RTLN(eif_compound_id ((int16 *) 0, (char *)0 , (int16) DTYPE_GEN(container_type_id), typearr))));
	}
}


/*
 * c_create_empty_rs_container(EIF_INTEGER container_type_id, EIF_INTEGER pred_oid, 
			EIF_INTEGER rel_oid)
 *   container_type_id: EIF_TYPE_ID of container object which
 *   contains successor objects.
 *
 *   pred_oid: OID of predecessor
 *   rel_oid: OID of relationship
 * Return new empty container object
 */
//EIF_OBJ c_create_empty_rs_container(EIF_INTEGER container_type_id, EIF_OBJ a_rel, EIF_OBJ an_obj)
//EIF_OBJ c_create_empty_rs_container(EIF_INTEGER container_type_id)
EIF_OBJ c_create_empty_rs_container(EIF_INTEGER container_type_id, EIF_INTEGER pred_oid, 
			EIF_INTEGER rel_oid)
{
	EIF_OBJ obj;//, obj2;
	EIF_PROC make_proc;//, proc1, proc2;
	int make_proc_type;
	//EIF_TYPE_ID an_id;
	char * type_name;
	
	type_name = eifname(container_type_id);
	//obj = eif_create(container_type_id);
	obj = create_container_object(container_type_id, pred_oid, rel_oid, type_name);

	if (obj == NULL) return obj;
	
	/* look up appropriate initialization procedure, and apply it to obj */
	//make_proc = search_make_proc_for(container_type_id, &make_proc_type);
	make_proc = search_make_proc_for(eif_type(obj), type_name, &make_proc_type);
	/* type of obj can be different from the argument container_type_id.
	 * For example, when container_type_id is MT_HASH_TABLE, type of obj
	 * is one of the MT_AA_HASH_TABHE, MT_RA_HASH_TABLE etc. */
	EIF_MT_LOG("search_make_proc done.");
	
	switch(make_proc_type){
	case 1:
		/* !!a.make */ /* No argument. e.g. LINKED_LIST */
		(make_proc)(eif_access(obj));
		break;
	case 2:
		/* !!a.make(n) -- One argument specifying the size */
		/* e.g. ARRAYED_LIST */
		(make_proc)(eif_access(obj), 0);
		break;
	case 3:
		/* !!a.make(n, v) */
		/* to be done */
		break;
	case 4:
		/* !!a.make(n, m) */ /* e.g. ARRAY */
		(make_proc)(eif_access(obj), 1, 0);
		break;
	/* default:*/
	}
	
//		EIF_MT_LOG("c_create_empty_rs_container: creation done");
//	an_id = eif_generic_id("MT_RS_CONTAINABLE");
//		EIF_MT_LOG1("c_create_empty_rs_container: eif_type_id %d done", an_id);
//
//	proc1 = eif_proc("set_predecessor", an_id);
//		EIF_MT_LOG("c_create_empty_rs_container: eif_proc for set_predecessor done");
//	proc2 = eif_proc("set_relationship", an_id);
//		EIF_MT_LOG("c_create_empty_rs_container: eif_proc for set_relationship done");
//	
//	(proc1)(eif_access(obj), eif_access(an_obj));
//		EIF_MT_LOG("c_create_rs_container: application of proc1 done");
//	(proc2)(eif_access(obj), eif_access(a_rel));
	EIF_MT_LOG("c_create_empty_rs_container is done.\n")
	
	return eif_access(obj);
}


/*
 * c_generic_type_id(char * generic_class_name)
 *
 * Return eiffel generic type id of 'generic_class_name'
 * If 'generic_class_name' does not exist in the system,
 * this function returns -1.
 */
EIF_INTEGER c_generic_type_id(char * generic_class_name)
{
	return eif_generic_id(generic_class_name);
}


/*
 * nk_c_lock_object(oid,lock)
 * oid:  MATISSE object id
 * lock: Kind of lock (write/read)
 *
 * Redefine the original c_lock_object function written by ISE.
 */
/*void nk_c_lock_object(EIF_INTEGER oid, EIF_INTEGER lock)
{
	CHECK_STS(MtLockObjects(1, oid, lock));
}
*/


/*
 * void as_eiffel_class_name(char * mt_class_name)
 * mt_class_name:  MATISSE class name
 *
 * convert MATISSE class name into all capital and
 * if the class name contains spaces, convert the spaces
 * into '_' (underscore)
 */
void as_eiffel_class_name(char * mt_class_name)
{
	char * tmp;
	
	tmp = mt_class_name;
	while(*tmp != '\0'){
		if(*tmp >=  'a' && *tmp <= 'z')
			*tmp = *tmp - 32;
		else if(*tmp == ' ')
			*tmp = '_';
		tmp++;
	}
}


/*
 * EIF_INTEGER c_get_eiffel_type_id_from_name(char * mt_class_name)
 * mt_class_name: MATISSE class name
 * Return type id of Eiffel class correspondig to MATISSE class mt_class_name
 */
EIF_INTEGER c_get_eiffel_type_id_from_name(char * mt_class_name)
{
	char * temp;
		
	temp = strdup(mt_class_name);
	as_eiffel_class_name(temp);
	EIF_MT_LOG1("c_get_eiffel_type_id_from_name: %s", temp);
	return (EIF_INTEGER) eif_type_id(temp);
}
	
EIF_OBJ c_dynamic_create_eif_object(EIF_INTEGER mt_handle)
{
	MtKey classHandle;
	MtSTS sts;
	MtSize size;
	char  className[256];
	EIF_OBJ eif_obj, eo;
	EIF_TYPE_ID eif_type /*, mt_object_type */;
//	EIF_PROC eif_make;

	sts = MtGetObjectClass(&classHandle, mt_handle);
	CHECK_STS(sts);
	EIF_MT_LOG2("MtGetObjectClass sts = %d, class = %d", sts, classHandle);
	size = 256;
	CHECK_STS(MtGetValue(classHandle, "Mt Name", NULL, (void *) className,
		NULL, &size, NULL));
	EIF_MT_LOG1("MtGetValue sts = %d", sts);
	
	as_eiffel_class_name(className);
	eif_type = eif_type_id(className);
	EIF_MT_LOG2("eif_type_id = %d for class %s", eif_type, className);
	eif_obj = eif_create(eif_type);
	EIF_MT_LOG("eif_create");
	
	/* eif_make = eif_proc("make", eif_type); */ /* MTEXMBOOK */
//	mt_object_type = eif_type_id("MT_OBJECT");
//	EIF_MT_LOG1("eif_type_id = %d for class MT_OBJECT", mt_object_type);
//
//	eif_make = eif_proc("make", mt_object_type); 
//	EIF_MT_LOG("eif_proc");
//
	eo = eif_access(eif_obj);
	EIF_MT_LOG("eif_access");
	
//	(eif_make)(eo, mt_handle);
//	EIF_MT_LOG("execute of procedure");
	
	return eo;
}
