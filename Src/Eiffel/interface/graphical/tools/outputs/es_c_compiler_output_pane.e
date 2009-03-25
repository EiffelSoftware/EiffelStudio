note
	description: "[
		An editor output pane specifically for the C compiler output, for use with the
		Outputs Tool ({ES_OUTPUTS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_C_COMPILER_OUTPUT_PANE

inherit
	ES_EDITOR_OUTPUT_PANE
		redefine
			new_widget
		end

create
	make,
	make_with_icon

feature {NONE} -- Factory

	new_widget (a_window: attached SHELL_WINDOW_I): attached ES_C_COMPILER_EDITOR_WIDGET
			-- <Precursor>
		do
			if attached {EB_DEVELOPMENT_WINDOW} a_window as l_window then
				create {ES_C_COMPILER_EDITOR_WIDGET} Result.make (l_window)
			else
				check False end
			end
		end

invariant
	not_name_is_empty: not name.is_empty

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
