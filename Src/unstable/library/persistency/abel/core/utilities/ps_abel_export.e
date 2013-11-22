note
	description: "Dummy class to restrict export of backend features to descendants of this class."
	author: "Roman schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ABEL_EXPORT

inherit

	REFACTORING_HELPER
		export
		{NONE}
			--to_implement_assertion,
			fixme,
			to_implement
		end

feature {NONE} -- Utilities

	attach (obj: detachable ANY): attached like obj
			-- Nice little helper function to make implementation with void safety easier.
		do
			check attached obj as attached_obj then
				Result := obj
			end
		end


	basic_types: HASH_TABLE [BOOLEAN, INTEGER]
			-- A quick lookup table for basic types.
		once
			create Result.make (20)

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

feature {PS_ABEL_EXPORT} -- Contracts

	enable_expensive_contracts: BOOLEAN = True
			-- Defines if some very expensive contracts should be enabled as well.
end
