indexing
	description: 
		"EiffelVision frame. A frame is a container with a line%
		% around it. A label can be set on this line or not."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FRAME

inherit
	EV_CONTAINER
		redefine
			implementation
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a frame with `par' as parent.
		do
			!EV_FRAME_IMP! implementation.make
			widget_make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a frame with `par' as parent ant `txt'
			-- as label.
		require
			valid_parent: parent_needed implies par /= Void
		do
			!EV_FRAME_IMP! implementation.make_with_text (txt)
			widget_make (par)
		end

feature -- Access

	text: STRING is
			-- Current text of the frame.
		require
			exists: not destroyed
		do
			Result := implementation.text
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new text of the frame.
		require
			exists: not destroyed
			valid_text: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end

feature {NONE} -- Implementation

	implementation: EV_FRAME_I

end -- class EV_FRAME

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
