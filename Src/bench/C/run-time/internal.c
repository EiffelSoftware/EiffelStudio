/*

    #    #    #   #####  ######  #####   #    #    ##    #                ####
    #    ##   #     #    #       #    #  ##   #   #  #   #               #    #
    #    # #  #     #    #####   #    #  # #  #  #    #  #               #
    #    #  # #     #    #       #####   #  # #  ######  #        ###    #
    #    #   ##     #    #       #   #   #   ##  #    #  #        ###    #    #
    #    #    #     #    ######  #    #  #    #  #    #  ######   ###     ####

	Routines to implement class INTERNAL
*/
#ifdef FIXME
#include "eiffel.h"
#include "config.h"
#include "malloc.h"
#include "garcol.h"
#include "struct.h"
#include "out.h"
#include "macros.h"         /* For macro LNGOFF */
#include "plug.h"

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

/*
 * Private declarations
 */

#define MAX_VALUE_SIZE 40	/* max size of nums in # of chars with %X %d... */

/*
 * Routine definitions
 */

uint32 v3_type(object)
register1 char *object;
{
	/*
	 * Return in long integer form the type of the object `object'.
	 */

	return HEADER(object)->ov_flags;
}

char *v3_address(object)
register1 char *object;
{
	/*
	 * Return Eiffel string containing the address of 'object'.
	 */

	char buffer[MAX_VALUE_SIZE];
	
	sprintf(buffer, "%X", object);

	return makestr(buffer, strlen(buffer));
}

uint32 v3_attribute_count(object)
register1 char *object;
{
	/*
	 * Return number of attributes in object
	 */

   	return (uint32) System(Dtype(object)).cn_nbattr;
}

char *v3_expanded_object(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return object known to be expanded at the valid entry i
	 * in object `object'.
	 */

	struct cnode *object_description;
	int16 dyn_type = Dtype(object);
#ifdef WORKBENCH
	int32 attr_key;
	struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	return (char *)(object + object_description->cn_offsets[i][dyn_type]);
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	return (char *) (object + ((attr_info->ca_id) & CA_ID));
#endif
}

char *v3_special_object(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return object known to be special at the valid entry i in object
	 * `object'.
	 */

	struct cnode *object_description;
    register2 char *o_ref;
	int16 dyn_type = Dtype(object);
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif

    return *(char **)o_ref;
}

int v3_special_has_reference(object)
register1 char *object;
{
	/*
	 * Return true if `object' which is a special object,
	 * contains references
	 */

	return HEADER(object)->ov_flags & EO_REF ? 1 : 0;
}

int v3_special_has_composite(object)
register1 char *object;
{
	/*
	 * Return true if `object' which is a special object,
	 * contains composite elements
	 */

	return HEADER(object)->ov_flags & EO_REF ? 1 : 0;
}

uint32 v3_special_content_type(object)
register1 char *object;
{
	/*
	 * Return type of elements in `object' which is a special object
	 * containing simple elements: boolean, character, int, real or double.
	 */

	return (long)(HEADER(object)->ov_flags & EO_TYPE);
}

uint32 v3_special_count(object)
register1 char *object;
{
	/*
	 * Return number of elements in `object' which is a special object
	 */

	register2 uint32 flags;							/* Object flags */
	register3 char *o_ref;
	union overhead *zone = HEADER(object);			/* Object header */

	flags = zone->ov_flags;
	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGOFF(2));
	
	return *(long *)(o_ref);
}

uint32 v3_ith_type(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return type of `i'-th element in `object', i is known to be
	 * a valid entry.
	 */

	struct cnode *object_description;
	register2 long flags;								/* Object flags */
	register3 char *o_ref;
	register4 char *reference;
	register5 long elem_size;
	union overhead *zone = HEADER(object);				/* Object header */
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	if(zone->ov_flags & EO_SPEC) {
		flags = zone->ov_flags;
		if(!(flags & EO_REF))
			return (flags & EO_TYPE);
		else if(!(flags & EO_COMP)) {
			o_ref = (char *) ((char **)object + i);
			reference = *(char **)o_ref;
			if (0 == reference)
				return SK_INVALID;			/* Signals: void reference */
			else
				return Dtype(reference);
		} else {
			o_ref = (char *)(object + (zone->ov_size & B_SIZE) - LNGOFF(2));
			elem_size = *(long *)(o_ref + sizeof(long));
			o_ref = (char *)(object + i*elem_size + OVERHEAD);
			return Dtype(o_ref);
		}
	}
	else {
		object_description = &System(Dtype(object));
#ifndef WORKBENCH
		return object_description->cn_types[i];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	return attr_info->ca_type;
#endif
		}
}

char *v3_bool_value(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return value in Eiffel String form of the `i'-th element which is
	 * known to be a valid entry and a boolean entity.
	 */

	struct cnode *object_description;
	register2 char *o_ref;
	int16 dyn_type = Dtype(object);
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
	return (*o_ref) ? makestr("true", 4) : makestr("false", 5);
}

char *v3_char_value(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return value in Eiffel String form of the `i'-th element which
	 * is known to be a valid entry and a character entity.
	 */

	struct cnode *object_description;
	register2 char *o_ref;
	char buffer[1];
	int16 dyn_type = Dtype(object);
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
	sprintf(buffer, "%c", *o_ref);

	return makestr(buffer, strlen(buffer));
}

char *v3_int_value(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return value in Eiffel String form of the `i'-th element which
	 * is known to be a valid entry and an integer entity.
	 */

	struct cnode *object_description;
	register2 char *o_ref;
	char buffer[MAX_VALUE_SIZE];
	int16 dyn_type = Dtype(object);
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
	sprintf(buffer, "%ld", (long)*(long *)o_ref);

	return makestr(buffer, strlen(buffer));
}

char *v3_real_value(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return value in Eiffel String form of the `i'-th element which
	 * is known to be a valid entry and a real entity.
	 */

	struct cnode *object_description;
	register2 char *o_ref;
	char buffer[MAX_VALUE_SIZE];
	int16 dyn_type = Dtype(object);
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
	sprintf(buffer, "%f", (float)*(float *)o_ref);

	return makestr(buffer, strlen(buffer));
}

char *v3_double_value(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return value in Eiffel String form of the `i'-th element which
	 * is known to be a valid entry and a double entity.
	 */

	struct cnode *object_description;
	register2 char *o_ref;
	int16 dyn_type = Dtype(object);
	char buffer[MAX_VALUE_SIZE];
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description  = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
	sprintf(buffer, "%lf", (double)*(double *)o_ref);

	return makestr(buffer, strlen(buffer));
}

char *v3_expanded_value(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return address in Eiffel String form of the `i'-th element which
	 * is known to be a valid entry and a expanded object.
	 */

	struct cnode *object_description;
	register2 char *o_ref;
	int16 dyn_type = Dtype(object);
	char buffer[MAX_VALUE_SIZE];
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	object_description = &System(dyn_type);
#ifndef WORKBENCH
	o_ref = object + object_description->cn_offsets[i][dyn_type];
#else
	attr_key = object_description->cn_attr[i];
	attr_info = (struct ca_info *) ht_value
		(&object_description->cn_eroutdf,attr_key);
	o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
	sprintf(buffer, "%X", (char *)o_ref);

	return makestr(buffer, strlen(buffer));
}

char *v3_ith_reference(object, i)
uint32 i;
register1 char *object;
{
	/*
	 * Return value in Eiffel String form of the `i'-th element which
	 * is known to be a valid entry and a normal reference.
	 */

	struct cnode *object_description;
	register2 long flags;								/* Object flags */
	register3 char *o_ref;
	register5 long elem_size;
	union overhead *zone = HEADER(object);				/* Object header */
	char *reference;
	char buffer[MAX_VALUE_SIZE];
	int16 dtype;
#ifdef WORKBENCH
    int32 attr_key;
    struct ca_info *attr_info;
#endif

	if(zone->ov_flags & EO_SPEC) {
		o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGOFF(2));
		flags = zone->ov_flags;
		if(!(flags & EO_COMP)) {
			o_ref = (char *) ((char **)object + i);
			reference = *(char **)o_ref;
			if (0 == reference)
				sprintf(buffer, "");
			else
				sprintf(buffer, "%X", reference);
		} else {
			o_ref = (char *)(object + (zone->ov_size & B_SIZE) - LNGOFF(2));
			elem_size = *(long *)(o_ref + sizeof(long));
			o_ref = (char *)(object + i*elem_size + OVERHEAD);
		}
	}
	else {
		dtype = Dtype(object);
		object_description = &System(dtype);
#ifndef WORKBENCH
		o_ref = object + object_description->cn_offsets[i][dtype];
#else
		attr_key = object_description->cn_attr[i];
		attr_info = (struct ca_info *) ht_value
			(&object_description->cn_eroutdf,attr_key);
		o_ref = object + ((attr_info->ca_id) & CA_ID);
#endif
		sprintf(buffer, "%X", *(char **)o_ref);
	}
	return makestr(buffer, strlen(buffer));
}
#endif
