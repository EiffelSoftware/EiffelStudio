indexing
	description: "Command to output diagram to a Postscript file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIAGRAM_TO_PS_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			menu_name
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform operation
		local
			png_file: FILE_NAME
			png_format: EV_PNG_FORMAT
			cd: CONTEXT_DIAGRAM
			cld: CLUSTER_DIAGRAM
			p: EV_PIXMAP
			dial: EV_FILE_SAVE_DIALOG
			size: EV_RECTANGLE
			test_file: RAW_FILE
			error: INTEGER
			wd: EB_WARNING_DIALOG
			env: EXECUTION_ENVIRONMENT
			current_directory: STRING
		do
			if error = 0 then
				create dial
				cd ?= tool.class_view
				if cd = Void then
					cld ?= tool.cluster_view
					check cld /= Void end
					cd := cld
				end
	
				dial.set_filter ("*.png")
				if cld = Void then
					dial.set_file_name (cd.center_class.name + ".png")
				else
					dial.set_file_name (cld.center_cluster.name + ".png")
				end
				create env
				current_directory := env.current_working_directory
				dial.show_modal_to_window (tool.development_window.window)
					-- EA: added this to prevent working directory changes by file dialog.
					-- Will maybe be fixed in Vision 2
				env.change_working_directory (current_directory)
				if not dial.file_name.is_empty then
					error := 1
					size := cd.bounds
					p := tool.projector.diagram_image (size)
					if p /= Void then 
						if p.width * p.height > 0 then
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
						else
							error := 2
						end
					end
				end
			else
				if error = 1 then
					create wd.make_with_text (Warning_messages.w_cannot_save_png_file (dial.file_name))
				else
					create wd.make_with_text (Warning_messages.W_cannot_generate_png)
				end
				wd.show_modal_to_window (tool.development_window.window)
			end
		rescue
			error := 1
			retry
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
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

	ps_projector: EV_POSTSCRIPT_PROJECTOR
			-- Projector of diagram to eps file.

	draw_bon_inheritance_figure_agent: PROCEDURE [ANY, TUPLE [EV_FIGURE]] is
			-- Routine to add to projector.
		once
			Result := ~draw_bon_inheritance_figure
		end

	draw_bon_inheritance_figure (ihf: BON_INHERITANCE_FIGURE) is
		do
			ihf.draw_ps (ps_projector)
		end

	draw_bon_client_supplier_figure_agent: PROCEDURE [ANY, TUPLE [EV_FIGURE]] is
			-- Routine to add to projector.
		once
			Result := ~draw_bon_client_supplier_figure
		end

	draw_bon_client_supplier_figure (csf: BON_CLIENT_SUPPLIER_FIGURE) is
		do
			csf.draw_ps (ps_projector)
		end

end -- class EB_DIAGRAM_TO_PS_COMMAND
