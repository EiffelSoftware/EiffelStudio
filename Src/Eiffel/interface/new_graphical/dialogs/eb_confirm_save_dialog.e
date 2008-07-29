indexing
	description	: "Dialog for confirming a save action"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_SAVE_DIALOG

inherit
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch (a_target: like target; a_caller: EB_CONFIRM_SAVE_CALLBACK) is
			-- Initialize and popup the dialog
		local
			clsi_stone: CLASSI_STONE
			cls_name: STRING
			l_question: ES_QUESTION_PROMPT
		do
			target := a_target
			caller := a_caller
			clsi_stone ?= target.stone
			if clsi_stone /= Void and clsi_stone.is_valid then
				cls_name := clsi_stone.class_name
			end
			create l_question.make_standard_with_cancel (Warning_messages.w_File_changed (cls_name))
			l_question.set_default_button (l_question.dialog_buttons.yes_button)
			l_question.set_button_action (l_question.dialog_buttons.yes_button, agent save_text)
			l_question.set_button_action (l_question.dialog_buttons.no_button, agent dont_save_text)
			l_question.show_on_active_window
		end

feature -- Access

	caller: EB_CONFIRM_SAVE_CALLBACK
		-- object whose `process' feature will be executed on success

	target: EB_FILEABLE
			-- Target for the command.

feature -- Execution

	save_text is
			-- Save text and quit.
		do
			target.save_text
			dont_save_text
		end

	dont_save_text is
			-- Directly quit.
		do
			caller.process
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

end -- class EB_CONFIRM_SAVE_DIALOG
