//------------------------------------------------------------------------------
// io_watcher.h
//------------------------------------------------------------------------------
// description: "C features of EV_ANY_IMP, see ev_any_imp.c and ev_any_imp.e" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#ifndef _IO_WATCHER_H_INCLUDED_
#define _IO_WATCHER_H_INCLUDED_

#include <eif_eiffel.h>
#include <glib.h>

void c_io_watcher_initialize_callback (
	void (*on_event_address) (EIF_REFERENCE, EIF_INTEGER)
);

guint c_io_watcher_add_watch_callback (EIF_OBJECT io_watcher, gint handle);

#endif

//------------------------------------------------------------------------------
// EiffelEvent: library of reusable components for ISE Eiffel.
// Copyright (C) 1986-1999 Interactive Software Engineering Inc.
// All rights reserved. Duplication and distribution prohibited.
// May be used only with ISE Eiffel, under terms of user license.
// Contact ISE for any other use.
//
// Interactive Software Engineering Inc.
// ISE Building, 2nd floor
// 270 Storke Road, Goleta, CA 93117 USA
// Telephone 805-685-1006, Fax 805-685-6869
// Electronic mail <info@eiffel.com>
// Customer support e-mail <support@eiffel.com>
// For latest info see award-winning pages: http://www.eiffel.com
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// CVS log
//------------------------------------------------------------------------------
//
// $Log$
// Revision 1.1  2000/08/10 17:37:59  etienne
// Moved file from .. to separate C code from Eiffel code.
//
// Revision 1.1  2000/05/16 16:05:10  oconnor
// initial
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
