indexing
	description	: "Command to edit class headers."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLASS_HEADER_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end
	
	SHARED_EIFFEL_PARSER
	
	SHARED_ERROR_HANDLER

create
	make

feature -- Basic operations

	execute is
			-- Display information about `Current'.
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_class_header)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

	execute_with_stone (a_stone: CLASSI_STONE) is
			-- Create a development window and process `a_stone'.
		local
			src: CLASS_FIGURE
			s, g, old_name, old_generics, stone_text: STRING
			cnr: CLASS_NAME_REPLACER
			cfs: CLASSI_FIGURE_STONE
			cd: CONTEXT_DIAGRAM
			invalid_name: BOOLEAN
			class_file: PLAIN_TEXT_FILE
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd /= Void end
			cfs ?= a_stone
			if cfs /= Void and then cfs.source.world = cd then
				src := cfs.source
			else
				src := cd.class_figure_by_class (a_stone.class_i)
			end
			if src /= Void then
				create class_file.make (src.class_i.file_name)
				if class_file.exists and then class_file.is_writable and not src.class_i.cluster.is_library then
					from
						invalid_name := True
					until
						not invalid_name
					loop
						old_name := clone (src.name)
						create change_name_dialog
						change_name_dialog.set_name (src.name)
						if src.generics /= Void then
							change_name_dialog.set_generics (src.generics)
							old_generics := clone (src.generics)
						else
							change_name_dialog.set_generics ("")
							old_generics := ""
						end
						change_name_dialog.show_modal_to_window (tool.development_window.window)
						if change_name_dialog.ok_pressed then
							create cnr
							s := change_name_dialog.name
							if s /= Void then
								s.to_upper
							else
								s := ""
							end
							g := change_name_dialog.generics
							if g = Void or g.occurrences (' ') = g.count then
								g := ""
							end
							stone_text := src.class_i.text
							parse_string (stone_text)
							if stone_as = Void then
								create invalid_name_dialog.make_with_text (
									Warning_messages.w_Class_header_syntax_error (src.class_i.name))
								invalid_name_dialog.show_modal_to_window (tool.development_window.window)
							else
								try_change_name (stone_text, s, g)
								parse_string (stone_text)
								if stone_as = Void then
									create invalid_name_dialog.make_with_text (Warning_messages.w_Wrong_class_name)
									invalid_name_dialog.show_modal_to_window (tool.development_window.window)
								else			
									if not change_name_dialog.global_replace then
										if not cnr.valid_new_class_name (s) then
											create invalid_name_dialog.make_with_text (Warning_messages.w_Wrong_class_name)
											invalid_name_dialog.show_modal_to_window (tool.development_window.window)
										else
											history.do_named_undoable (
												Interface_names.t_Diagram_rename_class_locally_cmd,
												~change_name_locally (src, s, g),
												~change_name_locally (src, old_name, old_generics))
											invalid_name := False
										end
									else
										if not cnr.valid_new_class_name (s) then
											create invalid_name_dialog.make_with_text (Warning_messages.w_Wrong_class_name)
											invalid_name_dialog.show_modal_to_window (tool.development_window.window)
										elseif cnr.class_name_in_use (s) then
											create invalid_name_dialog.make_with_text (
												Warning_messages.w_Class_already_exists (s))
											invalid_name_dialog.show_modal_to_window (tool.development_window.window)
										else
											if change_name_dialog.global_replace_universe then
												history.do_named_undoable (
													Interface_names.t_Diagram_rename_class_globally_cmd,
													[<<~tool_disable_sensitive, 
														~change_name_universe_classes (src, cnr, old_name, s, g),
														~tool_enable_sensitive>>],
													[<<~tool_disable_sensitive,
														~change_name_universe_classes (src, cnr, s, old_name, old_generics),
														~tool_enable_sensitive>>])
												invalid_name := False
											else
												history.do_named_undoable (
													Interface_names.t_Diagram_rename_class_globally_cmd,
													[<<~tool_disable_sensitive,
														~change_name_compiled_classes (src, cnr, old_name, s, g),
														~tool_enable_sensitive>>],
													[<<~tool_disable_sensitive,
														~change_name_compiled_classes (src, cnr, s, old_name, old_generics),
														~tool_enable_sensitive>>])
												invalid_name := False
											end
										end
									end
								end
							end
						else
							invalid_name := False
						end
					end
				else
					create invalid_name_dialog.make_with_text ("Class is not editable")
					invalid_name_dialog.show_modal_to_window (tool.development_window.window)
				end
			else
				create invalid_name_dialog.make_with_text ("Class must be on the diagram")
				invalid_name_dialog.show_modal_to_window (tool.development_window.window)				
			end
			tool.projector.project
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_stone)
		end

feature {NONE} -- Implementation

	change_name_locally (a_class: CLASS_FIGURE; new_name, new_generics: STRING) is
			-- Change name of `a_class' to `new_name'.
		require
			a_class_not_void: a_class /= Void
			new_name_not_void: new_name /= Void
		local
			cg: CLASS_TEXT_MODIFIER
			cur_cluster: CLUSTER_I
			new_name_in_lower: STRING
		do
			cg := a_class.code_generator
			cg.prepare_for_modification
			if cg.valid_syntax then
				cg.set_class_name_declaration (
					new_name,
					new_generics
				)
				cg.set_end_mark (new_name)
				cg.commit_modification
				a_class.set_name (new_name)
				a_class.set_generics (new_generics)
				a_class.synchronize
				a_class.update
				cur_cluster := a_class.class_i.cluster
				cur_cluster.classes.remove (a_class.class_i.name)
				new_name_in_lower := clone (new_name)
				new_name_in_lower.to_lower
				a_class.class_i.set_name (new_name_in_lower)
				cur_cluster.add_new_classs (a_class.class_i)
			end
		end
			
	change_name_compiled_classes (a_class: CLASS_FIGURE; cnr: CLASS_NAME_REPLACER; old_name, new_name, new_generics: STRING) is
			-- Change name of `a_class' to `new_name' in compiled classes.
		require
			cnr_not_void: cnr /= Void
			names_not_void: new_name /= Void and old_name /= Void
			a_class_not_void: a_class /= Void
		do
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Wait_cursor)
			change_name_locally (a_class, new_name, new_generics)
			cnr.global_compiled_class_name_replace (old_name, new_name)
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
		end

	change_name_universe_classes (a_class: CLASS_FIGURE; cnr: CLASS_NAME_REPLACER; old_name, new_name, new_generics: STRING) is
			-- Change name of `a_class' to `new_name' in the whole universe.
		require
			cnr_not_void: cnr /= Void
			names_not_void: new_name /= Void and old_name /= Void
			a_class_not_void: a_class /= Void
		do
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Wait_cursor)
			change_name_locally (a_class, new_name, new_generics)
			cnr.global_class_name_replace (old_name, new_name)
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
		end

	parse_string (str: STRING) is
			-- Build `stone_as' corresponding to class text in `str'.
		local
			retried: BOOLEAN
		do
			if retried then
				stone_as := Void
			else
				Eiffel_parser.parse_from_string (str)
				stone_as := Eiffel_parser.root_node
			end
		rescue
			retried := True
			Error_handler.error_list.wipe_out
			retry			
		end

	try_change_name (text, new_name, new_generics: STRING) is
			-- Change header in `text'.
		local
			click_ast: CLICK_AST
			sp, ep: INTEGER
		do
			check
				text_has_correct_syntax: stone_as /= Void
			end
			click_ast := stone_as.click_ast
			sp := click_ast.start_position + 1
			if stone_as.generics_end_position > 0 then
				ep := stone_as.generics_end_position + 1
			else
				ep := click_ast.end_position
			end
			text.replace_substring ("", sp, ep)
			text.insert (new_name, sp)
			if not new_generics.is_empty then
				text.insert (" " + new_generics, sp + new_name.count)
			end
		end

	tool_disable_sensitive is
			-- Make diagram unsensitive to user input.
		local
			cd: CONTEXT_DIAGRAM
		do
			cd := tool.class_view
			if cd = Void then
				cd := tool.cluster_view
			end
			check cd /= Void end
			tool.disable_toolbar
			tool.area_as_widget.disable_sensitive
		end			

	tool_enable_sensitive is
			-- Make diagram sensitive to user input.
		local
			class_d: CONTEXT_DIAGRAM
			cluster_d: CLUSTER_DIAGRAM
		do
			class_d := tool.class_view
			if class_d = Void then
				cluster_d := tool.cluster_view
				check cluster_d /= Void end
				tool.reset_tool_bar_for_cluster_view
				tool.update_toggles (cluster_d)
				tool.area_as_widget.enable_sensitive
			else
				check class_d /= Void end
				tool.reset_tool_bar_for_cluster_view
				tool.update_toggles (class_d)
				tool.area_as_widget.enable_sensitive
			end
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_class_header
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Change class name and generics"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Change class header"
		end

	stone_as: CLASS_AS
			-- AST of class dropped.
			-- Used to check syntax before and after renaming.

	name: STRING is "Class_header_hole"
			-- Name of the command. Used to store the command in the
			-- preferences.

	change_name_dialog: EB_CLASS_HEADER_DIALOG
			-- Dialog where new class name is typed.

	invalid_name_dialog: EB_WARNING_DIALOG
			-- Dialog displaying error messages.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.

end -- class EB_CLASS_HEADER_COMMAND