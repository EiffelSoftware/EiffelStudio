indexing
	description: "Objects that"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ROUTINE_FLAT_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			set_editor,
			feature_cmd,
			generate_text,
			formatted_text,
			format
		end

	EB_SHARED_FORMAT_TABLES

	SHARED_FORMAT_INFO

	SHARED_APPLICATION_EXECUTION

create
	make
	
feature -- Status setting

	set_editor (an_editor: EB_CLICKABLE_EDITOR) is
			-- Set `editor' to `an_editor'.
			-- Used to share an editor between several formatters.
		do
			Precursor {EB_FEATURE_TEXT_FORMATTER} (an_editor)
			an_editor.show_breakpoints
			editor.drop_actions.extend (~on_breakable_drop)
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		local
			app_stopped: BOOLEAN
			stel: CALL_STACK_ELEMENT
		do
			if
				displayed and then
				selected and then
				feature_cmd /= Void
			then
				editor.disable_feature_click
				if must_format then
					display_temp_header
					selected_line := 1
					generate_text
				end
				if not last_was_error then
					app_stopped := Application.is_running and then Application.is_stopped
					if app_stopped then
						stel := Application.status.current_stack_element
						app_stopped := stel.routine.body_index = associated_feature.body_index
					end
					if editor.current_text /= formatted_text then
						editor.process_text (formatted_text)
						if app_stopped then
							selected_line := stel.break_index
							editor.display_breakpoint_number_when_ready (selected_line)
						end
					else
							-- We remove the arrow.
						editor.invalidate_line (selected_line, True)
						if
							app_stopped
						then
							selected_line := stel.break_index
								-- We put an arrow back.
							editor.invalidate_line (selected_line, True)
							editor.display_breakpoint_number_when_ready (selected_line)
						else
							selected_line := 1
						end
						editor.refresh
					end
					if editable then
						editor.enable_editable
					else
						editor.disable_editable
					end
				else
						-- An error occurred while generating the text.
					editor.clear_window
					editor.display_message (Warning_messages.w_Formatter_failed)
				end
				display_header
				must_format := last_was_error
			end
		end

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_flat, 1)
			Result.put (Pixmaps.Icon_format_flat, 2)
		end
 
	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showflat
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Flat
		end

	post_fix: STRING is "rfl"
			-- String symbol of the command, used as an extension when saving.

	formatted_text: STRUCTURED_TEXT

feature {NONE} -- Implementation

	selected_line: INTEGER
			-- Line in the editor in front of which there is an arrowed breakpoint.

	on_breakable_drop (st: BREAKABLE_STONE) is
			-- Launch `st' to the manager.
		do
			manager.set_stone (st)
		end

	feature_cmd: E_SHOW_ROUTINE_FLAT
			-- Class command that can generate the information. Not used.

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.do_nothing
--			class_cmd.set_feature_clause_order 
--				(feature_clause_order)
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_with_breakable
				formatted_text := rout_flat_context_text (associated_feature)
				if formatted_text = Void then
					last_was_error := True
				else
					last_was_error := False
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

end -- class EB_ROUTINE_FLAT_FORMATTER
