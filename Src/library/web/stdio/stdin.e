indexing

	description:
		"Standard input in the Unix understanding.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	STDIN

inherit
	PLAIN_TEXT_FILE
		rename
			make as make_plain_text_file
		redefine
			count, close
		end
	
creation
	make

feature -- Initialization

	make is
		do
			make_plain_text_file ("stdin");
			file_pointer := file_def (0);
			set_read_mode
		end

feature -- Status setting

	close is
			-- Close file.
		do
			mode := Closed_file;
			descriptor_available := False
		end

feature -- Measurement

	count: INTEGER is 1
			-- Useless for STDIN class.
			-- `count' is non zero not to invalidate invariant clauses.

feature {NONE} -- Implementation

	file_def (number: INTEGER): POINTER is
			-- Convert `number' to the corresponding
			-- file descriptor.
		external
			"C"
		end

end -- class STDIN

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|---------------------------------------------------------------

