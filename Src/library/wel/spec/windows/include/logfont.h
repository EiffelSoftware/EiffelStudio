/*
 * LOGFONT.H
 */

#ifndef __WEL_LOGFONT_
#define __WEL_LOGFONT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_log_font_set_height(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfHeight = (LONG) (_value_))
#define cwel_log_font_set_width(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfWidth = (LONG) (_value_))
#define cwel_log_font_set_escapement(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfEscapement = (LONG) (_value_))
#define cwel_log_font_set_orientation(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfOrientation = (LONG) (_value_))
#define cwel_log_font_set_weight(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfWeight = (LONG) (_value_))
#define cwel_log_font_set_italic(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfItalic = (BYTE) (_value_))
#define cwel_log_font_set_underline(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfUnderline = (BYTE) (_value_))
#define cwel_log_font_set_strikeout(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfStrikeOut = (BYTE) (_value_))
#define cwel_log_font_set_charset(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfCharSet = (BYTE) (_value_))
#define cwel_log_font_set_outprecision(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfOutPrecision = (BYTE) (_value_))
#define cwel_log_font_set_clipprecision(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfClipPrecision = (BYTE) (_value_))
#define cwel_log_font_set_quality(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfQuality = (BYTE) (_value_))
#define cwel_log_font_set_pitchandfamily(_ptr_, _value_) (((LOGFONT *) _ptr_)->lfPitchAndFamily = (BYTE) (_value_))
#define cwel_log_font_set_facename(_ptr_, _value_) (strcpy(((LOGFONT *) _ptr_)->lfFaceName, (char *) (_value_)))

#define cwel_log_font_get_height(_ptr_) ((((LOGFONT *) _ptr_)->lfHeight))
#define cwel_log_font_get_width(_ptr_) ((((LOGFONT *) _ptr_)->lfWidth))
#define cwel_log_font_get_escapement(_ptr_) ((((LOGFONT *) _ptr_)->lfEscapement))
#define cwel_log_font_get_orientation(_ptr_) ((((LOGFONT *) _ptr_)->lfOrientation))
#define cwel_log_font_get_weight(_ptr_) ((((LOGFONT *) _ptr_)->lfWeight))
#define cwel_log_font_get_italic(_ptr_) ((((LOGFONT *) _ptr_)->lfItalic))
#define cwel_log_font_get_underline(_ptr_) ((((LOGFONT *) _ptr_)->lfUnderline))
#define cwel_log_font_get_strikeout(_ptr_) ((((LOGFONT *) _ptr_)->lfStrikeOut))
#define cwel_log_font_get_charset(_ptr_) ((((LOGFONT *) _ptr_)->lfCharSet))
#define cwel_log_font_get_outprecision(_ptr_) ((((LOGFONT *) _ptr_)->lfOutPrecision))
#define cwel_log_font_get_clipprecision(_ptr_) ((((LOGFONT *) _ptr_)->lfClipPrecision))
#define cwel_log_font_get_quality(_ptr_) ((((LOGFONT *) _ptr_)->lfQuality))
#define cwel_log_font_get_pitchandfamily(_ptr_) ((((LOGFONT *) _ptr_)->lfPitchAndFamily))
#define cwel_log_font_get_pitch(_ptr_) (LOWORD((((LOGFONT *) _ptr_)->lfPitchAndFamily)))
#define cwel_log_font_get_family(_ptr_) (HIWORD((((LOGFONT *) _ptr_)->lfPitchAndFamily)))
#define cwel_log_font_get_facename(_ptr_) ((((LOGFONT *) _ptr_)->lfFaceName))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_LOG_FONT__ */

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
