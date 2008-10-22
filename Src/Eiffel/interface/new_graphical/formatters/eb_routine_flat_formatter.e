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
			set_editor_displayer,
			feature_cmd,
			generate_text,
			set_stone,
			is_dotnet_formatter
		end

	EB_SHARED_FORMAT_TABLES

	SHARED_FORMAT_INFO

	SHARED_DEBUGGER_MANAGER

create
	make

feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_FEATURE_RELATION_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_FEATURE_RELATION_TOOL_VIEW_MODES}.flat
		end

feature -- Status setting

	set_editor_displayer (a_displayer: like displayer) is
			-- Set `displayer' with `a_displayer'.
		do
			Precursor {EB_FEATURE_TEXT_FORMATTER} (a_displayer)
			if displayer /= Void then
				displayer.editor.enable_has_breakable_slots
				displayer.editor.drop_actions.extend (agent on_breakable_drop)
			end
		end

	set_stone (new_stone: FEATURE_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		do
			force_stone (new_stone)
			if new_stone /= Void and new_stone.class_i.is_external_class then
				set_dotnet_mode (True)
				internal_consumed_type := consumed_type (new_stone.class_i)
			else
				set_dotnet_mode (False)
				internal_consumed_type := Void
			end
			Precursor {EB_FEATURE_TEXT_FORMATTER} (new_stone)
		end

feature -- Formatting

	show_debugged_line is
			-- Update arrows in formatter and ensure that arrows is visible.
		local
			t: TUPLE [line: INTEGER; fid: INTEGER]
			dm: like debugger_manager
		do
			if displayed and selected then
				if associated_feature /= Void then
					dm := debugger_manager
					if dm.safe_application_is_stopped then
						t := dm.application_status.debugged_position_information (associated_feature)
						if t /= Void and then t.line > 0 then
							editor.display_breakpoint_number_when_ready (t.line, t.fid)
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

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.view_clickable_feature_icon, 1)
			Result.put (pixmaps.icon_pixmaps.view_clickable_feature_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representation.
		once
			Result := pixmaps.icon_pixmaps.view_clickable_feature_icon_buffer
		end

	menu_name: STRING_GENERAL is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showflat
		end

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL is
			-- Name of the command.
		do
			Result := Interface_names.l_Flat_view
		end

	post_fix: STRING is "rfl"
			-- String symbol of the command, used as an extension when saving.

	internal_consumed_type: CONSUMED_TYPE
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
					last_was_error := rout_flat_dotnet_text (associated_feature, internal_consumed_type, editor.text_displayed)
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
