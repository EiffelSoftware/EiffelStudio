indexing

	description:
		"Encapsulation of a C++ extension.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		rename
			is_equal as ext_is_equal
		end
	EXTERNAL_EXT_I
		redefine
			is_equal
		select
			is_equal
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := ext_is_equal (other) and then
				False -- FIXME
io.error.putstring ("%N%N%NFIXME (CPP_EXTENSION_I.is_equal)!!!!!%N%N%N");
		end

end -- class CPP_EXTENSION_I
