indexing

	description:
		"Standard output in the Unix understanding.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	STDOUT

inherit
	PLAIN_TEXT_FILE
		rename
			make as make_plain_text_file
		redefine
			count,
			close
		end
	
create
	make

feature -- Initialization

	make is
		do
			make_plain_text_file ("stdout")
			file_pointer := file_def (1)
			set_write_mode
		end

feature -- Status setting

	close is
			-- Close file.
		do
			mode := Closed_file
			descriptor_available := False
		end

feature -- Measurement

	count: INTEGER is 1
			-- Useless for STDOUT class.
			-- `count' is non zero not to invalidate invariant clauses.

feature {NONE} -- Implementation

	file_def (number: INTEGER): POINTER is
			-- Convert `number' to the corresponding
			-- file descriptor.
		external
			"C"
		end
		
end -- class STDOUT


--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
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

