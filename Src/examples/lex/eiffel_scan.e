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
			copy, consistent, is_equal, setup
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

end -- class EIFFEL_SCAN

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
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

