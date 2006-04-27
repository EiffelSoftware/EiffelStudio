indexing
	description	: "Command to edit class headers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EV_DIALOG_CONSTANTS

create
	make

feature -- Basic operations

	execute is
			-- Display information about `Current'.
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_class_header)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.Icon_class_header
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_change_header
		end

	stone_as: CLASS_AS
			-- AST of class dropped.
			-- Used to check syntax before and after renaming.

	name: STRING is "Class_header_hole"
			-- Name of the command. Used to store the command in the
			-- preferences.

	change_name_dialog: EB_CLASS_HEADER_DIALOG
			-- Dialog where new class name is typed.

	invalid_name_dialog: EV_WARNING_DIALOG
			-- Dialog displaying error messages.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_stone)
		end

feature {NONE} -- Implementation

	execute_with_stone (a_stone: CLASSI_STONE) is
			-- Create a development window and process `a_stone'.
		local
			src: ES_CLASS
			s, g, old_name, old_generics, stone_text: STRING
			cnr: CLASS_NAME_REPLACER
			cfs: CLASSI_FIGURE_STONE
			invalid_name: BOOLEAN
			class_file: PLAIN_TEXT_FILE
			confirmation: EV_CONFIRMATION_DIALOG
		do
			cfs ?= a_stone
			if cfs /= Void then
				src := cfs.source.model
			end
			if src /= Void then
				create class_file.make (src.class_i.file_name)
				if class_file.exists and then class_file.is_writable and not src.class_i.is_read_only then
					from
						invalid_name := True
					until
						not invalid_name
					loop
						old_name := src.name.twin
						create change_name_dialog
						change_name_dialog.set_name (src.name)
						if src.generics /= Void then
							change_name_dialog.set_generics (src.generics)
							old_generics := src.generics.twin
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
							if not cnr.valid_new_class_name (s) then
								create invalid_name_dialog.make_with_text (Warning_messages.w_Wrong_class_name)
								invalid_name_dialog.show_modal_to_window (tool.development_window.window)
							else
								if cnr.class_name_in_use (s) then
									create confirmation.make_with_text (Warning_messages.w_Class_already_exists_info (s))
									confirmation.button (ev_ok).set_text (ev_yes)
									confirmation.button (ev_cancel).set_text (ev_no)
									confirmation.show_modal_to_window (tool.development_window.window)
								end
								if confirmation = Void or else confirmation.selected_button.is_equal (ev_ok) then
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
												history.do_named_undoable (
													Interface_names.t_Diagram_rename_class_locally_cmd (old_name, s),
													agent change_name_locally (src, s, g),
													agent change_name_locally (src, old_name, old_generics))
												invalid_name := False
											else
												if change_name_dialog.global_replace_universe then
													history.do_named_undoable (
														Interface_names.t_Diagram_rename_class_globally_cmd (old_name, s),
														[<<agent tool_disable_sensitive,
															agent change_name_universe_classes (src, cnr, old_name, s, g),
															agent tool_enable_sensitive>>],
														[<<agent tool_disable_sensitive,
															agent change_name_universe_classes (src, cnr, s, old_name, old_generics),
															agent tool_enable_sensitive>>])
													invalid_name := False
												else
													history.do_named_undoable (
														Interface_names.t_Diagram_rename_class_globally_cmd (old_name, s),
														[<<agent tool_disable_sensitive,
															agent change_name_compiled_classes (src, cnr, old_name, s, g),
															agent tool_enable_sensitive>>],
														[<<agent tool_disable_sensitive,
															agent change_name_compiled_classes (src, cnr, s, old_name, old_generics),
															agent tool_enable_sensitive>>])
													invalid_name := False
												end
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

	change_name_locally (a_class: ES_CLASS; new_name, new_generics: STRING) is
			-- Change name of `a_class' to `new_name'.
		require
			a_class_not_void: a_class /= Void
			new_name_not_void: new_name /= Void
		local
			cg: CLASS_TEXT_MODIFIER
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
				if not new_generics.is_empty then
					a_class.set_generics (new_generics)
				else
					a_class.set_generics (Void)
				end
			end
		end

	change_name_compiled_classes (a_class: ES_CLASS; cnr: CLASS_NAME_REPLACER; old_name, new_name, new_generics: STRING) is
			-- Change name of `a_class' to `new_name' in compiled classes.
		require
			cnr_not_void: cnr /= Void
			names_not_void: new_name /= Void and old_name /= Void
			a_class_not_void: a_class /= Void
		local
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			l_status_bar := tool.development_window.status_bar
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Wait_cursor)
			change_name_locally (a_class, new_name, new_generics)
			l_status_bar.display_message ("Updating references in compiled classes")
			cnr.global_class_name_replace (old_name, new_name, True, l_status_bar)
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Standard_cursor)
		end

	change_name_universe_classes (a_class: ES_CLASS; cnr: CLASS_NAME_REPLACER; old_name, new_name, new_generics: STRING) is
			-- Change name of `a_class' to `new_name' in the whole universe.
		require
			cnr_not_void: cnr /= Void
			names_not_void: new_name /= Void and old_name /= Void
			a_class_not_void: a_class /= Void
		local
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			l_status_bar := tool.development_window.status_bar
			tool.development_window.window.set_pointer_style (tool.Default_pixmaps.Wait_cursor)
			change_name_locally (a_class, new_name, new_generics)
			l_status_bar.display_message ("Updating references in cluster universe")
			cnr.global_class_name_replace (old_name, new_name, False, tool.development_window.status_bar)
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
			sp := click_ast.start_position
			if stone_as.generics_end_position > 0 then
				ep := stone_as.generics_end_position
			else
				ep := click_ast.end_position
			end
			text.replace_substring (new_name, sp, ep)
			if not new_generics.is_empty then
				text.insert_string (" " + new_generics, sp + new_name.count)
			end
		end

	tool_disable_sensitive is
			-- Make diagram unsensitive to user input.
		do
			tool.disable_toolbar
			tool.area_as_widget.disable_sensitive
		end

	tool_enable_sensitive is
			-- Make diagram sensitive to user input.
		do
			tool.enable_toolbar
			tool.area_as_widget.enable_sensitive
		end

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

end -- class EB_CLASS_HEADER_COMMAND
