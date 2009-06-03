note
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

feature {NONE} -- Initialization

	make (a_language: STRING_GENERAL)
			-- Initialize language id to `a_language'.
		require
			a_language_not_void: a_language /= Void
		do
			name := a_language.as_string_32
		ensure
			name_set: name.is_equal(a_language.as_string_32)
		end

feature -- Access

	name: STRING_32
			-- Language name

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := other.name.is_equal(name)
		end

feature --hashable

	hash_code: INTEGER
			-- Hash code value
		do
			Result := name.hash_code
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
