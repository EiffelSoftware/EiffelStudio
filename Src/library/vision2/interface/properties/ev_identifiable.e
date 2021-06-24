note
	description:
		"Abstraction for objects that can be identified by name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "identifiable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_IDENTIFIABLE

inherit
	EV_ANY

	DEBUG_OUTPUT
		undefine
			default_create, copy
		end

feature -- Access

	parent: detachable EV_IDENTIFIABLE
			-- Parent of object
		require
			not_destroyed: not is_destroyed
		deferred
		ensure
			correct: has_parent implies Result /= Void
			correct: not has_parent implies Result = Void
		end

	identifier_name: STRING_32
			-- Name of object
			-- If no specific name is set, `default_identifier_name' is used.
		do
			if attached internal_name as l_internal_name then
				Result := l_internal_name.twin
			else
				Result := default_identifier_name
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
			no_period_in_result: not Result.has ('.')
			default_name_available: not has_identifier_name_set implies Result.is_equal (default_identifier_name)
		end

	default_identifier_name: STRING_32
			-- Default name if no other name is set.
		do
			Result := {STRING_32} "{" + generating_type.name_32 + "}"
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
			no_period_in_result: not Result.has ('.')
		end

	full_identifier_path: STRING_32
			-- Full name of object by prepending path of parent
			-- Uses '.' as a separator.
		do
			if attached parent as l_parent then
				Result := l_parent.full_identifier_path
				Result.append_character (l_parent.identifier_path_separator)
				Result.append_string (identifier_name)
			else
				Result := identifier_name.twin
			end
		ensure
			result_not_void: Result /= Void
			result_correct: parent = Void implies Result.is_equal (identifier_name)
			result_correct: attached parent as l_parent implies Result.is_equal (l_parent.full_identifier_path + "." + identifier_name)
		end

feature -- Status report

	debug_output: STRING_32
		do
			create Result.make (10)
			Result.append_character ('<')
			Result.append (($Current).out)
			Result.append_character ('>')

			if has_identifier_name_set then
				Result.append_character (' ')

				Result.append_character ('%"')
				Result.append (identifier_name)
				Result.append_character ('%"')
				Result.append_character (' ')
			end
			Result.append (generating_type.name_32)
		end

	has_parent: BOOLEAN
			-- Does identifiable has a parent?
		do
			Result := not is_destroyed and then parent /= Void
		end

	has_identifier_name_set: BOOLEAN
			-- Is a specific identifier name set?
		do
			Result := internal_name /= Void
		end

feature -- Element change

	set_identifier_name (a_name: READABLE_STRING_GENERAL)
			-- Set `identifier_name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			no_period_in_name: not a_name.has ('.')
			no_special_regexp_characters_in_name: -- TODO
		do
			create internal_name.make_from_string_general (a_name)
		ensure
			identifier_name_set: identifier_name.same_string_general (a_name)
		end

feature {EV_IDENTIFIABLE} -- Implementation

	identifier_path_separator: CHARACTER
			-- Character used to separate path to children
		once
			Result := '.'
		end

feature {NONE} -- Implementation

	internal_name: detachable STRING_32
			-- Internal name set by `set_identifier_name'

invariant

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_IDENTIFIABLE
