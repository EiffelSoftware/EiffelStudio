indexing
	description: "Eiffel-MATISSE Binding: Example for HASH_TABLE";
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
	
end -- class ZIP_CODE_CONSTANTS
