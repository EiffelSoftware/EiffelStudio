indexing

	description:
		"Facilities for adapting the exception handling mechanism. %
		%This class may be used as ancestor by classes needing its facilities.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EXCEPTIONS

feature -- Status report

	is_programmer_exception (tag: STRING): BOOLEAN is
			-- Is the last exception a programmer exception of tag `tag' ?
		do
			Result := 	exception = Programmer_exception
						and then
						equal (tag, programmer_exception_name)
		end;


	exception: INTEGER is
			-- Last exception code
		external
			"C"
		alias
			"eecode"
		end;

	programmer_exception_name: STRING is
			-- Last programmer exception tag
		external
			"C"
		alias
			"eetag"
		end;

feature -- Output

	raise (tag: STRING) is
			-- Raise a user exception of tag `tag'.
		local
			str: ANY;
		do
			if tag /= Void then
				str := tag.to_c
			end;
			eraise ($str, Programmer_exception);
		end;

feature {NONE} -- Implementation

	eraise (str: ANY; code: INTEGER) is
			-- Raise an exception
		external
			"C"
		end;

	Programmer_exception: INTEGER is 24;
				--| This value cannot be changed.

end -- class EXCEPTIONS


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
