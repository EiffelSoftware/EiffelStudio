indexing
	description: "EiffelVision insert text data.% 
	%Class for representing insert character event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_INSERT_TEXT_EVENT_DATA
	
inherit
	EV_RICH_TEXT_EVENT_DATA	
		redefine
			make,
			implementation,
			print_contents
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			!EV_INSERT_TEXT_EVENT_DATA_IMP! implementation
		end
	
feature -- Access	

	position: INTEGER is
			-- The position where the text has been inserted
		do
			Result := implementation.position
		ensure
			positive_result: Result >= 0
		end
		
	text: STRING is
			-- The text that has been inserted
		do
			Result := implementation.text
		ensure
			text_not_void: text /= Void
		end

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("Position: ")
			io.put_integer (position)
			io.put_string ("%N")
			io.put_string ("Text: ")
			io.put_string (text)
			io.put_string ("%N")
			io.put_string ("Text length: ")
			io.put_integer (text.count)
			io.put_string ("%N")
		end

feature {EV_WIDGET_IMP} -- Implementation

	implementation: EV_INSERT_TEXT_EVENT_DATA_IMP

end -- class EV_INSERT_TEXT_EVENT_DATA

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------
