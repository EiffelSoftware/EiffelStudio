/*

 #    #  #####   #####     ##     #####  ######           ####
 #    #  #    #  #    #   #  #      #    #               #    #
 #    #  #    #  #    #  #    #     #    #####           #
 #    #  #####   #    #  ######     #    #        ###    #
 #    #  #       #    #  #    #     #    #        ###    #    #
  ####   #       #####   #    #     #    ######   ###     ####


	Interpretor datas update primitives
*/
/* TEMPORARY */
#include <stdio.h>
extern char *getenv();

#include "macros.h"
#include "struct.h"
#include "hashin.h"
#include "except.h"
#include "update.h"
#include "cecil.h"

private void cnode_updt();			/* Update a cnode structure */
private void routid_updt();			/* Update routine id array */
private void conform_updt();		/* Update a conformance table */
private void option_updt();			/* Update the option table */
private void cecil_updt();			/* Cecil update */
private char **names_updt();		/* String array */
private void root_class_updt();		/* Update the root class info */
private void routinfo_updt();		/* Update the rout info table */
private void desc_updt();			/* Update the descriptors */

public long mcount;					/* Size of melting table */

/* For debugging */
#define dprintf(n)	  if (DEBUG & (n)) printf
/*#define DEBUG 3		/**/

extern void wread();

/* TEMPORARY */
FILE *fil;
#define TEST
#ifdef TEST
extern void idump();
#endif

public void update()
{
	/* Update internal structures before execution */

	long count;								/* New size for `esystem' */
	long body_index;						/* Last body index */
	long body_id;							/* Last body id */
	char *bcode;							/* Last byte code */
	long bsize;								/* Last byte code size */
	long new_count;							/* New system size */
	char c;
	char *meltpath;							/* directory of .UPDT */
	char *filename;							/* .UPDT complet path */
	long pattern_id;


/* TEMPORARY */
meltpath = getenv ("MELT_PATH");
if (meltpath) 
	filename = (char *)cmalloc (strlen (meltpath) + 7);
else
	filename = (char *)cmalloc (8);
if (filename == (char *)0){
	enomem();	
	exit (0);	
}
if (meltpath) strcpy (filename, meltpath);
else strcpy (filename, ".");
strcat(filename, "/.UPDT");

#ifdef DEBUG
	dprintf(1)("Frozen level = %d\n", zeroc);
	dprintf(1)("Reading .UPDT in: %s\n", filename);
#endif

if ((fil = fopen(filename, "r")) == (FILE *) 0) {
	fprintf(stderr, "Error: could not open Eiffel .UPDT file\n");
	exit(0);
}
	xfree (filename);
	wread(&c, 1);				/* Is there something to update ? */
	if (c == '\0') {
		init_desc();
		return;
	}

		/* Update the root class and the creation feature ids */
	root_class_updt ();

	count = wlong();			/* Read the count of class types */
	new_count = count;
	ccount = wlong();			/* Read the count of classes */
#ifdef DEBUG
	dprintf(1)("New class type count: %ld\n", count);
#endif
	/* Allocation of variable `esystem' */
	esystem = (struct cnode *) cmalloc(count * sizeof(struct cnode));
	if (esystem == (struct cnode *) 0)
		enomem();				/* Not enough room */
	bcopy(fsystem, esystem, scount * sizeof(struct cnode));

	/* Allocation of the variable `ecall' */
	ecall = (int32 **) cmalloc(count * sizeof(int32 *));
	if (ecall == (int32 **) 0)
		enomem();
	bcopy(fcall, ecall, scount * sizeof(int32 *));

	scount = count;
	/* Feature table update */
	count = wlong();
#ifdef DEBUG
	dprintf(1)("Number of feature tables to update: %d\n", count);
#endif

	while (count-- > 0)
		cnode_updt();

	/* Update possible routine id array */
	routid_updt();

	/* Read the dispatch table new count */
	count = wlong();
#ifdef DEBUG
	dprintf(1)("=== New count for dispatch table: %ld [old = %ld] ===\n", count, dcount);
#endif
	/* Allocation of variable `dispatch' */
	dispatch = (uint32 *) cmalloc(count * sizeof(uint32));
	if (dispatch == (uint32 *) 0)
		enomem();

	/* Copy of the frozen dispatch table into `dispatch' */
	bcopy(fdispatch, dispatch, dcount * sizeof(uint32));

	/* Update of the dispatch table */
	while ((body_index = wlong()) != -1) {
		dispatch[body_index] = wlong();
#ifdef DEBUG
	dprintf(1)("dispatch[%ld] = %ld\n", body_index, dispatch[body_index]);
#endif
	}

	/* Updating of the melting table */
	mcount = wlong();		/* Read the size of the byte code array */
#ifdef DEBUG
	dprintf(1)("=== Size of melted table: %ld ===\n", mcount);
#endif
	/* Allocation of the variable `melt' */
	melt = (char **) cmalloc(mcount * sizeof(char *));
	if (melt == (char **) 0)
		enomem();
	/* Allocation of the variable `mpatidtab' */
	mpatidtab = (int *) cmalloc(mcount * sizeof(int));
	if (mpatidtab == (int *) 0)
		enomem();

	while ((body_id = wlong()) != -1) {
if (body_id < 0 ) {printf (""); }
		bsize = wlong();
		pattern_id = wlong();
if (body_id >= 0)
		mpatidtab[body_id] = (int) pattern_id;
		bcode = cmalloc(bsize * sizeof(char));
		if (bcode == (char *) 0)
			enomem();
		/* Read the byte code */
		wread(bcode, bsize * sizeof(char));
if (body_id >= 0)
		melt[body_id] = bcode;

#ifdef DEBUG
	dprintf(2)("------------------\n");
	if (DEBUG & (2)) idump(stdout, bcode); 
	dprintf(2)("------------------\n");
#endif

#ifdef DEBUG
	dprintf(1)("sizeof(melt[%ld]) = %ld\n", body_id, bsize);
#endif
	}

	/* Recompute adresses of `melt' and `patidtab' */

	melt -= zeroc;
	mpatidtab -= zeroc;

	/* Conformance table if any */
	wread (&c, 1);
	if (c == '\01') {
#ifdef DEBUG
	dprintf(1)("updating conformance table\n");
#endif
	conform_updt(new_count);

	}
	/* Option table */
	option_updt(new_count);

	/* Routine info table */
	routinfo_updt();

	/* Descriptors */
	init_desc();
	desc_updt();

/* TEMPORARY */
fclose(fil);
}

/* TEMPORARY */
void wread(buffer, nbytes)
char *buffer;
int nbytes;
{
#ifdef DEBUG
	dprintf(8)("Reading %d bytes at %d%\n", nbytes, ftell(fil));
#endif
	if (nbytes != fread(buffer, sizeof(char), nbytes, fil)) {
		fprintf(stderr, "Error: could not read Eiffel .UPDT file\n");
		exit(0);
	}
#ifdef DEBUG
{
	int i;
	for (i=0; i< nbytes; i++)
		dprintf(8)("\t%d: %d\n", i + 1, buffer[i]);
}
#endif
}

private void root_class_updt ()
{
	/* Update the root class info */

	extern int rcst;
	extern int rcdt;
	extern int32 rcfid;
	extern int rcarg;

	rcst = wlong();
	rcdt = wlong();
	rcfid = wlong();
	rcarg = wlong();

#ifdef DEBUG
	dprintf(1)("Root class info:\n\trcst = %ld, rcdt = %ld\n", rcst, rcdt);
	dprintf(1)("\trcfid = %ld, rcarg = %ld\n", rcfid, rcarg);
#endif
}

private void cnode_updt()
{
	/* Update a cnode structure */

	short dtype;			/* Dynamic type to update */
	short str_count;		/* String count */
	char *str;				/* String to allocate */
	short nbattr;			/* Attributes number */
	struct cnode *node;		/* Structure to update */
	char **names;			/* Name array */
	uint32 *types;			/* Attribute meta-type array */
	short nbparents;		/* Parent count */
	int *parents;			/* Parent dynmaic type array */
	short parent_dtype;		/* Parent dynamic type */
	int32 *rout_ids;		/* Routine id array */
	int32 rout_id;			/* Attribute routine id */
	int32 *feat_ids;		/* Feature id array */
	long feat_count;		/* Feature id array count */
	struct htable *htbl;	/* Hash table for calls */
	int32 call_size;		/* Hash table call size */
	char is_attribute;
	int i;
	char c;
	short level;			/* Attribute meta-type level */
	int32 feature_id;		/* Key for access table */

		/* 1. Dynamic type */
	dtype = wshort();
	node = &System(dtype);
#ifdef DEBUG
	dprintf(4)("Updating cnode of dyn type %d\n", dtype);
#endif

		/* 2. Generator string: the terminator null character is not
		 * in th byte code array read by `wread'. Read first the string,
		 * and then the character sequence */
	str_count = wshort();
	str = cmalloc((str_count + 1) * sizeof(char));
	if (str == (char *) 0)
		enomem();
	node->cn_generator = str;
	wread(str, str_count * sizeof(char));
	str[str_count] = '\0';
#ifdef DEBUG
	dprintf(4)("\tgenerator = %s\n", node->cn_generator);
#endif

		/* 3. Number of attributes */
	nbattr = wlong();
	node->cn_nbattr = nbattr;
#ifdef DEBUG
	dprintf(4)("\tattribute number = %ld\n", node->cn_nbattr);
#endif

		/* 4. Attribute names array */
	if (nbattr > 0) {
		names = (char **) cmalloc(nbattr * sizeof(char *));
		if (names == (char **) 0)
			enomem();
		node->cn_names = names;
		types = (uint32 *) cmalloc(nbattr * sizeof(uint32));
		if (types == (uint32 *) 0)
			enomem();
		node->cn_types = types;
#ifdef DEBUG
	dprintf(4)("\tattribute names = ");
#endif
		for (i=0; i<nbattr; i++) {
			str_count = wshort();
			str = cmalloc((str_count + 1) * sizeof(char));
			if (str == (char *) 0)
				enomem();
			wread(str, str_count * sizeof(char));
			str[str_count] = '\0';
			names[i] = str;
#ifdef DEBUG
	dprintf(4)("%s ", str);
#endif
		}
#ifdef DEBUG
	dprintf(4)("\tattribute types = ");
#endif
		for (i=0; i<nbattr; i++) {
			types[i] = wuint32();
#ifdef DEBUG
	dprintf(4)("0x%x ", types[i]);
#endif
		}
		
	} else {
		node->cn_names = (char **) 0;
		node->cn_types = (uint32 *) 0;
	}
		
		/* 5. Parent dynamic type array */
	nbparents = wshort();
	parents = (int *) cmalloc((nbparents + 1) * sizeof(int));
	if (parents == (int *) 0)
		enomem();
	node->cn_parents = parents;
#ifdef DEBUG
	dprintf(4)("\n\tparents = ");
#endif
	for (i=0; i<nbparents; i++) {
		parents[i] = (int) wshort();
#ifdef DEBUG
	dprintf(4)("%d ", parents[i]);
#endif
	}
	parents[nbparents] = -1;

		/* 6. Attribute routine id array */
	if (nbattr > 0) {
		rout_ids = (int32 *) cmalloc(nbattr * sizeof(int32));
		if (rout_ids == (int32 *) 0)
			enomem();
		node->cn_attr = rout_ids;
		wread(rout_ids, nbattr * sizeof(int32));
#ifdef DEBUG
	dprintf(4)("\n\trout id array = ");
	for (i=0; i<nbattr; i++)
		dprintf(4)("%ld ", rout_ids[i]);
#endif
	} else
		node->cn_attr = (int32 *) 0;

		/* 7. Reference number */
	node->nb_ref = wlong();
#ifdef DEBUG
	dprintf(4)("\n\treference number = %ld\n", node->nb_ref);
#endif

		/* 8. Node size */
	node->size = wlong();
#ifdef DEBUG
	dprintf(4)("\tsize = %ld\n", node->size);
#endif

	wread(&node->cn_deferred, 1);		/* Deferred flag */
	wread(&node->cn_composite, 1);		/* Composite flag */
	node->cn_creation_id = wint32();	/* Creation feature id */
	node->static_id = wint32();			/* Static id of Class */
	wread(&node->cn_disposed, 1);		/* Dispose flag */ 
#ifdef DEBUG
	dprintf(4)("\tcreation_id = %ld\n", node->cn_creation_id);
	dprintf(4)("\tstatic_id = %ld\n", node->static_id);
	dprintf(4)("\tdispose_id = %ld\n", node->cn_disposed);
#endif
}

private void routid_updt()
{
	/* Update routine id arrays */

	long class_id, dtype, orig_dtype;
	long array_size;
	int32 *cn_eroutid;
	char has_cecil;
	char **names = (char **) 0;
	uint32 *feature_ids = (uint32 *) 0;
	long size = 0;

	while ((class_id = wlong()) != -1L) {
		array_size = wlong();   /* Array size */
#ifdef DEBUG
	dprintf(4)("Updating rids of class of id %ld [%ld]\n",
		class_id, array_size);
#endif
		cn_eroutid = (int32 *) cmalloc(array_size * sizeof(int32));
		if (cn_eroutid == (int32 *) 0)
			enomem();
		wread(cn_eroutid, array_size * sizeof(int32));
#ifdef DEBUG
{
	long i;
    for (i=0; i<array_size; i++) 
        dprintf(4)("ra%d[%ld] = %ld\n", class_id, i, cn_eroutid[i]);
}
#endif
		wread(&has_cecil, 1);		/* Cecil ? */
		if (has_cecil) {
			size = wlong();		/* Hash table size */
			names = names_updt(size);
			feature_ids = (uint32 *) cmalloc(size * sizeof(uint32));
			if (feature_ids == (uint32 *) 0)
				enomem();
			wread(feature_ids, size * sizeof(uint32));
		}
		while ((dtype = wlong()) != -1L) {	/* Dynamic type */
#ifdef DEBUG
	dprintf(4)("\tfor %s [dt = %ld]\n", System(dtype).cn_generator, dtype);
#endif
			orig_dtype = wlong();
			Routids(orig_dtype) = cn_eroutid;
			System(dtype).cn_routids = cn_eroutid;
			if (has_cecil) {
				struct ctable *ce = &Cecil(dtype);

				ce->h_size = (int32) size;
				ce->h_sval = sizeof(uint32);
				ce->h_keys = names;
				ce->h_values = (char *) feature_ids;
			}
		}
	}
}

private void conform_updt(new_count)
long new_count;		/* New system size */
{
	/* Update conformance table */

	register1 short dtype;				/* Dynamic type to update */
	register2 struct conform *new;		/* New conformance table structure */
	register6 short min;				/* Minimum dyn. type for `new' */
	register5 short max;				/* Maximum dyn. type for `new' */
	register3 char *area;				/* Area of `new' */
	register4 short area_size;			/* Size of `area' */

	/* Allocation of the conformance table */
	co_table =
		(struct conform **) cmalloc(new_count * sizeof(struct conform *));
	if (co_table == (struct conform **) 0)
		enomem();

	while ((dtype = wshort()) != -1) {	/* Get a dynamic type */
		new = (struct conform *) cmalloc(sizeof(struct conform));
		if (new == (struct conform *) 0)
			enomem();

		min = wshort();
		new->co_min = min;
		max = wshort();
		new->co_max = max;

		/* Constant `8' is hardcoded here as in Eiffel: it is the bits
		 * number of a character */
		area_size = ((max - min + 1) / 8) * sizeof(char);
		area = cmalloc(area_size);
		if (area == (char *) 0)
			enomem();
		new->co_tab = area;
		wread(area, area_size);

		co_table[dtype] = new;
	}
	cecil_updt();
}

private void cecil_updt()
{
	/* Update high-level cecil structure. */

	short count, i, nb_generics, nb_types, n;
	uint32 *type_val;
	struct gt_info *gtype_val;
	int32 *gt_gen;
	int16 *gt_type;
	struct ctable *ce_nogeneric = &ce_type;
	struct ctable *ce_generic = &ce_gtype;

	/* First, non-generic class table */
	count = wshort();					/* Table size */
	ce_nogeneric->h_size = count;
	ce_nogeneric->h_sval = sizeof(uint32);
	ce_nogeneric->h_keys = names_updt(count);
	type_val = (uint32 *) cmalloc(count * sizeof(uint32));
	if (type_val == (uint32 *) 0)
		enomem();
	wread(type_val, count * sizeof(uint32));
	ce_nogeneric->h_values = (char *) type_val;

	/* Seocnd, generic class table */
	count = wshort();					/* Table size */
	ce_generic->h_size = count;
	ce_generic->h_sval = sizeof(struct gt_info);
	ce_generic->h_keys = names_updt(count);
	gtype_val = (struct gt_info *) cmalloc(count * sizeof(struct gt_info));
	if (gtype_val == (struct gt_info *) 0)
		enomem();
	ce_generic->h_values = (char *) gtype_val;
	for (i=0; i<count; gtype_val++,i++) {
		nb_generics = wshort();				/* Number of generic parameters */
		if (nb_generics == 0)
			continue;
		gtype_val->gt_param = nb_generics;
		nb_types = wshort();				/* Number of class types */
		n = nb_generics * nb_types;
		gt_gen = (int32 *) cmalloc((n + 1) * sizeof(int32));
		if (gt_gen == (int32 *) 0)
			enomem();
		wread(gt_gen, n * sizeof(int32));	/* Read meta type desc */
		gt_gen[n] = SK_INVALID;
		gtype_val->gt_gen = gt_gen;
		gt_type = (int16 *) cmalloc(nb_types * sizeof(int16));
		if (gt_type == (int16 *) 0)
			enomem();
		wread(gt_type, nb_types * sizeof(int16));
		gtype_val->gt_type = gt_type;
	}
}

private char **names_updt(count)
short count;
{
	/* Return and array of string of count `count'. */

	short i, len;
	char **result;
	char *name;

	result = (char **) cmalloc(count * sizeof(char *));
	if (result == (char **) 0)
		enomem();
	for (i=0; i<count; i++) {
		len = wshort();			/* Read string count */
		if (len == 0) {
			result[i] = (char *) 0;
			continue;
		}
		name = (char *) cmalloc((len + 1) * sizeof(char));
		if (name == (char *) 0)
			enomem();
		wread(name, len);		/* Read string content */
		name[len] = '\0';
		result[i] = name;
	}
	return result;
}
		
private void option_updt(new_count)
long new_count;
{
	/* Update of the option table */

	char c;
	struct eif_opt *current;	/* Current option structure */
	int16 as_level;				/* Assertion level */
	struct dbg_opt *debug_opt;	/* Debug structure */
	int16 debug_level;			/* Debug level */
	short debug_count;			/* Debug tag count */
	short count;				/* String count */
	char *debug_tag;			/* Debug tag */
	char **keys;				/* Debug tag array */
	short dtype;
	int i;
	
	eoption = (struct eif_opt *) cmalloc(new_count * sizeof(struct eif_opt));
	if (eoption == (struct eif_opt *) 0)
		enomem();

	while ((dtype = wshort()) != -1) {	/* Get a dynamic type */
		current = eoption + dtype;
		bzero(current, sizeof(struct eif_opt));

		wread(&c, 1);			/* Assertion level byte code */
		as_level = 0;
		switch (c) {
		case BCAS_NO:			as_level = AS_NO; 			break;
		case BCAS_REQUIRE:		as_level = AS_REQUIRE;		break;
		case BCAS_ENSURE:		as_level = AS_ENSURE;		break;
		case BCAS_INVARIANT:	as_level = AS_INVARIANT;	break;
		case BCAS_LOOP:			as_level = AS_LOOP;			break;
		case BCAS_CHECK:		as_level = AS_CHECK;		break;
		default:				panic("invalid assertion level");
		}
		current->assert_level = as_level;

		wread(&c, 1);			/* Debug level byte code */
		debug_opt = &current->debug_level;
		debug_level = 0;
		switch (c) {
		case BCDB_NO:	debug_level = DB_NO;
						break;
		case BCDB_YES:	debug_level = DB_ALL;
						debug_opt->nb_keys = 0;
						break;
		case BCDB_TAG:	debug_level = DB_ALL;
						debug_count = wshort();
						keys = (char **) cmalloc(debug_count * sizeof(char *));
						if (keys == (char **) 0)
							enomem();
						debug_opt->keys = keys;
						debug_opt->nb_keys = debug_count;
						for (i=0; i<debug_count; i++) {
							count = wshort();
							debug_tag =
								(char *) cmalloc((count + 1) * sizeof(char));
							if (debug_tag == (char *) 0)
								enomem();
							wread(debug_tag, count);
							debug_tag[count] = '\0';
							keys[i] = debug_tag;
						}
						break;
		default:		panic("invalid debug level");
		}
		debug_opt->debug_level = debug_level;
	}
}

private void routinfo_updt()
{

	/* Update the routine information table */

	uint32 count;
	int i;
	struct rout_info ri;

	count = wuint32();
	eorg_table = (struct rout_info *) cmalloc(count * sizeof(struct rout_info));
	if (eorg_table == (struct rout_info *) 0)
		enomem();
	
	for (i=0;i<count;i++) {
		ri.origin = wshort();
		ri.offset = wshort();
		eorg_table[i] = ri;
	}
}

private void desc_updt()
{
	
	long count;
	short desc_size;
	short org_count, rout_count;
	short type_id, org_id;
	struct desc_info *desc_ptr;
	int i;

	while ((count = wlong()) != -1L) {
		while (count-- > 0) {
			type_id = wshort();
			org_count = wshort();
			while (org_count-- > 0) {
				org_id = wshort();
				rout_count = wshort();
				desc_ptr = (struct desc_info *) 
						cmalloc (rout_count * sizeof(struct desc_info));
				if (desc_ptr == (struct desc_info *) 0)
					enomem();
				for (i=0; i<rout_count;i++) {
					desc_ptr[i].info = wshort();
					desc_ptr[i].type = wshort();
				}
#ifdef DEBUG
	dprintf(4)("Melted descriptor\n\torigin = %d, dtype = %d, RTUD = %d, size = %d\n", 
						org_id, type_id, RTUD(type_id-1), rout_count);
	{
		int i;
		for (i=0;i<rout_count;i++)
			printf ("\t%d: body_index = %d, type = %d\n", i, desc_ptr[i].info, desc_ptr[i].type);
	}
#endif
				IMDSC(desc_ptr, org_id, RTUD(type_id-1));
			}

		}
	}
}

public short wshort()
{
	/* Next short integer. */

	short result;

	wread(&result, sizeof(short));
	return result;
}

public long wlong()
{
	/* Next long integer. */

	long result;

	wread(&result, sizeof(long));
	return result;
}

public int32 wint32()
{
	/* Next int32. */

	int32 result;

	wread(&result, sizeof(int32));
	return result;
}

public uint32 wuint32()
{
	/* Next uint32. */

	uint32 result;

	wread(&result, sizeof(uint32));
	return result;
}
