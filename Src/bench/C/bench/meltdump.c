#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include <memory.h>
#include "eif_interp.h"

#define BCDB_TAG    't'

/*------------------------------------------------------------------*/

typedef unsigned    uint32;
typedef int         int32;
typedef short       int16;

/*------------------------------------------------------------------*/

static  char    *melt_path;
static  FILE    *ifp, *bfp, *mfp;
static  char    **melt;
static  long    msize;

/*------------------------------------------------------------------*/

static  char    **dtype_names;
static  int     dtype_size;
static  int     dtype_max;
static  char    **ctype_names;
static  int     ctype_size;
static  int     ctype_max;

/*------------------------------------------------------------------*/

static  void    prepare_types (void);
static  void    analyze_file (void);
static  void    analyze_cnodes (void);
static  void    analyze_routids (void);
static  void    analyze_parents (void);
static  void    analyze_cecil (void);
static  void    analyze_options (void);
static  void    analyze_routinfo (void);
static  void    analyze_desc (void);
static  void    read_byte_code (void);
static  void    panic ();

/*------------------------------------------------------------------*/

static  char    rchar (void);
static  long    rlong (void);
static  short   rshort (void);
static  uint32  ruint32 (void);
static  void    rseq (int);
static  char    *rbuf (int);
static  void    print_line (void);
static  void    print_dtype (uint32);
static  void    print_ctype (short);

/*------------------------------------------------------------------*/

#define MAX_TYPE 256

main (int argc, char **argv)

{
	if (argc > 1)
	{
		melt_path = argv [1];
	}
	else
	{
		melt_path = "melted.eif";
	}

	ifp = bfp = mfp = (FILE *) 0;

	if ((ifp = fopen (melt_path, "rb")) == (FILE *) 0)
	{
		fprintf (stderr,"Cannot open file <%s>\n", melt_path);
		panic ();
	}

	if ((mfp = fopen ("melted.txt", "wb")) == (FILE *) 0)
	{
		fprintf (stderr,"Cannot open file <%s>\n", "melted.txt");
		panic ();
	}

	prepare_types ();

	fclose (ifp);

	ifp = fopen (melt_path, "rb");

	analyze_file ();

	fclose (ifp);
	fclose (bfp);
	fclose (mfp);

	printf ("Files \"melted.txt\" and \"bytecode.eif\" generated\n");

	exit (0);
}
/*------------------------------------------------------------------*/

static  void    prepare_types ()

{
	long    count, acount, i, ctype;
	short   slen, pcount, dtype;
	char    *dname;

	(void) rchar ();	/* Is there something to read */
	(void) rlong ();	/* root_class_updt */
	(void) rlong ();	/* root_class_updt */
	(void) rlong ();	/* root_class_updt */
	(void) rlong ();	/* root_class_updt */
	(void) rlong ();	/* class types count */
	(void) rlong ();	/* class count */
	(void) rlong ();	/* prof enabled */


	dtype_size  = MAX_TYPE;
	dtype_max   = -1;
	dtype_names = (char **) malloc (dtype_size * sizeof (char *));

	if (dtype_names == (char **) 0)
	{
		fprintf (stderr, "Out of memory\n");
		panic ();
	} else {
		memset (dtype_names, 0, dtype_size * sizeof (char *));
	}

	ctype_size  = MAX_TYPE;
	ctype_max   = -1;
	ctype_names = (char **) malloc (ctype_size * sizeof (char *));

	if (ctype_names == (char **) 0)
	{
		fprintf (stderr, "Out of memory\n");
		panic ();
	} else {
		memset (ctype_names, 0, ctype_size * sizeof (char *));
	}

	count = rlong ();

	while (count--)
	{
		dtype = rshort ();
		slen  = rshort ();
		dname = malloc (slen + 2);

		if (dname == (char *) 0)
		{
			fprintf (stderr, "Out of memory\n");
			panic ();
		}

		i = 0;
		
		while (slen--)
		{
			dname [i] = rchar ();
			++i;
		}

		dname [i] = '\0';

		if (dtype > dtype_max)
			dtype_max = dtype;

		if (dtype >= dtype_size)
		{
			int old_size = dtype_size;

			dtype_size = ((dtype_size + 256) > dtype ? dtype_size : dtype + 256) ;

			dtype_names = (char **) realloc ((char *) dtype_names,
											 dtype_size * sizeof (char *));
			if (dtype_names == (char **) 0)
			{
				fprintf (stderr, "Out of memory\n");
				panic ();
			} else {
				memset (dtype_names + old_size, 0, (dtype_size - old_size) * sizeof (char *));
			}
		}

		dtype_names [dtype] = dname;

		acount = rlong ();

		i = acount;

		while (i--)
		{
			slen = rshort ();

			while (slen--)
				(void) rchar ();
		}

		i = acount;

		while (i--)
		{
			(void) ruint32 ();
		}

		i = acount;

		while (i--)
		{
			if (rshort ())
			{
				short t;

				while ((t = rshort())!=-1)
					;
			}
		}

		pcount = rshort ();

		i = (long) pcount;

		while (i--)
			(void) rshort ();

		i = acount;

		while (i--)
			(void) ruint32 ();

		(void) rlong ();
		(void) rlong ();
		(void) rchar ();
		(void) rchar ();
		(void) ruint32 ();
		
		ctype = rlong ();

		if (ctype > ctype_max)
			ctype_max = ctype;

		if (ctype >= ctype_size)
		{
			int old_size = ctype_size;

			ctype_size = ((ctype_size + 256) > ctype ? ctype_size : ctype + 256) ;

			ctype_names = (char **) realloc ((char *) ctype_names,
											 ctype_size * sizeof (char *));
			if (ctype_names == (char **) 0)
			{
				fprintf (stderr, "Out of memory\n");
				panic ();
			} else {
				memset (ctype_names + old_size, 0, (ctype_size - old_size) * sizeof (char *));
			}
		}

		ctype_names [ctype] = dname;

		(void) rchar ();
	}
}
/*------------------------------------------------------------------*/

static  void    analyze_file ()

{
	if (rchar ())
	{
		fprintf (mfp, "Needs update   : YES\n");
	}
	else
	{
		fprintf (mfp,"Needs update   : NO\n");
		return;
	}

	
	print_line ();

	fprintf (mfp,"Root class origin       : %ld\n", rlong ());
	fprintf (mfp,"Root class dynamic type : %ld\n", rlong ());
	fprintf (mfp,"Root class offset       : %ld\n", rlong ());
	fprintf (mfp,"Root class arguments    : %ld\n", rlong ());

	print_line ();

	fprintf (mfp,"Nr. of class types : %ld\n", rlong ());
	fprintf (mfp,"Nr. of classes     : %ld\n", rlong ());

	print_line ();

	fprintf (mfp,"Profile level : %ld\n", rlong ());

	print_line ();

	analyze_cnodes ();
	analyze_routids ();
	read_byte_code ();
	analyze_parents ();
	analyze_options ();
	analyze_routinfo ();
	analyze_desc ();
}
/*------------------------------------------------------------------*/

static  void    analyze_cnodes ()

{
	long    count, acount, i, ctype;
	short   slen, pcount, pid, dtype;
	char    *dname;

	printf ("Analyzing Cnodes\n");

	count = rlong ();
	fprintf (mfp,"Cnode update entries : %ld\n", count);

	if (!count)
		print_line ();

	while (count--)
	{
		dtype = rshort ();

		fprintf (mfp,"Dynamic class type : %d\n", (int) dtype);
		fprintf (mfp,"Generating class   : ");

		slen = rshort ();

		dname = malloc (slen + 2);

		if (dname == (char *) 0)
		{
			fprintf (stderr, "Out of memory\n");
			panic ();
		}

		i = 0;
		
		while (slen--)
		{
			dname [i] = rchar ();
			fprintf (mfp,"%c", dname [i]);
			++i;
		}

		dname [i] = '\0';

		fprintf (mfp,"\n");

		acount = rlong ();

		fprintf (mfp,"Nr. of attributes  : %ld\n", acount);

		i = acount;

		while (i--)
		{
			fprintf (mfp,"   Attribute name : ");

			slen = rshort ();

			while (slen--)
				fprintf (mfp,"%c", rchar ());

			fprintf (mfp,"\n");
		}

		i = acount;

		while (i--)
		{
			fprintf (mfp,"   Attribute type : ");
			print_dtype (ruint32());
			fprintf (mfp, "\n");
		}

		i = acount;

		while (i--)
		{
			fprintf (mfp,"   Full Attribute type : ");

			if (rshort ())
			{
				short t;

				fprintf (mfp, "{");

				while ((t = rshort())!=-1)
					fprintf (mfp, "%d, ", (int) t);

				fprintf (mfp, "-1}");

			}

			fprintf (mfp, "\n");
		}

		pcount = rshort ();

		fprintf (mfp,"Nr. of parents     : %d\n", (int) pcount);

		i = (long) pcount;

		while (i--)
		{
			pid = rshort ();
			fprintf (mfp,"   Parent id      : %d\n", (int) pid);
		}

		fprintf (mfp,"Attribute ids         : %ld\n", acount);

		i = acount;

		while (i--)
		{
			fprintf (mfp,"    Id            : %ld\n", ruint32 ());                
		}

		fprintf (mfp,"Reference number    : %ld\n", rlong ());
		fprintf (mfp,"Node size           : %ld\n", rlong ());

		if (rchar ())
			fprintf (mfp,"Deferred            : YES\n");
		else
			fprintf (mfp,"Deferred            : No\n");

		if (rchar ())
			fprintf (mfp,"Composite           : YES\n");
		else
			fprintf (mfp,"Composite           : No\n");

		fprintf (mfp,"Creation id         : %ld\n", ruint32 ());

		ctype = rlong ();

		fprintf (mfp,"Class type          : %ld\n", ctype);

		if (rchar ())
			fprintf (mfp,"Disposed            : YES\n");
		else
			fprintf (mfp,"Disposed            : No\n");

		print_line ();
	}
}
/*------------------------------------------------------------------*/

static  void    analyze_routids ()

{
	long    class_id, asize, hsize, i, j, dtype, orig_dtype;
	long    *rids, rid;
	short   slen;
	char    has_cecil;

	printf ("Analyzing Routids\n");

	rids = (long *) 0;

	for (;;)
	{
		class_id = rlong ();

		if (class_id == -1)
			break;

		fprintf (mfp,"Class id   : %ld\n", class_id);

		asize = rlong ();
/*
		fprintf (mfp,"Routine ids: %ld\n", asize);
*/
		if (asize)
		{
			rids = (long *) malloc (asize * sizeof (long));

			if (rids == (long *) 0)
			{
				fprintf (stderr, "Out of memory\n");
				panic ();
			}
		}
		else
			rids = (long *) 0;

		i = 0;
		j = asize;

		while (j--)
		{
			rid = rlong ();
			rids [i++] = rid;
/*
			fprintf (mfp,"  %5d : %d\n", i, rid);
*/
		}

		has_cecil = rchar ();

		if (has_cecil)
		{
			fprintf (mfp,"Has cecil  : YES\n");

			hsize = rlong ();

			fprintf (mfp,"Hash size  : %ld\n", hsize);

			i = hsize;

			while (i--)
			{
				fprintf (mfp,"   Name : ");

				slen = rshort ();

				while (slen--)
					fprintf (mfp,"%c", rchar ());

				fprintf (mfp,"\n");
			}

			rseq ((int) (hsize * sizeof (uint32)));
		}
		else
		{
			fprintf (mfp,"Has cecil  : No\n");
		}

		for (;;)
		{
			dtype = rlong ();

			if (dtype == -1)
				break;

			orig_dtype = rlong ();

			fprintf (mfp,"System [%ld].cn_routines =\n", dtype);
			fprintf (mfp,"Routids [%ld]            =", orig_dtype);

			for (i = 0; i < asize; ++i)
			{
				if ((i % 8) == 0)
					fprintf (mfp, "\n  ");

				fprintf (mfp, "%ld: %ld   ", i, rids [i]);
			}

			fprintf (mfp, "\n");
		}

		if (rids != (long *) 0)
			free ((char *) rids);
	}

	print_line ();
}
/*------------------------------------------------------------------*/

static  void    read_byte_code ()

{
	long    body_id, bsize;
	int     i;

	printf ("Analyzing Byte code\n");

	bfp = fopen ("bytecode.eif", "wb");

	if (bfp == (FILE *) 0)
	{
		fprintf (stderr,"Cannot open file <%s>\n", "bytecode.eif");
		panic ();
	}

	msize = rlong ();
	melt  = (char **) malloc (msize * sizeof (char *));

	if (melt == (char **) 0)
	{
		fprintf (stderr,"Out of memory (read_byte_code)\n");
		panic ();
	}

	/* Write dynamic type names */

	if (fwrite (&dtype_max, sizeof (int), 1, bfp) != 1)
	{
		fprintf (stderr,"Write error\n");
		panic ();
	}

	for (i = 0; i <= dtype_max; ++i)
	{
		if (dtype_names [i] != (char *) 0)
			fprintf (bfp, "%s%c", dtype_names [i], '\0');
		else
			fprintf (bfp, "%c", '\0');
	}

	/* Write classtypes names */

	if (fwrite (&ctype_max, sizeof (int), 1, bfp) != 1)
	{
		fprintf (stderr,"Write error\n");
		panic ();
	}

	for (i = 0; i <= ctype_max; ++i)
	{
		if (ctype_names [i] != (char *) 0)
			fprintf (bfp, "%s%c", ctype_names [i], '\0');
		else
			fprintf (bfp, "%c", '\0');
	}
	
	for (;;)
	{
		body_id = rlong ();

		if (fwrite (&body_id, sizeof (long), 1, bfp) != 1)
		{
			fprintf (stderr,"Write error\n");
			panic ();
		}

		if (body_id == -1)
			break;

		fprintf (mfp,"    Body id    : %ld\n", body_id);

		bsize = rlong ();

		fprintf (mfp,"    Size       : %ld\n", bsize);
		fprintf (mfp,"    Pattern id : %ld\n", rlong ());

		melt [body_id] = rbuf ((int) bsize);

		if (fwrite (&bsize, sizeof (long), 1, bfp) != 1)
		{
			fprintf (stderr,"Write error\n");
			panic ();
		}

		if (fwrite (melt [body_id], sizeof (char), bsize, bfp) != (size_t) bsize)
		{
			fprintf (stderr,"Write error\n");
			panic ();
		}

		free ((char *) (melt [body_id]));
	}

	free ((char *) melt);

	print_line ();
}

/*------------------------------------------------------------------*/

static  void    analyze_parents ()

{
	short   dtype, gcount;
	char    c;

	printf ("Analyzing Parents\n");

	if (rchar ())
	{
		fprintf (mfp,"Has parent table : YES\n");
	}
	else
	{
		fprintf (mfp,"Has parent table : NO\n");
		return;
	}

	for (;;)
	{
		dtype = rshort ();

		if (dtype == -1)
			break;

		gcount = rshort ();

/*
		i = rshort ();
*/
		/* Read class name */

		while ((c = rchar ()))
			fprintf (mfp, "%c", c);

		if (rchar ())
			fprintf (mfp, " E ");     /* Expanded */
		else
			fprintf (mfp, " ");       /* Not expanded */

		while (rshort () != -1)
			;
/*
		asize = rshort ();

		fprintf (mfp,"Dynamic type : %d  Generics = %d Table size = %d\n", 
							(int) dtype, (int) gcount, (int) asize);
		
		rseq (asize * sizeof (short));
*/
	}

	print_line ();

	analyze_cecil ();
}
/*------------------------------------------------------------------*/

static  void    analyze_cecil ()

{
	int     i;
	short   slen, tsize, nb_generics, nb_types;

	printf ("Analyzing Cecil\n");

	tsize = rshort ();

	fprintf (mfp,"Non generic table size  : %d\n", (int) tsize);

	i = (int) tsize;

	while (i--)
	{
		fprintf (mfp,"   Name : ");

		slen = rshort ();

		while (slen--)
			fprintf (mfp,"%c", rchar ());

		fprintf (mfp,"\n");
	}

	rseq ((int) (tsize * sizeof (uint32)));

	tsize = rshort ();

	fprintf (mfp,"generic table size      : %d\n", (int) tsize);

	i = (int) tsize;

	while (i--)
	{
		fprintf (mfp,"   Name : ");

		slen = rshort ();

		while (slen--)
			fprintf (mfp,"%c", rchar ());

		fprintf (mfp,"\n");
	}

	i = (int) tsize;

	while (i--)
	{
		nb_generics = rshort ();
		fprintf (mfp,"    Generics : %d\n", (int) nb_generics);

		if (nb_generics)
		{
			nb_types = rshort ();

			fprintf (mfp,"    Types    : %d\n", (int) nb_types);

			rseq ((int) (nb_generics * nb_types * sizeof (int32)));
			rseq ((int) (nb_types * sizeof (int16)));
		}
	}

	print_line ();
}
/*------------------------------------------------------------------*/

static  void    analyze_options ()

{
	short   dtype, dbcount, slen, i;
	char    dbg_level;

	printf ("Analyzing Options\n");

	for (;;)
	{
		dtype = rshort ();

		if (dtype == -1)
			break;

		fprintf (mfp,"Dynamic type   : %d\n", (int) dtype);
		fprintf (mfp,"Assertion kind : %d\n", (int) rshort ());

		dbg_level = rchar ();

		if (dbg_level == BCDB_TAG)
		{
			dbcount = rshort ();

			fprintf (mfp,"Debug keys     : %d\n", (int) dbcount);

			i = dbcount;

			while (i--)
			{
				fprintf (mfp,"   Name : ");

				slen = rshort ();

				while (slen--)
					fprintf (mfp,"%c", rchar ());

				fprintf (mfp,"\n");
			}
		}
		fprintf (mfp,"Trace level    : %d\n", (int) rchar ());
		fprintf (mfp,"Profile level  : %d\n", (int) rchar ());
	}

	print_line ();
}
/*------------------------------------------------------------------*/

static  void    analyze_routinfo ()

{
	long    count, rid, org, off;

	printf ("Analyzing Routinfo\n");

	count = (long) ruint32 ();

	fprintf (mfp,"Routine info table : %ld\n\n", count);
	fprintf (mfp,"Routinfo =\n");

	rid = 0;

	while (count--)
	{
		org = (long) rshort ();
		off = (long) rshort ();
		fprintf (mfp,"%8ld:   %5ld  %5ld\n", (int) rid, (int) org, (int) off);

		++rid;
	}

	print_line ();
}
/*------------------------------------------------------------------*/

static  void    analyze_desc ()

{
	long    count, tid, info, type, i, j;
	short   org_count, info_count, org_id;
	short   *dinfo;

	printf ("Analyzing Desc\n");

	fprintf (mfp,"Descriptors : (desc_tab)\n");

	for (;;)
	{
		count = rlong ();

		if (count == -1)
			break;

		while (count--)
		{
			tid       = (long) rshort ();
			org_count = rshort ();

			while (org_count--)
			{
				org_id = rshort ();

				fprintf (mfp,"Origin_id %5d  Dtype_id %8d\n", (int) org_id, tid);

				info_count = rshort ();

				if (info_count)
				{
					dinfo = (short *) malloc (2*info_count * sizeof (short));

					if (dinfo == (short *) 0)
					{
						fprintf (stderr,"Out of memory\n");
						panic ();
					}
				}
				else
					dinfo = (short *) 0;

				i = 0;
				j = info_count;

				while (j--)
				{
					info = (long) rshort ();
					type = (long) rshort ();

/*
					fprintf (mfp,"  I/T : [%5d, %5d]\n", (int) info, (int) type);
*/
					dinfo [i++] = (short) info;
					dinfo [i++] = (short) type;
/* GENERIC CONFORMANCE */

					while (rshort() != -1)
						;
				}

				fprintf (mfp, "desc_tab [%d][%d] = ", org_id, tid-1);

				for (i = 0; i < info_count; ++i)
				{
					if ((i % 8) == 0)
						fprintf (mfp, "\n  ");

					fprintf (mfp, "%ld: (%ld,%ld) ",
							 i, dinfo [2*i], dinfo [2*i+1]);
				}

				fprintf (mfp, "\n");

				if (dinfo != (short *) 0)
					free ((char *) dinfo);
			}
		}
	}

	print_line ();
}
/*------------------------------------------------------------------*/

static  char    rchar ()

{
	char    result;

	if (fread (&result, sizeof (char), 1, ifp) != 1)
	{
		fprintf (stderr,"Read error (char)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  long    rlong ()

{
	long    result;

	if (fread (&result, sizeof (long), 1, ifp) != 1)
	{
		fprintf (stderr,"Read error (long)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  short   rshort ()

{
	short    result;

	if (fread (&result, sizeof (short), 1, ifp) != 1)
	{
		fprintf (stderr,"Read error (short)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  uint32  ruint32 ()

{
	uint32    result;

	if (fread (&result, sizeof (uint32), 1, ifp) != 1)
	{
		fprintf (stderr,"Read error (uint32)\n");
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  void    rseq (int scount)

{
	int     i;
	char    c;

	i = scount;

	while (i--)
	{
		if (fread (&c, sizeof (char), 1, ifp) != 1)
		{
			fprintf (stderr,"Read error (seq)\n");
			panic ();
		}
	}
}
/*------------------------------------------------------------------*/

static  char    *rbuf (int size)

{
	char    *result;

	result = malloc (size);

	if (result == (char *) 0)
	{
		fprintf (stderr,"Out of memory (rbuf)\n");
		panic ();
	}

	if (fread (result, sizeof (char), size, ifp) != (size_t) size)
	{
		fprintf (stderr,"Read error (rbuf)\n");
		free (result);
		panic ();
	}

	return result;
}
/*------------------------------------------------------------------*/

static  void    print_line ()

{
	fprintf (mfp,"---------------------------\n");
}
/*------------------------------------------------------------------*/

static  void    print_dtype (uint32 type)

{
	int     dtype;

	dtype = (int) (type & SK_DTYPE);

	if ((type & SK_HEAD) != SK_VOID) 
	{
		switch (type & SK_HEAD) 
		{
			case SK_BOOL:   fprintf (mfp," [BOOLEAN]"); break;
			case SK_CHAR:   fprintf (mfp," [CHARACTER]"); break;
			case SK_WCHAR:   fprintf (mfp," [WIDE_CHARACTER]"); break;
			case SK_INT8:    fprintf (mfp," [INTEGER_8]"); break;
			case SK_INT16:    fprintf (mfp," [INTEGER_16]"); break;
			case SK_INT32:    fprintf (mfp," [INTEGER]"); break;
			case SK_INT64:    fprintf (mfp," [INTEGER_64]"); break;
			case SK_FLOAT:  fprintf (mfp," [FLOAT]"); break;
			case SK_DOUBLE: fprintf (mfp," [DOUBLE]"); break;
			case SK_POINTER:fprintf (mfp," [POINTER]"); break;
			case SK_BIT:    fprintf (mfp," [BIT]"); break;
			case SK_EXP:    fprintf (mfp,"ET %u", type & SK_DTYPE);

							if (dtype <= dtype_max)
								fprintf (mfp, " [%s]", dtype_names [dtype]);
							else
								fprintf (mfp, " [?]");

							break;
			case SK_REF:    fprintf (mfp,"RT %u", type & SK_DTYPE);

							if (dtype <= dtype_max)
								fprintf (mfp, " [%s]", dtype_names [dtype]);
							else
								fprintf (mfp, " [?]");
							break;

			default    :    fprintf (stderr,"Illegal type\n");
							panic ();
							break;
		}
	}
	else
	{
		fprintf (mfp,"VOID");
	}
}
/*------------------------------------------------------------------*/

static  void    print_ctype (short type)

{
	if (type <= ctype_max)
		fprintf (mfp, " [%d : %s]", (int) type, ctype_names [type]);
	else
		fprintf (mfp, " [%d : ?]", (int) type);
}
/*------------------------------------------------------------------*/

static  void    panic ()

{
	if (ifp != (FILE *) 0)
		fclose (ifp);

	if (bfp != (FILE *) 0)
		fclose (bfp);

	if (mfp != (FILE *) 0)
		fclose (mfp);

	printf ("********** Program aborted **********\n");

	exit (-1);
}
/*------------------------------------------------------------------*/

