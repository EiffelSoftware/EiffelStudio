indexing
	description: "Console"
	external_name: "ISE.Examples.Calculator.Console"

class
	CONSOLE

feature -- Access

	io: SYSTEM_CONSOLE
		indexing
			description: "Console"
			external_name: "Io"
		end

	last_string: STRING
		indexing
			description: "Last string read"
			external_name: "LastString"
		end

	last_real: REAL
		indexing
			description: "Last real read"
			external_name: "LastReal"
		end
		
feature -- Basic Operations

	put_string (a_string: STRING) is
		indexing
			description: "Write `a_string' to the console."
			external_name: "PutString"
		require
			non_void_string: a_string /= Void
		do
			io.write_string (a_string)
		end

	put_real (a_real: REAL) is
		indexing
			description: "Write `a_real' to the console."
			external_name: "PutReal"
		require
			non_void_real: a_real /= Void
		do
			io.write_single (a_real)
		end

	put_char (a_char: CHARACTER) is
		indexing
			description: "Write `a_char' to the console."
			external_name: "PutChar"
		require
			non_void_char: a_char /= Void		
		do
			io.write_char (a_char)
		end
		
	put_boolean (a_boolean: BOOLEAN) is
		indexing
			description: "Write `a_boolean' to the console."
			external_name: "PutBoolean"
		require
			non_void_boolean: a_boolean /= Void				
		do
			io.write_boolean (a_boolean)
		end

	new_line is
		indexing
			description: "Write a new line."
			external_name: "NewLine"
		do
			put_string ("%N")
		end

	read_real is
		indexing
			description: "Read a real. Make Result available in `last_real'."
			external_name: "ReadReal"
		local
			s: STRING
			convert: SYSTEM_CONVERT
		do
			s := io.read_line
			last_real := convert.to_single_string (s)
		end

	read_line is
		indexing
			description: "Read a line. Make Result available in `last_string'."
			external_name: "ReadLine"
		do
			last_string := io.read_line
		end
	
	next_line is
		indexing
			description: "Read next line and make Result available in `last_string'."
			external_name: "NextLine"
		do
			last_string := io.read_line
		end
		
end -- class CONSOLE

--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
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

