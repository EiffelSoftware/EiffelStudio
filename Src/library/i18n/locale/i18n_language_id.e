indexing
	description: "Objects that ..."
	author: ""
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

end
