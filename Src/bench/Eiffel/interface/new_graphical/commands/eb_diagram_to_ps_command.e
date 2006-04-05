indexing
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

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_s),
				True, False, True)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation
		local
			png_file: FILE_NAME
			png_format: EV_PNG_FORMAT
			p: EV_PIXMAP
			dial: EB_FILE_SAVE_DIALOG
			test_file: RAW_FILE
			error: INTEGER
			wd: EV_WARNING_DIALOG
			env: EXECUTION_ENVIRONMENT
			current_directory: STRING
		do
			if is_sensitive then
				if error = 0 then
					create dial.make_with_preference (preferences.dialog_data.last_saved_diagram_postscript_directory_preference)
					set_dialog_filters_and_add_all (dial, <<Png_files_filter>>)

					if tool.class_graph /= Void then
						dial.set_file_name (tool.class_graph.center_class.name + ".png")
					else
						dial.set_file_name (tool.cluster_graph.center_cluster.name + ".png")
					end
					create env
					current_directory := env.current_working_directory
					dial.show_modal_to_window (tool.development_window.window)
						-- EA: added this to prevent working directory changes by file dialog.
						-- Will maybe be fixed in Vision 2
					env.change_working_directory (current_directory)
					if not dial.file_name.is_empty then
						error := 1
						p := tool.projector.world_as_pixmap (5)
						if p /= Void then
							create png_file.make_from_string (dial.file_name)
							create test_file.make_open_write (png_file)
							if test_file.is_writable then
								test_file.close
								create png_format
								tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Wait_cursor)
								p.save_to_named_file (png_format, png_file)
								tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
								error := 0
							else
								test_file.close
							end
						end
					end
				else
					if error = 1 then
						create wd.make_with_text (Warning_messages.w_cannot_save_png_file (dial.file_name))
					elseif error = 2 then
						create wd.make_with_text (Warning_messages.W_cannot_generate_png)
					end
					wd.show_modal_to_window (tool.development_window.window)
				end
			end
		rescue
			if tool.projector.is_world_too_large then
				error := 2
			else
				error := 1
			end
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
			retry
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.Icon_export_to_png
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_to_png
		end

	menu_name: STRING is
			-- Name for the menu entry.
		do
			Result := Interface_names.m_diagram_to_png
		end

	name: STRING is "Diagram_to_png";
			-- Name of the command. Used to store the command in the
			-- preferences.


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

end -- class EB_DIAGRAM_TO_PS_COMMAND
