/*
 * REGISTRY.H
 */

#ifndef __WEL_REGISTRY__
#define __WEL_REGISTRY__

#ifndef __WEL__
#	include <wel.h>
#endif

extern EIF_INTEGER cwin_reg_create_key (EIF_OBJ main_obj, EIF_INTEGER parent_key,
									EIF_POINTER keyName, EIF_INTEGER access_mode);

extern EIF_INTEGER cwin_reg_open_key (EIF_INTEGER parent_key, EIF_POINTER keyName,
									EIF_INTEGER access_mode);

extern EIF_INTEGER cwin_reg_set_key_value (EIF_INTEGER key, EIF_POINTER keyname,
									EIF_POINTER keyvalue);
									
extern void cwin_reg_close_key (EIF_INTEGER key);


extern EIF_POINTER cwin_reg_query_value (EIF_INTEGER key, EIF_POINTER value_name);
		
#endif  /* __WEL_REGISTRY__ */
