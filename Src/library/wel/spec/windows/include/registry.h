/*
 * REGISTRY.H
 */

#ifndef __WEL_REGISTRY__
#define __WEL_REGISTRY__

#ifndef __WEL__
#	include <wel.h>
#endif

#include "wel_reg_value.h"

//////////////////////////////////////////////////////////////
//
//  Structure used to store information about a key.
//

typedef struct {
		EIF_POINTER name;
		EIF_POINTER class;
		PFILETIME LastWriteTime;
		} REG_KEY;

extern EIF_INTEGER cwin_reg_create_key (EIF_INTEGER parent_key,
									EIF_POINTER keyName, EIF_INTEGER access_mode);

extern EIF_INTEGER cwin_reg_open_key (EIF_INTEGER parent_key, EIF_POINTER keyName,
									EIF_INTEGER access_mode);

extern EIF_BOOLEAN cwin_reg_delete_key (EIF_INTEGER key, EIF_POINTER subkey);


extern void cwin_reg_set_key_value (EIF_INTEGER key, EIF_POINTER keyname,
									EIF_POINTER keyvalue);
									
extern EIF_BOOLEAN cwin_reg_close_key (EIF_INTEGER key);


extern EIF_POINTER cwin_reg_query_value (EIF_INTEGER key, EIF_POINTER value_name);

extern EIF_POINTER cwin_reg_def_query_value (EIF_INTEGER key, EIF_POINTER value_name);

extern EIF_POINTER cwin_reg_enum_key (EIF_INTEGER key, EIF_INTEGER index);

extern EIF_POINTER cwin_reg_enum_value (EIF_INTEGER key, EIF_INTEGER index);

extern EIF_BOOLEAN cwin_reg_delete_value (EIF_INTEGER key, EIF_POINTER value_name);

extern EIF_INTEGER cwin_reg_subkey_number(EIF_INTEGER key);

extern EIF_INTEGER cwin_reg_value_number(EIF_INTEGER key);

extern EIF_INTEGER cwin_reg_connect_key(EIF_POINTER hostname, EIF_INTEGER key);

#endif  /* __WEL_REGISTRY__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
