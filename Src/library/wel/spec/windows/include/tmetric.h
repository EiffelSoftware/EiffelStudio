/*
 * TMETRIC.H
 */

#ifndef __WEL_TEXTMETRIC__
#define __WEL_TEXTMETRIC__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_text_metric_get_tmheight(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmHeight))
#define cwel_text_metric_get_tmascent(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmAscent))
#define cwel_text_metric_get_tmdescent(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmDescent))
#define cwel_text_metric_get_tminternalleading(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmInternalLeading))
#define cwel_text_metric_get_tmexternalleading(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmExternalLeading))
#define cwel_text_metric_get_tmavecharwidth(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmAveCharWidth))
#define cwel_text_metric_get_tmmaxcharwidth(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmMaxCharWidth))
#define cwel_text_metric_get_tmweight(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmWeight))
#define cwel_text_metric_get_tmoverhang(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmOverhang))
#define cwel_text_metric_get_tmdigitizedaspectx(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmDigitizedAspectX))
#define cwel_text_metric_get_tmdigitizedaspecty(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmDigitizedAspectY))
#define cwel_text_metric_get_tmfirstchar(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmFirstChar))
#define cwel_text_metric_get_tmlastchar(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmLastChar))
#define cwel_text_metric_get_tmdefaultchar(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmDefaultChar))
#define cwel_text_metric_get_tmbreakchar(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmBreakChar))
#define cwel_text_metric_get_tmitalic(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmItalic))
#define cwel_text_metric_get_tmunderlined(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmUnderlined))
#define cwel_text_metric_get_tmstruckout(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmStruckOut))
#define cwel_text_metric_get_tmpitchandfamily(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmPitchAndFamily))
#define cwel_text_metric_get_tmcharset(_ptr_) ((((TEXTMETRIC *) _ptr_)->tmCharSet))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TEXTMETRIC__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
