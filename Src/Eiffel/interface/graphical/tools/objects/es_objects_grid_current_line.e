note
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_CURRENT_LINE

inherit
	ES_OBJECTS_GRID_SPECIFIC_LINE
		redefine
			compute_grid_display_for,
			text_data_for_clipboard
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_as (current_object_id)
		end

feature {NONE} -- Implementation

	compute_grid_display_for (cse: like call_stack_element)
		local
			value: ABSTRACT_DEBUG_VALUE
			proc: PROCEDURE
			item: ES_OBJECTS_GRID_OBJECT_LINE
			app: APPLICATION_EXECUTION
			r: like row
		do
			if cse /= Void then
				if attached cse.routine as l_routine and then l_routine.is_class then
						-- Do not show Current object for instance free call!
				elseif debugger_manager.is_dotnet_project then
					app := debugger_manager.application
					if not app.current_call_stack_is_empty then
						if attached {APPLICATION_STATUS_DOTNET} app.status as dn_st then
							value := dn_st.current_call_stack_element_dotnet.current_object
							if value /= Void then
								create {ES_OBJECTS_GRID_VALUE_LINE} item.make_with_value (value, parent_grid)
							end
						else
							check has_dotnet_status: False end
						end
					end
				else
					create {ES_OBJECTS_GRID_ADDRESS_LINE} item.make_with_call_stack_element (cse, parent_grid)
				end
			end
			if item /= Void then
				item.set_read_only (is_read_only)
				written_line := item --| Override default written_line
				item.set_display (display_expanded)
				item.set_title (interface_names.l_current_object)
				r := row
				if
					compute_grid_row_completed_action /= Void
					and then compute_grid_row_completed_action.is_empty
				then
					from
						compute_grid_row_completed_action.start
					until
						compute_grid_row_completed_action.after
					loop
						proc := compute_grid_row_completed_action.item
						if compute_grid_row_completed_action.has_kamikaze_action (proc) then
							item.compute_grid_row_completed_action.extend_kamikaze (proc)
						else
							item.compute_grid_row_completed_action.extend (proc)
						end
						compute_grid_row_completed_action.remove
					end
					check
						compute_grid_row_completed_action.count = 0
					end
				end
				unattach
				item.attach_to_row (r)
			else
				row.hide
			end
		end

feature -- Query

	text_data_for_clipboard: detachable STRING_32
		do
			Result := Interface_names.l_current_object
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
