indexing
	description: "Command to output diagram to a Postscript file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIAGRAM_TO_PS_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			menu_name
		end
		
	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform operation
		local
			png_file: FILE_NAME
			png_format: EV_PNG_FORMAT
			p: EV_PIXMAP
			dial: EV_FILE_SAVE_DIALOG
			test_file: RAW_FILE
			error: INTEGER
			wd: EB_WARNING_DIALOG
			env: EXECUTION_ENVIRONMENT
			current_directory: STRING
		do
			if error = 0 then
				create dial
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
		rescue
			if tool.projector.is_world_too_large then
				error := 2
			else
				error := 1
			end
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
			retry
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
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

	name: STRING is "Diagram_to_png"
			-- Name of the command. Used to store the command in the
			-- preferences.


end -- class EB_DIAGRAM_TO_PS_COMMAND
