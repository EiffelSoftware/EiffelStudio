indexing

	description:
		"Use this class as ansector of classes that are used to do a boolean %
		%operation on the profile information."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class BOOLEAN_FILTER

inherit
	PROFILE_FILTER

feature -- Creation

	make is
		do
			create filters.make
		end

feature -- Adding PROFILE_FILTERs

	extend (new_filter: PROFILE_FILTER) is
			-- Extend filters to be checked with `new_filter'.
		do
			filters.extend (new_filter)
			filters.forth
		end

feature -- Checking

	filtering_is_allowed: BOOLEAN is
			-- May `filter' be called?
		do
			Result := filters.count >= 2
		end

feature {NONE} -- Attributes

	filters: LINKED_LIST [PROFILE_FILTER]
		-- Filters to checked by this filter

feature {NONE} -- Hidden features

	set_operator (new_operator: STRING) is
		do
		end

	set_value (new_value: COMPARABLE) is
		do
		end

	set_value_range (lower, upper: COMPARABLE) is
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class BOOLEAN_FILTER
