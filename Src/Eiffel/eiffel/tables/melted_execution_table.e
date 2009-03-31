note
	description: "HASH_TABLE of EXECUTION_UNIT with redefined `same_keys' comparison."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_EXECUTION_TABLE

inherit
	SEARCH_TABLE [EXECUTION_UNIT]
		redefine
			same_keys
		end

create
	make

feature -- Comparison

	same_keys (a_search_key, a_key: EXECUTION_UNIT): BOOLEAN
			-- <Precursor>
		do
			Result := a_search_key.same_as (a_key)
		end

end
