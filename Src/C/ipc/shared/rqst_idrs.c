/*
	description: "Routines for Request Internal Data Representation."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "request.h"
#include "rqst_idrs.h"
#include "idrs_helpers.h"
#include <string.h>
#include "rt_assert.h"

/* We have to declare private routines before the declaration of the union
 * discriminent. Let's declare public routines as well...
 */

/* Initialization routines */

/* Internal (de)serialization */
rt_private bool_t idr_Opaque(IDR *idrs, void *ext);
rt_private bool_t idr_Acknlge(IDR *idrs, void *ext);
rt_private bool_t idr_Where(IDR *idrs, void *ext);
rt_private bool_t idr_Stop(IDR *idrs, void *ext);
rt_private bool_t idr_Dumped(IDR *idrs, void *ext);
rt_private bool_t idr_Item (IDR *idrs, EIF_TYPED_VALUE *ext);
rt_private bool_t idr_Notif(IDR *idrs, void *ext);
rt_private bool_t idr_void(IDR *idrs, void *ext);

struct idr_discrim {	/* Discrimination array for unions encoding */
	int id_value;		/* Value of union discriminent */
	bool_t (*id_fn)(IDR *, void *);	/* Function to call to serialize the union */
};

rt_private bool_t idr_union(IDR *idrs, int *type, char *unp, struct idr_discrim *arms);

/* This arrray records each serialization routine depending on the type of
 * the union request (field rq_type). The default arm routine is idr_void,
 * therefore only those requests which carry some other information are
 * listed hereafter.
 */
rt_private struct idr_discrim u_Request[] = {
	/*  0 */ { 0, idr_void},
	/*  1 */ { EIF_OPAQUE, idr_Opaque },
	/*  2 */ { ACKNLGE, idr_Acknlge },
	/*  3 */ { TRANSFER, idr_Opaque },
	/*  4 */ { HELLO, idr_void},
	/*  5 */ { STOPPED, idr_Stop },
	/*  6 */ { NOTIFIED, idr_Notif },
	/*  7 */ { INSPECT, idr_Opaque },
	/*  8 */ { DUMP_THREADS, idr_Opaque },
	/*  9 */ { DUMP_STACK, idr_Opaque },
	/* 10 */ { DUMP_VARIABLES, idr_Opaque },
	/* 11 */ { DUMPED, idr_Dumped },
	/* 12 */ { MOVE, idr_Opaque },
	/* 13 */ { BREAK, idr_Opaque },
	/* 14 */ { RESUME, idr_Opaque },
	/* 15 */ { QUIT, idr_void },
	/* 16 */ { CMD, idr_void },
	/* 17 */ { APPLICATION, idr_void },
	/* 18 */ { KPALIVE, idr_void },
	/* 19 */ { ASYNCMD, idr_void },
	/* 20 */ { ASYNACK, idr_void },
	/* 21 */ { DEAD, idr_void },
	/* 22 */ { LOAD, idr_Opaque },
	/* 23 */ { BYTECODE, idr_Opaque },
	/* 24 */ { KILL, idr_void },
	/* 25 */ { ADOPT, idr_Opaque },
	/* 26 */ { ACCESS, idr_Opaque },
	/* 27 */ { WEAN, idr_Opaque },
	/* 28 */ { ONCE, idr_Opaque },
	/* 29 */ { EWB_INTERRUPT, idr_void },
	/* 30 */ { APP_INTERRUPT, idr_void },
	/* 31 */ { INTERRUPT_OK, idr_void },
	/* 32 */ { INTERRUPT_NO, idr_void },
	/* 33 */ { SP_LOWER, idr_Opaque },
	/* 34 */ { METAMORPHOSE, idr_Opaque },
	/* 35 */ { APP_INTERRUPT_FLAG, idr_void },
	/* 36 */ { EWB_UPDBREAKPOINTS, idr_void },
	/* 37 */ { MODIFY_LOCAL, idr_Opaque },
	/* 38 */ { MODIFY_ATTR, idr_Opaque },
	/* 39 */ { DYNAMIC_EVAL, idr_Opaque },
	/* 40 */ { APPLICATION_CWD, idr_void },
	/* 41 */ { OVERFLOW_DETECT, idr_Opaque },
	/* 42 */ { CHANGE_THREAD, idr_Opaque },
	/* 43 */ { EWB_SET_ASSERTION_CHECK, idr_Opaque },
	/* 44 */ { CLOSE_DBG, idr_void },
	/* 45 */ { SET_IPC_PARAM, idr_Opaque },
	/* 46 */ { CLEAR_BREAKPOINTS, idr_void },
	/* 47 */ { LAST_EXCEPTION, idr_void },
	/* 48 */ { APPLICATION_ENV, idr_void },
	/* 49 */ { NEW_INSTANCE, idr_Opaque },
	/* 50 */ { RT_OPERATION, idr_Opaque },
	/* 51 */ { LAST_RTCC_INFO, idr_void },
};

/*
 * Public (de)serializing routine.
 */

rt_public bool_t idr_void(IDR *idrs, void *ext)
{
	return TRUE;
}

rt_public bool_t idr_Request(IDR *idrs, Request *ext)
{
	return idr_union(idrs, &ext->rq_type, (char *) (&ext->rqu), u_Request);
}

/*
 * Private encoding routines (one for each structure).
 */

rt_private bool_t idr_Opaque(IDR *idrs, void *ext)
{
	Opaque *opa = (Opaque *) ext;
	return idr_int(idrs, &opa->op_type) &&
			idr_int(idrs, &opa->op_cmd) &&
			idr_rt_uint_ptr(idrs, &opa->op_size) &&
			idr_int(idrs, &opa->op_info);
}

rt_private bool_t idr_Acknlge(IDR *idrs, void *ext)
{
	return idr_int(idrs, &((Acknlge *)ext)->ak_type);
}

rt_private bool_t idr_Where(IDR *idrs, void *ext)
{
	/* Arnaud: I've replaced MAX_STRLEN with MAX_FEATURE_NAME to avoid a bug
	 * in the debugger with feature with a 'long' name (>MAX_STRLEN chars)
	 */
	Where *whe = (Where *) ext;
	bool_t result;
	static char buf[MAX_FEATURE_LEN + 1];

	if (idrs->i_op == IDR_DECODE) {
		buf[0]='\0';
		whe->wh_name = buf;
	}
	result = idr_string(idrs, &whe->wh_name, -MAX_FEATURE_LEN);
	result = result && idr_rt_uint_ptr(idrs, &whe->wh_obj);
	result = result && idr_int(idrs, &whe->wh_origin);
	result = result && idr_int(idrs, &whe->wh_type);
	result = result && idr_int(idrs, &whe->wh_offset);
	result = result && idr_rt_uint_ptr(idrs, &whe->wh_thread_id);

	return result;
}

rt_private bool_t idr_Stop(IDR *idrs, void *ext)
{
	Stop *sto = (Stop *) ext;
	bool_t result;
	result = idr_Where(idrs, &sto->st_where);
	result = result && idr_int(idrs, &sto->st_why);
	result = result && idr_int(idrs, &sto->st_exception);
	return result;
}

rt_private bool_t idr_Notif(IDR *idrs, void *ext)
{
	Notif *not = (Notif *) ext;
	bool_t result;
	result = idr_int(idrs, &not->st_type);
	result = result && idr_int(idrs, &not->st_data);
	return result;
}

rt_private bool_t idr_Dumped (IDR *idrs, void *ext)
{
	Dump *dum = (Dump *)ext;
	static struct ex_vect *last_exv;
	static EIF_TYPED_VALUE *last_exi;
	struct ex_vect *exv;
	EIF_TYPED_VALUE *exi;

	if (!idr_int (idrs, &dum->dmp_type))
		return FALSE;
	switch (dum -> dmp_type) {
	case DMP_VECT:
	case DMP_MELTED:
		exv = dum -> dmpu.dmpu_vect;
		if ((exv != last_exv) && (last_exv)) {
			free(last_exv);
			last_exv = NULL;
		}
		if (!exv){
			exv = (struct ex_vect *) malloc (sizeof (struct ex_vect));
			last_exv = exv;
			memset  (exv, 0, sizeof (struct ex_vect));
			dum -> dmpu.dmpu_vect = exv;
		}
		if ((!exv) ||
			(! (idr_unsigned_char (idrs, &exv->ex_type)
			&& idr_unsigned_char (idrs, &exv->ex_retry)
			&& idr_unsigned_char (idrs, &exv->ex_rescue)))) {
			return FALSE;
		}
		switch (exv->ex_type) {
		case EX_RESC:
		case EX_RETY:
		case EX_CALL:
			return idr_eif_reference (idrs, &exv->exu.exur.exur_id)
				&& idr_string (idrs, &exv->exu.exur.exur_rout, -MAX_FEATURE_LEN)
				&& idr_type_index (idrs, &exv -> exu.exur.exur_orig)
				&& idr_type_index (idrs, &exv -> exu.exur.exur_dtype)
				&& idr_int (idrs, &exv->ex_linenum);
		default:
			return idr_string (idrs, &exv->exu.exua.exua_name, -MAX_STRLEN)
				&& idr_string (idrs, &exv->exu.exua.exua_where, -MAX_STRLEN)
				&& idr_type_index (idrs, &exv->exu.exua.exua_from)
				&& idr_eif_reference (idrs, &exv->exu.exua.exua_oid);
		}
	case DMP_EXCEPTION_ITEM:
	case DMP_ITEM:
		exi = dum->dmpu.dmpu_item;
		if ((exi != last_exi) && (last_exi)) {
			free(last_exi);
			last_exi = NULL;
		}
		if (!exi) {
			exi = (EIF_TYPED_VALUE *) malloc (sizeof (EIF_TYPED_VALUE));
			last_exi = exi;
			memset (exi, 0, sizeof (EIF_TYPED_VALUE));
			dum->dmpu.dmpu_item = exi;
		}
		if (!exi) {
			return FALSE; /* lack of memory. Abort */
		}
		return idr_Item (idrs, exi);
	case DMP_OBJ:
		return 1;
	case DMP_VOID:
		return 1;
	}
	return 0; /* not a proper dumped */
}


rt_private bool_t idr_Item (IDR *idrs, EIF_TYPED_VALUE *ext)
{
	if (idrs->i_op == IDR_ENCODE) {
		memcpy (idrs->i_ptr, &ext->type, sizeof(EIF_INTEGER_32));
		idrs->i_ptr += sizeof(EIF_INTEGER_32);

		switch (ext -> type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR:
			memcpy (idrs->i_ptr, &ext->it_char, sizeof(EIF_CHARACTER));
			idrs->i_ptr += sizeof(EIF_CHARACTER);
			return TRUE;
		case SK_WCHAR:
			memcpy (idrs->i_ptr, &ext->it_wchar, sizeof(EIF_WIDE_CHAR));
			idrs->i_ptr += sizeof(EIF_WIDE_CHAR);
			return TRUE;
		case SK_UINT8:
			memcpy (idrs->i_ptr, &ext->it_uint8, sizeof(EIF_NATURAL_8));
			idrs->i_ptr += sizeof(EIF_NATURAL_8);
			return TRUE;
		case SK_UINT16:
			memcpy (idrs->i_ptr, &ext->it_uint16, sizeof(EIF_NATURAL_16));
			idrs->i_ptr += sizeof(EIF_NATURAL_16);
			return TRUE;
		case SK_UINT32:
			memcpy (idrs->i_ptr, &ext->it_uint32, sizeof(EIF_NATURAL_32));
			idrs->i_ptr += sizeof(EIF_NATURAL_32);
			return TRUE;
		case SK_UINT64:
			memcpy (idrs->i_ptr, &ext->it_uint64, sizeof(EIF_NATURAL_64));
			idrs->i_ptr += sizeof(EIF_NATURAL_64);
			return TRUE;
		case SK_INT8:
			memcpy (idrs->i_ptr, &ext->it_int8, sizeof(EIF_INTEGER_8));
			idrs->i_ptr += sizeof(EIF_INTEGER_8);
			return TRUE;
		case SK_INT16:
			memcpy (idrs->i_ptr, &ext->it_int16, sizeof(EIF_INTEGER_16));
			idrs->i_ptr += sizeof(EIF_INTEGER_16);
			return TRUE;
		case SK_INT32:
			memcpy (idrs->i_ptr, &ext->it_int32, sizeof(EIF_INTEGER_32));
			idrs->i_ptr += sizeof(EIF_INTEGER_32);
			return TRUE;
		case SK_INT64:
			memcpy (idrs->i_ptr, &ext->it_int64, sizeof(EIF_INTEGER_64));
			idrs->i_ptr += sizeof(EIF_INTEGER_64);
			return TRUE;
		case SK_REAL32:
			memcpy (idrs->i_ptr, &ext->it_real32, sizeof(EIF_REAL_32));
			idrs->i_ptr += sizeof(EIF_REAL_32);
			return TRUE;
		case SK_REAL64:
			memcpy (idrs->i_ptr, &ext->it_real64, sizeof(EIF_REAL_64));
			idrs->i_ptr += sizeof(EIF_REAL_64);
			return TRUE;
		case SK_POINTER:
			memcpy (idrs->i_ptr, &ext->it_ptr, sizeof(EIF_POINTER));
			idrs->i_ptr += sizeof(EIF_POINTER);
			return TRUE;
		case SK_BIT:
			return idr_eif_reference (idrs, (&ext->it_bit));
		case SK_STRING:
			return idr_string (idrs, &ext->it_ref, 0); /* 0 = no limit */
		default:
			return idr_eif_reference (idrs, &ext->it_ref);
		}
	} else {
		memcpy (&ext->type, idrs->i_ptr, sizeof(EIF_INTEGER_32));
		idrs->i_ptr += sizeof(EIF_INTEGER_32);

		switch (ext -> type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR:
			memcpy (&ext->it_char, idrs->i_ptr, sizeof(EIF_CHARACTER));
			idrs->i_ptr += sizeof(EIF_CHARACTER);
			return TRUE;
		case SK_WCHAR:
			memcpy (&ext->it_wchar, idrs->i_ptr, sizeof(EIF_WIDE_CHAR));
			idrs->i_ptr += sizeof(EIF_WIDE_CHAR);
			return TRUE;
		case SK_UINT8:
			memcpy (&ext->it_uint8, idrs->i_ptr, sizeof(EIF_NATURAL_8));
			idrs->i_ptr += sizeof(EIF_NATURAL_8);
			return TRUE;
		case SK_UINT16:
			memcpy (&ext->it_uint16, idrs->i_ptr, sizeof(EIF_NATURAL_16));
			idrs->i_ptr += sizeof(EIF_NATURAL_16);
			return TRUE;
		case SK_UINT32:
			memcpy (&ext->it_uint32, idrs->i_ptr, sizeof(EIF_NATURAL_32));
			idrs->i_ptr += sizeof(EIF_NATURAL_32);
			return TRUE;
		case SK_UINT64:
			memcpy (&ext->it_uint64, idrs->i_ptr, sizeof(EIF_NATURAL_64));
			idrs->i_ptr += sizeof(EIF_NATURAL_64);
			return TRUE;
		case SK_INT8:
			memcpy (&ext->it_int8, idrs->i_ptr, sizeof(EIF_INTEGER_8));
			idrs->i_ptr += sizeof(EIF_INTEGER_8);
			return TRUE;
		case SK_INT16:
			memcpy (&ext->it_int16, idrs->i_ptr, sizeof(EIF_INTEGER_16));
			idrs->i_ptr += sizeof(EIF_INTEGER_16);
			return TRUE;
		case SK_INT32:
			memcpy (&ext->it_int32, idrs->i_ptr, sizeof(EIF_INTEGER_32));
			idrs->i_ptr += sizeof(EIF_INTEGER_32);
			return TRUE;
		case SK_INT64:
			memcpy (&ext->it_int64, idrs->i_ptr, sizeof(EIF_INTEGER_64));
			idrs->i_ptr += sizeof(EIF_INTEGER_64);
			return TRUE;
		case SK_REAL32:
			memcpy (&ext->it_real32, idrs->i_ptr, sizeof(EIF_REAL_32));
			idrs->i_ptr += sizeof(EIF_REAL_32);
			return TRUE;
		case SK_REAL64:
			memcpy (&ext->it_real64, idrs->i_ptr, sizeof(EIF_REAL_64));
			idrs->i_ptr += sizeof(EIF_REAL_64);
			return TRUE;
		case SK_POINTER:
			memcpy (&ext->it_ptr, idrs->i_ptr, sizeof(EIF_POINTER));
			idrs->i_ptr += sizeof(EIF_POINTER);
			return TRUE;
		case SK_BIT:
			return idr_eif_reference (idrs, &ext->it_bit);
		case SK_STRING:
			return idr_string (idrs, &ext->it_ref, 0); /* 0 = no limit */
		default:
			return idr_eif_reference (idrs, &ext->it_ref);
		}
	}
}


rt_private bool_t idr_union(IDR *idrs, int *type, char *unp, struct idr_discrim *arms)
          					/* The serializing stream */
          					/* Union discriminent, serialized in the process */
          					/* Pointer to the start of the union */
                         	/* Null terminated array to deal with union arms */
{
	/* Serialization of an union, based on the contents of the union's type
	 * which is an integer. Depending on the value of this disciminent, the
	 * correct basic serialization routine is called to serialize the right
	 * component. If the type is not found in the arms array, then the default
	 * arm routine is called if not nulled (otherwise this makes the routine
	 * fail immediately).
	 */

	register int l_type;

	if (!idr_int(idrs, type)) {
		return FALSE;
	}

	l_type = *type;

	if ((l_type >= 1) && (l_type <= MAX_REQUEST_TYPE)) {
		CHECK("Valid type", arms[l_type].id_value == l_type);
		return (arms[l_type].id_fn)(idrs, unp);
	} else {
		return TRUE;
	}
}
