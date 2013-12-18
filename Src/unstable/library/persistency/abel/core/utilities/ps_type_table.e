note
	description: "Lookup tables for special type identifier."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TYPE_TABLE

inherit
	REFLECTOR_CONSTANTS

feature -- Access

	basic_expanded_types: HASH_TABLE [BOOLEAN, INTEGER]
			-- The basic expanded types.
		once
			create Result.make (14)

			Result.extend (True, ({INTEGER_8}).type_id)
			Result.extend (True, ({INTEGER_16}).type_id)
			Result.extend (True, ({INTEGER_32}).type_id)
			Result.extend (True, ({INTEGER_64}).type_id)

			Result.extend (True, ({NATURAL_8}).type_id)
			Result.extend (True, ({NATURAL_16}).type_id)
			Result.extend (True, ({NATURAL_32}).type_id)
			Result.extend (True, ({NATURAL_64}).type_id)


			Result.extend (True, ({REAL_32}).type_id)
			Result.extend (True, ({REAL_64}).type_id)

			Result.extend (True, ({CHARACTER_8}).type_id)
			Result.extend (True, ({CHARACTER_32}).type_id)

			Result.extend (True, ({BOOLEAN}).type_id)
			Result.extend (True, ({POINTER}).type_id)
		end

	string_types: HASH_TABLE [BOOLEAN, INTEGER]
			-- The supported string types.
		once
			create Result.make (4)
			Result.extend (True, ({detachable STRING_8}).type_id)
			Result.extend (True, ({detachable STRING_32}).type_id)
			Result.extend (True, ({detachable IMMUTABLE_STRING_8}).type_id)
			Result.extend (True, ({detachable IMMUTABLE_STRING_32}).type_id)
		end

	basic_type_names: SPECIAL [IMMUTABLE_STRING_8]
			-- The name for all basic types.
			-- Lookup is based on REFLECTOR_CONSTANTS.
			-- NOTE: Do not use it with the none type.
			-- NOTE: A lookup for a reference or expanded type will yield a bogus result.
		once
			create Result.make_empty (max_predefined_type + 1)

			Result.extend (({POINTER}).name) -- at Index 0
			Result.extend ("error_reference")
			Result.extend (({CHARACTER_8}).name)
			Result.extend (({BOOLEAN}).name)
			Result.extend (({INTEGER_32}).name)

			Result.extend (({REAL_32}).name) -- Index 5
			Result.extend (({REAL_64}).name)
			Result.extend ("error_expanded")
			Result.extend ("error_bit_type")
			Result.extend (({INTEGER_8}).name)

			Result.extend (({INTEGER_16}).name) -- Index 10
			Result.extend (({INTEGER_64}).name)
			Result.extend (({CHARACTER_32}).name)
			Result.extend (({NATURAL_8}).name)
			Result.extend (({NATURAL_16}).name)

			Result.extend (({NATURAL_32}).name) -- Index 15
			Result.extend (({NATURAL_64}).name)
		end

end
