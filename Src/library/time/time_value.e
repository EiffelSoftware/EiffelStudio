indexing
	description: "time value in a day"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	TIME_VALUE

inherit
	TIME_CONSTANTS
		redefine
			out
		 end;

creation

feature -- Access 

	hour: INTEGER;
			-- Hour of the current time
			
	minute: INTEGER;
			-- Minute of the current time
			
	fine_second: DOUBLE;
			-- Representation of second with decimals 
 
	second: INTEGER is
			-- Second of the current time
		do
			Result := fine_second.truncated_to_integer
		end;

	fractionnal_second: DOUBLE is
			-- Fractionnal part of `fine_second'
		do
			Result := fine_second - second
		end;

	milli_second: INTEGER is 
			-- Millisecond of the current time
		do 
			Result := (fractionnal_second * 1000).truncated_to_integer 
		end;

	micro_second: INTEGER is 
			-- Microsecond of the current time
		do 
			Result := (fractionnal_second * 1_000_000).truncated_to_integer;
			Result := Result \\ 1000
		end; 
 
	nano_second: INTEGER is 
			-- Nanosecond of the current time
		do 
			Result := (fractionnal_second * 1_000_000_000).truncated_to_integer;
			Result := Result \\ 1000
		end; 
 
feature -- Conversion
 
	out: STRING is 
			-- Printable representation of time
		do 
			Result := hour.out; 
			Result.extend (':');
			Result.append (minute.out);
			Result.extend (':');
			Result.append (second.out);
			Result.extend ('.')
		end;
 
	out_fine (p: INTEGER): STRING is
			-- Printable representation of time
			-- `p' is the number of decimals shown
		require
			p_strictly_positive: p > 0
		local
			fractions: INTEGER;
			format: FORMAT_DOUBLE
		do
			Result := hour.out;
			Result.extend (':'); 
			Result.append (minute.out); 
			Result.extend (':');
			!! format.make (p + 1, p)
			Result.append (format.formatted (fine_second));
		end;			 

end -- class TIME_VALUE


--|---------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|---------------------------------------------------------------
