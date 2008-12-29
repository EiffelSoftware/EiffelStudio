note
	description: "User Interfaces of EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_UI

inherit
	EB_DEVELOPMENT_WINDOW_PART

create
	make

feature -- Query

	editors_widget: EV_VERTICAL_BOX
			-- Editors widget.

	arguments_dialog: EB_ARGUMENT_DIALOG
			-- The arguments dialog for current, if any

	goto_dialog: EB_GOTO_DIALOG
			-- The goto dialog for line number access

	current_editor: EB_CLICKABLE_EDITOR
			-- Current smart editor.
			-- Different from EB_EDITORS_MANAEGER.current_editor
			-- Result is not only class text editors used by end users, but also maybe is the EB_SMART_EDITOR in Feature Relation Tool or Class Tool...

feature -- Settings

	set_current_editor (a_editor: like current_editor)
			-- Set `current_editor'
		do
			if current_editor /= a_editor then
				current_editor := a_editor
					-- We should call command_controller set_current_editor to update cut and copy menu/toolbar items states.
				if a_editor /= Void then
					develop_window.command_controller.set_current_editor (a_editor)
				end
			end
		ensure
			set: current_editor = a_editor
		end

	set_editors_widget (a_widget: like editors_widget)
			-- Set `editors_widget'
		do
			editors_widget := a_widget
		ensure
			set: editors_widget = a_widget
		end

	set_goto_dialog (a_dialog: like goto_dialog)
			-- Set `goto_dialog'
		do
			goto_dialog := a_dialog
		ensure
			set: goto_dialog = a_dialog
		end

note
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
