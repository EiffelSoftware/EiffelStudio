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
			count,
			close
		end
	
create
	make

feature -- Initialization

	make is
		do
			make_plain_text_file ("stdin")
			file_pointer := console_def (0)
			set_read_mode
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
			-- Useless for STDIN class.
			-- `count' is non zero not to invalidate invariant clauses.

feature {NONE} -- Externals			
			
	console_def (number: INTEGER): POINTER is
			-- Convert `number' to the corresponding
			-- file descriptor.
		external
			"C | %"eif_console.h%""
		end

end -- class STDIN

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

