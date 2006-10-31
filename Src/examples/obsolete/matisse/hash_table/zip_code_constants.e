indexing
	description: "Eiffel-MATISSE Binding: Example for HASH_TABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ZIP_CODE_CONSTANTS

feature

	Zip_Standard: INTEGER is 1
	Zip_Unique: INTEGER is 2
	Zip_Military: INTEGER is 3
	
feature {NONE} -- Implementation

	zip_type_string(a_type: INTEGER) : STRING is
		do
			inspect a_type
			when Zip_Standard then Result := "Standard"
			when Zip_Unique then Result := "Unique"
			when Zip_Military then Result := "Military"
			else
				Result := "UNKNOWN"
			end
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


end -- class ZIP_CODE_CONSTANTS
