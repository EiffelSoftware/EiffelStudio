indexing
	description: "Formatter that displays the text of a feature in flat form."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			set_stone,
			is_dotnet_formatter
		end

	EB_SHARED_FORMAT_TABLES

	SHARED_FORMAT_INFO

	EB_SHARED_DEBUG_TOOLS

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
			force_stone (new_stone)
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
			if displayed and selected then
				if associated_feature /= Void then
					if
						eb_debugger_manager.application_is_executing
						and then eb_debugger_manager.application_is_stopped
					then
						stel  ?= eb_debugger_manager.application.status.current_call_stack_element
						if
							stel /= Void and then stel.routine /= Void
							and then stel.routine.body_index = associated_feature.body_index
						then
							l_line := stel.break_index
							if l_line > 0 then
								editor.display_breakpoint_number_when_ready (l_line)
									-- Refresh is needed on the margin because if we are showing the same
									-- feature but from a different CALL_STACK_ELEMENT (case of recursive call)
									-- we need to refresh it to show/hide the green arrow representing
									-- where the execution is in the call stack history.
								editor.margin.refresh
							end
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
			create feature_cmd
			feature_cmd.set_text_formatter (editor.text_displayed)
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_with_breakable
				editor.handle_before_processing (false)
				if not is_dotnet_mode then
					last_was_error := rout_flat_context_text (associated_feature, editor.text_displayed)
				else
					set_is_without_breakable
					last_was_error := rout_flat_dotnet_text (associated_feature, consumed_type, editor.text_displayed)
				end
				editor.handle_after_processing
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	has_breakpoints: BOOLEAN is True;
			-- Should breakpoints be shown in Current?

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

end -- class EB_ROUTINE_FLAT_FORMATTER
