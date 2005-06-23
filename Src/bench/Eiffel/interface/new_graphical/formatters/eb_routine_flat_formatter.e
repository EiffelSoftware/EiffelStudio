indexing
	description: "Formatter that displays the text of a feature in flat form."
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
			set_stone,
			is_dotnet_formatter
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
			an_editor.enable_has_breakable_slots
			editor.drop_actions.extend (agent on_breakable_drop)
		end

	set_stone (new_stone: FEATURE_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			l_ext_class: EXTERNAL_CLASS_I
		do
			if new_stone /= Void and new_stone.class_i.is_external_class then
				set_dotnet_mode (True)
				if consumed_types.has (new_stone.class_i.name) then
					consumed_type := consumed_types.item (new_stone.class_i.name)
				else
					l_ext_class ?= new_stone.class_i
					check
						l_ext_class_not_void: l_ext_class /= Void
					end
					consumed_type := l_ext_class.external_consumed_type
					if consumed_type /= Void then
						consumed_types.put (consumed_type, new_stone.class_i.name)	
					end
				end
				set_feature (new_stone.e_feature)
			else
				set_dotnet_mode (False)
				Precursor {EB_FEATURE_TEXT_FORMATTER} (new_stone)
			end
		end

feature -- Formatting

	show_debugged_line is
			-- Update arrows in formatter and ensure that arrows is visible. 
		local
			stel: EIFFEL_CALL_STACK_ELEMENT
			l_line: INTEGER
		do
			if displayed and selected and not must_format then
				if Application.is_running and then Application.is_stopped then
					stel  ?= Application.status.current_call_stack_element
					if stel /= Void and then stel.routine.body_index = associated_feature.body_index then
						l_line := stel.break_index
						if l_line > 0 then
							editor.display_breakpoint_number_when_ready (l_line)
						end
					end
				end
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
			-- Actual formatted text, if any.
			
	consumed_type: CONSUMED_TYPE
			-- .NET consumed type contain this feature if external.

	is_dotnet_formatter: BOOLEAN is
 			-- Is Current able to format .NET XML types?
 		do
 			Result := True
 		end
	
feature {NONE} -- Implementation

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
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_with_breakable
				if not is_dotnet_mode then			
					formatted_text := rout_flat_context_text (associated_feature)
				else
					set_is_without_breakable
					formatted_text := rout_flat_dotnet_text (associated_feature, consumed_type)
				end
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

	has_breakpoints: BOOLEAN is True
			-- Should breakpoints be shown in Current?

end -- class EB_ROUTINE_FLAT_FORMATTER
