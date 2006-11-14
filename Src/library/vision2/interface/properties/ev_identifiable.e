indexing
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

feature -- Access

	parent: EV_IDENTIFIABLE is
			-- Parent of object
		require
			not_destroyed: not is_destroyed
		deferred
		ensure
			correct: has_parent implies Result /= Void
			correct: not has_parent implies Result = Void
		end

	identifier_name: STRING is
			-- Name of object
			-- If no specific name is set, the generating type is used.
		do
			if internal_name = Void then
				Result := "{"+generating_type+"}"
			else
				Result := internal_name.twin
			end
		end

	full_identifier_path: STRING
			-- Full name of object by prepending path of parent
			-- Uses '.' as a separator.
		do
			if parent = Void then
				Result := identifier_name.twin
			else
				Result := parent.full_identifier_path
				Result.append_character ('.')
				Result.append_string (identifier_name)
			end
		ensure
			result_not_void: Result /= Void
			result_correct: parent = Void implies Result.is_equal (identifier_name)
			result_correct: parent /= Void implies Result.is_equal (parent.full_identifier_path + "." + identifier_name)
		end

feature -- Status report

	has_parent: BOOLEAN is
			-- Does identifiable has a parent?
		do
			Result := parent /= Void
		end

feature -- Element change

	set_identifier_name (a_name: like identifier_name) is
			-- Set `identifier_name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			no_period_in_name: not a_name.has ('.')
			no_special_regexp_characters_in_name: -- TODO
		do
			internal_name := a_name.twin
		ensure
			identifier_name_set: identifier_name.is_equal (a_name)
		end

feature {NONE} -- Implementation

	internal_name: STRING
			-- Internal name set by `set_name'

invariant
	identifier_name_not_void: identifier_name /= Void
	identifier_name_not_empty: not identifier_name.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- EV_IDENTIFIABLE
