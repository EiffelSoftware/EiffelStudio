indexing

	description:
		"Command to manage exception handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ASSERTION_CHECKING_HANDLER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	EB_SHARED_DEBUG_TOOLS

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
--				True, False, True)
--			accelerator.actions.extend (agent execute)
		end

feature -- Execution

	reset is
		do
			assertion_checking_changed := False
			disable_sensitive
			update_graphical
		end

	execute is
			-- Pause the execution.
		local
			app_exec: APPLICATION_EXECUTION
		do
			app_exec := Debugger_manager.Application
			if not app_exec.is_running or else not app_exec.is_stopped then
				disable_sensitive
			else
				enable_sensitive
			end
			if assertion_checking_changed then
				assertion_checking_changed := False
				app_exec.restore_assertion_check
			else
				assertion_checking_changed := True
				app_exec.disable_assertion_check
			end
			update_graphical
		end

	assertion_checking_changed: BOOLEAN

feature -- Change text

	update_graphical is
		local
			menu_items: like managed_menu_items
			toolbar_items: like managed_toolbar_items
			t: STRING
			p: like pixmap
		do
			p := pixmap
			t := menu_name

			menu_items := managed_menu_items
			if menu_items /= Void then
				from
					menu_items.start
				until
					menu_items.after
				loop
					menu_items.item.set_text (t)
					menu_items.item.set_pixmap (p)
					menu_items.forth
				end
			end

			t := tooltext
			toolbar_items := managed_toolbar_items
			if toolbar_items /= Void then
				from
					toolbar_items.start
				until
					toolbar_items.after
				loop
					toolbar_items.item.set_text (t)
					toolbar_items.item.set_pixmap (p)
					toolbar_items.forth
				end
			end
		end

feature {NONE} -- Attributes

	description: STRING is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Dbg_assertion_checking
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			if assertion_checking_changed then
				Result := Interface_names.b_Dbg_assertion_checking_restore
			else
				Result := Interface_names.b_Dbg_assertion_checking_disable
			end
		end

	name: STRING is "Assertion_checking_handler"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		do
			if assertion_checking_changed then
				Result := Interface_names.m_Dbg_assertion_checking_restore
			else
				Result := Interface_names.m_Dbg_assertion_checking_disable
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			if assertion_checking_changed then
				Result := Pixmaps.icon_dbg_assert_checking_restore
			else
				Result := Pixmaps.icon_dbg_assert_checking_disable
			end
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

end
