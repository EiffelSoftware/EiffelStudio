#include            <stdio.h>
#include            <malloc.h>
#include            "melted.h"

/*------------------------------------------------------------------*/

typedef unsigned    uint32;
typedef int         int32;
typedef short       int16;

/*------------------------------------------------------------------*/

static  char    *melt_path;
static  FILE    *ifp, *bfp, *mfp;
static  char    **melt;
static  long    msize;
static  char    java_mode;

/*------------------------------------------------------------------*/

static  void    analyze_file (void);
static  void    analyze_cnodes (void);
static  void    analyze_routids (void);
static  void    analyze_dispatch_table (void);
static  void    analyze_conformance (void);
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
static  void    print_type (uint32);

/*------------------------------------------------------------------*/

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

    analyze_file ();

    fclose (ifp);
    fclose (bfp);
    fclose (mfp);

    printf ("Files \"melted.txt\" and \"bytecode.eif\" generated\n");

    exit (0);
}
/*------------------------------------------------------------------*/

static  void    analyze_file ()

{
    long    count;

    if (rchar ())
    {
        fprintf (mfp, "Needs update   : YES\n");
    }
    else
    {
        fprintf (mfp,"Needs update   : NO\n");
        return;
    }

    if ((java_mode = rchar ()))
    {
        fprintf (mfp,"Java byte-code : YES\n");
    }
    else
    {
        fprintf (mfp,"Java byte-code : NO\n");
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
    fprintf (mfp,"DLE level     : %ld\n", rlong ());

    print_line ();

    analyze_cnodes ();
    analyze_routids ();
    analyze_dispatch_table ();

    read_byte_code ();
    analyze_conformance ();
    analyze_options ();
    analyze_routinfo ();
    analyze_desc ();
}
/*------------------------------------------------------------------*/

static  void    analyze_cnodes ()

{
    long    count, acount, i;
    short   slen, pcount;
    char    c;

    count = rlong ();
    fprintf (mfp,"Cnode update entries : %ld\n", count);

    if (!count)
        print_line ();

    while (count--)
    {
        fprintf (mfp,"Dynamic class type : %d\n", (int) rshort ());
        fprintf (mfp,"Generating class   : ");

        slen = rshort ();

        while (slen--)
            fprintf (mfp,"%c", rchar ());

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
            print_type (ruint32());
            fprintf (mfp, "\n");
        }

        pcount = rshort ();

        fprintf (mfp,"Nr. of parents     : %d\n", (int) pcount);

        i = (long) pcount;

        while (i--)
        {
            fprintf (mfp,"   Parent id      : %d\n", (int) rshort ());
        }

        fprintf (mfp,"Routine ids         : %ld\n", acount);

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
        fprintf (mfp,"Class type          : %ld\n", rlong ());

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
    long    class_id, asize, hsize, i, dtype;
    short   slen;
    char    has_cecil;

    for (;;)
    {
        class_id = rlong ();

        if (class_id == -1)
            break;

        fprintf (mfp,"Class id   : %ld\n", class_id);

        asize = rlong ();
        fprintf (mfp,"Routine ids: %ld\n", asize);

        i = 0;

        while (asize--)
        {
            fprintf (mfp,"  %5d : %d\n", i, rlong ());
            ++i;
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

        fprintf (mfp,"Dynamic types : \n");

        for (;;)
        {
            dtype = rlong ();

            if (dtype == -1)
                break;

            fprintf (mfp,"  Type       : %ld\n", dtype);
            fprintf (mfp,"  Orig. type : %ld\n", rlong ());
        }
    }

    print_line ();
}
/*------------------------------------------------------------------*/

static  void    analyze_dispatch_table ()

{
    long    dcount, i, bidx, bitem;

    dcount = rlong ();

    fprintf (mfp,"Dispatch table : %ld\n", dcount);

    for (;;)
    {
        bidx = rlong ();

        if (bidx == -1)
            break;

        fprintf (mfp,"   Body index  : %ld\n", bidx);
        fprintf (mfp,"   Entry       : %ld\n", rlong ());
    }

    print_line ();

}
/*------------------------------------------------------------------*/

static  void    read_byte_code ()

{
    long    body_id, bsize, pattern_id;

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

    /* Write java flag */

    if (fwrite (&java_mode, sizeof (char), 1, bfp) != 1)
    {
        fprintf (stderr,"Write error\n");
        panic ();
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

        if (fwrite (melt [body_id], sizeof (char), bsize, bfp) != bsize)
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

static  void    analyze_conformance ()

{
    short   dtype, dmin, dmax;
    int     asize;

    if (rchar ())
    {
        fprintf (mfp,"Has conformance table : YES\n");
    }
    else
    {
        fprintf (mfp,"Has conformance table : NO\n");
        return;
    }

    for (;;)
    {
        dtype = rshort ();

        if (dtype == -1)
            break;

        fprintf (mfp,"Dynamic type : %d\n", (int) dtype);
        
        dmin  = rshort ();
        dmax  = rshort ();
        asize = (((int) (dmax - dmin + 1))/8) * sizeof (char);
        
        fprintf (mfp,"Min          : %d\n", (int) dmin);
        fprintf (mfp,"Max          : %d\n", (int) dmax);

        rseq (asize);
    }

    print_line ();

    analyze_cecil ();
}
/*------------------------------------------------------------------*/

static  void    analyze_cecil ()

{
    int     i;
    short   slen, tsize, nb_generics, nb_types;

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

    for (;;)
    {
        dtype = rshort ();

        if (dtype == -1)
            break;

        fprintf (mfp,"Dynamic type   : %d\n", (int) dtype);
        fprintf (mfp,"Assertion kind : %d\n", (int) rchar ());

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

    count = (long) ruint32 ();

    fprintf (mfp,"Routine info : %ld\n\n", count);
    fprintf (mfp,"Routine Id   Origin  Offset\n");

    rid = 0;

    while (count--)
    {
        org = (long) rshort ();
        off = (long) rshort ();
        fprintf (mfp,"%8ld   %5ld  %5ld\n", (int) rid, (int) org, (int) off);

        ++rid;
    }

    print_line ();
}
/*------------------------------------------------------------------*/

static  void    analyze_desc ()

{
    long    count, tid, info, type;
    short   org_count, rout_count;

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
                fprintf (mfp,"Origin_id %5d  Dtype_id %8d\n", (int) rshort (), tid);

                rout_count = rshort ();

                while (rout_count--)
                {
                    info = (long) rshort ();
                    type = (long) rshort ();

                    fprintf (mfp,"  I/T : [%5d, %5d]\n", (int) info, (int) type);
                }
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

    if (fread (result, sizeof (char), size, ifp) != size)
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

static  void    print_type (uint32 type)

{
    fprintf (mfp, "(%u) ", type);

    if ((type & SK_HEAD) != SK_VOID) 
    {
        switch (type & SK_HEAD) 
        {
            case SK_BOOL:   fprintf (mfp,"BOOLEAN");
                            break;
            case SK_CHAR:   fprintf (mfp,"CHARACTER");
                            break;
            case SK_INT:    fprintf (mfp,"INTEGER");
                            break;
            case SK_FLOAT:  fprintf (mfp,"FLOAT");
                            break;
            case SK_DOUBLE: fprintf (mfp,"DOUBLE");
                            break;
            case SK_POINTER:fprintf (mfp,"POINTER");
                            break;
            case SK_BIT:    fprintf (mfp,"BIT");
                            break;
            case SK_EXP:    fprintf (mfp,"ET %u", type & SK_DTYPE);
                            break;
            case SK_REF:    fprintf (mfp,"RT %u", type & SK_DTYPE);
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

