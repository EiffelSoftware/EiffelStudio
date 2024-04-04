note
	description: "Command to output diagram to a Postscript file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIAGRAM_TO_PS_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			menu_name,
			initialize
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_s),
				True, False, True)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute
			-- Perform operation
		local
			l_path: PATH
			png_format: EV_PNG_FORMAT
			p: EV_PIXMAP
			dial: EB_FILE_SAVE_DIALOG
			test_file: RAW_FILE
			error: INTEGER
			l_pref: PATH_PREFERENCE
		do
			if is_sensitive then
				if error = 0 then
					l_pref := preferences.dialog_data.last_saved_diagram_postscript_directory_preference
					if l_pref.value = Void or else l_pref.value.is_empty then
						l_pref.set_value (eiffel_layout.user_projects_path)
					end
					create dial.make_with_preference (l_pref)
					set_dialog_filters_and_add_all (dial, {ARRAY [STRING_32]} <<Png_files_filter>>)

					if tool.class_graph /= Void then
						create l_path.make_from_string (tool.class_graph.center_class.name_32 + ".png")
					else
						create l_path.make_from_string (tool.cluster_graph.center_cluster.name_32 + ".png")
					end
					dial.set_full_file_path (l_path)
					dial.show_modal_to_window (tool.develop_window.window)
					if not dial.full_file_path.is_empty and then not dial.selected_button_name.same_string ((create {EV_DIALOG_NAMES}).ev_cancel) then
						error := 1
						p := tool.projector.world_as_pixmap (5)
						if p /= Void then
							create test_file.make_with_path (dial.full_file_path)
							test_file.open_write
							if test_file.is_writable then
								test_file.close
								create png_format
								tool.develop_window.window.set_pointer_style (tool.Default_pixmaps.Wait_cursor)
								p.save_to_named_path (png_format, dial.full_file_path)
								tool.develop_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
								error := 0
							else
								test_file.close
							end
						end
					end
				else
					if error = 1 then
						prompts.show_error_prompt (Warning_messages.w_cannot_save_png_file (dial.full_file_path.name), tool.develop_window.window, Void)
					elseif error = 2 then
						prompts.show_error_prompt (Warning_messages.W_cannot_generate_png, tool.develop_window.window, Void)
					end
				end
			end
		rescue
			if tool.projector.is_world_too_large then
				error := 2
			else
				error := 1
			end
			tool.develop_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
			retry
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_export_to_png_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_export_to_png_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_to_png
		end

	menu_name: STRING_GENERAL
			-- Name for the menu entry.
		do
			Result := Interface_names.m_diagram_to_png
		end

	name: STRING = "Diagram_to_png";
			-- Name of the command. Used to store the command in the
			-- preferences.

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
