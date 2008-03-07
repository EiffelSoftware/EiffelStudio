indexing
	description: "Objects that control the debugger session"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_CONTROLLER

inherit
	DEBUGGER_CONTROLLER
		redefine
			manager,
			before_starting,
			after_starting,
			if_confirmed_do,
			discardable_if_confirmed_do,
			activate_debugger_environment
		end

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_MANAGERS

feature -- Aspects

	before_starting (param: DEBUGGER_EXECUTION_PARAMETERS) is
		do
			Precursor (param)
			if not manager.application_is_executing then
				output_manager.clear_general
			end
				--| Display information
			output_manager.add_string ("Launching system :")
			output_manager.add_new_line
			output_manager.add_comment ("  - directory = ")
			output_manager.add_quoted_text (param.working_directory)
			output_manager.add_new_line
			output_manager.add_comment_text ("  - arguments = ")
			if param = Void or else param.arguments.is_empty then
				output_manager.add_string ("<Empty>")
			else
				output_manager.add_quoted_text (param.arguments)
			end
--| For now useless since the output panel display those info just a few nanoseconds ...
--			if environment_vars /= Void and then not environment_vars.is_empty then
--				output_manager.add_comment_text ("  - environment : ")
--				from
--					environment_vars.start
--				until
--					environment_vars.after
--				loop
--					output_manager.add_new_line
--					output_manager.add_indent
--					output_manager.add_string (environment_vars.key_for_iteration)
--					output_manager.add_string ("=")
--					output_manager.add_quoted_text (environment_vars.item_for_iteration)
--					environment_vars.forth
--				end
--			end
			output_manager.add_new_line
		end

	after_starting is
		do
			Precursor
		end

	if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE]) is
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
				msg, Void, a_action, Void)
		end

	discardable_if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE];
			a_button_count: INTEGER; a_pref_string: STRING) is
		local
			l_question: ES_DISCARDABLE_QUESTION_PROMPT
		do
			if a_button_count = 2 then
				create l_question.make_standard (msg, "", a_pref_string)
			elseif a_button_count = 3 then
				create l_question.make_standard_with_cancel (msg, "", a_pref_string)
			else
				check False end
			end
			if l_question /= Void then
				l_question.set_button_action (l_question.dialog_buttons.yes_button, a_action)
				l_question.show_on_active_window
			end
		end

	activate_debugger_environment (b: BOOLEAN) is
		do
			Precursor {DEBUGGER_CONTROLLER} (b)
			if not b then
				if manager.raised and then not manager.debug_mode_forced then
					manager.unraise
				end
			else
				if not manager.raised then
					manager.raise
				end
			end
		end

feature -- {DEBUGGER_MANAGER, SHARED_DEBUGGER_MANAGER} -- Implementation

	manager: EB_DEBUGGER_MANAGER;

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

end
