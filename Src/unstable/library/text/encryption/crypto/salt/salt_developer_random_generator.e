note
	description: "Salt generator based on RANDOM for development purposes"
	date: "$Date$"
	revision: "$Revision$"

class
	SALT_DEVELOPER_RANDOM_GENERATOR

inherit

	SALT_GENERATOR

create
	make

feature --{NONE} Implementation

	set_seed (a_seed: INTEGER)
			-- <Precursor>
		do
			create random_sequence.set_seed (a_seed)
		end

	new_random: INTEGER_64
			-- <Precursor>
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	random_sequence: RANDOM
			-- Random sequence

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
