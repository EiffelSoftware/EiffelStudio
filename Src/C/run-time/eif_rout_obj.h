/*
	description: "Externals for agents and TUPLEs."
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

#ifndef _eif_rout_obj
#define _eif_rout_obj

#ifdef __cplusplus
extern "C" {
#endif


	/*---------------------*/
	/*  For typed element  */
	/*---------------------*/

/* New object of type `dftype' with routine dispatcher `rout_disp',
   argument tuple `args', open map `omap' and closed map `cmap'
*/
RT_LNK EIF_REFERENCE rout_obj_create2 (
								EIF_TYPE_INDEX dftype, 
								EIF_POINTER rout_disp, 
								EIF_POINTER encaps_rout_disp, 
								EIF_POINTER calc_rout_addr, 
								EIF_INTEGER class_id,
								EIF_INTEGER feature_id,
								EIF_REFERENCE open_map,
								EIF_BOOLEAN is_precompiled,
								EIF_BOOLEAN is_basic, 
								EIF_BOOLEAN is_target_closed,
								EIF_BOOLEAN is_inline_agent,
								EIF_REFERENCE closed_operands,
								EIF_INTEGER open_count);
#ifdef WORKBENCH
RT_LNK EIF_REFERENCE rout_obj_create_wb (
								EIF_TYPE_INDEX dftype, 
								EIF_POINTER rout_disp, 
								EIF_POINTER encaps_rout_disp, 
								EIF_POINTER calc_rout_addr, 
								EIF_INTEGER class_id,
								EIF_INTEGER feature_id,
								EIF_REFERENCE open_map,
								EIF_BOOLEAN is_precompiled,
								EIF_BOOLEAN is_basic, 
								EIF_BOOLEAN is_target_closed,
								EIF_BOOLEAN is_inline_agent,
								EIF_REFERENCE closed_operands,
								EIF_INTEGER open_count);
#else
RT_LNK EIF_REFERENCE rout_obj_create_fl (
								EIF_TYPE_INDEX dftype, 
								EIF_POINTER rout_disp, 
								EIF_POINTER encaps_rout_disp, 
								EIF_POINTER calc_rout_addr, 
								EIF_REFERENCE closed_operands,
								EIF_BOOLEAN is_target_closed,
								EIF_INTEGER open_count);
#endif
/* Argument structure (alloc/free) */

RT_LNK EIF_POINTER rout_obj_new_args (EIF_INTEGER count);
RT_LNK void rout_obj_free_args (EIF_POINTER);

/* Calls */

RT_LNK void rout_obj_call_function (EIF_REFERENCE res, EIF_POINTER rout, EIF_POINTER args);


#ifdef WORKBENCH
RT_LNK void rout_obj_call_procedure_dynamic (int stype_id, int feature_id, int is_precompiled, int is_basic_type, int is_inline_agent,
											 EIF_TYPED_VALUE* closed_args, int closed_count, EIF_TYPED_VALUE* open_args, 
											 int open_count, EIF_REFERENCE open_map);
RT_LNK void rout_obj_call_function_dynamic (int stype_id, int feature_id, int is_precompiled, int is_basic_type, int is_inline_agent,
											EIF_TYPED_VALUE* closed_args, int closed_count, EIF_TYPED_VALUE* open_args, 
											int open_count, EIF_REFERENCE open_map, void* res);
#endif

/* Conversion */

	/* Convert SK_... type into type code EIF_..._CODE */
RT_LNK char eif_sk_type_to_type_code (uint32 sk_type);


/* Macros */

#define rout_obj_call_procedure(r,a) ((void(*)(char *, char *, EIF_VALUE *))(r))(((EIF_VALUE*)(a))[0].r, (char *)(((EIF_VALUE*)(a))+1), (EIF_VALUE*)0)

#define rout_obj_call_agent(r,a, val) ((val(*)(EIF_TYPED_VALUE *))(r))(0, (EIF_TYPED_VALUE *)(a))

#define RBVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? EIF_FALSE : *((EIF_BOOLEAN *)v))
#define RCVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_CHARACTER) 0 : *((EIF_CHARACTER *)v))
#define RWCVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_WIDE_CHAR) 0 : *((EIF_WIDE_CHAR *)v))
#define RDVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_REAL_64) 0.0 : *((EIF_REAL_64 *)v))
#define RFVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_REAL_32) 0.0 : *((EIF_REAL_32 *)v))
#define RU8VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_NATURAL_8) 0 : *((EIF_NATURAL_8 *)v))
#define RU16VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_NATURAL_16) 0 : *((EIF_NATURAL_16 *)v))
#define RU32VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_NATURAL_32) 0 : *((EIF_NATURAL_32 *)v))
#define RU64VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_NATURAL_64) 0 : *((EIF_NATURAL_64 *)v))
#define RI8VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_8) 0 : *((EIF_INTEGER_8 *)v))
#define RI16VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_16) 0 : *((EIF_INTEGER_16 *)v))
#define RI32VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_32) 0 : *((EIF_INTEGER_32 *)v))
#define RI64VAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_INTEGER_64) 0 : *((EIF_INTEGER_64 *)v))
#define RPVAL(v) (((EIF_REFERENCE)(v))== (EIF_REFERENCE) 0 ? (EIF_POINTER) 0 : *((EIF_POINTER *)v))

#define rout_obj_putb(a,i,v) (((EIF_VALUE *)(a))[i].b = RBVAL(v))
#define rout_obj_putc(a,i,v) (((EIF_VALUE *)(a))[i].c1 = RCVAL(v))
#define rout_obj_putwc(a,i,v) (((EIF_VALUE *)(a))[i].c4 = RWCVAL(v))
#define rout_obj_putd(a,i,v) (((EIF_VALUE *)(a))[i].r8 = RDVAL(v))
#define rout_obj_putf(a,i,v) (((EIF_VALUE *)(a))[i].r4 = RFVAL(v))
#define rout_obj_putu8(a,i,v) (((EIF_VALUE *)(a))[i].n1 = RU8VAL(v))
#define rout_obj_putu16(a,i,v) (((EIF_VALUE *)(a))[i].n2 = RU16VAL(v))
#define rout_obj_putu32(a,i,v) (((EIF_VALUE *)(a))[i].n4 = RU32VAL(v))
#define rout_obj_putu64(a,i,v) (((EIF_VALUE *)(a))[i].n8 = RU64VAL(v))
#define rout_obj_puti8(a,i,v) (((EIF_VALUE *)(a))[i].i1 = RI8VAL(v))
#define rout_obj_puti16(a,i,v) (((EIF_VALUE *)(a))[i].i2 = RI16VAL(v))
#define rout_obj_puti32(a,i,v) (((EIF_VALUE *)(a))[i].i4 = RI32VAL(v))
#define rout_obj_puti64(a,i,v) (((EIF_VALUE *)(a))[i].i8 = RI64VAL(v))
#define rout_obj_putp(a,i,v) (((EIF_VALUE *)(a))[i].p = RPVAL(v))
#define rout_obj_putr(a,i,v) (((EIF_VALUE *)(a))[i].r = (EIF_REFERENCE) v)

#define rout_putb(a,i,v) (((EIF_VALUE *)(a))[i].b = (v))
#define rout_putc(a,i,v) (((EIF_VALUE *)(a))[i].c1 = (v))
#define rout_putwc(a,i,v) (((EIF_VALUE *)(a))[i].c4 = (v))
#define rout_putd(a,i,v) (((EIF_VALUE *)(a))[i].r8 = (v))
#define rout_putf(a,i,v) (((EIF_VALUE *)(a))[i].r4 = (v))
#define rout_putu8(a,i,v) (((EIF_VALUE *)(a))[i].n1 = (v))
#define rout_putu16(a,i,v) (((EIF_VALUE *)(a))[i].n2 = (v))
#define rout_putu32(a,i,v) (((EIF_VALUE *)(a))[i].n4 = (v))
#define rout_putu64(a,i,v) (((EIF_VALUE *)(a))[i].n8 = (v))
#define rout_puti8(a,i,v) (((EIF_VALUE *)(a))[i].i1 = (v))
#define rout_puti16(a,i,v) (((EIF_VALUE *)(a))[i].i2 = (v))
#define rout_puti32(a,i,v) (((EIF_VALUE *)(a))[i].i4 = (v))
#define rout_puti64(a,i,v) (((EIF_VALUE *)(a))[i].i8 = (v))
#define rout_putp(a,i,v) (((EIF_VALUE *)(a))[i].p = (v))
#define rout_putr(a,i,v) (((EIF_VALUE *)(a))[i].r = (EIF_REFERENCE) v)

/* Copy TUPLE element s[j] into t[i]. Note that 0x00 corresponds to a reference type code. */
#define rout_tuple_item_copy(t,i,s,j) \
	(*((EIF_TYPED_VALUE *) (t) + i)).item = (*((EIF_TYPED_VALUE *) (s) + j)).item; \
	if (eif_item_sk_type(t,i) == SK_REF) { \
		RTAR((EIF_REFERENCE) t, eif_reference_item(s,j)); \
	}

/***************************************/
/* Macros used for tuple manipulations */
/***************************************/

/* Macro to access data directly from tuple item */
#define eif_tuple_item_sk_type(item)		((EIF_TYPED_VALUE *) (item))->type
#define eif_is_reference_tuple_item(item)       (eif_tuple_item_sk_type(item) == SK_REF)
#define eif_reference_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_r
#define eif_boolean_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_b
#define eif_character_8_tuple_item(item)	((EIF_TYPED_VALUE *) (item))->it_c1
#define eif_character_32_tuple_item (item)	((EIF_TYPED_VALUE *) (item))->it_c4
#define eif_real_64_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_r8
#define eif_natural_8_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_n1
#define eif_natural_16_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_n2
#define eif_natural_32_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_n4
#define eif_natural_64_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_n8
#define eif_integer_8_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_i1
#define eif_integer_16_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_i2
#define eif_integer_32_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_i4
#define eif_integer_64_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_i8
#define eif_pointer_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_p
#define eif_real_32_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_r4

/* Macro for accessing type of tuple element */
#define eif_item_sk_type(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->type
#define eif_item_type(tuple,pos)		eif_sk_type_to_type_code(eif_item_sk_type(tuple,pos))

/* Macro for accessing tuple element value */
#define eif_boolean_item(tuple,pos)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_b
#define eif_character_8_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_c1
#define eif_character_32_item(tuple,pos)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c4
#define eif_real_64_item(tuple,pos)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_r8
#define eif_natural_8_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n1
#define eif_natural_16_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n2
#define eif_natural_32_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n4
#define eif_natural_64_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n8
#define eif_integer_8_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i1
#define eif_integer_16_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i2
#define eif_integer_32_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i4
#define eif_integer_64_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i8
#define eif_pointer_item(tuple,pos)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_p
#define eif_real_32_item(tuple,pos)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_r4
#define eif_reference_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_r

/* Conveniences */
#define EIF_BOOLEAN_ITEM eif_boolean_item
#define EIF_CHARACTER_8_ITEM eif_character_8_item
#define EIF_CHARACTER_32_ITEM eif_character_32_item
#define EIF_REAL_64_ITEM eif_real_64_item
#define EIF_NATURAL_8_ITEM eif_natural_8_item
#define EIF_NATURAL_16_ITEM eif_natural_16_item
#define EIF_NATURAL_32_ITEM eif_natural_32_item
#define EIF_NATURAL_64_ITEM eif_natural_64_item
#define EIF_INTEGER_8_ITEM eif_integer_8_item
#define EIF_INTEGER_16_ITEM eif_integer_16_item
#define EIF_INTEGER_32_ITEM eif_integer_32_item
#define EIF_INTEGER_64_ITEM eif_integer_64_item
#define EIF_POINTER_ITEM eif_pointer_item
#define EIF_REAL_32_ITEM eif_real_32_item
#define EIF_REFERENCE_ITEM eif_reference_item

/* Macro for setting tuple element value from a reference object
 * `val' should not be Void */
#define eif_put_boolean_item_with_object(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_b = *(EIF_BOOLEAN *)(val)
#define eif_put_character_8_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c1 = *(EIF_CHARACTER *)(val)
#define eif_put_character_32_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c4 = *(EIF_WIDE_CHAR *)(val)
#define eif_put_real_64_item_with_object(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_r8 = *(EIF_REAL_64 *)(val)
#define eif_put_natural_8_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_n1 = *(EIF_NATURAL_8 *)(val)
#define eif_put_natural_16_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_n2 = *(EIF_NATURAL_16 *)(val)
#define eif_put_natural_32_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_n4 = *(EIF_NATURAL_32 *)(val)
#define eif_put_natural_64_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_n8 = *(EIF_NATURAL_64 *)(val)
#define eif_put_integer_8_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_i1 = *(EIF_INTEGER_8 *)(val)
#define eif_put_integer_16_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_i2 = *(EIF_INTEGER_16 *)(val)
#define eif_put_integer_32_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_i4 = *(EIF_INTEGER_32 *)(val)
#define eif_put_integer_64_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_i8 = *(EIF_INTEGER_64 *)(val)
#define eif_put_pointer_item_with_object(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_p = *(EIF_POINTER *)(val)
#define eif_put_real_32_item_with_object(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_r4 = *(EIF_REAL_32 *)(val)
#define eif_put_reference_item_with_object(tuple,pos,val)	eif_put_reference_item(tuple,pos,val)

/* Macro for setting tuple element value */
#define eif_put_boolean_item(tuple,pos,val)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_b = (EIF_BOOLEAN)(val)
#define eif_put_character_8_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_c1 = (EIF_CHARACTER)(val)
#define eif_put_character_32_item(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c4 = (EIF_WIDE_CHAR)(val)
#define eif_put_real_64_item(tuple,pos,val)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_r8 = (EIF_REAL_64)(val)
#define eif_put_natural_8_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n1 = (EIF_NATURAL_8)(val)
#define eif_put_natural_16_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n2 = (EIF_NATURAL_16)(val)
#define eif_put_natural_32_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n4 = (EIF_NATURAL_32)(val)
#define eif_put_natural_64_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_n8 = (EIF_NATURAL_64)(val)
#define eif_put_integer_8_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i1 = (EIF_INTEGER_8)(val)
#define eif_put_integer_16_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i2 = (EIF_INTEGER_16)(val)
#define eif_put_integer_32_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i4 = (EIF_INTEGER_32)(val)
#define eif_put_integer_64_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_i8 = (EIF_INTEGER_64)(val)
#define eif_put_pointer_item(tuple,pos,val)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_p = (EIF_POINTER)(val)
#define eif_put_real_32_item(tuple,pos,val)			((EIF_TYPED_VALUE *) (tuple) + pos)->it_r4 = (EIF_REAL_32)(val)
#define eif_put_reference_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_r = (EIF_REFERENCE) (val); RTAR((EIF_REFERENCE) (tuple), (EIF_REFERENCE) (val))

/* Obsolete macro kept for backward compatibility. */
#define eif_character_tuple_item(item)		((EIF_TYPED_VALUE *) (item))->it_c1
#define eif_wide_character_tuple_item(item)	((EIF_TYPED_VALUE *) (item))->it_c4
#define eif_character_item(tuple,pos)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_c1
#define eif_wide_character_item(tuple,pos)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c4
#define EIF_CHARACTER_ITEM eif_character_item
#define EIF_WIDE_CHARACTER_ITEM eif_wide_character_item
#define eif_put_character_item_with_object(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_c1 = *(EIF_CHARACTER *)(val)
#define eif_put_wide_character_item_with_object(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c4 = *(EIF_WIDE_CHAR *)(val)
#define eif_put_character_item(tuple,pos,val)		((EIF_TYPED_VALUE *) (tuple) + pos)->it_c1 = (EIF_CHARACTER)(val)
#define eif_put_wide_character_item(tuple,pos,val)	((EIF_TYPED_VALUE *) (tuple) + pos)->it_c4 = (EIF_WIDE_CHAR)(val)

#ifdef __cplusplus
}
#endif

#endif
