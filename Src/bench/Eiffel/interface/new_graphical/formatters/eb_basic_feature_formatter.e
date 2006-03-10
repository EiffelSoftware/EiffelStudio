indexing
	description: "Formatter that displays the text of a feature with no analysis."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BASIC_FEATURE_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			generate_text,
			feature_cmd,
			editable,
			format,
			make
		end

create
	make

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			Precursor {EB_FEATURE_TEXT_FORMATTER} (a_manager)
			create_feature_cmd
		end

feature -- Properties

	editable: BOOLEAN is False
			-- Can the generated text be edited?

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_text, 1)
			Result.put (Pixmaps.Icon_format_text, 2)
		end

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showtext_new
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if
				selected and then
				associated_feature /= Void and then
				displayed
			then
				editor.set_feature_for_click (associated_feature)
				editor.enable_feature_click
				display_temp_header
				generate_text
				if last_was_error then
					editor.clear_window
					editor.display_message (Warning_messages.W_formatter_failed)
				end
				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.disable_has_breakable_slots
				end
				editor.set_read_only (not editable)
				display_header
			end
		end


feature -- Status setting

	set_associated_feature (a_feature: E_FEATURE) is
			-- Associate `Current' with `a_feature'.
		do
			associated_feature := a_feature
		end

feature {NONE} -- Properties

	feature_cmd: E_SHOW_ROUTINE_FLAT
			-- Just needed for compatibility, do not use.

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Basic_text
		end

	post_fix: STRING is "txt"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	generate_text is
			-- Create `formatted_text'.
		local
			retried: BOOLEAN
			ynk_win: YANK_STRING_WINDOW
		do
			create ynk_win.make
			if not retried then
				last_was_error := associated_feature.text (ynk_win)
			else
				last_was_error := True
			end
			if not last_was_error then
				editor.load_text (ynk_win.stored_output)
			end
		rescue
			retried := True
			retry
		end

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			True
		do
			create feature_cmd
		end

	has_breakpoints: BOOLEAN is False;
			-- Should breakpoints be shown in Current?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_BASIC_FEATURE_FORMATTER
