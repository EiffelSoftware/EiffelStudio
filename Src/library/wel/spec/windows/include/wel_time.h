/*
 *  wel_time.h
 */

 
#ifndef __WEL_TIME__
#define __WEL_TIME__


#include "wel.h"

#define cwel_compare_file_time(_pft1_, _pft2_) (CompareFileTime ((FILETIME *)_pft1_, (FILETIME *)_pft2_))
#define cwel_system_time_to_file_time(_pst_, _pft_) (SystemTimeToFileTime ((SYSTEMTIME *)_pst_, (LPFILETIME)_pft_))
#define cwel_file_time_to_system_time(_pft_, _pst_) (FileTimeToSystemTime ((FILETIME *)_pft_, (LPSYSTEMTIME)_pst_))
#define cwel_get_system_time(_pst_) (GetSystemTime ((LPSYSTEMTIME)_pst_))
#define cwel_file_time_to_local_file_time(_pft1_, _pft2_) (FileTimeToLocalFileTime ((FILETIME *)_pft1_, (LPFILETIME)_pft2_))
#define cwel_local_file_time_to_file_time(_pft1_, _pft2_) (LocalFileTimeToFileTime ((FILETIME *)_pft1_, (LPFILETIME)_pft2_))
#define cwel_get_file_time(_hfile_, _pftc_, _pfta_, _pftm_) (GetFileTime ((HANDLE)_hfile_, (LPFILETIME)_pftc_, (LPFILETIME)_pfta_, (LPFILETIME)_pftm_))
#define cwel_get_system_time_as_file_time(_pft_) (GetSystemTimeAsFileTime ((LPFILETIME)_pft_))
#define cwel_system_time_year(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wYear))
#define cwel_system_time_month(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wMonth))
#define cwel_system_time_day_of_week(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wDayOfWeek))
#define cwel_system_time_day(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wDay))
#define cwel_system_time_hour(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wHour))
#define cwel_system_time_minute(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wMinute))
#define cwel_system_time_second(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wSecond))
#define cwel_system_time_milliseconds(_pst_) ((EIF_INTEGER)(((SYSTEMTIME *)_pst_)->wMilliseconds))

#endif /* __WEL_TIME__  */

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
