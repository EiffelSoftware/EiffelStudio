#include <stdio.h>
#include <malloc.h>
#include "rt_interp.h"
#include "eif_size.h"
#include <string.h>
#include <stdlib.h>

/*------------------------------------------------------------------*/

typedef unsigned    uint32;

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
"BC_PROTECT" ,
"BC_RELEASE" ,
"BC_JMP_T" ,
"UNUSED_79" ,
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
"UNUSED_109" ,
"BC_CAST_LONG" ,
"BC_CAST_FLOAT" ,
"BC_CAST_DOUBLE" ,
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
"BC_CREATE_EXP" ,
"BC_NULL_POINTER" ,
"BC_BASIC_OPERATIONS" ,
"BC_INT_BIT_OP" ,
"BC_WCHAR" ,
"BC_INT8" ,
"BC_INT16" ,
"BC_INT64" ,
"UNUSED_143" ,
"UNUSED_144" ,
"UNUSED_145" ,
"UNUSED_146" ,
"UNUSED_147" ,
"UNUSED_148" ,
"UNUSED_149" ,
"BC_SEP_SET" ,
"BC_SEP_UNSET" ,
"BC_SEP_RESERVE" ,
"BC_SEP_FREE" ,
"BC_SEP_TO_SEP" ,
"BC_SEP_RAISE_PREC" ,
"BC_SEP_CREATE" ,
"BC_SEP_CREATE_END" ,
"BC_SEP_ATTRIBUTE_INV" ,
"BC_SEP_EXTERN_INV" ,
"BC_SEP_FEATURE_INV" ,
"BC_SEP_PATTRIBUTE_INV" ,
"BC_SEP_PEXTERN_INV" ,
"BC_SEP_PFEATURE_INV" ,
"BC_SEP_EXTERN" ,
"BC_SEP_FEATURE" ,
"BC_SEP_PEXTERN" ,
"BC_SEP_PFEATURE" ,
"UNUSED_168",
"UNUSED_169",
"UNUSED_170",
"UNUSED_171",
"UNUSED_172",
"UNUSED_173",
"UNUSED_174",
"UNUSED_175",
"UNUSED_176",
"UNUSED_177",
"UNUSED_178",
"UNUSED_179",
"UNUSED_180",
"UNUSED_181",
"UNUSED_182",
"UNUSED_183",
"UNUSED_184",
"UNUSED_185",
"UNUSED_186",
"UNUSED_187",
"UNUSED_188",
"UNUSED_189",
"UNUSED_190",
"UNUSED_191",
"UNUSED_192",
"UNUSED_193",
"UNUSED_194",
"UNUSED_195",
"UNUSED_196",
"UNUSED_197",
"UNUSED_198",
"UNUSED_199",
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
"BC_ONE"
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
};

/*------------------------------------------------------------------*/

#define NEWL            fprintf (ofp,"\n")

/*------------------------------------------------------------------*/

static  int             fpos;
static  char            *byte_path;
static  FILE            *ifp, *ofp;
static  char            *body;
static  long            body_id;
static  long            body_size;
static  long            bcount;
static  char            *ip;
static  unsigned char   code;
static  char            **dtype_names;
static  int             dtype_max;
static  char            **ctype_names;
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

static  char    rchar (void);
static  long    rlong (void);
static  int     rint (void);
static  short   rshort (void);
static  uint32  ruint32 (void);
static  void    rseq (int);
static  char    *rbuf (int);
static  char    *rstr (void);

/*------------------------------------------------------------------*/

static  char    bbool (void);
static  unsigned char    bchar (void); /* !!! */
static  EIF_WIDE_CHAR bwchar (void);
static  long    blong (void);
static  short   bshort (void);
static  uint32  buint32 (void);
static  double  bdouble (void);
static  char    *bstr (int length);

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

	dtype_max = rint ();

	dtype_names = (char **) malloc ((dtype_max + 1) * sizeof (char *));

	if (dtype_names == (char **) 0)
	{
		fprintf (stderr, "Out of memory\n");
		panic ();
	}

	for (i = 0; i <= dtype_max; ++i)
	{
		dtype_names [i] = rstr ();
	}

	ctype_max = rint ();

	ctype_names = (char **) malloc ((ctype_max + 1) * sizeof (char *));

	if (ctype_names == (char **) 0)
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

		if (body_id < 0)
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
	body_id = rlong ();

	if (body_id < 0)
		return;

	body_size = rlong ();

	body      = rbuf ((int) body_size);
}
/*------------------------------------------------------------------*/

static  void    print_byte_code ()

{
	uint32  rtype;  /* Type of routine */
	long    rid;    /* Routine id      */
	char    rescue; /* Has rescue?     */
	int     i;
	int     is_once;

	ip = body;

	is_once = (int) bbool();  /* Once flag */

	if (is_once)
		(void) blong();     /* Reserved space - skip it */

	advance (1);

	NEWL;

	fprintf (ofp,"Body Id      : %ld\n", body_id);

	rid = blong ();
	fprintf (ofp,"Routine Id   : %ld\n", rid);

	rid = blong ();
	fprintf (ofp,"Real body Id : %ld\n", rid);
	
	fprintf (ofp,"Result Type  : ");
	rtype = buint32 ();

	print_dtype (0,rtype);

	NEWL;

	i = (int) bshort ();

	fprintf (ofp,"Nr. args     : %d\n", i);

	if (is_once)
	{
		/* A once routine */

		fprintf (ofp,"Once routine : YES\n");
		fprintf (ofp,"Body Id      : %ld\n", blong ());
	}

	i = (int) bshort ();

	fprintf (ofp,"Nr. locals   : %d\n", i);

	while (i--)
	{
		/* Types of locals - always provided */

		fprintf (ofp,"  Type : ");
		print_dtype (1,buint32 ());
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
			fprintf (ofp,"Clone nr : %d\n", (int) bshort ());
		}
	}

	advance (3);    /* Consume the 'BC_NO_CLONE_ARGS' */
	NEWL;

	/* If the routine id is zero it's a class invariant */

	if (rid)
	{
		fprintf (ofp,"Routine name : %s\n", bstr (-1));
		fprintf (ofp,"Written      : %d\n", (int) bshort ());
	}

	/* Offset of rescue clause - if any */

	rescue = bbool ();
	if (rescue)
	{
		fprintf (ofp,"Rescue offset: %ld\n", blong ());
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

	if ((((int) code) < 0) || (((int) code) > MAX_CODE))
	{
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
	long            lval;
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
				fprintf (ofp,"<%d, ", (int) bchar ());
				/* Type of tag */
				cval = bchar();
				fprintf (ofp,"%d>", (int) cval);

				if (cval == BC_TAG)
					fprintf (ofp," : \"%s\"", bstr (-1));
				break;
			case  BC_END_ASSERT :
				break;
			case  BC_CHECK :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %ld ", blong ());
				break;
			case  BC_INIT_VARIANT :
				/* Index of local used in variant expression */
				fprintf (ofp,"local %d", (int) bshort ());
				break;
			case  BC_END_VARIANT :
				/* Index of local used in variant expression */
				fprintf (ofp,"local %d", (int) bshort ());
				break;
			case  BC_DEBUG :
				/* Nr. of debug keys */

				fprintf (ofp,"nr_keys %ld ", (lval = blong ()));

				/* The keys - if any */
				
				while (lval--)
				{
					fprintf (ofp,"\"%s\"", bstr (blong()));

					if (lval)
						fprintf (ofp, ", ");
				}

				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %ld", blong ());
				break;
			case  BC_CREAT_INV :
				break;
			case  BC_PRECOND :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %ld", blong ());
				break;
			case  BC_END_PRE :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %ld", blong ());
				break;
			case  BC_POSTCOND :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %ld", blong ());
				break;
			case  BC_LOOP :
				/* If not enabled jump to 'offset' */
				fprintf (ofp,"offset %ld", blong ());
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
				fprintf (ofp," %d", (int) bshort ());
				break;
			case  BC_LEXP_ASSIGN :
				/* Local index */
				fprintf (ofp," %d", (int) bshort ());
				break;
			case  BC_ASSIGN :
				/* Attribute */
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Static type of class */
				print_ctype (bshort ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_EXP_ASSIGN :
				/* Attribute (expanded) */
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Static type of class */
				print_ctype (bshort ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_PASSIGN :
				/* Precompiled attribute */
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld ", blong ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_PEXP_ASSIGN :
				/* Precompiled attribute (expanded)*/
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld ", blong ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_NONE_ASSIGN :
				break;
			case  BC_RREVERSE :
				/* Reverse assignment to 'Result' */
				/* Static type of target */
				print_ctype (bshort ());
/*GENERIC CONFORMANCE*/
				print_cid ();
				break;
			case  BC_LREVERSE :
				/* Reverse assignment to a local */
				/* local index */
				fprintf (ofp,"%d ", (int) bshort ());
				/* Static type of target */
				print_ctype (bshort ());
/*GENERIC CONFORMANCE*/
				print_cid ();
				break;
			case  BC_REVERSE :
				/* Attribute */
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Static type of class */
				print_ctype (bshort ());
				/* True type */
				print_dtype (0,buint32 ());
				/* Static type of target */
				print_ctype (bshort ());
/*GENERIC CONFORMANCE*/
				print_cid ();
				break;
			case  BC_PREVERSE :
				/* Precompiled attribute */
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld ", blong ());
				/* True type */
				print_dtype (0,buint32 ());
				/* Static type of target */
				print_ctype (bshort ());
/*GENERIC CONFORMANCE*/
				print_cid ();
				break;

/* Creation */
			case  BC_RCREATE:
				fprintf (ofp, " Args:%d ", bshort());
				fprintf (ofp, " Open map:%d ", bshort());
				fprintf (ofp, " Closed map:%d ", bshort());
				print_ctype (bshort());
				print_cid ();
				break;

			case  BC_CREATE :
				/* Kind of creation */

				cval = bchar ();

				fprintf (ofp,"<%d> ", (int) cval);

				switch (cval)
				{
					case BC_BIT:
						/* creation of a bit type */
						fprintf (ofp, " (BC_BIT) %ld", blong());
						break;
					case  BC_CTYPE :
						/* creation type */
						fprintf (ofp, " (BC_CTYPE) ");
						print_ctype (bshort ());
/*GENERIC CONFORMANCE*/
						print_cid ();
						break;
					case BC_CREATE_EXP:
						/* Hardcoded creation expression type */
						fprintf (ofp, " (BC_CREATE_EXP) ");
						(void) bshort ();
						(void) bshort ();
						/* creation type */
						print_ctype (bshort ());
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

						print_ctype (bshort ());
/*GENERIC CONFORMANCE*/
						print_cid ();
						/* argument index */
						fprintf (ofp,"%d", (int) bshort ());
						break;
					case  BC_CLIKE :
						/* like feature */
						/* creation type */
						fprintf (ofp, " (BC_CLIKE) ");
						print_ctype (bshort ());
						/* Anchor id */
						fprintf (ofp,"%ld", blong ());
						break;
					case  BC_PCLIKE :
						/* like precompiled feature */
						/* Org. id */
						fprintf (ofp, " (BC_PCTYPE) ");

						print_ctype (bshort ());
						fprintf (ofp,"oid %ld ", blong ());
						/* Org. offset */
						fprintf (ofp,"ooff %ld", blong ());
						break;
					case BC_GEN_PARAM_CREATE:
						fprintf (ofp, " (BC_GEN_PARAM_CREATE) ");
						print_ctype (bshort());
						fprintf (ofp,"pos %ld", blong ());
						break;
				}
				break;

			case  BC_ARRAY :    /* Have to check this */
				/* Manifest array */
				
				/* Static type */
				print_ctype (bshort ());

				/* Dynamic type */
				print_ctype (bshort ());
				print_cid ();
				/* Feature id ('make') */
				fprintf (ofp,"fid %d ", (int) bshort ());
				/* Nr. of items */
				fprintf (ofp,"%ld", blong ());
				if (bshort())
					fprintf (ofp, " Tuple");
				else
					fprintf (ofp, " Array");
				break;
			case  BC_PARRAY :   /* Have to check this */
				/* Manifest array precompiled */
				/* Org. id (make) */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld ", blong ());
				/* Dynamic type */
				print_ctype (bshort ());
				print_cid ();
				/* Nr. of items */
				fprintf (ofp,"%ld", blong ());
				if (bshort())
					fprintf (ofp, " Tuple");
				else
					fprintf (ofp, " Array");
				break;
			case  BC_CLONE :
				break;

/* Calls */

			case  BC_EXTERN :
				/* External */
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Type of class */
				print_ctype (bshort ());
				break;
			case  BC_PEXTERN :
				/* External precompiled */
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld", blong ());
				break;
			case  BC_EXTERN_INV :
				/* External with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Type of class */
				print_ctype (bshort ());
				break;
			case  BC_PEXTERN_INV :
				/* External precompiled with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld", blong ());
				break;
			case  BC_FEATURE :
				/* Routine */
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Type of class */
				print_ctype (bshort ());
/* NEW */
				(void) bshort ();

				break;
			case  BC_PFEATURE :
				/* Routine precompiled */
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld", blong ());
/* NEW */
				(void) bshort ();
				break;
			case  BC_FEATURE_INV :
				/* Routine with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Type of class */
				print_ctype (bshort ());
/* NEW */
				(void) bshort ();
				break;
			case  BC_PFEATURE_INV :
				/* Routine precompiled with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld", blong ());
/* NEW */
				(void) bshort ();
				break;

			case  BC_ATTRIBUTE :
				/* Attribute */
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Type of class */
				print_ctype (bshort ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_PATTRIBUTE :
				/* Attribute precompiled */
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld", blong ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_ATTRIBUTE_INV :
				/* Attribute with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				/* Feature id */
				fprintf (ofp,"fid %ld ", blong ());
				/* Type of class */
				print_ctype (bshort ());
				/* True type */
				print_dtype (0,buint32 ());
				break;
			case  BC_PATTRIBUTE_INV :
				/* Attribute precompiled with invariant check */
				/* Feature name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				/* Org. id */
				fprintf (ofp,"oid %ld ", blong ());
				/* Org. offset */
				fprintf (ofp,"ooff %ld", blong ());
				/* True type */
				print_dtype (0,buint32 ());
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
				fprintf (ofp,"%d", (int) bshort ());
				break;
			case  BC_ARG :
				/* Access to argument */
				/* Argument index */
				fprintf (ofp,"%d ", (int) bshort ());
				break;

/* Casts */
			case  BC_CAST_LONG :
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_CAST_FLOAT :
				break;
			case  BC_CAST_DOUBLE :
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
				fprintf (ofp,"%ld ", blong ());
				break;
			case  BC_OR_ELSE :
				/* Jump offset */
				fprintf (ofp,"%ld ", blong ());
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
				fprintf (ofp,"%ld ", blong ());
				/* Static type */
				print_ctype (bshort ());
				fprintf (ofp," %d ", (int) bshort());
				break;
			case  BC_OBJECT_ADDR :
				/* Address of object */
				/* Offset */
				fprintf (ofp,"%ld ", buint32 ());
				break;
			case  BC_OBJECT_EXPR_ADDR :
				/* Address of expression */
				/* Pointer */
				fprintf (ofp,"%ld ", buint32 ());
				/* Value */
				fprintf (ofp,"%ld ", buint32 ());
				break;

			case BC_BASIC_OPERATIONS :
				/* For basic operations such as min, max, generator.... */
				fprintf (ofp,"%s",basic_op_names[bchar()]);
				break;


			case BC_INT_BIT_OP:
				/* For bit manipulations on INTEGERs */
				fprintf (ofp,"%s",bit_op_names[bchar()]);
				break;

/* Constants */

			case  BC_CHAR :
				fprintf (ofp,"%d", (int) bchar ());
				break;
			case BC_WCHAR:
				fprintf (ofp,"%d", (int) bwchar ());
			case  BC_BOOL :
				fprintf (ofp,"%d", (int) bchar ());
				break;
			case BC_INT8:
			case BC_INT16:
			case BC_INT32:
			case BC_INT64:
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_FLOAT :
				fprintf (ofp,"%lf", bdouble ());
				break;
			case  BC_DOUBLE :
				fprintf (ofp,"%lf", bdouble ());
				break;
			case  BC_NULL_POINTER :
				fprintf (ofp,"%ld", 0);
				break;
			case  BC_STRING :
				fprintf (ofp,"\"%s\"", bstr (blong()));
				break;
			case  BC_BIT :
				/* True number of bits */
				fprintf (ofp, "%ld ", buint32 ());
				/* Bit count */
				lval = buint32 ();
				fprintf (ofp, "%ld", lval);

				i = (int) BIT_NBPACK(lval);

				/* Bit sequence packed */

				while (i--)
					(void) buint32 ();

				break;
			case  BC_VOID :
				break;


			case  BC_RETRY :
				/* Retry offset */
				fprintf (ofp,"offset %ld", blong ());
				break;
			case  BC_RANGE :
				/* When part of inspect. Jump offset */
				fprintf (ofp,"offset %ld", blong ());
				break;
			case  BC_INSPECT :
				break;
			case  BC_RETRIEVE_OLD :
				/* Old expression */
				/* Local index */
				fprintf (ofp,"%d", (int) bshort ());
				break;
			case  BC_OLD :
				/* Old expression */
				/* Local index */
				fprintf (ofp,"%d", (int) bshort ());
				break;
			case  BC_START_EVAL_OLD :
				/* Offset if not enabled */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_END_EVAL_OLD :
				break;
			case  BC_ADD_STRIP :
				/* Attribute name */
				fprintf (ofp,"\"%s\" ", bstr (-1));
				break;
			case  BC_END_STRIP :
				/* Static type */
				print_ctype (bshort ());
				/* Dynamic type */
				print_ctype (bshort ());
				/* Nr. of items */
				fprintf (ofp,"%ld ", blong ());
				break;
			case  BC_ROTATE :
				/* Rotate stack */
				/* Amount */
				fprintf (ofp,"%d", (int) bshort ());
				break;
			case  BC_PROTECT :
				break;
			case  BC_RELEASE :
				fprintf (ofp,"code %d ", (int) bshort ());
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
				fprintf (ofp,"%ld", buint32 ());
				break;
			case  BC_JMP_F :
				/* Jump offset */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_JMP_T :
				/* Jump offset */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_JMP :
				/* Jump offset */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_HOOK :
				/* For debugger */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_NHOOK :
				/* For debugger */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_GOTO_BODY :
				/* Offset */
				fprintf (ofp,"%ld", blong ());
				break;
			case  BC_DEFERRED :
				break;
			case  BC_RESCUE :
				break;
			case  BC_JAVA_RTYPE :
				/* Feature name */
				(void) bstr (-1);
				print_dtype (0,buint32());
				/* Class name */
				(void) bstr (-1);
				break;
			case  BC_JAVA_EXTERNAL :
				/* External call */
				/* Eiffel name of external */
				(void) bstr (-1);
				/* True external C name */
				fprintf (ofp,"\"%s\"", bstr (-1));
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
			case SK_INT8:   fprintf (ofp," [INTEGER_8]"); break;
			case SK_INT16:   fprintf (ofp," [INTEGER_16]"); break;
			case SK_INT32:   fprintf (ofp," [INTEGER]"); break;
			case SK_INT64:   fprintf (ofp," [INTEGER_64]"); break;
			case SK_FLOAT:  fprintf (ofp," [FLOAT]"); break;
			case SK_DOUBLE: fprintf (ofp," [DOUBLE]"); break;
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

static  void    print_ctype (short type)

{
	if (type <= ctype_max)
		fprintf (ofp, " [%d : %s]", (int) type, ctype_names [type]);
	else
		fprintf (ofp, " [%d : ?]", (int) type);
}
/*------------------------------------------------------------------*/

static  void    print_cid ()

{
	short t;

	fprintf (ofp, "{");

	while ((t=bshort()) != -1)
		fprintf (ofp, "%d, ", (int) t);

	fprintf (ofp, "-1}");
}
/*------------------------------------------------------------------*/

static  char    bbool ()

{
	char    result;

	result  = *ip;
	ip    += sizeof (char);

	return result;
}
/*------------------------------------------------------------------*/
static  unsigned char bchar (void)

{
	unsigned char    result; /* !!! */

	result = *ip;
	ip    += sizeof (char);

	return result;
}

static  EIF_WIDE_CHAR bwchar (void)

{
	EIF_WIDE_CHAR    result; /* !!! */

	result = *ip;
	ip    += sizeof (EIF_WIDE_CHAR);

	return result;
}
/*------------------------------------------------------------------*/

static  long    blong (void)

{
	union {
		char xtract[sizeof(long)];
		long value;
	} xlong;
	register char *p = (char *) &xlong;
	register int i;

	for (i = 0; i < sizeof(long); i++)
		*p++ = *ip++;
	
	return *(long *) &xlong;
}
/*------------------------------------------------------------------*/

static  double    bdouble (void)

{
	union {
		char xtract[sizeof(double)];
		double value;
	} xdouble;
	register char *p = (char *) &xdouble;
	register int i;

	for (i = 0; i < sizeof(double); i++)
		*p++ = *ip++;
	
	return *(double *) &xdouble;
}
/*------------------------------------------------------------------*/

static  short    bshort (void)

{
	union {
		char xtract[sizeof(short)];
		short value;
	} xshort;
	register char *p = (char *) &xshort;
	register int i;

	for (i = 0; i < sizeof(short); i++)
		*p++ = *ip++;
	
	return *(short *) &xshort;
}
/*------------------------------------------------------------------*/

static  uint32    buint32 (void)

{
	union {
		char xtract[sizeof(uint32)];
		uint32 value;
	} xuint32;
	register char *p = (char *) &xuint32;
	register int i;

	for (i = 0; i < sizeof(uint32); i++)
		*p++ = *ip++;
	
	return *(uint32 *) &xuint32;
}
/*------------------------------------------------------------------*/

static char *bstr (int length)
{
	char    *result;

	result  = ip;
	if (length == -1)
		ip += strlen (result) + 1;
	else
		ip += length + 1;

	return result;
}
/*------------------------------------------------------------------*/

static  char    rchar ()

{
	char    result;

	fpos += sizeof (char);

	if (fread (&result, sizeof (char), 1, ifp) != 1)
	{
		printf ("Read error (char)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  int    rint ()

{
	int    result;

	fpos += sizeof (int);

	if (fread (&result, sizeof (int), 1, ifp) != 1)
	{
		printf ("Read error (int)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  long    rlong ()

{
	long    result;

	fpos += sizeof (long);

	if (fread (&result, sizeof (long), 1, ifp) != 1)
	{
		printf ("Read error (long)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  short   rshort ()

{
	short    result;

	fpos += sizeof (short);

	if (fread (&result, sizeof (short), 1, ifp) != 1)
	{
		printf ("Read error (short)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  uint32  ruint32 ()

{
	uint32    result;

	fpos += sizeof (uint32);

	if (fread (&result, sizeof (uint32), 1, ifp) != 1)
	{
		printf ("Read error (uint32)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  void    rseq (int scount)

{
	int     i;
	char    c;

	fpos += scount;

	i = scount;

	while (i--)
	{
		if (fread (&c, sizeof (char), 1, ifp) != 1)
		{
			printf ("Read error (seq)\n");
			panic ();
		}
	}
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

static  char    *rstr ()

{
	static char buf [1024];
	char        *result;
	int         i;
	char        c;

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

	if (result == (char *) 0)
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

