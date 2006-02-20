/*
	description: "Byte code reader."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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
#include "eif_size.h"
#include <string.h>
#include <stdlib.h>

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
"BC_CTYPE" ,
"BC_CARG" ,
"BC_CLIKE" ,
"BC_CCUR" ,
"BC_INSPECT" ,
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
"BC_NOTUSED_77" ,
"BC_JMP_T" ,
"BC_NOTUSED_79" ,
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
"BC_BIT_STD_EQUAL" ,
"BC_HOOK" ,
"BC_BIT" ,
"BC_ARRAY" ,
"BC_RETRIEVE_OLD" ,
"BC_FLOAT" ,
"BC_OLD" ,
"BC_ADD_STRIP" ,
"BC_END_STRIP" ,
"BC_LBIT_ASSIGN" ,
"BC_RAISE_PREC" ,
"BC_GOTO_BODY" ,
"BC_NOT_REC" ,
"BC_END_PRE" ,
"BC_CAST_NATURAL" ,
"BC_CAST_INTEGER" ,
"BC_CAST_REAL_32" ,
"BC_CAST_REAL_64" ,
"BC_INV_NULL" ,
"BC_CREAT_INV" ,
"BC_END_EVAL_OLD" ,
"BC_START_EVAL_OLD" ,
"BC_OBJECT_ADDR" ,
"BC_PFEATURE" ,
"BC_PFEATURE_INV" ,
"BC_PEXTERN" ,
"BC_PEXTERN_INV" ,
"BC_PARRAY" ,
"BC_PATTRIBUTE" ,
"BC_PATTRIBUTE_INV" ,
"BC_PEXP_ASSIGN" ,
"BC_PASSIGN" ,
"BC_PREVERSE" ,
"BC_PCLIKE" ,
"BC_OBJECT_EXPR_ADDR" ,
"BC_RESERVE" ,
"BC_POP" ,
"BC_REF_TO_PTR" ,
"BC_RCREATE" ,
"BC_GEN_PARAM_CREATE" ,
"BC_NOTUSED_135" ,
"BC_NULL_POINTER" ,
"BC_BASIC_OPERATIONS" ,
"BC_INT_BIT_OP" ,
"BC_WCHAR" ,
"BC_INT8" ,
"BC_INT16" ,
"BC_INT64" ,
"BC_CAST_CHAR" ,
"BC_ONCE_STRING" ,
"BC_ALLOCATE_ONCE_STRINGS" ,
"BC_NOTUSED_146" ,
"BC_NOTUSED_147" ,
"BC_NOTUSED_148" ,
"BC_NOTUSED_149" ,
"BC_UINT8" ,
"BC_UINT16" ,
"BC_UINT32" ,
"BC_UINT64" ,
"BC_NOTUSED_154" ,
"BC_NOTUSED_155" ,
"BC_NOTUSED_156" ,
"BC_NOTUSED_157" ,
"BC_NOTUSED_158" ,
"BC_NOTUSED_159" ,
"BC_NOTUSED_160" ,
"BC_NOTUSED_161" ,
"BC_NOTUSED_162" ,
"BC_NOTUSED_163" ,
"BC_NOTUSED_164" ,
"BC_NOTUSED_165" ,
"BC_NOTUSED_166" ,
"BC_NOTUSED_167" ,
"BC_TUPLE",
"BC_PTUPLE",
"BC_NOTUSED_170",
"BC_NOTUSED_171",
"BC_NOTUSED_172",
"BC_NOTUSED_173",
"BC_NOTUSED_174",
"BC_NOTUSED_175",
"BC_NOTUSED_176",
"BC_NOTUSED_177",
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
"BC_JAVA_RTYPE",
"BC_JAVA_EXTERNAL",
 (char *) 0
};

static  char    *basic_op_names [] = {
"",
"BC_MAX" ,
"BC_MIN" ,
"BC_GENERATOR" ,
"BC_OFFSET" ,
"BC_ZERO" ,
"BC_ONE",
"BC_THREE_WAY_COMPARISON"
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
static  EIF_CHARACTER   **dtype_names;
static  int             dtype_max;
static  EIF_CHARACTER   **ctype_names;
static  int             ctype_max;

/*------------------------------------------------------------------*/

static  void    read_byte_code (void);
static  void    print_byte_code (void);
static  void    print_instructions (void);
static  void    print_dtype (int, uint32);
static  void    print_ctype (short);
static  void    print_cid (void);
static	void	get_creation_type (void);
static  void    advance (int);
static  void    panic (void);

/*------------------------------------------------------------------*/

static  EIF_INTEGER_32 rlong (void);
static  BODY_INDEX rbody_index (void);
static  char    *rbuf (int);
static  EIF_CHARACTER * rstr (void);

/*------------------------------------------------------------------*/

int main (int argc, char **argv)
{
	long    i;

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

	dtype_names = (EIF_CHARACTER **) malloc ((dtype_max + 1) * sizeof (char *));

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

	ctype_names = (EIF_CHARACTER **) malloc ((ctype_max + 1) * sizeof (char *));

	if (ctype_names == NULL)
	{
		fprintf (stderr, "Out of memory\n");
		panic ();
	}

	for (i = 0; i <= ctype_max; ++i)
	{
		ctype_names [i] = rstr ();
	}

	while (1)
	{
		read_byte_code ();

		if (body_id == INVALID_ID)
			break;

		print_byte_code ();
	}

	fclose (ifp);
	fclose (ofp);

	printf ("File \"bytecode.txt\" generated\n");

	return 0;
}
/*------------------------------------------------------------------*/

static  void    read_byte_code ()

{
	body_id = rbody_index ();

	if (body_id == INVALID_ID)
		return;

	body_size = rlong ();

	body      = rbuf ((int) body_size);
}
/*------------------------------------------------------------------*/

static  void    print_byte_code ()

{
	uint32  rtype;  /* Type of routine */
	uint32    rid;    /* Routine id      */
	char    rescue; /* Has rescue?     */
	int     i;
	EIF_NATURAL_8   once_mark;
	BODY_INDEX	once_key;

	ip = body;

	once_mark = get_uint8(&ip);  /* Once mark */
	once_key = 0;

	if (once_mark)
		once_key = get_int32(&ip);     /* Once index. */

	advance (1);

	NEWL;

	rid = get_int32(&ip);
	fprintf (ofp,"Routine Id   : %d\n", rid);

	body_id = get_uint32(&ip);
	fprintf (ofp,"Body Id      : %d\n", body_id);

	fprintf (ofp,"Result Type  : ");
	rtype = get_uint32(&ip);

	print_dtype (0,rtype);

	NEWL;

	i = (int) get_int16(&ip);

	fprintf (ofp,"Nr. args     : %d\n", i);

	switch (once_mark)
	{
	case ONCE_MARK_THREAD_RELATIVE:
		fprintf (ofp,"Once routine : thread-relative (%u)\n", once_key);
		break;
	case ONCE_MARK_PROCESS_RELATIVE:
		fprintf (ofp,"Once routine : process-relative (%u)\n", once_key);
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

	/* Arguments which must be cloned */

	if (*ip != BC_NO_CLONE_ARG)
	{
		/* Consume the BC_CLONE_ARG */
		ip += sizeof (char);

		/* NOTE: The printout is wrong - FIXME */

		while (*ip != BC_NO_CLONE_ARG)
		{
			fprintf (ofp,"Clone nr : %d\n", (int) get_int16(&ip));
		}
	}

	advance (3);    /* Consume the 'BC_NO_CLONE_ARGS' */
	NEWL;

	/* If the routine id is zero it's a class invariant */

	if (rid)
	{
		fprintf (ofp,"Routine name : %s\n", get_string8(&ip, -1));
		fprintf (ofp,"Written      : %d\n", (int) get_int16(&ip));
	}

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

static  void    print_instructions ()

{
	unsigned char   cval; /* !!! */
	uint32            lval;
	int             i;

	advance (4);

	while ((code != BC_NULL)     && 
		   (code != BC_INV_NULL) && 
		   (code != BC_END_RESCUE))
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
			case  BC_CREAT_INV :
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
				/* Attribute */
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Static type of class */
				print_ctype (get_int16(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_EXP_ASSIGN :
				/* Attribute (expanded) */
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Static type of class */
				print_ctype (get_int16(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_PASSIGN :
				/* Precompiled attribute */
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d ", get_int32(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_PEXP_ASSIGN :
				/* Precompiled attribute (expanded)*/
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d ", get_int32(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_NONE_ASSIGN :
				break;
			case  BC_RREVERSE :
				/* Reverse assignment to 'Result' */
				/* Static type of target */
				get_creation_type();
				break;
			case  BC_LREVERSE :
				/* Reverse assignment to a local */
				/* local index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				/* Static type of target */
				get_creation_type();
				break;
			case  BC_REVERSE :
				/* Attribute */
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Static type of class */
				print_ctype (get_int16(&ip));
				/* Meta-type */
				print_dtype (0, get_uint32(&ip));
				/* Static type of target */
				get_creation_type ();
				break;
			case  BC_PREVERSE :
				/* Precompiled attribute */
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d ", get_int32(&ip));
				/* Meta-type */
				print_dtype (0,get_uint32(&ip));
				/* Static type of target */
				get_creation_type ();
				break;

/* Creation */
			case  BC_RCREATE:
				fprintf (ofp, " Args:%d ", get_int16(&ip));
				fprintf (ofp, " Open map:%d ", get_int16(&ip));
				fprintf (ofp, " Closed map:%d ", get_int16(&ip));
				print_ctype (get_int16(&ip));
				print_cid ();
				break;

			case  BC_CREATE :
				/* Kind of creation */

					/* Do we need to duplicate top object or is it a BIT type creation? */
				cval = get_char8(&ip);

				if (cval == BC_BIT) {
					fprintf (ofp, " (BC_BIT %d)", get_int32(&ip));	
					break;
				} else if (cval == (char) 1) {
					fprintf (ofp," dup_top_object ");
				}

				get_creation_type ();
				break;

			case BC_SPCREATE:
				get_creation_type ();
				fprintf (ofp, " ");
					/* Read various flags about special we want to create. */
				if (get_char8(&ip)) { fprintf (ofp, "is_reference "); }
				if (get_char8(&ip)) { fprintf (ofp, "is_basic "); }
				cval = get_char8(&ip);
				if (cval) { fprintf (ofp, "is_bit "); }
				if (get_char8(&ip)) {
					fprintf (ofp, "is_expanded of type %d", get_int16(&ip));
				} else {
						/* Read SK_XX type */
					get_uint32(&ip);
				}
				if (cval) {
						/* Get size of bits. */
					get_uint32(&ip);
				}
				break;

			case  BC_ARRAY :    /* Have to check this */
				/* Manifest array */
				
				/* Static type */
				print_ctype (get_int16(&ip));

				/* Dynamic type */
				print_ctype (get_int16(&ip));
				print_cid ();
				/* Feature id ('make') */
				fprintf (ofp,"fid %d ", (int) get_int16(&ip));
				/* Nr. of items */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_PARRAY :   /* Have to check this */
				/* Manifest array precompiled */
				/* Org. id (make) */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d ", get_int32(&ip));
				/* Dynamic type */
				print_ctype (get_int16(&ip));
				print_cid ();
				/* Nr. of items */
				fprintf (ofp,"%d", get_int32(&ip));
				break;

			case BC_TUPLE:
			case BC_PTUPLE:
					/* Dynamic type of tuple */
				fprintf (ofp, "dtype %d ", get_int16(&ip));
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
				break;

/* Calls */

			case  BC_EXTERN :
				/* External */
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Type of class */
				print_ctype (get_int16(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);
				break;
			case  BC_PEXTERN :
				/* External precompiled */
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d", get_int32(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);
				break;
			case  BC_EXTERN_INV :
				/* External with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Type of class */
				print_ctype (get_int16(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);

				break;
			case  BC_PEXTERN_INV :
				/* External precompiled with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d", get_int32(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);
				break;
			case  BC_FEATURE :
				/* Routine */
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Type of class */
				print_ctype (get_int16(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);

				break;
			case  BC_PFEATURE :
				/* Routine precompiled */
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d", get_int32(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);
				break;
			case  BC_FEATURE_INV :
				/* Routine with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Type of class */
				print_ctype (get_int16(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);
				break;
			case  BC_PFEATURE_INV :
				/* Routine precompiled with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d", get_int32(&ip));
				/* Is precursor or static */
				(void) get_int16(&ip);
				break;

			case  BC_ATTRIBUTE :
				/* Attribute */
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Type of class */
				print_ctype (get_int16(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_PATTRIBUTE :
				/* Attribute precompiled */
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d", get_int32(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_ATTRIBUTE_INV :
				/* Attribute with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				/* Feature id */
				fprintf (ofp,"fid %d ", get_int32(&ip));
				/* Type of class */
				print_ctype (get_int16(&ip));
				/* True type */
				print_dtype (0,get_uint32(&ip));
				break;
			case  BC_PATTRIBUTE_INV :
				/* Attribute precompiled with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", get_string8(&ip, -1));
				/* Org. id */
				fprintf (ofp,"oid %d ", get_int32(&ip));
				/* Org. offset */
				fprintf (ofp,"ooff %d", get_int32(&ip));
				/* True type */
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
				/* Access to argument */
				/* Argument index */
				fprintf (ofp,"%d ", (int) get_int16(&ip));
				break;

/* Casts */
			case  BC_CAST_INTEGER:
			case  BC_CAST_NATURAL :
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_CAST_CHAR :
			case  BC_CAST_REAL_32 :
			case  BC_CAST_REAL_64 :
				break;
			case  BC_METAMORPHOSE :
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
				/* Feature id */
				fprintf (ofp,"%d ", get_int32(&ip));
				/* Static type */
				print_ctype (get_int16(&ip));
				fprintf (ofp," %d ", (int) get_int16(&ip));
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

			case BC_BASIC_OPERATIONS :
				/* For basic operations such as min, max, generator.... */
				fprintf (ofp,"%s",basic_op_names[get_char8(&ip)]);
				break;


			case BC_INT_BIT_OP:
				/* For bit manipulations on INTEGERs */
				fprintf (ofp,"%s",bit_op_names[get_char8(&ip)]);
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
			case BC_ALLOCATE_ONCE_STRINGS:
				fprintf (ofp, "index %d, ", get_int32(&ip));
				fprintf (ofp, "count %d", get_int32(&ip));
				break;
			case  BC_FLOAT :
				fprintf (ofp,"%lf", get_real64(&ip));
				break;
			case  BC_DOUBLE :
				fprintf (ofp,"%lf", get_real64(&ip));
				break;
			case  BC_NULL_POINTER :
				fprintf (ofp,"%d", 0);
				break;
			case  BC_STRING :
				fprintf (ofp,"\"%s\"", get_string8(&ip, get_int32(&ip)));
				break;
			case  BC_BIT :
				/* True number of bits */
				fprintf (ofp, "%d ", get_uint32(&ip));
				/* Bit count */
				lval = get_uint32(&ip);
				fprintf (ofp, "%d", lval);

				i = (int) BIT_NBPACK(lval);

				/* Bit sequence packed */

				while (i--)
					(void) get_uint32(&ip);

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
			case  BC_INSPECT :
				break;
			case  BC_RETRIEVE_OLD :
				/* Old expression */
				/* Local index */
				fprintf (ofp,"%d", (int) get_int16(&ip));
				break;
			case  BC_OLD :
				/* Old expression */
				/* Local index */
				fprintf (ofp,"%d", (int) get_int16(&ip));
				break;
			case  BC_START_EVAL_OLD :
				/* Offset if not enabled */
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
			case  BC_BIT_STD_EQUAL  :
				break;
			case  BC_STANDARD_EQUAL :
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
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_GOTO_BODY :
				/* Offset */
				fprintf (ofp,"%d", get_int32(&ip));
				break;
			case  BC_DEFERRED :
				break;
			case  BC_RESCUE :
				break;
			case  BC_JAVA_RTYPE :
				/* Feature name */
				(void) get_string8(&ip, -1);
				print_dtype (0,get_uint32(&ip));
				/* Class name */
				(void) get_string8(&ip, -1);
				break;
			case  BC_JAVA_EXTERNAL :
				/* External call */
				/* Eiffel name of external */
				(void) get_string8(&ip, -1);
				/* True external C name */
				fprintf (ofp,"\"%s\"", get_string8(&ip, -1));
				break;

/* NOTE: Separate codes not included yet */

			default:
				fprintf (stderr,"Illegal byte code %d\n", (int) code);
				panic ();
				break;
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
			case SK_CHAR:   fprintf (ofp," [CHARACTER]"); break;
			case SK_WCHAR:   fprintf (ofp," [WIDE_CHARACTER]"); break;
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
			case SK_BIT:    fprintf (ofp," [BIT]"); break;
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
							break;
		}
	}
	else
	{
		fprintf (ofp,"VOID");
	}
}

/*------------------------------------------------------------------*/
static void get_creation_type (void)
	/* Type of creation */
{
	unsigned char   cval;

	cval = get_char8(&ip);

	switch (cval)
	{
		case  BC_CTYPE :
			/* creation type */
			fprintf (ofp, " (BC_CTYPE) ");
			print_ctype (get_int16(&ip));
/*GENERIC CONFORMANCE*/
			print_cid ();
			break;

		case  BC_CCUR :
			/* like current */
			fprintf (ofp, " (BC_CCUR) ");
			break;
		case  BC_CARG :
			/* like argument */
			/* static creation type */
			fprintf (ofp, " (BC_CARG) ");

			print_ctype (get_int16(&ip));
/*GENERIC CONFORMANCE*/
			print_cid ();
			/* argument index */
			fprintf (ofp,"%d", (int) get_int16(&ip));
			break;
		case  BC_CLIKE :
			/* like feature */
			/* creation type */
			fprintf (ofp, " (BC_CLIKE) ");
			print_ctype (get_int16(&ip));
			/* Anchor id */
			fprintf (ofp,"%d", get_int32(&ip));
			break;
		case  BC_PCLIKE :
			/* like precompiled feature */
			/* Org. id */
			fprintf (ofp, " (BC_PCTYPE) ");

			print_ctype (get_int16(&ip));
			fprintf (ofp,"oid %d ", get_int32(&ip));
			/* Org. offset */
			fprintf (ofp,"ooff %d", get_int32(&ip));
			break;
		case BC_GEN_PARAM_CREATE:
			fprintf (ofp, " (BC_GEN_PARAM_CREATE) ");
			print_ctype (get_int16(&ip));
			fprintf (ofp,"pos %d", get_int32(&ip));
			break;
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

static  void    print_cid ()

{
	short t;

	fprintf (ofp, "{");

	while ((t=get_int16(&ip)) != -1)
		fprintf (ofp, "%d, ", (int) t);

	fprintf (ofp, "-1}");
}
/*------------------------------------------------------------------*/

static BODY_INDEX rbody_index ()
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

static EIF_INTEGER_32 rlong ()
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

static  char    *rbuf (int size)

{
	char    *result;

	fpos += size;

	result = malloc (size);

	if (result == (char *) 0)
	{
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

static  EIF_CHARACTER * rstr ()
{
	static char buf [1024];
	EIF_CHARACTER * result;
	int i;
	EIF_CHARACTER c;

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

static  void    panic ()

{
	if (ifp != (FILE *) 0)
		fclose (ifp);

	if (ofp != (FILE *) 0)
		fclose (ofp);

	printf ("********** Program aborted **********\n");

	exit (-1);
}
/*------------------------------------------------------------------*/

