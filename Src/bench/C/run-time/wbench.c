/*
 #    #  #####   ######  #    #   ####   #    #           ####
 #    #  #    #  #       ##   #  #    #  #    #          #    #
 #    #  #####   #####   # #  #  #       ######          #
 # ## #  #    #  #       #  # #  #       #    #   ###    #
 ##  ##  #    #  #       #   ##  #    #  #    #   ###    #    #
 #    #  #####   ######  #    #   ####   #    #   ###     ####

		Workbench primitives
*/

#include "config.h"
#include "macros.h"
#include "malloc.h"
#include "garcol.h"
#include "struct.h"
#include "hashin.h"
#include "except.h"
#include "wbench.h"
#include "interp.h"
#include "plug.h"

/*#define DEBUG 6	/**/
#define dprintf(n) if (DEBUG & n) printf

private struct as_info *rec_waslist();		/* Recursion */

public char *(*wfeat(static_type, feature_id, dyn_type))()
int static_type, dyn_type;
int32 feature_id;
{
	/* Function pointer associated to Eiffel feature of feature id
	 * `feature_id' accessed in Eiffel static type `static_type' to
	 * apply on an object of dynamic type `dyn_type'.
	 * Return a function pointer.
	 * NOTE: static_type is not the static type of the class
	 * but just a number that does not change, dixit FREDD
	 */

	int32 rout_id;
	struct ca_info *info;
	uint32 body_id;

	nstcall = 0;	/* No invariant check */
	rout_id = Routids(static_type)[feature_id];
	info = &((struct ca_info *) Table(rout_id))[dyn_type];
	body_id = dispatch[info->ca_id];

#ifdef DEBUG
	dprintf(2)(
		"\tcall [fid: %d stat: %d dyn: %d] rout_id: %ld bidx: %ld bid: %ld\n",
		feature_id, static_type, dyn_type, rout_id, info->ca_id, body_id);
#endif
	if (body_id < zeroc) {
		return frozen[body_id];		/* Frozen feature */
	}
	else {
		IC = melt[body_id - zeroc];	/* Position byte code to interpret */
		return pattern[info->ca_pattern_id].toi;
	}
}

public char *(*wfeat_inv(static_type, feature_id, name, object))()
int static_type;
int32 feature_id;
char *object;
char *name;
{
	/* Function pointer associated to Eiffel feature of feature id
	 * `feature_id' accessed in Eiffel static type `static_type' to
	 * apply on an object `object'.
	 * Return a function pointer.
	 */

	int dyn_type;
	int32 rout_id;
	uint32 body_id;
	struct ca_info *info;

	if (object == (char *) 0)			/* Void reference check */
			/* Raise an exception for a feature named `fname' applied
			 * to a void reference. */
		eraise(name, EN_VOID);

	nstcall = 1;						/* Invariant check on */

	dyn_type = Dtype(object);

	rout_id = Routids(static_type)[feature_id];
	info = &((struct ca_info *) Table(rout_id))[dyn_type];
	body_id = dispatch[info->ca_id];

#ifdef DEBUG
	dprintf(2)(
		"\tcall [fid: %d stat: %d dyn: %d] rout_id: %ld bidx: %ld bid: %ld\n",
		feature_id, static_type, dyn_type, rout_id, info->ca_id, body_id);
#endif

	if (body_id < zeroc)
		/* Frozen feature */
		return frozen[body_id];
	else {
		IC = melt[body_id - zeroc];	/* Position byte code to interpret */
		return pattern[info->ca_pattern_id].toi;
	}
}

public fnptr wpointer(static_type, feature_id, dyn_type)
int static_type, dyn_type;
int32 feature_id;
{
	/* Function pointer associated to Eiffel feature of feature id
	 * `feature_id' accessed in Eiffel static type `static_type' to
	 * apply on an object of dynamic type `dyn_type'.
	 * Return a function pointer if not melted.
	 */

	int32 rout_id;
	uint32 body_id;
	struct ca_info *info;
	int16 body_index;

	rout_id = Routids(static_type)[feature_id];
	body_index = ((struct ca_info *)Table(rout_id))[dyn_type].ca_id;
	body_id = dispatch[body_index];

	if (body_id < zeroc)
		/* Frozen feature */
		return frozen[body_id];
	else
		xraise(EN_DOL);
}

public long wattr(static_type, feature_id, dyn_type)
int static_type, dyn_type;
int32 feature_id;
{
	/* Offset of attribute of feature id `feature_id' in the class of
	 * static type `static_type' in an object of dynamic type `dyn_type'.
	 * Return a long integer.
	 */

	int32 rout_id;

	rout_id = Routids(static_type)[feature_id];
#ifdef DEBUG
    dprintf(2)("\taccess [fid: %d stat: %d dyn: %d] rout_id: %ld\n" ,
		feature_id, static_type, dyn_type, rout_id);
#endif

	return ((long *) Table(rout_id))[dyn_type];
}

public long wattr_inv (static_type, feature_id, name, object)
int static_type;
int32 feature_id;
char *object;	/* Target object */
char *name;		/* Feature name to apply */
{
	/* Offset of attribute of feature id `feature_id' in the class of
	 * static type `static_type' in an object `object'.
	 * Return a long integer.
	 */

	int dyn_type;
	int32 rout_id;

	if (object == (char *) 0)			/* Void reference check */
			/* Raise an exception for a feature named `fname' applied
			 * to a void reference. */
		eraise(name, EN_VOID);

	dyn_type = Dtype(object);
	if (WASC(dyn_type) & CK_INVARIANT)	/* Invariant checking */
		chkinv(object);

	rout_id = Routids(static_type)[feature_id];
#ifdef DEBUG
    dprintf(2)("\taccess [fid: %d stat: %d dyn: %d] rout_id: %ld\n" ,
        feature_id, static_type, dyn_type, rout_id);
#endif

	return ((long *) Table(rout_id))[dyn_type];
}

public struct ca_info *wcainfo(static_type, feature_id, dyn_type)
int static_type, dyn_type;
int32 feature_id;
{
	/* Call info  of feature of feature id `feature_id' in the class of
	 * static type `static_type' in an object of dynamic type `dyn_type'.
	 * Return a call info pointer.
	 */

	int32 rout_id;

	rout_id = Routids(static_type)[feature_id];
	return &((struct ca_info *) Table(rout_id))[dyn_type];
}

public int wtype(static_type, feature_id, dyn_type)
int dyn_type, static_type;
int32 feature_id;
{
	/* Type of feature of routine id `rout_id' in the class of
	 * dynamic type `dyn_type'.
	 * Return an integer.
	 */ 

	int32 rout_id;

	rout_id = Routids(static_type)[feature_id];
	return Type(rout_id)[dyn_type] & SK_DTYPE;
}

