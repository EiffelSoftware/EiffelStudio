indexing
	description: "Object that represents a cell for e_feature used in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE_CELL

create
	make_with_feature

feature{NONE} -- Initialization

	make_with_feature (a_feature: like e_feature) is
			-- Initialize `e_feature' with `a_feature'.
		require
			a_feature_not_void: a_feature /= Void
		do
			set_e_feature (a_feature)
		end

feature -- Status reporting

	is_e_feature_set: BOOLEAN is
			-- Is `e_feature' set?
		do
			Result := e_feature /= Void
		ensure
			good_result: Result implies e_feature /= Void
		end

feature -- Access

	e_feature: E_FEATURE
			-- Feature in current context

	set_e_feature (ft: E_FEATURE) is
			-- Assign `ft' to `e_feature'.
		do
			e_feature := ft
		end

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
