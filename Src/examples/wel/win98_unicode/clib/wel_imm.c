#include <eif_eiffel.h>
#include <stdio.h>
#include <windows.h>

#include "wel_imm.h"

EIF_POINTER cwel_get_keyboard_layout (void);
EIF_INTEGER cwel_get_keyboard_layout_list (EIF_INTEGER arraySize, EIF_POINTER list);
EIF_BOOLEAN cwel_get_keyboard_layout_name (EIF_POINTER buff);
EIF_POINTER cwel_load_keyboard_layout(EIF_POINTER hKl, EIF_INTEGER flags);
EIF_INTEGER cwel_get_imm_property (EIF_POINTER hKl, EIF_INTEGER propInfo);
EIF_INTEGER cwel_get_imm_description (EIF_POINTER hKL, EIF_POINTER description, EIF_INTEGER uBuflen);
EIF_INTEGER cwel_get_imm_ime_filename (EIF_POINTER hKL, EIF_POINTER description, EIF_INTEGER uBuflen);
EIF_POINTER cwel_get_imm_context (EIF_POINTER hWnd);
EIF_POINTER cwel_imm_create_context (void);
EIF_POINTER cwel_imm_associate_context (EIF_POINTER hWnd, EIF_POINTER hImc);
EIF_BOOLEAN cwel_imm_destroy_context (EIF_POINTER hImc);
EIF_BOOLEAN cwel_get_imm_is_ime (EIF_POINTER hKl);
EIF_BOOLEAN cwel_set_imm_release_context(EIF_POINTER hWnd, EIF_POINTER hIMC);
EIF_BOOLEAN cwel_set_open_status (EIF_POINTER hIMC, EIF_BOOLEAN fOpen);
EIF_POINTER cwel_activate_keyboard_layout (EIF_POINTER hKl, EIF_INTEGER flags);
EIF_INTEGER cwel_langid_from_locale(EIF_POINTER hKl);
EIF_INTEGER cwel_primary_langid_from_langid (EIF_POINTER hKl);
EIF_INTEGER cwel_sub_langid_from_langid (EIF_POINTER hKl);
EIF_INTEGER cwel_localeid_from_langid (EIF_INTEGER langid, EIF_INTEGER sort_id);
EIF_BOOLEAN cwel_imm_configure_ime (EIF_POINTER hKl, EIF_POINTER hWnd, EIF_INTEGER flag, EIF_INTEGER mode);
EIF_BOOLEAN cwel_imm_get_conversion_status (EIF_POINTER input_cont, EIF_POINTER conv_mode, EIF_POINTER sent_mode);
EIF_POINTER cwel_install_ime (EIF_POINTER path, EIF_POINTER file);
EIF_INTEGER cwel_imm_get_composition_string (EIF_POINTER hImc, EIF_INTEGER type, EIF_POINTER buffer, EIF_INTEGER bytes);
EIF_BOOLEAN cwel_imm_set_composition_string (EIF_POINTER hImc, EIF_INTEGER type, EIF_POINTER cbuffer, EIF_INTEGER cbytes, EIF_POINTER rbuffer, EIF_INTEGER rbytes);
EIF_BOOLEAN cwel_get_conversion_status (EIF_POINTER input_cont, EIF_POINTER conv_mode, EIF_POINTER sent_mode);
EIF_BOOLEAN cwel_set_conversion_status (EIF_POINTER input_cont, EIF_INTEGER conv_mode, EIF_INTEGER sent_mode);
EIF_INTEGER cwel_imm_get_candidate_list_count (EIF_POINTER hImc, EIF_INTEGER cnt);
EIF_BOOLEAN cwel_ime_move_composition_window (EIF_POINTER hImc, EIF_INTEGER style, EIF_INTEGER xpos, EIF_INTEGER ypos);
EIF_BOOLEAN cwel_ime_move_status_window (EIF_POINTER hImc, EIF_INTEGER xpos, EIF_INTEGER ypos);



EIF_POINTER cwel_get_keyboard_layout (void)
{
	//DWORD Id = GetCurrentThreadId();

	return (EIF_POINTER)GetKeyboardLayout(0);
}

EIF_INTEGER cwel_get_keyboard_layout_list (EIF_INTEGER arraySize, EIF_POINTER list)
{
	return (EIF_INTEGER)GetKeyboardLayoutList((int)arraySize, (HKL FAR)list);
}

EIF_BOOLEAN cwel_get_keyboard_layout_name (EIF_POINTER buff)
{
	return (EIF_BOOLEAN)GetKeyboardLayoutName((LPTSTR)buff);
}

EIF_POINTER cwel_load_keyboard_layout(EIF_POINTER hKl, EIF_INTEGER flags)
{
	return (EIF_POINTER)LoadKeyboardLayout((LPCTSTR) hKl, (UINT) flags);
}

EIF_INTEGER cwel_get_imm_property (EIF_POINTER hKl, EIF_INTEGER propInfo)
{
	return (EIF_INTEGER)ImmGetProperty((HKL)hKl, (DWORD)propInfo);	
}

EIF_INTEGER cwel_get_imm_description (EIF_POINTER hKl, EIF_POINTER description, EIF_INTEGER uBuflen)
{
	return (EIF_INTEGER)ImmGetDescription((HKL)hKl, (LPTSTR)description, (UINT)uBuflen);
}

EIF_INTEGER cwel_get_imm_ime_filename (EIF_POINTER hKl, EIF_POINTER description, EIF_INTEGER uBuflen)
{
	return (EIF_INTEGER)ImmGetIMEFileName((HKL)hKl, (LPTSTR)description, (UINT)uBuflen);
}

EIF_POINTER cwel_get_imm_context (EIF_POINTER hWnd)
{
	return (EIF_POINTER)ImmGetContext(hWnd);
}

EIF_BOOLEAN cwel_get_imm_is_ime (EIF_POINTER hKl)
{
	return (EIF_BOOLEAN) ImmIsIME((HKL)hKl);
}

EIF_BOOLEAN cwel_set_imm_release_context(EIF_POINTER hWnd, EIF_POINTER hIMC)
{
	return (EIF_BOOLEAN)ImmReleaseContext((HWND) hWnd, (HIMC) hIMC);
}

EIF_BOOLEAN cwel_set_open_status (EIF_POINTER hIMC, EIF_BOOLEAN fOpen)
{
	return (EIF_BOOLEAN)ImmSetOpenStatus((HIMC) hIMC, (BOOL) fOpen);
}

EIF_POINTER cwel_activate_keyboard_layout (EIF_POINTER hKl, EIF_INTEGER flags)
{
	return (EIF_POINTER)ActivateKeyboardLayout((HKL)hKl, (UINT)flags);
}

EIF_INTEGER cwel_langid_from_locale(EIF_POINTER hKl)
{
	return (EIF_INTEGER) LANGIDFROMLCID ((LCID)hKl);
}

EIF_INTEGER cwel_primary_langid_from_langid (EIF_POINTER hKl)
{
	return (EIF_INTEGER) PRIMARYLANGID((WORD)LANGIDFROMLCID ((LCID)hKl));
}

EIF_INTEGER cwel_sub_langid_from_langid (EIF_POINTER hKl)
{
	return (EIF_INTEGER) SUBLANGID((WORD)LANGIDFROMLCID ((LCID)hKl));
}

EIF_INTEGER cwel_localeid_from_langid (EIF_INTEGER langid, EIF_INTEGER sort_id)
{
	return (EIF_INTEGER) MAKELCID ((DWORD) langid, (DWORD) sort_id);
}

EIF_BOOLEAN cwel_imm_configure_ime (EIF_POINTER hKl, EIF_POINTER hWnd, EIF_INTEGER flag, EIF_INTEGER mode)
{
	return (EIF_BOOLEAN)ImmConfigureIME ((HKL) hKl, (HWND) hWnd, (DWORD) flag, (LPVOID) mode);
}

EIF_BOOLEAN cwel_imm_get_conversion_status (EIF_POINTER input_cont, EIF_POINTER conv_mode, EIF_POINTER sent_mode)
{
	return (EIF_BOOLEAN) ImmGetConversionStatus ((HIMC) input_cont, (LPDWORD) conv_mode, (LPDWORD) sent_mode);
}

EIF_POINTER cwel_install_ime (EIF_POINTER path, EIF_POINTER file)
{
	return (EIF_POINTER) ImmInstallIME ((LPCTSTR) path, (LPCTSTR) file);
}

EIF_INTEGER cwel_imm_get_composition_string (EIF_POINTER hImc, EIF_INTEGER type, EIF_POINTER buffer, EIF_INTEGER bytes)
{
	return (EIF_INTEGER) ImmGetCompositionString ((HIMC) hImc, (DWORD) type, (LPVOID) buffer, (DWORD) bytes);
}

EIF_BOOLEAN cwel_imm_set_composition_string (EIF_POINTER hImc, EIF_INTEGER type, EIF_POINTER cbuffer, EIF_INTEGER cbytes, EIF_POINTER rbuffer, EIF_INTEGER rbytes)
{
	return (EIF_BOOLEAN) ImmSetCompositionString ((HIMC) hImc, (DWORD) type, (LPVOID) cbuffer, (DWORD) cbytes, (LPVOID) rbuffer, (DWORD) rbytes);
}

EIF_BOOLEAN cwel_get_conversion_status (EIF_POINTER input_cont, EIF_POINTER conv_mode, EIF_POINTER sent_mode)
{
	return (EIF_BOOLEAN) ImmGetConversionStatus ((HIMC) input_cont, (LPDWORD) conv_mode, (LPDWORD) sent_mode);
}

EIF_BOOLEAN cwel_set_conversion_status (EIF_POINTER input_cont, EIF_INTEGER conv_mode, EIF_INTEGER sent_mode)
{
	return (EIF_BOOLEAN) ImmSetConversionStatus ((HIMC) input_cont, (DWORD) conv_mode, (DWORD) sent_mode);
}

EIF_POINTER cwel_imm_create_context (void)
{
	return (EIF_POINTER) ImmCreateContext ();
}

EIF_POINTER cwel_imm_associate_context (EIF_POINTER hWnd, EIF_POINTER hImc)
{
	return (EIF_POINTER) ImmAssociateContext ((HWND) hWnd, (HIMC) hImc);
}

EIF_BOOLEAN cwel_imm_destroy_context (EIF_POINTER hImc)
{
	return (EIF_BOOLEAN) ImmDestroyContext ((HIMC) hImc);
}

EIF_INTEGER cwel_imm_get_candidate_list_count (EIF_POINTER hImc, EIF_INTEGER cnt)
{
	return (EIF_INTEGER) ImmGetCandidateListCount ((HIMC) hImc, (LPDWORD) cnt);
}

EIF_BOOLEAN cwel_ime_move_composition_window (EIF_POINTER hImc, EIF_INTEGER style, EIF_INTEGER xpos, EIF_INTEGER ypos)
{
	COMPOSITIONFORM lpCompForm;
	POINT pt;
	RECT rc;
	
	pt.x = xpos;
	pt.y = ypos;
	
	rc.left = 10;
	rc.top = 10;
	rc.right = 200;
	rc.bottom = 200;
	
	lpCompForm.dwStyle = (DWORD) style;
	lpCompForm.ptCurrentPos = pt;
	lpCompForm.rcArea = rc;
	
	return (EIF_BOOLEAN) ImmSetCompositionWindow ((HIMC) hImc, &lpCompForm);
	
}

EIF_BOOLEAN cwel_ime_move_status_window (EIF_POINTER hImc, EIF_INTEGER xpos, EIF_INTEGER ypos)
{
	POINT pt;
	
	pt.x = xpos;
	pt.y = ypos;
	
	return (EIF_BOOLEAN) ImmSetStatusWindowPos ((HIMC) hImc, &pt);
}


