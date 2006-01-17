indexing
	description	: "Dialog for confirming a save action"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_SAVE_DIALOG

inherit
	EV_QUESTION_DIALOG

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_WINDOW_MANAGER
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
		do
			target := a_target
			caller := a_caller
			clsi_stone ?= target.stone
			if clsi_stone /= Void then
				cls_name := clsi_stone.class_name
			end
			make_with_text (Warning_messages.w_File_changed (cls_name))
			button (ev_yes).select_actions.extend (agent save_text)
			button (ev_no).select_actions.extend (agent dont_save_text)
			
			show_modal_to_window (window_manager.last_focused_development_window.window)
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

end -- class EB_CONFIRM_SAVE_DIALOG
