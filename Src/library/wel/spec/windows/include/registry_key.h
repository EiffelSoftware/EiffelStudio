/*
 * REGISTRY_KEY.H
 */

#ifndef __WEL_REGISTRY_KEY__
#define __WEL_REGISTRY_KEY__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifndef __WEL_REGISTRY__
#	include "registry.h"
#endif

#define cwin_reg_key_name(_ptr_) (((REG_KEY *) _ptr_)->name)
	
#define	cwin_reg_key_class(_ptr_) (((REG_KEY *) _ptr_)->class)
		
#define	cwin_reg_key_time(_ptr_) (((REG_KEY *) _ptr_)->LastWriteTime)

#define cwin_reg_key_destroy(_ptr_) (free ((REG_KEY *)_ptr_))
		
#endif  /* __WEL_REGISTRY_KEY__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1998, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
