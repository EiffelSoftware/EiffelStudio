indexing
	description: "Name to be inserted by auto-completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAME_FOR_COMPLETION

inherit
	STRING
		rename
			make as make_string
		redefine
			is_equal, infix "<"
		end

create
	make

create {NAME_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialization
		do
			make_from_string (a_name)
			name := a_name
		end

feature -- Access

	name: STRING
			-- Completion item name

	full_insert_name: STRING is
			-- Full name to insert in editor
		do
			Result := out
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	icon: EV_PIXMAP is
			-- Associated icon based on data
		do
			Result := icon_internal
		end

	tooltip_text: STRING is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			create Result.make_from_string (Current)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Element change

	set_icon (a_icon: EV_PIXMAP) is
			-- Set `icon_internal' with `a_icon'.
		require
			a_icon_not_void: a_icon /= Void
		do
			icon_internal := a_icon
		ensure
			icon_internal_not_void: icon_internal /= Void
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is name made of same character sequence as `other' (case has no importance)
		do
			if name = Void or other.name = Void then
				Result := Precursor {STRING} (other)
			else
				Result := name.as_lower.is_equal (other.name.as_lower)
			end
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is name lexicographically lower than `other'?
		do
			if name = Void or other.name = Void then
				Result := Precursor {STRING} (other)
			else
				Result := name.as_lower < other.name.as_lower
			end
		end

	begins_with (s:STRING): BOOLEAN is
			-- Does this feature name begins with `s'?
		local
			lower_s: STRING
		do
			if count >= s.count then
				lower_s := s.as_lower
				Result := as_lower.substring_index_in_bounds (lower_s, 1, lower_s.count) = 1
			end
		end

feature {NONE} -- Implementation

	icon_internal: EV_PIXMAP;
			-- Icon	


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
