/*
 * dynamic_creation.h
 *
 *  Support dynamic creation of Eiffel objects using CECIL functions
 *
 * Created: Aug. 98
 * Author: Kazuhiro Nakao
 *
 */
 
#ifndef __DYNAMIC_CREATION_H__
#define __DYNAMIC_CREATION_H__

#include "eif_eiffel.h"

/* define names of classes used as container of successors */

#define MT_ARRAY			"MT_ARRAY"
#define MT_LINKED_LIST		"MT_LINKED_LIST"
#define MT_ARRAYED_LIST	"MT_ARRAYED_LIST"
#define MT_LINKED_STACK	"MT_LINKED_STACK"
#define MT_HASH_TABLE	"MT_HASH_TABLE"
#define MT_AA_HASH_TABLE	"MT_AA_HASH_TABLE"
#define MT_RA_HASH_TABLE	"MT_RA_HASH_TABLE"
#define MT_AR_HASH_TABLE	"MT_AR_HASH_TABLE"
#define MT_RR_HASH_TABLE	"MT_RR_HASH_TABLE"

/* attribute names for HASH_TABLE */
#define HASH_TABLE__att_keys	"att_keys"
#define HASH_TABLE__att_values	"att_values"
#define HASH_TABLE__properties_type	"properties_type"

/* A sample of reference type for HASH_TABLE */
#define HT_REFERENCE_TYPE	"STRING" 

#define DTYPE(x)	((uint32) (x) & SK_DTYPE)
#define DTYPE_GEN(x)	(rtud_inv[(uint32) (x) & SK_DTYPE])

#endif
