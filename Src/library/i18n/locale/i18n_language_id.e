indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_LANGUAGE_ID

inherit
	ANY
		redefine
			is_equal
		end

	HASHABLE
		undefine
			is_equal
		end
create
	make

feature --Identification

	name: STRING_32

feature --Creation

	make (a_language: STRING_GENERAL) is
			--
		require
			a_language_valid: a_language /= Void
		do
			name := a_language.as_string_32
		ensure
			name_set: name.is_equal(a_language.as_string_32)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			--
		do
			Result := other.name.is_equal(name)
		end

feature --hashable

	hash_code: INTEGER is
			--
		do
			Result := name.hash_code
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
