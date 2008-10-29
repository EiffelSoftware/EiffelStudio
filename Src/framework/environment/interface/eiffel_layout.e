indexing
	description: "Provide access to eiffel environment information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LAYOUT

feature -- Status

	is_eiffel_layout_defined: BOOLEAN is
			-- Has the layout been defined?
		do
			Result := eiffel_layout_cell.item /= Void
		end

feature -- Update

	set_eiffel_layout (a_layout: like eiffel_layout) is
			-- Set `eiffel_layout' to `a_layout'.
		require
			a_layout_ok: a_layout /= Void
		do
			eiffel_layout_cell.put (a_layout)
		ensure
			is_eiffel_layout_defined: is_eiffel_layout_defined
		end

feature -- Access

	eiffel_layout: EIFFEL_ENV is
			-- Layout of eiffel.
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		do
			Result := eiffel_layout_cell.item
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	eiffel_layout_cell: CELL [EIFFEL_ENV] is
			-- Cell to hold the layout.
		indexing
			once_status: global
		once
			create Result.put (Void)
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
