note
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OBJECTS_GRID_SPECIFIC_LINE

inherit

	ES_OBJECTS_GRID_SPECIFIC_LINE_CONSTANTS

	ES_OBJECTS_GRID_LINE
		rename
			make as make_line
		redefine
			record_layout,
			reset
		end

feature {NONE} -- Initialization

	make_as (a_id: INTEGER)
			-- Initialize `Current'.
		do
			written_line := Current
			make_line
			id := a_id
			display_expanded := True
			set_read_only (True)
		end

feature -- Status

	display_expanded: BOOLEAN

feature -- Access

	id: INTEGER

	is_represented_by (aline: ES_OBJECTS_GRID_LINE): BOOLEAN
		do
			Result := (aline = written_line)
		end

	written_line: ES_OBJECTS_GRID_LINE

feature -- Change

	set_display_expanded (b: BOOLEAN)
			-- Set `display_expanded' with `b'
		do
			display_expanded := b
		end

	update
		do
		end

	compute_grid_display
		local
			cse: like call_stack_element
		do
			if row /= Void and not compute_grid_display_done then
				cse := call_stack_element
				compute_grid_display_for (cse)

				set_expand_action   (agent (r: EV_GRID_ROW) do display_expanded := True  end)
				set_collapse_action (agent (r: EV_GRID_ROW) do display_expanded := False end)

				compute_grid_display_done := True
				if
					display_expanded
					and
					row /= Void and then row.is_expandable
				then
					row.expand
				end
				update
			end
		end

	record_layout
		do
			Precursor
			if
				written_line /= Void
				and then written_line /= Current
				and then written_line.row /= Void
				and then written_line.row.parent /= Void
				and then written_line.row.is_show_requested
				and then written_line.compute_grid_display_done
			then
				display_expanded := written_line.row.is_expanded
			elseif
				row /= Void
				and then row.parent /= Void
				and then row.is_show_requested
				and then compute_grid_display_done
			then
				display_expanded := row.is_expanded
			end
		end

	reset
			--
		do
			Precursor
			reset_compute_grid_display_done
			if written_line /= Void and written_line /= Current then
				written_line.reset
				written_line := Void
			end
		end


feature {NONE} -- Implementation

	call_stack_element: detachable EIFFEL_CALL_STACK_ELEMENT
			--
		local
			app: APPLICATION_EXECUTION
		do
			if debugger_manager.safe_application_is_stopped then
				app := debugger_manager.application
				if not app.current_call_stack_is_empty then
					check app.status.current_call_stack /= Void end
					if attached {EIFFEL_CALL_STACK_ELEMENT} app.status.current_call_stack_element as elt then
						Result := elt
					end
				end
			end
		end

	compute_grid_display_for (cse: like call_stack_element)
		deferred
		end

	show_exception_dialog (a_exc_dv: EXCEPTION_DEBUG_VALUE)
			-- Show `a_exc_dv' in exception dialog
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
		do
			create dlg.make
			dlg.set_exception (a_exc_dv)
			dlg.set_is_modal (True)
			dlg.show_on_active_window
		end

	Cst_exception_double_click_text: STRING_GENERAL
		do
			Result := interface_names.l_exception_double_click_text
		end

	Cst_exception_raised_text: STRING_GENERAL
		do
			Result := interface_names.l_exception_raised
		end

	Cst_exception_first_chance_text: STRING_GENERAL
		do
			Result := interface_names.l_first_chance
		end

	Cst_exception_unhandled_text: STRING_GENERAL
		do
			Result := interface_names.l_unhandled
		end

feature -- Query

	debug_output: STRING
		do
			Result := text_data_for_clipboard
		end

	text_data_for_clipboard: detachable STRING_32
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
