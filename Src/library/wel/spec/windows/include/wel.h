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

#ifndef __WEL__
#define __WEL__

#ifndef STRICT
#	define STRICT
#endif

#ifdef _WIN32
#	ifndef WIN32
#		define WIN32
#	endif
#endif

#include <windows.h>
#include <commctrl.h>

#include "eif_eiffel.h"
#include "wel_lang.h"

#ifdef __cplusplus
extern "C" {
#endif

#if !defined (_WIN64) && !defined(GetWindowLongPtr)
	/* Special handling of LONG_PTR, GetWindowLongPtr, SetWindowLongPtr
	 * when compiled on a platform where the SDK header is not up to date. */

#if defined(SetWindowLongPtr) || defined(SetClassLongPtr)
	It should not be defined!!
#endif

	/* 1 - We define the type and functions. */
#ifndef LONG_PTR
#define LONG_PTR LONG
#endif
#ifndef ULONG_PTR
#define ULONG_PTR ULONG
#endif
#ifndef DWORD_PTR
#define DWORD_PTR DWORD
#endif
#define GetWindowLongPtr GetWindowLong
#define SetWindowLongPtr SetWindowLong
#define SetClassLongPtr SetClassLong

	/* 2 - We define the constant values for windows. */
#ifndef GWLP_WNDPROC
#define GWLP_WNDPROC        (-4)
#endif
#ifndef GWLP_HINSTANCE
#define GWLP_HINSTANCE      (-6)
#endif
#ifndef GWLP_HWNDPARENT
#define GWLP_HWNDPARENT     (-8)
#endif
#ifndef GWLP_USERDATA
#define GWLP_USERDATA       (-21)
#endif
#ifndef GWLP_ID
#define GWLP_ID             (-12)
#endif

	/* 3 - We define the constant values for dialogs. */
#ifndef DWLP_MSGRESULT
#define DWLP_MSGRESULT  0
#endif
#ifndef DWLP_DLGPROC
#define DWLP_DLGPROC    DWLP_MSGRESULT + sizeof(LRESULT)
#endif
#ifndef DWLP_USER
#define DWLP_USER       DWLP_DLGPROC + sizeof(DLGPROC)
#endif

#endif

#define cwel_pointer_to_integer(_ptr_) ((EIF_INTEGER) _ptr_)
#define cwel_integer_to_pointer(_int_) ((EIF_POINTER) _int_)

#define cwel_temp_dialog_value (0x01)

#define cwel_menu_item_not_found 0xFFFFFFFF


#ifndef BIF_EDITBOX
#define BIF_EDITBOX				0x0010
#endif

#ifndef BIF_VALIDATE
#define BIF_VALIDATE			0x0020
#endif

#ifdef EIF_BORLAND
/* Shoulde be defined in <commctrl.h> */
#define RBS_TOOLTIPS	0x0100
#define RBS_VARHEIGHT	0x0200
#define RBS_BANDBORDERS	0x0400
#define RBS_FIXEDORDER	0x0800

#define RBBS_BREAK		0x00000001
#define RBBS_FIXEDSIZE	0x00000002
#define RBBS_CHILDEDGE	0x00000004
#define RBBS_HIDDEN		0x00000008
#define RBBS_NOVERT		0x00000010
#define RBBS_FIXEDBMP	0x00000020

#define RBN_FIRST			(0U-831U)
#define RBN_LAST			(0U-859U)
#define RBN_HEIGHTCHANGE	(RBN_FIRST - 0)

#define RBIM_IMAGELIST	0x00000001

#define RB_INSERTBANDA	(WM_USER + 1)
#define RB_DELETEBAND	(WM_USER + 2)
#define RB_GETBARINFO	(WM_USER + 3)
#define RB_SETBARINFO	(WM_USER + 4)
#define RB_GETBANDINFO	(WM_USER + 5)
#define RB_SETBANDINFOA (WM_USER + 6)
#define RB_SETPARENT	(WM_USER + 7)
#define RB_INSERTBANDW	(WM_USER + 10)
#define RB_SETBANDINFOW (WM_USER + 11)
#define RB_GETBANDCOUNT (WM_USER + 12)
#define RB_GETROWCOUNT	(WM_USER + 13)
#define RB_GETROWHEIGHT (WM_USER + 14)

#ifdef UNICODE
#define RB_INSERTBAND	RB_INSERTBANDW
#define RB_SETBANDINFO	RB_SETBANDINFOW
#else
#define RB_INSERTBAND	RB_INSERTBANDA
#define RB_SETBANDINFO	RB_SETBANDINFOA
#endif

struct _IMAGELIST;
typedef struct _IMAGELIST NEAR* HIMAGELIST;

typedef struct tagREBARINFO
{
	UINT	cbSize;
	UINT	fMask;
#ifndef NOIMAGEAPIS
	HIMAGELIST	himl;
#else
	HANDLE	himl;
#endif
} REBARINFO, FAR *LPREBARINFO;

typedef struct _TREEITEM FAR* HTREEITEM;
typedef struct tagTVHITTESTINFO {
	POINT	pt;
	UINT	flags;
	HTREEITEM	hItem;
} TVHITTESTINFO, FAR *LPTVHITTESTINFO;

typedef struct tagINITCOMMONCONTROLSEX {
	DWORD dwSize;
	DWORD dwICC;
} INITCOMMONCONTROLSEX, *LPINITCOMMONCONTROLSEX;

typedef struct tagREBARBANDINFOA
{
	UINT	cbSize;
	UINT	fMask;
	UINT	fStyle;
	COLORREF	clrFore;
	COLORREF	clrBack;
	LPSTR	lpText;
	UINT	cch;
	int	iImage;
	HWND	hwndChild;
	UINT	cxMinChild;
	UINT	cyMinChild;
	UINT	cx;
	HBITMAP	hbmBack;
	UINT	wID;
}	REBARBANDINFOA, FAR *LPREBARBANDINFOA;
typedef REBARBANDINFOA CONST FAR *LPCREBARBANDINFOA;

typedef struct tagREBARBANDINFOW
{
	UINT	cbSize;
	UINT	fMask;
	UINT	fStyle;
	COLORREF	clrFore;
	COLORREF	clrBack;
	LPWSTR	lpText;
	UINT	cch;
	int	iImage;
	HWND	hwndChild;
	UINT	cxMinChild;
	UINT	cyMinChild;
	UINT	cx;
	HBITMAP	hbmBack;
	UINT	wID;
}	REBARBANDINFOW, FAR *LPREBARBANDINFOW;
typedef REBARBANDINFOW CONST FAR *LPCREBARBANDINFOW;

typedef struct tagCOMBOBOXEXITEMA
{
	UINT mask;
	int iItem;
	LPSTR pszText;
	int cchTextMax;
	int iImage;
	int iSelectedImage;
	int iOverlay;
	int iIndent;
	LPARAM lParam;
} COMBOBOXEXITEMA, *PCOMBOBOXEXITEMA;
typedef COMBOBOXEXITEMA CONST *PCCOMBOEXITEMA;


typedef struct tagCOMBOBOXEXITEMW
{
	UINT mask;
	int iItem;
	LPWSTR pszText;
	int cchTextMax;
	int iImage;
	int iSelectedImage;
	int iOverlay;
	int iIndent;
	LPARAM lParam;
} COMBOBOXEXITEMW, *PCOMBOBOXEXITEMW;
typedef COMBOBOXEXITEMW CONST *PCCOMBOEXITEMW;

#ifdef UNICODE
#define COMBOBOXEXITEM	COMBOBOXEXITEMW
#define PCOMBOBOXEXITEM	PCOMBOBOXEXITEMW
#define PCCOMBOBOXEXITEM	PCCOMBOBOXEXITEMW
#else
#define COMBOBOXEXITEM	COMBOBOXEXITEMA
#define PCOMBOBOXEXITEM	PCOMBOBOXEXITEMA
#define PCCOMBOBOXEXITEM	PCCOMBOBOXEXITEMA
#endif

typedef struct {
	NMHDR hdr;
	COMBOBOXEXITEM ceItem;
} NMCOMBOBOXEX, *PNMCOMBOBOXEX;

#define CBEMAXSTRLEN 260

typedef struct {
	NMHDR hdr;
	BOOL fChanged;
	int iNewSelection;
	WCHAR szText[CBEMAXSTRLEN];
	int iWhy;
} NMCBEENDEDITW, *PNMCBEENDEDITW;

typedef struct {
	NMHDR hdr;
	BOOL fChanged;
	int iNewSelection;
	char szText[CBEMAXSTRLEN];
	int iWhy;
} NMCBEENDEDITA, *PNMCBEENDEDITA;

typedef struct tagNMTOOLBARA {
	NMHDR	hdr;
	int	iItem;
	TBBUTTON tbButton;
	int	cchText;
	LPSTR	pszText;
} NMTOOLBARA, FAR* LPNMTOOLBARA;


typedef struct tagNMTOOLBARW {
	NMHDR	hdr;
	int	iItem;
	TBBUTTON tbButton;
	int	cchText;
	LPWSTR	pszText;
} NMTOOLBARW, FAR* LPNMTOOLBARW;

typedef struct tagLVHITTESTINFO
{
	POINT pt;
	UINT flags;
	int iItem;

	int iSubItem;
} LVHITTESTINFO, FAR* LPLVHITTESTINFO;
#define LV_HITTESTINFO LVHITTESTINFO

#ifdef UNICODE
#define NMTOOLBAR	NMTOOLBARW
#define LPNMTOOLBAR	LPNMTOOLBARW
#else
#define NMTOOLBAR	NMTOOLBARA
#define LPNMTOOLBAR	LPNMTOOLBARA
#endif
#ifdef UNICODE
#define	NMCBEENDEDIT NMCBEENDEDITW
#define	PNMCBEENDEDIT PNMCBEENDEDITW
#else
#define	NMCBEENDEDIT NMCBEENDEDITA
#define	PNMCBEENDEDIT PNMCBEENDEDITA
#endif

#ifdef UNICODE
#define REBARBANDINFO	REBARBANDINFOW
#define LPREBARBANDINFO	LPREBARBANDINFOW
#define LPCREBARBANDINFO	LPCREBARBANDINFOW
#else
#define REBARBANDINFO	REBARBANDINFOA
#define LPREBARBANDINFO	LPREBARBANDINFOA
#define LPCREBARBANDINFO	LPCREBARBANDINFOA
#endif
#define PBS_SMOOTH		0x01
#define PBS_VERTICAL	0x04

#define PBM_GETRANGE	(WM_USER+7)
#define PBM_GETPOS		(WM_USER+8)

#define TCS_SCROLLOPPOSITE	0x0001
#define TCS_BOTTOM			0x0002
#define TCS_RIGHT			0x0002
#define TCS_HOTTRACK		0x0040
#define TCS_VERTICAL		0x0080

#define TBS_TOOLTIPS		0x0100

#define TB_GETBUTTONSIZE	(WM_USER + 58)

#define TCIF_STATE			0x0010

#define UDS_HOTTRACK		0x0100

#define TBN_DROPDOWN	(TBN_FIRST - 10)

#define CBES_EX_NOEDITIMAGE			0x00000001
#define CBES_EX_NOEDITIMAGEINDENT	0x00000002

#define CBEM_INSERTITEMA		(WM_USER + 1)
#define CBEM_SETIMAGELIST		(WM_USER + 2)
#define CBEM_GETIMAGELIST		(WM_USER + 3)
#define CBEM_GETITEMA			(WM_USER + 4)
#define CBEM_SETITEMA			(WM_USER + 5)
#define CBEM_DELETEITEM			CB_DELETESTRING
#define CBEM_GETCOMBOCONTROL	(WM_USER + 6)
#define CBEM_GETEDITCONTROL		(WM_USER + 7)
#define CBEM_SETEXSTYLE			(WM_USER + 8)
#define CBEM_GETEXSTYLE			(WM_USER + 9)
#define CBEM_HASEDITCHANGED		(WM_USER + 10)
#define CBEM_INSERTITEMW		(WM_USER + 11)
#define CBEM_SETITEMW			(WM_USER + 12)
#define CBEM_GETITEMW			(WM_USER + 13)

#ifdef UNICODE
#define CBEM_INSERTITEM			CBEM_INSERTITEMW
#define CBEM_SETITEM			CBEM_SETITEMW
#define CBEM_GETITEM			CBEM_GETITEMW
#else
#define CBEM_INSERTITEM			CBEM_INSERTITEMA
#define CBEM_SETITEM			CBEM_SETITEMA
#define CBEM_GETITEM			CBEM_GETITEMA
#endif

#define CBEN_FIRST				(0U-800U)

#define CBENF_KILLFOCUS			1
#define CBENF_RETURN			2
#define CBENF_ESCAPE			3
#define CBENF_DROPDOWN			4

#define CBEN_GETDISPINFO		(CBEN_FIRST - 0)
#define CBEN_INSERTITEM			(CBEN_FIRST - 1)
#define CBEN_DELETEITEM			(CBEN_FIRST - 2)
#define CBEN_BEGINEDIT			(CBEN_FIRST - 4)
#define CBEN_ENDEDITA			(CBEN_FIRST - 5)
#define CBEN_ENDEDITW			(CBEN_FIRST - 6)

#ifdef UNICODE
#define CBEN_ENDEDIT CBEN_ENDEDITW
#else
#define CBEN_ENDEDIT CBEN_ENDEDITA
#endif

/* Should be defined in <shlobj.h> */
#define BIF_BROWSEINCLUDEFILES	0x4000

#define ICC_LISTVIEW_CLASSES	0x00000001
#define ICC_TREEVIEW_CLASSES	0x00000002
#define ICC_BAR_CLASSES			0x00000004
#define ICC_TAB_CLASSES			0x00000008
#define ICC_UPDOWN_CLASS		0x00000010
#define ICC_PROGRESS_CLASS		0x00000020
#define ICC_HOTKEY_CLASS		0x00000040
#define ICC_ANIMATE_CLASS		0x00000080
#define ICC_WIN95_CLASSES		0x000000FF
#define ICC_DATE_CLASSES		0x00000100
#define ICC_USEREX_CLASSES		0x00000200
#define ICC_COOL_CLASSES		0x00000400

#define LVCF_IMAGE				0x0010

#define TBSTYLE_DROPDOWN		0x08
#define TBSTYLE_FLAT			0x0800
#define TBSTYLE_LIST			0x1000
#define TBSTYLE_CUSTOMERASE		0x2000

#define TTM_SETDELAYTIME		(WM_USER + 3)
#define TTM_SETTIPBKCOLOR		(WM_USER + 19)
#define TTM_SETTIPTEXTCOLOR		(WM_USER + 20)
#define TTM_GETDELAYTIME		(WM_USER + 21)
#define TTM_GETTIPBKCOLOR		(WM_USER + 22)
#define TTM_GETTIPTEXTCOLOR		(WM_USER + 23)

#define CBEIF_TEXT				0x00000001
#define CBEIF_IMAGE				0x00000002
#define CBEIF_SELECTEDIMAGE		0x00000004
#define CBEIF_OVERLAY			0x00000008
#define CBEIF_INDENT			0x00000010
#define CBEIF_LPARAM			0x00000020
#define CBEIF_DI_SETITEM		0x10000000

#define RBBIM_STYLE			0x00000001
#define RBBIM_COLORS		0x00000002
#define RBBIM_TEXT			0x00000004
#define RBBIM_IMAGE			0x00000008
#define RBBIM_CHILD			0x00000010
#define RBBIM_CHILDSIZE		0x00000020
#define RBBIM_SIZE			0x00000040
#define RBBIM_BACKGROUND	0x00000080
#define RBBIM_ID			0x00000100

#ifdef _WIN32
#define REBARCLASSNAMEW			L"ReBarWindow32"
#define REBARCLASSNAMEA			"ReBarWindow32"

#ifdef UNICODE
#define REBARCLASSNAME			REBARCLASSNAMEW
#else
#define REBARCLASSNAME			REBARCLASSNAMEA
#endif

#else
#define REBARCLASSNAME			"ReBarWindow"
#endif

#define WC_COMBOBOXEXW			L"ComboBoxEx32"
#define WC_COMBOBOXEXA			"ComboBoxEx32"

#ifdef UNICODE
#define WC_COMBOBOXEX			WC_COMBOBOXEXW
#else
#define WC_COMBOBOXEX			WC_COMBOBOXEXA
#endif

#define RICHEDIT_CLASSA		"RichEdit20A"
#define RICHEDIT_CLASS10A	"RICHEDIT"

#define RICHEDIT_CLASSW		L"RichEdit20W"

#if (_RICHEDIT_VER >= 0x0200 )
#ifdef UNICODE
#define RICHEDIT_CLASS		RICHEDIT_CLASSW
#else
#define RICHEDIT_CLASS		RICHEDIT_CLASSA
#endif
#else
#define RICHEDIT_CLASS		RICHEDIT_CLASS10A
#endif 

#endif /* EIF_BORLAND */
#ifdef __cplusplus
}
#endif

#endif /* __WEL__ */
