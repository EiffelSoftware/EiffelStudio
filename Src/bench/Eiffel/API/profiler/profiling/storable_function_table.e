indexing

	description:
		"Hashtable containing mappings for C-function names that are actually %
		%Eiffel features.";
	date: "$Date$";
	revision: "$Revision$"

class STORABLE_FUNCTION_TABLE [G -> EIFFEL_FUNCTION, H -> STRING]

inherit
	HASH_TABLE [G, H]

creation
	make

end -- class STORABLE_FUNCTION_TABLE
