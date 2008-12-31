note
	description: "[
		Specialize implementation of {EC_EIFFEL_LAYOUT} that overrides onces and allows `is_workbench' to be set irrespective on a containing
		project's compiled status.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EC_CLEANER_EIFFEL_LAYOUT

inherit
	EC_EIFFEL_LAYOUT
		redefine
			is_workbench
		end

feature -- Status report

	is_workbench: BOOLEAN
			-- Is workbench
		do
			Result := internal_is_workbench
		end

feature {NONE} -- Status report

	internal_is_workbench: BOOLEAN
			-- Internal version of `is_workbench'

feature {PACKAGE} -- Status setting

	set_is_workbench (a_value: like is_workbench)
			-- Set `is_workbench' with `a_value'
		do
			internal_is_workbench := a_value
		ensure
			is_workbench_set: is_workbench = a_value
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
