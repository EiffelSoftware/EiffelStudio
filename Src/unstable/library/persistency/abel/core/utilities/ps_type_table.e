note
	description: "Lookup tables for special type identifier."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TYPE_TABLE

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

end
