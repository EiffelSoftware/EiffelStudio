/*
 * wex_mci.h
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __WEL_MCI__
#define __WEL_MCI__

#ifdef _WIN32
#	ifndef WIN32
#		define WIN32
#	endif
#endif

#ifndef _INC_WINDOWS /* for Win16 */
#	ifndef _WINDOWS_ /* for Win32 */
#		include <windows.h>
#	endif
#endif

#include <vfw.h>
#include <digitalv.h>
#include <mmsystem.h>

#endif /* __WEL_MCI__ */

/*
--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
*/
