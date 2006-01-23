indexing

	description:
		"Standard input in the Unix understanding."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STDIN

