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
			interface,
			visual_widget
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
			set_c_object (C.gtk_event_box_new)
			entry_widget := C.gtk_entry_new
			C.gtk_widget_show (entry_widget)
			C.gtk_container_add (c_object, entry_widget)
			set_text ("")
		end

feature -- Access

	text: STRING is
			-- Text displayed in field.
		do
			create Result.make_from_c (C.gtk_entry_get_text (entry_widget))
		end

feature -- Status setting
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			temp_text: ANY
		do
			temp_text := a_text.to_c
			C.gtk_entry_set_text (entry_widget, $temp_text)
		end

	append_text (txt: STRING) is
			-- Append `txt' to the end of the text.
		local
			temp_caret_pos: INTEGER
			temp_text: ANY
		do
			temp_caret_pos := caret_position
			temp_text := txt.to_c
			C.gtk_entry_append_text (entry_widget, $temp_text)
			set_caret_position (temp_caret_pos)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend `txt' to the end of the text.
		local
			temp_caret_pos: INTEGER
			temp_text: ANY
		do
			temp_caret_pos := caret_position
			temp_text := txt.to_c
			C.gtk_entry_prepend_text (entry_widget, $temp_text)
			set_caret_position (temp_caret_pos)
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
		
	visual_widget: POINTER is
			-- 
		do
			Result := entry_widget
		end

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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

