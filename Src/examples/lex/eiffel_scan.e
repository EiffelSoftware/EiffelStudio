indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Example of a lexical analyzer based on the Eiffel syntax.
-- The analyzer itself is found in the file ``eiffel_lex'', which
-- is created according to the file  ``eiffel_token'' if not
-- previously built and stored.

class EIFFEL_SCAN

inherit

	SCANNING
		rename
			make as scanning_make
		end;

	ARGUMENTS
		undefine
			copy, is_equal
		end

create

	make

feature 

	make is
			-- Create a lexical analyser for Eiffel if none,
			-- then use it to analyze the file of name
			-- `file_name'.
		local
			file_name: STRING;
		do
			if argument_count < 1 then
				io.error.putstring ("Usage: eiffel_scan eiffel_class_file.e%N")
			else
				file_name := argument (1);
				scanning_make;
				build ("eiffel_lex", "eiffel_regular");
				io.putstring ("Scanning file `");
				io.putstring (file_name);
				io.putstring ("'.%N");
				analyze (file_name)
			end
		end -- make

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


end -- class EIFFEL_SCAN

