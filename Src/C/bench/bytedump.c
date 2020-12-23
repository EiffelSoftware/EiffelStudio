/*
	description: "Byte code reader."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2020, Eiffel Software."
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


#include <stdio.h>
#include "rt_interp.h"
#include "rt_bc_reader.h"
#include "rt_gen_types.h"
#include "eif_size.h"
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>

/*------------------------------------------------------------------*/

static  char    *names [] = {
"BC_START" ,
"BC_PRECOND" ,
"BC_POSTCOND" ,
"BC_DEFERRED" ,
"BC_REVERSE" ,
"BC_CHECK" ,
"BC_ASSERT" ,
"BC_NULL" ,
"BC_PRE" ,
"BC_PST" ,
"BC_CHK" ,
"BC_LINV" ,
"BC_LVAR" ,
"BC_INV" ,
"BC_END_ASSERT" ,
"BC_TAG" ,
"BC_NOTAG" ,
"BC_JMP_F" ,
"BC_JMP" ,
"BC_LOOP" ,
"BC_END_VARIANT" ,
"BC_INIT_VARIANT" ,
"BC_DEBUG" ,
"BC_RASSIGN" ,
"BC_LASSIGN" ,
"BC_ASSIGN" ,
"BC_CREATE" ,
"BC_START_SEPARATE" ,
"BC_END_SEPARATE" ,
"BC_NOTUSED_29" ,
"BC_NOTUSED_30" ,
"BC_CREATE_TYPE" ,
"BC_RANGE" ,
"BC_INSPECT_EXCEP" ,
"BC_LREVERSE" ,
"BC_RREVERSE" ,
"BC_FEATURE" ,
"BC_METAMORPHOSE" ,
"BC_CURRENT" ,
"BC_ROTATE" ,
"BC_FEATURE_INV" ,
"BC_ATTRIBUTE" ,
"BC_ATTRIBUTE_INV" ,
"BC_EXTERN" ,
"BC_EXTERN_INV" ,
"BC_CHAR" ,
"BC_BOOL" ,
"BC_INT32" ,
"BC_DOUBLE" ,
"BC_RESULT" ,
"BC_LOCAL" ,
"BC_ARG" ,
"BC_UPLUS" ,
"BC_UMINUS" ,
"BC_NOT" ,
"BC_LT" ,
"BC_GT" ,
"BC_MINUS" ,
"BC_XOR" ,
"BC_GE" ,
"BC_EQ" ,
"BC_NE" ,
"BC_STAR" ,
"BC_POWER" ,
"BC_LE" ,
"BC_DIV" ,
"BC_NHOOK" ,
"BC_AND" ,
"BC_SLASH" ,
"BC_MOD" ,
"BC_PLUS" ,
"BC_OR" ,
"BC_ADDR" ,
"BC_STRING" ,
"BC_AND_THEN" ,
"BC_OR_ELSE" ,
"BC_SPCREATE" ,
"BC_TUPLE_ACCESS" ,
"BC_JMP_T" ,
"BC_TUPLE_ASSIGN" ,
"BC_RESCUE" ,
"BC_END_RESCUE" ,
"BC_RETRY" ,
"BC_EXP_ASSIGN" ,
"BC_CLONE" ,
"BC_EXP_EXCEP" ,
"BC_VOID" ,
"BC_NONE_ASSIGN" ,
"BC_LEXP_ASSIGN" ,
"BC_REXP_ASSIGN" ,
"BC_CLONE_ARG" ,
"BC_NO_CLONE_ARG" ,
"BC_FALSE_COMPAR" ,
"BC_TRUE_COMPAR" ,
"BC_STANDARD_EQUAL" ,
"BC_NOTUSED_95" ,
"BC_HOOK" ,
"BC_NOTUSED_97" ,
"BC_ARRAY" ,
"BC_RETRIEVE_OLD" ,
"BC_FLOAT" ,
"BC_OLD" ,
"BC_ADD_STRIP" ,
"BC_END_STRIP" ,
"BC_NOTUSED_104" ,
"BC_RAISE_PREC" ,
"BC_GOTO_BODY" ,
"BC_NOT_REC" ,
"BC_END_PRE" ,
"BC_CAST_NATURAL" ,
"BC_CAST_INTEGER" ,
"BC_CAST_REAL_32" ,
"BC_CAST_REAL_64" ,
"BC_INV_NULL" ,
"BC_SEPARATE" ,
"BC_END_EVAL_OLD" ,
"BC_START_EVAL_OLD" ,
"BC_OBJECT_ADDR" ,
"BC_NOTUSED_118" ,
"BC_NOTUSED_119" ,
"BC_NOTUSED_120" ,
"BC_NOTUSED_121" ,
"BC_NOTUSED_122" ,
"BC_NOTUSED_123" ,
"BC_NOTUSED_124" ,
"BC_NOTUSED_125" ,
"BC_NOTUSED_126" ,
"BC_NOTUSED_127" ,
"BC_NOTUSED_128" ,
"BC_OBJECT_EXPR_ADDR" ,
"BC_RESERVE" ,
"BC_POP" ,
"BC_REF_TO_PTR" ,
"BC_RCREATE" ,
"BC_BUILTIN" ,
"BC_CAST_CHAR32" ,
"BC_NULL_POINTER" ,
"BC_BASIC_OPERATIONS" ,
"BC_INT_BIT_OP" ,
"BC_WCHAR" ,
"BC_INT8" ,
"BC_INT16" ,
"BC_INT64" ,
"BC_CAST_CHAR8" ,
"BC_ONCE_STRING" ,
"BC_ALLOCATE_ONCE_STRINGS" ,
"BC_CCLONE" ,
"BC_CEQUAL" ,
"BC_OBJECT_TEST" ,
"BC_BOX" ,
"BC_UINT8" ,
"BC_UINT16" ,
"BC_UINT32" ,
"BC_UINT64" ,
"BC_FLOOR" ,
"BC_CEIL" ,
"BC_CATCALL" ,
"BC_START_CATCALL" ,
"BC_END_CATCALL" ,
"BC_IS_ATTACHED_ATTRIBUTE" ,
"BC_SPECIAL_EXTEND" ,
"BC_NOTUSED_161" ,
"BC_NOTUSED_162" ,
"BC_GUARD" ,
"BC_CREATION" ,
"BC_NOTUSED_165" ,
"BC_WAIT_ARG" ,
"BC_TUPLE_CATCALL" ,
"BC_TUPLE",
"BC_NOTUSED_169",
"BC_STRING32",
"BC_ONCE_STRING32",
"BC_TRY",
"BC_TRY_END",
"BC_TRY_END_EXCEPT",
"BC_DO_RESCUE",
"BC_DO_RESCUE_END",
"BC_POSTFAIL",
"BC_NOTUSED_178",
"BC_NOTUSED_179",
"BC_NOTUSED_180",
"BC_NOTUSED_181",
"BC_NOTUSED_182",
"BC_NOTUSED_183",
"BC_NOTUSED_184",
"BC_NOTUSED_185",
"BC_NOTUSED_186",
"BC_NOTUSED_187",
"BC_NOTUSED_188",
"BC_NOTUSED_189",
"BC_NOTUSED_190",
"BC_NOTUSED_191",
"BC_NOTUSED_192",
"BC_NOTUSED_193",
"BC_NOTUSED_194",
"BC_NOTUSED_195",
"BC_NOTUSED_196",
"BC_NOTUSED_197",
"BC_NOTUSED_198",
"BC_NOTUSED_199",
 (char *) 0
};

static  char    *builtin_op_names [] = {
"",
"BC_BUILTIN_UNKNOWN" ,
"BC_BUILTIN_TYPE__HAS_DEFAULT" ,
"BC_BUILTIN_TYPE__DEFAULT" ,
"BC_BUILTIN_TYPE__TYPE_ID" ,
"BC_BUILTIN_TYPE__RUNTIME_NAME__S1" ,
"BC_BUILTIN_TYPE__GENERIC_PARAMETER_TYPE" ,
"BC_BUILTIN_TYPE__GENERIC_PARAMETER_COUNT",
"BC_BUILTIN_TYPE__IS_ATTACHED",
"BC_BUILTIN_TYPE__IS_DEFERRED",
"BC_BUILTIN_TYPE__IS_EXPANDED",
"BC_BUILTIN_TYPE__RUNTIME_NAME__S4" ,
};


static  char    *basic_op_names [] = {
"",
"BC_MAX" ,
"BC_MIN" ,
"BC_GENERATOR__S1" ,
"BC_OFFSET" ,
"BC_ZERO" ,
"BC_ONE",
"BC_THREE_WAY_COMPARISON",
"BC_IS_NAN",
"BC_IS_NEGATIVE_INFINITY",
"BC_IS_POSITIVE_INFINITY",
"BC_NAN",
"BC_NEGATIVE_INFINITY",
"BC_POSITIVE_INFINITY",
"BC_GENERATOR__S4" ,
};

static  char    *bit_op_names [] = {
"",
"BC_INT_BIT_AND" ,
"BC_INT_BIT_OR" ,
"BC_INT_BIT_XOR" ,
"BC_INT_BIT_NOT" ,
"BC_INT_BIT_SHIFT_LEFT" ,
"BC_INT_BIT_SHIFT_RIGHT" ,
"BC_INT_BIT_TEST" ,
"BC_INT_SET_BIT" ,
"BC_INT_SET_BIT_WITH_MASK" ,
};

/*------------------------------------------------------------------*/

#define NEWL            fprintf (ofp,"\n")

/*------------------------------------------------------------------*/

static  size_t          fpos;
static  char            *byte_path;
static  FILE            *ifp, *ofp;
static  unsigned char   *body;
static  BODY_INDEX      body_id;
static  long            body_size;
static  unsigned char   *ip;
static  unsigned char   code;
static  EIF_CHARACTER_8 **dtype_names;
static  int             dtype_max;
static  EIF_CHARACTER_8 **ctype_names;
static  int             ctype_max;

/*------------------------------------------------------------------*/

static  void    read_byte_code (void);
static  void    print_byte_code (void);
static  void    print_instructions (void);
static  void    print_dtype (int, uint32);
static  void    print_ctype (short);
static  void    print_cid (void);
static  void    advance (int);
static  void    panic (void);

/*------------------------------------------------------------------*/

static  EIF_INTEGER_32 rlong (void);
static  BODY_INDEX rbody_index (void);
static  unsigned char *rbuf (int);
static  EIF_CHARACTER_8 * rstr (void);

/*------------------------------------------------------------------*/

int main (int argc, char **argv)
{
	long    i;
	int done;

	if (argc > 1)
	{
		byte_path = argv [1];
	}
	else
	{
		byte_path = "bytecode.eif";
	}

	ifp = ofp = (FILE *) 0;

	if ((ifp = fopen (byte_path, "rb")) == (FILE *) 0)
	{
		printf ("Cannot open file <%s>\n", byte_path);
		panic ();
	}

	if ((ofp = fopen ("bytecode.txt", "wb")) == (FILE *) 0)
	{
		printf ("Cannot open file <%s>\n", "bytecode.txt");
		panic ();
	}

	fpos = 0;

	dtype_max = rlong ();

	dtype_names = (EIF_CHARACTER_8 **) malloc ((dtype_max + 1) * sizeof (char *));

	if (dtype_names == NULL)
	{
		fprintf (stderr, "Out of memory\n");
		panic ();
	}

	for (i = 0; i <= dtype_max; ++i)
	{
		dtype_names [i] = rstr ();
	}

	ctype_max = rlong ();

	ctype_names = (EIF_CHARACTER_8 **) malloc ((ctype_max + 1) * sizeof (char *));

	if (ctype_names == NULL)
	{
		fprintf (stderr, "Out of memory\n");
		panic ();
	}

	for (i = 0; i <= ctype_max; ++i)
	{
		ctype_names [i] = rstr ();
	}

	done = 1;
	while (done)
	{
		read_byte_code ();

		if (body_id != INVALID_ID) {
			print_byte_code ();
		} else {
			done = 0;
		}
	}

	fclose (ifp);
	fclose (ofp);

	printf ("File \"bytecode.txt\" generated\n");

	return 0;
}
/*------------------------------------------------------------------*/

static  void    read_byte_code (void)

{
	body_id = rbody_index ();

	if (body_id == INVALID_ID)
		return;

	body_size = rlong ();

	body      = rbuf ((int) body_size);
}
/*------------------------------------------------------------------*/

static  void    print_byte_code (void)

{
	uint32  rtype;  /* Type of routine */
	uint32    rid;    /* Routine id      */
	char    rescue; /* Has rescue?     */
	int     i;
	uint32 argnum;
	uint32 n;
	EIF_NATURAL_8   once_mark;
	BODY_INDEX	once_key;
	uint32 once_end_break_index;				/* Index in once table */

	ip = body;

	once_mark = get_uint8(&ip);  /* Once mark */
	once_key = 0;
	once_end_break_index = 0;

	switch (once_mark)
	{
	case ONCE_MARK_THREAD_RELATIVE:
	case ONCE_MARK_PROCESS_RELATIVE:
		once_key = get_int32(&ip);     /* Once index. */
		once_end_break_index = get_uint32(&ip);		/* break index of end statement */
		break;
	case ONCE_MARK_OBJECT_RELATIVE:
		once_end_break_index = get_uint32(&ip);		/* break index of end statement */
		break;
	}

	advance (1);

	NEWL;

	rid = get_int32(&ip);
	fprintf (ofp,"Routine Id   : %d\n", rid);

	body_id = get_uint32(&ip);
	fprintf (ofp,"Body Id      : %d\n", body_id);

	rtype = get_uint32(&ip);

	argnum = get_uint16(&ip);

	fprintf (ofp,"Nr. args     : %d\n", argnum);

	switch (once_mark)
	{
	case ONCE_MARK_THREAD_RELATIVE:
		fprintf (ofp,"Once routine : thread-relative (%u)\n", once_key);
		break;
	case ONCE_MARK_PROCESS_RELATIVE:
		fprintf (ofp,"Once routine : process-relative (%u)\n", once_key);
		break;
	case ONCE_MARK_OBJECT_RELATIVE:
		fprintf (ofp,"Once routine : object-relative (end_bp=%u)\n", once_end_break_index);
		break;
	case ONCE_MARK_ATTRIBUTE:
		fprintf (ofp,"Attribute\n");
		break;
	}

	i = (int) get_int16(&ip);

	fprintf (ofp,"Nr. locals   : %d\n", i);

	while (i--)
	{
		/* Types of locals - always provided */

		fprintf (ofp,"  Type : ");
		print_dtype (1,get_uint32(&ip));
		NEWL;
	}

	/* Arguments which must be cloned or initialized */

	for (n = 1; n <= argnum; n++) {
		fprintf (ofp,"arg%d: ", (int) n);
		switch (get_uint8 (&ip)) {
		case EIF_EXPANDED_CODE_EXTENSION:
			print_cid ();
			break;
		case EIF_REFERENCE_CODE:
			fprintf (ofp,"REFERENCE");
			break;
		case EIF_BOOLEAN_CODE:
			fprintf (ofp,"BOOLEAN");
			break;
		case EIF_CHARACTER_8_CODE:
			fprintf (ofp,"CHARACTER_8");
			break;
		case EIF_REAL_64_CODE:
			fprintf (ofp,"REAL_64");
			break;
		case EIF_REAL_32_CODE:
			fprintf (ofp,"REAL_32");
			break;
		case EIF_POINTER_CODE:
			fprintf (ofp,"POINTER");
			break;
		case EIF_INTEGER_8_CODE:
			fprintf (ofp,"INTEGER_8");
			break;
		case EIF_INTEGER_16_CODE:
			fprintf (ofp,"INTEGER_16");
			break;
		case EIF_INTEGER_32_CODE:
			fprintf (ofp,"INTEGER_32");
			break;
		case EIF_INTEGER_64_CODE:
			fprintf (ofp,"INTEGER_64");
			break;
		case EIF_NATURAL_8_CODE:
			fprintf (ofp,"NATURAL_8");
			break;
		case EIF_NATURAL_16_CODE:
			fprintf (ofp,"NATURAL_16");
			break;
		case EIF_NATURAL_32_CODE:
			fprintf (ofp,"NATURAL_32");
			break;
		case EIF_NATURAL_64_CODE:
			fprintf (ofp,"NATURAL_64");
			break;
		case EIF_CHARACTER_32_CODE:
			fprintf (ofp,"CHARACTER_32");
			break;
		}
		NEWL;
	}

	fprintf (ofp,"Result Type  : ");
	if ((rtype & SK_HEAD) == SK_EXP)
		print_dtype (1, rtype);
	else
		print_dtype (0, rtype);

	NEWL;

	/* If the routine id is zero it's a class invariant
	 * but we get anyway the name and type */

	fprintf (ofp,"Routine name : %s\n", get_string8(&ip, -1));
	fprintf (ofp,"Written      : %d\n", (int) get_int16(&ip));

	/* Offset of rescue clause - if any */

	rescue = get_bool(&ip);
	if (rescue)
	{
		fprintf (ofp,"Rescue offset: %d\n", get_int32(&ip));
	}

	print_instructions ();

	if (rescue)
	{
		fprintf (ofp,"Rescue clause:\n");
		print_instructions ();
	}

	fprintf (ofp,"\n----------------------------\n");

	free (body);
}
/*------------------------------------------------------------------*/

static  void    advance (int where)

{
	code   = *((unsigned char *) ip);

	if (((int) code) > MAX_CODE) {
		fprintf (stderr, "Illegal byte code : %d (%d)\n", (int) code, where);
		panic ();
	}

	fprintf (ofp, "%4d: %s ", (int) (ip-body), names [(int)(code)]);

	ip    += sizeof (char);
}
/*------------------------------------------------------------------*/

static  void    print_instructions (void)

{
	unsigned char   cval; /* !!! */
	uint32            lval;
	int16 l_type;

	advance (4);

	while ((code != BC_NULL)     &&
		   (code != BC_INV_NULL) &&
		   (code != BC_END_RESCUE) &&
		   (code != BC_TRY_END) &&
		   (code != BC_TRY_END_EXCEPT) &&
		   (code != BC_DO_RESCUE_END))
	{
		switch (code)
		{
/* Assertions */

			case  BC_ASSERT :
				/* Type of assertion */
				fprintf (ofp,"<%d, ", (int) get_char8(&ip));
				/* Type of tag */
				cval = get_char8(&ip);
				fprintf (ofp,"%d>", (int) cval);

				if (cval == BC_TAG)
					fprintf (ofp," : \"%s\"", get_string8(&ip, -1));
				break;
			case  BC_END_ASSERT :
				if (!get_bool(&ip)) {
					fprintf (ofp," guard");
				}
				break;
			case  BC_CHECK :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %d ", get_int32(&ip));
				break;
			case  BC_INIT_VARIANT :
				/* Index of local used in variant expression */
				fprintf (ofp,"local %d", (int) get_int16(&ip));
				break;
			case  BC_END_VARIANT :
				/* Index of local used in variant expression */
				fprintf (ofp,"local %d", (int) get_int16(&ip));
				break;
			case  BC_DEBUG :
				/* Nr. of debug keys */

				fprintf (ofp,"nr_keys %d ", (lval = get_int32(&ip)));

				/* The keys - if any */

				while (lval--)
				{
					fprintf (ofp,"\"%s\"", get_string8(&ip, get_int32(&ip)));

					if (lval)
						fprintf (ofp, ", ");
				}

				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;
			case  BC_PRECOND :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;
			case  BC_END_PRE :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;
			case  BC_POSTCOND :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;

			case BC_START_CATCALL:
			case BC_END_CATCALL:
				break;
			case BC_CATCALL :
				print_cid();
					/* Annotations. */
				fprintf (ofp, " with annotations 0x%X", (int) get_int16(&ip));
					/* Static type of class */
				print_ctype (get_int16(&ip));
				fprintf (ofp, ".%s", get_string8(&ip, get_int32(&ip)));
				fprintf (ofp, " @ %d", get_int32(&ip));
				break;

			case BC_TUPLE_CATCALL :
					/* Static type of class */
				print_ctype (get_int16(&ip));
				fprintf (ofp, ".%s", get_string8(&ip, get_int32(&ip)));
				fprintf (ofp, " @ %d", get_int32(&ip));
				break;

			case  BC_LOOP :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;

/* Assignments */

			case  BC_RASSIGN :
				/* Assignment to 'Result' */
				break;
			case  BC_REXP_ASSIGN :
				/* Assignment to 'Result' (expanded) */
				break;
			case  BC_LASSIGN :
				/* Local index */
				fprintf (ofp," %d", (int) get_int16(&ip));
				break;
			case  BC_LEXP_ASSIGN :
				/* Local index */
				fprintf (ofp," %d", (int) get_int16(&ip));
				break;
			case  BC_ASSIGN :
			case  BC_EXP_ASSIGN :
				/* Attribute */
				/* Routine id */
				fprintf (ofp,"rid %d ", get_int32(&ip));
				/* Meta-type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_NONE_ASSIGN :
				break;
			case  BC_RREVERSE :
				/* Reverse assignment to 'Result' */
				/* Static type of target */
				print_cid();
				break;
			case  BC_LREVERSE :
				/* Reverse assignment to a local */
				/* local index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				/* Static type of target */
				print_cid();
				break;
			case  BC_REVERSE :
				/* Attribute */
				/* Routine id */
				fprintf (ofp,"rid %d ", get_int32(&ip));
				/* Meta-type */
				print_dtype (0, get_uint32(&ip));
				/* Static type of target */
				print_cid ();
				break;
			case  BC_OBJECT_TEST :
				/* Object test */
				/* local index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				/* Static type of target */
				print_cid();
				break;
			case  BC_IS_ATTACHED_ATTRIBUTE :
				/* Test if attribute of `routine_id' is attached in current. */
				/* Routine id */
				fprintf (ofp,"rid %d ", get_int32(&ip));
				break;
/* Creation */
			case  BC_RCREATE:
				{
				int open_count;
				fprintf (ofp, " Has args:%d ", get_bool(&ip));
				print_cid ();
				fprintf (ofp, " Routine ID:%d ", get_int32(&ip));
				fprintf (ofp, " Is_basic:%d ", get_bool(&ip));
				fprintf (ofp, " Is_target_closed:%d ", get_bool(&ip));
				fprintf (ofp, " Written type id inline agent:%d ", get_int32(&ip));
				open_count = get_int32(&ip);
				fprintf (ofp, " Open_count: %d ", open_count);

				break;
				}

			case BC_CREATE :
			case BC_CREATE_TYPE:
				{
					int is_type_creation = (code == BC_CREATE_TYPE);

						/* Do we need to duplicate top object? */
					cval = get_char8(&ip);

					if (cval == (char) 1) {
						fprintf (ofp," dup_top_object ");
					}

					print_cid ();

					if (is_type_creation) {
						EIF_TYPE_INDEX l_annotations = get_int16(&ip);
						fprintf (ofp, " with annotations %d", (int) l_annotations);
					}
				}
				break;

			case BC_SPCREATE:
				if (get_char8(&ip)) { fprintf (ofp, "make_filled"); }
				if (get_char8(&ip)) { fprintf (ofp, "make_empty"); }
				print_cid ();
				fprintf (ofp, " ");
					/* Read various flags about special we want to create. */
				if (get_char8(&ip)) {
					fprintf (ofp, "is_expanded of type %d", get_int16(&ip));
				} else {
						/* Read SK_XX type */
					get_uint32(&ip);
				}
				break;

			case  BC_ARRAY: /* Manifest array */
					/* Routine id ('make') */
				fprintf (ofp,"rid %d ", (int) get_int32(&ip));
				break;

			case BC_START_SEPARATE: /* Start of an inline separate instruction. */
				fprintf (ofp,"%d args", (int) get_uint16(&ip));
				break;

			case  BC_END_SEPARATE: /* End of an inline separate instruction. */
				break;

			case BC_SPECIAL_EXTEND:
				fprintf (ofp, "Index %d ", get_int32(&ip));
				break;

			case BC_TUPLE_ACCESS:
					/* Position of access/assign in TUPLE. */
				fprintf (ofp, "[%d] ", get_int32(&ip));
					/* Type of access/assign in TUPLE. */
				print_dtype(0, get_uint32(&ip));
				break;

			case BC_TUPLE_ASSIGN:
					/* Position of access/assign in TUPLE. */
				fprintf (ofp, "[%d] ", get_int32(&ip));
				break;

			case BC_TUPLE:
					/* Full dynamic typle of tuple */
				print_cid ();
					/* Number of elements in tuple */
				fprintf (ofp, " #%d ", get_int32(&ip));
					/* Is TUPLE atomic? */
				if (get_int32(&ip)) {
					fprintf (ofp, "Atomic ");
				}
				break;


			case  BC_CLONE :
			case  BC_CCLONE :
				break;

/* Calls */
			case  BC_SEPARATE :
				/* Separate feature call prefix */
				fprintf (ofp, "%d args", get_uint16(&ip));
				{
					EIF_NATURAL_8 scoop_call_flags = get_uint8 (&ip);
					if (scoop_call_flags & SCOOP_CALL_MASK_QUERY)
						fprintf (ofp, " query");
					else
						fprintf (ofp, " command");
					if (scoop_call_flags & SCOOP_CALL_MASK_ACTIVE_CREATION)
						fprintf (ofp, " active");
					else
						fprintf (ofp, " passive");
				}
				break;
			case  BC_EXTERN_INV :
				/* External with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
			case  BC_EXTERN :
				/* Routine id */
				fprintf (ofp,"rid %d ", get_int32(&ip));
				/* Is precursor or static */
				fprintf (ofp, "static call on type ID=%d", get_int16(&ip));
				break;

			case  BC_FEATURE_INV :
				/* Routine with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
			case  BC_FEATURE :
			case  BC_CREATION :
				/* Routine id */
				fprintf (ofp,"rid %d ", get_int32(&ip));
					/* Is precursor or static */
				l_type = get_int16(&ip);
				if (l_type != -1) {
					fprintf (ofp, " on target %d ", l_type);
				}
				break;

			case  BC_ATTRIBUTE_INV :
				/* Attribute with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
			case  BC_ATTRIBUTE :
				/* Attribute */
				/* Routine id */
				fprintf (ofp,"rid %d ", get_int32(&ip));
				/* Meta-type */
				print_dtype (0,get_uint32(&ip));
				break;

			case  BC_CURRENT :
				/* Access to current */
				break;
			case  BC_RESULT :
				/* Access to Result */
				break;
			case  BC_LOCAL :
				/* Access to local */
				/* Local index */
				fprintf (ofp,"%d", (int) get_int16(&ip));
				break;
			case  BC_ARG :
			case  BC_WAIT_ARG :
				/* Access to argument */
				/* Argument index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				break;

/* Casts */
			case  BC_CAST_INTEGER:
			case  BC_CAST_NATURAL :
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_CAST_CHAR8 :
			case  BC_CAST_CHAR32 :
			case  BC_CAST_REAL_32 :
			case  BC_CAST_REAL_64 :
				break;
			case  BC_METAMORPHOSE :
				break;
			case  BC_BOX :
					/* GENERIC CONFORMANCE */
				print_cid ();
				break;

			case  BC_REF_TO_PTR :
				break;

/* Exceptions */

			case  BC_EXP_EXCEP :
				break;
			case  BC_RAISE_PREC :
				break;
			case  BC_INSPECT_EXCEP :
				break;
			case  BC_POSTFAIL :
				break;
/* Operators */

			case  BC_AND_THEN :
				/* Jump offset */
				fprintf (ofp,"%d ", get_int32(&ip));
				break;
			case  BC_OR_ELSE :
				/* Jump offset */
				fprintf (ofp,"%d ", get_int32(&ip));
				break;

			case  BC_UPLUS :
				break;
			case  BC_UMINUS :
				break;
			case  BC_NOT :
				break;
			case BC_LT :
				break;
			case  BC_GT :
				break;
			case  BC_MINUS :
				break;
			case  BC_XOR :
				break;
			case  BC_GE :
				break;
			case  BC_EQ :
				break;
			case  BC_NE :
				break;
			case  BC_STAR :
				break;
			case  BC_POWER :
				break;
			case  BC_LE :
				break;
			case  BC_DIV :
				break;
			case  BC_AND :
				break;
			case  BC_SLASH :
				break;
			case  BC_MOD :
				break;
			case  BC_PLUS :
				break;
			case  BC_OR :
				break;
			case  BC_ADDR :
				/* Address of routine */
				/* id */
				fprintf (ofp,"%d ", get_int32(&ip));
				break;
			case  BC_OBJECT_ADDR :
				/* Address of object */
				/* Offset */
				fprintf (ofp,"%d ", get_uint32(&ip));
				break;
			case  BC_OBJECT_EXPR_ADDR :
				/* Address of expression */
				/* Pointer */
				fprintf (ofp,"%d ", get_uint32(&ip));
				/* Value */
				fprintf (ofp,"%d ", get_uint32(&ip));
				break;

			case BC_BUILTIN:
				/* For builtin operations. */
				fprintf (ofp, "%s", builtin_op_names[get_char8(&ip)]);
				break;

			case BC_BASIC_OPERATIONS :
				/* For basic operations such as min, max, generator.... */
				fprintf (ofp,"%s",basic_op_names[get_char8(&ip)]);
				break;


			case BC_INT_BIT_OP:
				/* For bit manipulations on INTEGERs */
				fprintf (ofp,"%s",bit_op_names[get_char8(&ip)]);
				break;

			case BC_FLOOR:
			case BC_CEIL:
				break;

/* Constants */

			case  BC_CHAR :
				fprintf (ofp,"%d", (int) get_char8(&ip));
				break;
			case BC_WCHAR:
				fprintf (ofp,"%d", (int) get_char32(&ip));
				break;
			case  BC_BOOL :
				fprintf (ofp,"%d", (int) get_char8(&ip));
				break;
			case BC_UINT8:
				fprintf(ofp, "%u", (int) get_char8(&ip));
				break;
			case BC_UINT16:
				fprintf (ofp, "%u", (int) get_int16(&ip));
				break;
			case BC_UINT32:
				fprintf (ofp,"%u", get_int32(&ip));
				break;
			case BC_UINT64:
				fprintf (ofp, "%" EIF_NATURAL_64_DISPLAY, get_uint64(&ip));
				break;
			case BC_INT8:
				fprintf(ofp, "%d", (int) get_char8(&ip));
				break;
			case BC_INT16:
				fprintf (ofp, "%d", (int) get_int16(&ip));
				break;
			case BC_INT32:
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case BC_INT64:
				fprintf (ofp, "%" EIF_INTEGER_64_DISPLAY, get_int64(&ip));
				break;
			case BC_ONCE_STRING:
				fprintf (ofp, "index %d, ", get_int32(&ip));
				fprintf (ofp, "number %d, ", get_int32(&ip));
				fprintf (ofp, "value \"%s\"", get_string8(&ip, get_int32(&ip)));
				break;
			case BC_ONCE_STRING32:
				fprintf (ofp, "index %d, ", get_int32(&ip));
				fprintf (ofp, "number %d, ", get_int32(&ip));
				fprintf (ofp, "value \"%s\"", get_string8(&ip, get_int32(&ip)));
				break;
			case BC_ALLOCATE_ONCE_STRINGS:
				fprintf (ofp, "index %d, ", get_int32(&ip));
				fprintf (ofp, "count %d", get_int32(&ip));
				break;
			case  BC_FLOAT :
				fprintf (ofp,"%f", get_real64(&ip));
				break;
			case  BC_DOUBLE :
				fprintf (ofp,"%f", get_real64(&ip));
				break;
			case  BC_NULL_POINTER :
				fprintf (ofp,"%d", 0);
				break;
			case  BC_STRING :
				fprintf (ofp,"\"%s\"", get_string8(&ip, get_int32(&ip)));
				break;
			case  BC_STRING32 :
				fprintf (ofp,"\"%s\"", get_string8(&ip, get_int32(&ip)));
				break;
			case  BC_VOID :
				break;
			case  BC_RETRY :
				/* Retry offset */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;
			case  BC_RANGE :
				/* When part of inspect. Jump offset */
				fprintf (ofp,"offset %d", get_int32(&ip));
				break;
			case  BC_RETRIEVE_OLD :
				/* Old expression */
				/* Local index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				/* Local index for exception object */
				fprintf (ofp,"%d", (int) get_int16(&ip));
				break;
			case  BC_OLD :
				/* Old expression */
				/* Local index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				/* Local index for exception */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				/* Start of next BC_OLD */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_START_EVAL_OLD :
				/* Offset if not enabled */
				fprintf (ofp,"%d ", get_int32(&ip));
				/* Start of next BC_OLD */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_END_EVAL_OLD :
				break;
			case  BC_ADD_STRIP :
				/* Attribute name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				break;
			case  BC_END_STRIP :
				/* Dynamic type */
				print_ctype (get_int16(&ip));
				/* Nr. of items */
				fprintf (ofp,"%d ", get_int32(&ip));
				break;
			case  BC_ROTATE :
				/* Rotate stack */
				/* Amount */
				fprintf (ofp,"%d", (int) get_int16(&ip));
				break;
			case  BC_STANDARD_EQUAL :
				break;
			case  BC_CEQUAL :
				break;
			case  BC_TRUE_COMPAR :
				break;
			case  BC_FALSE_COMPAR :
				break;
			case  BC_RESERVE :
				break;
			case  BC_POP :
				/* How many? */
				fprintf (ofp,"%d", get_uint32(&ip));
				break;
			case  BC_JMP_F :
				/* Jump offset */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_JMP_T :
				/* Jump offset */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_JMP :
				/* Jump offset */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_HOOK :
				/* For debugger */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_NHOOK :
				/* For debugger */
				fprintf (ofp,"%d,%d", get_int32(&ip), get_int32(&ip));
				break;
			case  BC_GOTO_BODY :
				/* Offset */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_DEFERRED :
				break;
			case  BC_RESCUE :
				break;
			case BC_TRY:
				{
					char    has_except_part; 
					has_except_part = get_bool(&ip);
					if (has_except_part) {
						NEWL;
						fprintf (ofp,"Try-Except offset: %d\n", get_int32(&ip));
					}
					print_instructions ();
					if (has_except_part) {
						fprintf (ofp,"Try-Except clause: start\n");
						print_instructions ();
						fprintf (ofp,"Try-Except clause: end");
					}
				}
				break;
			case BC_TRY_END:
					fprintf (ofp,"Try-End\n");
				break;
			case BC_TRY_END_EXCEPT:
					fprintf (ofp,"Try-End-Except\n");
				break;
			case BC_DO_RESCUE:
				{
					char    has_do_rescue; 
					has_do_rescue = get_bool(&ip);
					if (has_do_rescue) {
						NEWL;
						fprintf (ofp,"Do-Rescue offset: %d\n", get_int32(&ip));
					}
					print_instructions ();
					if (has_do_rescue) {
						fprintf (ofp,"Do-Rescue clause: start\n");
						print_instructions ();
						fprintf (ofp,"Do-Rescue clause: end");
					}
				}
				break;
			case BC_DO_RESCUE_END:
				break;

/* NOTE: Separate codes not included yet */

			default:
				fprintf (ofp,"%d: Illegal byte code %d\n", (int)(ip - body), (int) code);
				panic ();
		}

		NEWL;
		advance (5);
	}

	NEWL;
}
/*------------------------------------------------------------------*/

static  void    print_dtype (int cid, uint32 type)

{
	int     dtype;

	dtype = (int) (type & SK_DTYPE);

	if ((type & SK_HEAD) != SK_VOID)
	{
		switch (type & SK_HEAD)
		{
			case SK_BOOL:   fprintf (ofp," [BOOLEAN]"); break;
			case SK_CHAR8:   fprintf (ofp," [CHARACTER_8]"); break;
			case SK_CHAR32:   fprintf (ofp," [CHARACTER_32]"); break;
			case SK_UINT8:   fprintf (ofp," [NATURAL_8]"); break;
			case SK_UINT16:   fprintf (ofp," [NATURAL_16]"); break;
			case SK_UINT32:   fprintf (ofp," [NATURAL_32]"); break;
			case SK_UINT64:   fprintf (ofp," [NATURAL_64]"); break;
			case SK_INT8:   fprintf (ofp," [INTEGER_8]"); break;
			case SK_INT16:   fprintf (ofp," [INTEGER_16]"); break;
			case SK_INT32:   fprintf (ofp," [INTEGER_32]"); break;
			case SK_INT64:   fprintf (ofp," [INTEGER_64]"); break;
			case SK_REAL32:  fprintf (ofp," [REAL_32]"); break;
			case SK_REAL64: fprintf (ofp," [REAL_64]"); break;
			case SK_POINTER:fprintf (ofp," [POINTER]"); break;
			case SK_EXP:    fprintf (ofp,"ET %u", type & SK_DTYPE);

							if (dtype <= dtype_max)
								fprintf (ofp, " [%s]", dtype_names [dtype]);
							else
								fprintf (ofp, " [?]");

							if (cid)
								print_cid ();

							break;
			case SK_REF:    fprintf (ofp,"RT %u", type & SK_DTYPE);

							if (dtype <= dtype_max)
								fprintf (ofp, " [%s]", dtype_names [dtype]);
							else
								fprintf (ofp, " [?]");
							break;

			default    :    fprintf (stderr,"Illegal type\n");
							panic ();
		}
	} else {
		fprintf (ofp,"VOID");
	}
}

/*------------------------------------------------------------------*/

static  void    print_ctype (short type)

{
	if ((type >= 0) && (type <= ctype_max))
		fprintf (ofp, " [%d : %s]", (int) type, ctype_names [type]);
	else
		fprintf (ofp, " [%d : ?]", (int) type);
}
/*------------------------------------------------------------------*/

static  void    print_cid (void)

{
	short t;

	fprintf (ofp, "{");

	while ((t=get_int16(&ip)) != -1)
		fprintf (ofp, "%d (%04" PRIX16 "), ", (int) t, (int) t);

	fprintf (ofp, "-1}");
}
/*------------------------------------------------------------------*/

static BODY_INDEX rbody_index (void)
{
	BODY_INDEX result;

	fpos += sizeof (BODY_INDEX);

	if (fread (&result, sizeof (BODY_INDEX), 1, ifp) != 1)
	{
		printf ("Read error (EIF_INTEGER_32)\n");
		panic ();
	}

	return result;
}

static EIF_INTEGER_32 rlong (void)
{
	EIF_INTEGER_32 result;

	fpos += sizeof (EIF_INTEGER_32);

	if (fread (&result, sizeof (EIF_INTEGER_32), 1, ifp) != 1)
	{
		printf ("Read error (EIF_INTEGER_32)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  unsigned char *rbuf (int size)

{
	unsigned char    *result;

	fpos += size;

	result = malloc (size);

	if (!result) {
		printf ("Out of memory (rbuf)\n");
		panic ();
	}

	if (fread (result, sizeof (char), size, ifp) != (unsigned int)size)
	{
		printf ("Read error (rbuf)\n");
		free (result);
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  EIF_CHARACTER_8 * rstr (void)
{
	static char buf [1024];
	EIF_CHARACTER_8 * result;
	int i;
	EIF_CHARACTER_8 c;

	c = '?';
	i = 0;

	while (c != '\0')
	{
		if (fread (&c, sizeof (char), 1, ifp) != 1)
		{
			printf ("Read error (rstr)\n");
			panic ();
		}

		buf [i++] = c;
	}

	fpos += strlen (buf)+1;

	result = malloc (strlen (buf) + 1);

	if (result == NULL)
	{
		printf ("Out of memory (rbuf)\n");
		panic ();
	}

	memcpy (result, buf, strlen (buf) + 1);

	return result;
}
/*------------------------------------------------------------------*/

static  void    panic (void)

{
	if (ifp != (FILE *) 0)
		fclose (ifp);

	if (ofp != (FILE *) 0)
		fclose (ofp);

	printf ("********** Program aborted **********\n");

	exit (-1);
}
/*------------------------------------------------------------------*/

