note
	description: "[
		A simple editor output pane for use with the Outputs tool ({ES_OUTPUTS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_OUTPUT_PANE

inherit
	ES_OUTPUT_PANE [ES_EDITOR_WIDGET]

create
	make,
	make_with_icon

feature {NONE} -- Initialization

	make (a_name: !READABLE_STRING_GENERAL)
			-- Initialize a output editor
			--
			-- `a_name': A friendly, human readable name for the editor.
		do
			make_with_icon (a_name, stock_pixmaps.tool_output_icon_buffer)
		ensure
			name_set: a_name.as_string_32 ~ name.as_string_32
		end

	make_with_icon (a_name: !READABLE_STRING_GENERAL; a_icon: like icon)
			-- Initialize a output editor with an representation icon
			--
			-- `a_name': A friendly, human readable name for the editor.
			-- `a_icon': An icon representing the output pane.
		do
			create name.make_from_string (a_name.as_string_32)
			icon := a_icon
		ensure
			name_set: a_name.as_string_32 ~ name.as_string_32
			icon_set: icon ~ a_icon
		end

	build_interface (a_widget: !ES_EDITOR_WIDGET)
			-- <Precursor>
		do
			a_widget.editor.disable_line_numbers
			a_widget.editor.disable_editable
			a_widget.editor.disable_has_breakable_slots
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if not is_recycled and not is_recycling then
					recycle
				end
			end
		ensure then
			is_recycled: (a_explicit and not is_recycling) implies is_recycled
		end

feature -- Access

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>

	name: !IMMUTABLE_STRING_32
			-- <Precursor>

feature -- Query

	text_for_window (a_window: !SHELL_WINDOW_I): !STRING_32
			-- <Precursor>
		local
			l_widget: like widget_for_window
		do
			l_widget := widget_for_window (a_window)
			if l_widget.is_interface_usable and then l_widget.is_initialized then
				create Result.make_from_string (l_widget.editor.wide_text)
			else
				create Result.make_empty
			end
		end

	output_window_for_window (a_window: !SHELL_WINDOW_I): !OUTPUT_WINDOW
			-- <Precursor>
		local
			l_widget: ES_EDITOR_WIDGET
			l_result: ?OUTPUT_WINDOW
		do
			l_widget := widget_table.item (a_window.window_id)
			check l_widget_attached: l_widget /= Void end
			l_result ?= l_widget.editor.text_displayed
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Query

	widget_output_window (a_widget: !ES_EDITOR_WIDGET; a_window: !SHELL_WINDOW_I): !OUTPUT_WINDOW
			-- <Precursor>
		local
			l_result: ?OUTPUT_WINDOW
		do
			l_result := a_widget.editor
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Basic operations

	activate
			-- <Precursor>
		do
			check not_implemented: False end
		end

feature {NONE} -- Factory

	new_widget (a_window: !SHELL_WINDOW_I): !ES_EDITOR_WIDGET
			-- <Precursor>
		do
			if {l_window: EB_DEVELOPMENT_WINDOW} a_window then
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
