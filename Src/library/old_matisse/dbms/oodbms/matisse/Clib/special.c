#include "eif_eiffel.h"
#include "eif_config.h"
#include "eif_portable.h"
#include "eif_malloc.h"
#include "eif_store.h"
#include "eif_garcol.h"
#include "eif_macros.h"
#include "eif_cecil.h"
#include "eif_except.h"
#include "eif_traverse.h"
#include "eif_struct.h"
#include "eif_bits.h"
#include "eif_plug.h"
/*#include "eif_run_idr.h"*/
#include "eif_except.h"
#include <stdio.h>


#include <string.h>

#define BASIC_STORE '\0'


#ifndef WORKBENCH
  //extern long esize[];   -- removed by Andrew Perry to avoid plug.h problem
#endif


 void st_store();                               /* Second pass of the store */
  void ext_gst_write();
  void ext_make_header();                               /* Make header */
 void object_write ();
 void gen_object_write ();
 void st_clean();


char * new_object = (char *) 0;
uint32 obj_flags;
extern char rt_kind;
int r_mat_fides;
int s_mat_fides;
char * old_adress=(char*)NULL;
 char *s_buffer = (char *) 0;
 int gen_accounting=0 ;
 int32*gt_gen=(int32*)0;
extern  char* account;
extern  unsigned int** sorted_attributes;
extern int scount;

 void c_prepare_header()
{
  jmp_buf exenv;
  excatch((char*)exenv);
  if (setjmp(exenv)){ereturn();}
}

 void c_free_account()
{
xfree(account);
account = (char * )0;
}

 void c_free_sorted_attributes()
{
xfree(sorted_attributes);
sorted_attributes = (unsigned int **)0;
}

 EIF_INTEGER c_gen_traversal(object)
EIF_OBJ object;
{
  gen_accounting = TR_ACCOUNT;
  obj_nb = 0;
  account = (char*)xmalloc(scount*sizeof(char),C_T,GC_OFF);
  if (account == (char*)0) xraise(EN_MEM);
  bzero(account,scount*sizeof(char));
  sorted_attributes=(unsigned int**)xmalloc(scount*sizeof(unsigned int*),C_T,GC_OFF);
  if( sorted_attributes==(unsigned int**)0) { c_free_account();xraise(EN_MEM);}
  traversal(object,gen_accounting);
  return(obj_nb);
}

 EIF_INTEGER c_dgen()
{
return((long)*(gt_gen++));
}
 EIF_INTEGER c_scount()
{
return(scount);
} 

 EIF_BOOLEAN c_account_item_is_not_null(i)
EIF_INTEGER i;
{
  return(account[i]!=0);
}

 EIF_INTEGER c_class_size(i)
int i;
{
return(Size(i));
}

 EIF_POINTER c_visible_name(i)
EIF_INTEGER i;
{
  return(System(i).cn_generator);
}

 EIF_BOOLEAN c_is_generic(i)
EIF_INTEGER i;
{
struct gt_info * info;
info = (struct gt_info*) ct_value(&egc_ce_gtype,System(i).cn_generator);
return(info!=(struct gt_info*)0);
}

 EIF_INTEGER c_nb_gen(i)
EIF_INTEGER i;
{
struct gt_info * info;
info = (struct gt_info*) ct_value(&egc_ce_gtype,System(i).cn_generator);
return(info->gt_param);
}

 void c_inspect_generics(i)
EIF_INTEGER i;
{
struct gt_info * info;
int16 *gt_type;

info = (struct gt_info*) ct_value(&egc_ce_gtype,System(i).cn_generator);
gt_type = info->gt_type;
for (;;)
  {
    if ((*gt_type++ &SK_DTYPE)==(int16)i)
      break;
  }
gt_type--;
gt_gen=info->gt_gen+c_nb_gen(i)*(gt_type-info->gt_type);

}
 EIF_BOOLEAN c_is_special_simples(object)
EIF_OBJ object;
{
  register2 union overhead *zone;
  uint32 flags;

  zone = HEADER(object);
  flags = zone -> ov_flags;
  return ((flags & EO_SPEC) && (!(flags & EO_REF)));
}
 EIF_INTEGER c_object_flags(object)
EIF_OBJ object;
{
  register2 union overhead *zone;
  uint32 flags;

  zone = HEADER(object);
  flags = zone -> ov_flags;
  return ((uint32)flags);
}

 EIF_BOOLEAN c_is_special_composites(object)
EIF_OBJ object;
{
  register2 union overhead *zone;
  uint32 flags;

  zone = HEADER(object);
  flags = zone -> ov_flags;
  return ((flags & EO_SPEC) && (flags & EO_REF) && (flags & EO_COMP));
}

 EIF_BOOLEAN c_is_special_references(object)
EIF_OBJ object;
{
  register2 union overhead *zone;
  uint32 flags;
  zone = HEADER(object);
  flags = zone -> ov_flags;
  return ((flags & EO_SPEC) && (flags & EO_REF) && (!(flags & EO_COMP)));
}

 void c_set_file_descriptor(file_desc)
EIF_INTEGER file_desc;
{
  s_mat_fides = (int) file_desc;
  allocate_gen_buffer();
}

 void c_set_file_descriptor_retrieve(file_desc)
EIF_INTEGER file_desc;
{
  r_mat_fides = (int) file_desc;
}

 EIF_BOOLEAN c_is_expanded(object)
EIF_OBJ object;
{
  register2 union overhead *zone;
  uint32 flags;
  zone = HEADER(object);
  flags = zone -> ov_flags;
  return ((flags & EO_EXP) != (uint32)0);
}

 EIF_REFERENCE c_read_object_address()
{
  buffer_read(&old_adress,sizeof(char*));
  return ((char*)old_adress);
}

 EIF_POINTER c_object_address(object)
char*object;
{
	return((char *)object);
}

 EIF_INTEGER c_read_object_flags()
{
  uint32 flags;
  buffer_read(&flags,sizeof(uint32));
  obj_flags = flags;
   return ((uint32)flags);
}

 EIF_BOOLEAN c_read_is_special()
{
  return((obj_flags&EO_SPEC)!=NULL);
}


 void  c_buffer_write(data, size_args)
EIF_POINTER data;
int size_args;
{
  buffer_write(data,size_args*sizeof(char));
}

 EIF_BOOLEAN c_is_special_object(object)
char *object;
{
  return((HEADER(object)->ov_flags&EO_SPEC)!=0);
}

 EIF_INTEGER c_gen_special_count(object)
char * object;
{
char *o_ptr;
uint32 count;

o_ptr = (char*) (object+(HEADER(object)->ov_size & B_SIZE)-LNGPAD(2));
return((uint32)(*(long*)o_ptr));
}

 EIF_INTEGER c_gen_special_elm_size(object)
char * object;
{
char *o_ptr;
uint32 count;
o_ptr = (char*) (object+(HEADER(object)->ov_size & B_SIZE)-LNGPAD(2));
return((uint32)(*(long*)(o_ptr+sizeof(long*))));
}

 EIF_INTEGER c_size_of_special(object)
char *object;
{
/*  EIF_INTEGER size;

  register2 union overhead *zone;
  char*ref;
  zone = HEADER(object);
  ref = object + (zone->ov_size&B_SIZE)-LNGPAD(2)+sizeof(EIF_INTEGER); 
  return(*(EIF_INTEGER*)ref);
*/
  return( (HEADER(object)->ov_size&B_SIZE)*sizeof(char));
}

 EIF_INTEGER c_size_of_normal_flag(object)
char *object;
{
  register2 union overhead *zone;
  uint32 flags;

  zone = HEADER(object);
  flags = zone -> ov_size;
  
  return ((uint32)flags);
}


 EIF_INTEGER c_size_of_normal(pointer)
EIF_POINTER pointer;
{
  register2 union overhead *zone;
   uint32 flags;
  zone = HEADER(pointer);flags = zone -> ov_flags;
  return(Size((uint16)(flags&EO_TYPE))*sizeof(char));
}

 void c_write_basic_store_3_2()
{
  char kind_of_store;
  int n;
  kind_of_store = BASIC_STORE_3_2;
  write(s_mat_fides,&kind_of_store,sizeof(char));
}

 void c_write_general_store_3_3()
{
  char kind_of_store;
  int n;
  kind_of_store = GENERAL_STORE_3_3;
  write(s_mat_fides,&kind_of_store,sizeof(char));
}


 EIF_BOOLEAN c_is_basic_store_3_2()
{
  char kind_of_store;
  read(r_mat_fides,&kind_of_store,sizeof(char));
  rt_kind=BASIC_STORE;
  current_position = 0;
return(kind_of_store == BASIC_STORE_3_2);
}

 EIF_BOOLEAN c_is_general_store_3_3()
{
  char kind_of_store;
  read(r_mat_fides,&kind_of_store,sizeof(char));
  rt_kind=BASIC_STORE;
  current_position = 0;
  return(kind_of_store == GENERAL_STORE_3_3);
}

 void c_write_objects_count(object_nb)
EIF_INTEGER object_nb;
{
  obj_nb = object_nb;
  buffer_write(&obj_nb,sizeof(long));
}

 EIF_INTEGER c_read_objects_count()
{
  long obj_count;
  buffer_read(&obj_count,sizeof(long));
  return(obj_count);
}

 void st_store_sol(object)
char * object;
{
/* Do nothing */
}

 int buffer_read(object,size)
register char * object;
int size;
{
register i;

if (current_position+size >= end_of_buffer)
  {
    for(i=0;i<size;i++)
      {
	if (current_position>=end_of_buffer)
	  if ((retrieve_read()==0)&& size != i+1)
	    eraise ("Incomplete file",EN_RETR);
	*(object++)=*(general_buffer+current_position++);
      }
  }
else
  {
    for(i=0;i<size;i++)
      {
	*(object++)=*(general_buffer+current_position++);
      }
  }
return(i);
}


 EIF_REFERENCE c_retrieved_special()
{
  uint32 count,special_size=0,elm_size;
  long nb_char;

  buffer_read(&special_size,sizeof(uint32));
  nb_char = (special_size&B_SIZE)*sizeof(char);
  new_object = spmalloc(nb_char);
  HEADER(new_object)->ov_flags |= obj_flags & (EO_REF|EO_COMP|EO_TYPE);
  buffer_read(new_object,(int)sizeof(char)*nb_char);
  return(new_object);
}

 EIF_REFERENCE c_retrieved_normal()
{
  long nb_char;
  

  /* !! Not valid if WORKBENCH is not defined !!*/

#ifndef WORKBENCH
  nb_char = esize[(uint16)(obj_flags&EO_TYPE)];
#else
  nb_char = esystem[(uint16)(obj_flags&EO_TYPE)].size;
#endif

  new_object = emalloc(obj_flags&EO_TYPE);
  buffer_read(new_object,(int)sizeof(char)*nb_char);
  return(new_object);
}

 char * pointer_on_field(i,object)
long i;
char * object;
{
struct cnode  *object_desc;
int dynamic_type = Dtype(object);
char *o_ref ;
long offset;
long *at;

object_desc = &System(dynamic_type);
#ifdef WORKBENCH
CAttrOffs(offset,object_desc->cn_attr[i],dynamic_type);
#else
offset=((object_desc->cn_offsets)[i])[obj_flags&EO_TYPE];
#endif

o_ref = object+offset;
return o_ref;
}

 EIF_REFERENCE pointer_inside_field(i,object)
long i;
char * object;
{
return *(char**)pointer_on_field(i,object);
}

 void change_inside_field(source,target)
char *source,*target;
{
*(char**)target=source;
}


 EIF_REFERENCE pointer_on_special_item(i,object)
long i;
char * object;
{
int j;
char *ref = object;
ref+= sizeof(EIF_REFERENCE)*i;
return((char*)(ref));
}

 EIF_REFERENCE pointer_inside_special_item(i,object)
long i;
char * object;
{
return *(char**)pointer_on_special_item(i,object);
}





 void ext_st_clean()
{
  /* clean up memory allocation and reset function pointers */
  
  if (s_buffer != (char *) 0) {
    xfree(s_buffer);
    s_buffer = (char *) 0;
  }
  if (account != (char *)0) {
    xfree(account);
    account = (char *) 0;
  }
  free_sorted_attributes();
}

 void ext_gen_object_write(object)
     char * object;
{
  /* Writes an object to disk (used by the new (3.3) general store)
   * It uses the same algorithm as `object_write' and should be updated
   * at the same time.
   */
  
  long attrib_offset;
  int z;
  uint32 o_type;
  uint32 num_attrib;
  uint32 flags = HEADER(object)->ov_flags;
  
  o_type = flags & EO_TYPE;
  num_attrib = System(o_type).cn_nbattr;
  
  if (num_attrib > 0) {
    for (; num_attrib > 0;) {
      attrib_offset = get_alpha_offset(o_type, --num_attrib);
      switch (*(System(o_type).cn_types + num_attrib) & SK_HEAD) {
      case SK_INT:
	buffer_write(object + attrib_offset, sizeof(EIF_INTEGER));
	break;
      case SK_BOOL:
      case SK_CHAR:
	buffer_write(object + attrib_offset, sizeof(EIF_CHARACTER));
	break;
      case SK_FLOAT:
	buffer_write(object + attrib_offset, sizeof(EIF_REAL));
	break;
      case SK_DOUBLE:
	buffer_write(object + attrib_offset, sizeof(EIF_DOUBLE));
	break;
      case SK_BIT:
	{
	  int q;
	  struct bit *bptr = (struct bit *)(object + attrib_offset);
	  buffer_write(&(HEADER(bptr)->ov_flags), sizeof(uint32));
	  buffer_write(&(bptr->b_length), sizeof(uint32));
	  buffer_write(bptr->b_value, bptr->b_length);
	}
	break;
      case SK_EXP:
	ext_gst_write (object + attrib_offset);
	break;
      case SK_REF:
      case SK_POINTER:
	buffer_write(object + attrib_offset, sizeof(EIF_REFERENCE));
	break;
      default:
	eio();
      }
    } 
  } else {
    if (flags & EO_SPEC) {              /* Special object */
      long count, elem_size;
      char *ref, *o_ptr;
      char *vis_name;
      uint32 dgen, dgen_typ;
      struct gt_info *info;
      
      o_ptr = (char *) (object + (HEADER(object)->ov_size & B_SIZE) - LNGPAD(2));
      count = *(long *) o_ptr;
      vis_name = System(o_type).cn_generator;
      
      
      info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
      if (info != (struct gt_info *) 0) {       /* Is the type a generic one ? */
	/* Generic type, write in file:
	 *    "dtype visible_name size nb_generics {meta_type}+"
	 */
	int16 *gt_type = info->gt_type;
	int32 *gt_gen;
	int nb_gen = info->gt_param;
	
	for (;;) {
	  if ((*gt_type++ & SK_DTYPE) == (int16) o_type)
	    break;
	}
	gt_type--;
	gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
	dgen = *gt_gen;
      }
      
      if (!(flags & EO_REF)) {          /* Special of simple types */
	switch (dgen & SK_HEAD) {
	case SK_INT:
	  buffer_write(((long *)object), count*sizeof(EIF_INTEGER));
	  break;
	case SK_BOOL:
	case SK_CHAR:
	  buffer_write(object, count*sizeof(EIF_CHARACTER));
	  break;
	case SK_FLOAT:
	  buffer_write((float *)object, count*sizeof(EIF_REAL));
	  break;
	case SK_DOUBLE:
	  buffer_write((double *)object, count*sizeof(EIF_DOUBLE));
	  break;
	case SK_BIT:
	  dgen_typ = dgen & SK_DTYPE;
	  elem_size = *(long *) (o_ptr + sizeof(long));
	  
	  /*FIXME: header for each object ????*/
	  buffer_write((struct bit *)object, count*elem_size);
	  break;
	case SK_EXP:
	  elem_size = *(long *) (o_ptr + sizeof(long));
	  buffer_write(&(HEADER (object + OVERHEAD)->ov_flags), sizeof(uint32));
	  for (ref = object + OVERHEAD; count > 0;
	       count --, ref += elem_size) {
	    ext_gen_object_write(ref);
	  }
	  break;
	case SK_POINTER:
	  buffer_write(object, count*sizeof(EIF_POINTER));
	  break;
	default:
	  eio();
	  break;
	}
      } else {
	if (!(flags & EO_COMP)) {       /* Special of references */
	  buffer_write(object, count*sizeof(EIF_REFERENCE));
	} else {                        /* Special of composites */
	  elem_size = *(long *) (o_ptr + sizeof(long));
	  buffer_write(&(HEADER (object)->ov_flags), sizeof(uint32));
	  for (ref = object + OVERHEAD; count > 0;
	       count --, ref += elem_size) {
	    ext_gen_object_write(ref);
	  }
	}
      }
    } 
  }
}

 void ext_gst_write(object)
char *object;
{
	/* Write an object in file `s_mat_fides'.
	 * used for general store
	 */

	register2 union overhead *zone;
	uint32 flags;
	register1 uint32 nb_char;

	zone = HEADER(object);
	flags = zone->ov_flags;
	/* Write address */

	buffer_write(&object, sizeof(char *));
	buffer_write(&flags, sizeof(uint32));

	if (flags & EO_SPEC) {
		char * o_ptr;
		uint32 count, elm_size;
		o_ptr = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
		count = (uint32)(*(long *) o_ptr);
		elm_size = (uint32)(*(long *) (o_ptr + sizeof (long *)));

		/* We have to save the number of objects in the special object */

		buffer_write(&count, sizeof(uint32));
		buffer_write(&elm_size, sizeof(uint32));


	} 
	/* Write the body of the object */
	ext_gen_object_write(object);

}



 void ext_make_header()
{
  
  /* Generate header for stored hiearchy retrivable by other systems. */
  int i;
  char *vis_name;                       /* Visible name of a class */
  struct gt_info *info;
  int nb_line = 0;
  int bsize = 80;
  
  account  = (char*) xmalloc(scount*sizeof(char),C_T,GC_OFF);
  bzero(account, scount*sizeof(char));
  sorted_attributes= (unsigned int**) xmalloc(scount*sizeof(unsigned int*),C_T,GC_OFF);
  bzero(sorted_attributes, scount*sizeof(unsigned int*));
   
	s_buffer = (char *) xmalloc (bsize * sizeof( char), C_T, GC_OFF);
	/* Write maximum dynamic type */
	if (0 > sprintf(s_buffer,"%d\n", scount)) {
		eio();
	}
	buffer_write(s_buffer, (strlen (s_buffer)));
	

	for (i=0; i<scount; i++)
		if (account[i])
			nb_line++;
	/* Write number of header lines */
	if (0 > sprintf(s_buffer,"%d\n", nb_line)) {
		eio();
	}
	buffer_write(s_buffer, (strlen (s_buffer)));

	for (i=0; i<scount; i++) {
		if (!account[i])
			continue;                               /* No object of dyn. type `i'. */

		sort_attributes(i);

		/* vis_name = Visible(i) */;/* Visible name of the dyn. type */
		vis_name = System(i).cn_generator;

		if (bsize < (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6))
			{
				bsize = (strlen (vis_name) + sizeof (long) + 2 * sizeof (int) + 6);
				s_buffer = (char *) xrealloc (s_buffer, bsize, GC_OFF);
		}

		info = (struct gt_info *) ct_value(&egc_ce_gtype, vis_name);
		if (info != (struct gt_info *) 0) {     /* Is the type a generic one ? */
			/* Generic type, write in file:
			 *    "dtype visible_name size nb_generics {meta_type}+"
			 */
			int16 *gt_type = info->gt_type;
			int32 *gt_gen;
			int nb_gen = info->gt_param;
			int j;

			if (0 > sprintf(s_buffer, "%d %s %ld %d", i, vis_name, Size(i), nb_gen)) {
				eio();
			}

			buffer_write(s_buffer, (strlen (s_buffer)));

			for (;;) {
#if DEBUG &1
				if (*gt_type == SK_INVALID)
					panic("corrupted cecil table");
#endif
				if ((*gt_type++ & SK_DTYPE) == (int16) i)
					break;
			}
			gt_type--;
			gt_gen = info->gt_gen + nb_gen * (gt_type - info->gt_type);
			for (j=0; j<nb_gen; j++) {
				long dgen;

				dgen = (long) *(gt_gen++);
				if (0 > sprintf(s_buffer, " %lu", dgen)) {
					eio();
				}
				buffer_write(s_buffer, (strlen (s_buffer)));
			}
		} else {
			/* Non-generic type, write in file:
			 *    "dtype visible_name size 0"
			 */
			if (0 > sprintf(s_buffer, "%d %s %ld 0", i, vis_name, Size(i))) {
				eio();
			}
			buffer_write(s_buffer, (strlen (s_buffer)));
		}
		if (0 > sprintf(s_buffer,"\n")) {
			eio();
		}
		buffer_write(s_buffer, (strlen (s_buffer)));
	}
	xfree (s_buffer);
	s_buffer = (char *) 0;
	expop(&eif_stack);
}

 EIF_CHARACTER c_i_th(object,i)
EIF_POINTER object;
EIF_INTEGER i ;
{
return((EIF_CHARACTER)*(object+sizeof(char)*i));
}

 EIF_CHARACTER c_index0(index)
EIF_INTEGER index;
{
int *pindex=(int*)&index;
char result;
return((EIF_CHARACTER)*pindex);
}

 EIF_CHARACTER  c_index(index,i)
     EIF_INTEGER index;
{

  char *pindex=(char*)&index;
  /*printf("Param=%d-%x\n",index,index);
  printf("return index(%d)=%x\n",i,*(pindex+(3-i)));*/
  return(*(pindex+(3-i)));
}

 EIF_CHARACTER  c_index_ref(index,i)
     EIF_POINTER index;
{

  char *pindex=(char*)&index;
  return(*(pindex+(3-i)));
}

 void put_char_in_special_char(target,value)
char *target,value;
{
*target=value;
}

 void put_ref_in_special_char(target,value)
char *target,*value;
{
*(char**)target=value;
}

 void put_int_in_special_char(target,value)
char *target; 
int value;
{
*(char**)target=(char*)value;
}
 

 EIF_REFERENCE pointer_on_special_item_char(i,object)
long i;
char * object;
{
int j;
char *ref = object;
ref+= sizeof(EIF_CHARACTER)*i;
return((char*)ref);
}

