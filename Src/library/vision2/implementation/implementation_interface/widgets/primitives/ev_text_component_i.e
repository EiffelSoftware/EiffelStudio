indexing
	description: 
		"EiffelVision text component, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			build
		end

	EV_BAR_ITEM_I

feature {EV_WIDGET} -- Initialization

	build is
			-- Common initializations for Gtk and Windows.
		local
			color: EV_COLOR
		do
			set_expand (True)
			set_vertical_resize (True)
			set_horizontal_resize (True)
			!! color.make_rgb (255, 255, 255)
			set_background_color (color)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
		end

feature -- Access

	text: STRING is
			-- Text of current label
		require
			exists: not destroyed
		deferred
		end 

	text_length: INTEGER is
			-- Length of the text in the widget
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting
	
	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		require
			exists: not destroyed
		deferred
		end

	set_text (txt: STRING) is
			-- set text in component to 'txt'
		require
			exist: not destroyed			
			not_void: txt /= Void
		deferred		
		ensure
			text_set: text.is_equal (txt)
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into component
		require
			exist: not destroyed			
			not_void: txt /= Void
		deferred
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		require
			exist: not destroyed			
			not_void: txt /= Void
		deferred
		ensure
			text_prepended:
		end
	
	set_position (pos: INTEGER) is
			-- set current insertion position
		require
			exist: not destroyed			
			valid_pos: pos >= 0 and pos <= text.count
		deferred
		end
	
	set_maximum_line_length (lenght: INTEGER) is
			-- Maximum number of charachters on line
		require
			exist: not destroyed			
		deferred
		end
	
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		require
			exist: not destroyed
			valid_start: start_pos > 0 and start_pos <= text.count
			valid_end: end_pos > 0 and end_pos <= text.count
		deferred
		ensure
		end	

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		require
			exists: not destroyed
			valid_nb: nb > 0
		deferred
		end

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		require
			exists: not destroyed
			valid_string: str /= Void
		deferred
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		require
			exists: not destroyed
		deferred
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		require
			exists: not destroyed
		deferred
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		require
			exists: not destroyed
		deferred
		end
	
end --class EV_TEXT_COMPONENT_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
