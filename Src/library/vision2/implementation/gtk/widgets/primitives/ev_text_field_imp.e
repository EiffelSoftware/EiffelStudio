indexing
	description: "EiffelVision text field. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP
	
inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end
	
	EV_TEXT_COMPONENT_IMP
		redefine
			interface
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP
		redefine
			create_return_actions
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk entry.
		do
			base_make (an_interface)
			set_c_object (C.gtk_entry_new)
			entry_widget := c_object
		end

feature -- Access

	text: STRING is
			-- Text displayed in field.
		do
			create Result.make_from_c (C.gtk_entry_get_text (entry_widget))
			if Result.is_equal ("") then
				Result := Void
			end
		end

feature -- Status setting
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			tf_text: STRING
		do
			if a_text /= Void then
				tf_text := a_text
			else
				tf_text := ""
			end
			C.gtk_entry_set_text (entry_widget, eiffel_to_c (tf_text))
		end

	append_text (txt: STRING) is
			-- Append `txt' to the end of the text.
		do
			C.gtk_entry_append_text (entry_widget, eiffel_to_c (txt))
		end
	
	prepend_text (txt: STRING) is
			-- Prepend `txt' to the end of the text.
		do
			C.gtk_entry_prepend_text (entry_widget, eiffel_to_c (txt))
		end
		
	set_capacity (len: INTEGER) is
		do
			C.gtk_entry_set_max_length (entry_widget, len)
		end
	
	capacity: INTEGER is
			-- Return the maximum number of characters that the
			-- user may enter.
		do
			Result := C.gtk_entry_struct_text_max_length (entry_widget)
		end

feature -- Status Report

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_editable_get_position (entry_widget) + 1
		end

feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field

feature {EV_ANY_I} -- Implementation

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_connect_signal_to_actions (entry_widget, "activate", Result, Void)
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD
			--Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	entry_widget_set: entry_widget /= NULL
end -- class EV_TEXT_FIELD_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable  components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.21  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.7  2000/10/27 22:45:47  king
--| Updated set/get text routines to account for interface revision
--|
--| Revision 1.13.4.6  2000/09/13 16:46:31  oconnor
--| fixed off by one on carret_position
--|
--| Revision 1.13.4.5  2000/09/12 19:08:09  king
--| Moved some implementation up to text_component
--|
--| Revision 1.13.4.4  2000/08/03 20:15:53  king
--| Removed unneeded initialize, redefined create_return_actions
--|
--| Revision 1.13.4.3  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.13.4.2  2000/05/25 00:41:58  king
--| Implemented external in Eiffel
--|
--| Revision 1.13.4.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.19  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.18  2000/04/20 18:07:41  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.17  2000/04/04 21:00:33  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.16  2000/03/08 21:42:44  king
--| Indented to fit within 80 cols
--|
--| Revision 1.15  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.12  2000/02/11 18:25:27  king
--| Added entry widget pointer in EV_TEXT_FIELD_IMP to accomodate the fact
--| that combo box is not an entry widget
--|
--| Revision 1.13.6.11  2000/02/10 08:45:18  oconnor
--| connect_signal_to_actions "changed"
--|
--| Revision 1.13.6.10  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.13.6.9  2000/02/01 01:42:34  brendel
--| Implemented (set_)caret_position.
--| Improved implementations.
--|
--| Revision 1.13.6.8  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.7  2000/01/18 07:15:09  oconnor
--| rewoked in like with new interface class
--|
--| Revision 1.13.6.6  2000/01/06 18:43:03  king
--| Added unimplemented caret_position and set_caret_position
--|
--| Revision 1.13.6.5  1999/12/13 20:03:09  oconnor
--| commented out old command stuff
--|
--| Revision 1.13.6.4  1999/12/04 18:59:21  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.13.6.3  1999/12/01 20:27:50  oconnor
--| tweaks for new externals
--|
--| Revision 1.13.6.2  1999/11/30 23:14:21  oconnor
--| rename widget to c_object
--| redefine interface to be of mreo refined type
--|
--| Revision 1.13.6.1  1999/11/24 17:29:58  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.13.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
