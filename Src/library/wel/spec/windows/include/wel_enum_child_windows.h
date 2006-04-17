/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*****************************************************************************/
/* wel_enum_child_windows.h                                                  */
/*****************************************************************************/
/* Used to enumerate the children of a given window                         */
/*****************************************************************************/

#ifndef __WEL_ENUM_CHILD_WINDOWS_H_
#define __WEL_ENUM_CHILD_WINDOWS_H_

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_enum_child_windows                                             */
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
void cwel_enum_child_windows_procedure (
#ifndef EIF_IL_DLL
		EIF_OBJECT pCurrObject,
#endif
		void *fnptr,
		HWND hWndParent);

#ifdef __cplusplus
}
#endif

#endif /* __WEL_ENUM_CHILD_WINDOWS_H_ */
