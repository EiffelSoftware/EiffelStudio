indexing
	description: "Constants used in DUMP_VALUE and its clients to value the types"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE_CONSTANTS

feature -- Type identifiant in context of DUMP_VALUE

	Type_unknown		: INTEGER is 0
	Type_boolean		: INTEGER is 1
	Type_character		: INTEGER is 2
	Type_integer_32		: INTEGER is 3
	Type_integer_64		: INTEGER is 4
	Type_natural_32		: INTEGER is 5
	Type_natural_64		: INTEGER is 6	
	Type_real_32		: INTEGER is 7
	Type_real_64		: INTEGER is 8
	Type_bits			: INTEGER is 9
	Type_pointer		: INTEGER is 10
	Type_object			: INTEGER is 11
	Type_string			: INTEGER is 12
	Type_string_dotnet	: INTEGER is 13
	Type_expanded_object: INTEGER is 14

end -- class DUMP_VALUE_CONSTANTS
