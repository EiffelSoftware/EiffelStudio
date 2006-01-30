indexing
	description: "Manages all available refactorings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_MANAGER

inherit
	EB_SHARED_PREFERENCES
		rename
			preferences AS eb_preferences
		end

	EB_SHARED_WINDOW_MANAGER


create
	make

feature {NONE} -- Initialization

	make is
			-- Create
		do
			preferences := eb_preferences.preferences

			create undo_stack.make
			create redo_stack.make

				-- create the different refactorings
			create class_rename_refactoring.make (undo_stack, preferences)
			create feature_rename_refactoring.make (undo_stack, preferences)
			create feature_pull_refactoring.make (undo_stack, preferences)

				-- create the commands
			create pull_command.make (Current)
			create rename_command.make (Current)
			create undo_command.make (Current)
			create redo_command.make (Current)
		end

feature -- Commands

	pull_command: EB_RF_PULL_COMMAND
	rename_command: EB_RF_RENAME_COMMAND
	undo_command: EB_RF_UNDO_COMMAND
	redo_command: EB_RF_REDO_COMMAND

feature -- Access

	class_rename_refactoring: ERF_CLASS_RENAME
	feature_rename_refactoring: ERF_FEATURE_RENAME
	feature_pull_refactoring: ERF_FEATURE_PULL

feature -- Status

	can_undo: BOOLEAN is
			-- Is there a refactoring to undo?
		do
			Result := not undo_stack.is_empty
		end

	can_redo: BOOLEAN is
			-- Is there a refactoring to redo?
		do
			Result := not redo_stack.is_empty
		end

feature -- Element change

	undo_last is
			-- Undo the last refactoring.
		require
			can_undo: can_undo
		local
			compiler_check: ERF_COMPILATION_SUCCESSFUL
			l_actions: LIST [ERF_ACTION]
			wd: EV_WARNING_DIALOG
		do
			disable_sensitive
			window_manager.on_refactoring_start

			create compiler_check.make
				-- Execute compilation
			compiler_check.execute

			from
				l_actions := undo_stack.item
				l_actions.finish
			until
				l_actions.before
			loop
				l_actions.item.undo
				l_actions.back
			end
			redo_stack.put (l_actions)
			undo_stack.remove

				-- Execute compilation
			compiler_check.execute
			if not compiler_check.success then
				redo_last
				create wd.make_with_text (compiler_check.error_message+" Undo not possible.")
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end

			window_manager.on_refactoring_end
			window_manager.synchronize_all
			enable_sensitive
		end

	redo_last is
			-- Redo the last refactoring.
		require
			can_redo: can_redo
		local
			compiler_check: ERF_COMPILATION_SUCCESSFUL
			l_actions: LIST [ERF_ACTION]
		do
			disable_sensitive
			window_manager.on_refactoring_start

			create compiler_check.make
				-- Execute compilation
			compiler_check.execute

			from
				l_actions := redo_stack.item
				l_actions.start
			until
				l_actions.after
			loop
				l_actions.item.redo
				l_actions.forth
			end
			undo_stack.put (l_actions)
			redo_stack.remove

				-- Execute compilation
			compiler_check.execute

			window_manager.on_refactoring_end
			window_manager.synchronize_all
			enable_sensitive
		end

	enable_sensitive is
			-- Enable the commands.
		do
			pull_command.enable_sensitive
			rename_command.enable_sensitive
			if can_undo then
				undo_command.enable_sensitive
			else
				undo_command.disable_sensitive
			end
			if can_redo then
				redo_command.enable_sensitive
			else
				redo_command.disable_sensitive
			end
		end

	disable_sensitive is
			-- Disable the commands and forget undo informations.
		do
			pull_command.disable_sensitive
			rename_command.disable_sensitive
			undo_command.disable_sensitive
			redo_command.disable_sensitive
		end

	destroy is
			-- Called before the object ist destroyed.
		do
			destroy_undo
			destroy_redo
		end

	forget_undo_redo is
			-- Forget any associated undo or redo information.
		do
			destroy_undo
			destroy_redo
		end



feature -- Basic operation

	execute_refactoring (a_refactoring: ERF_REFACTORING) is
			-- Execute `a_refactoring'.
		do
			disable_sensitive
			window_manager.on_refactoring_start
			a_refactoring.execute
			if a_refactoring.success then
				destroy_redo
			end
			window_manager.on_refactoring_end
			enable_sensitive
		end


feature {NONE} -- Implementation

	preferences: PREFERENCES
			-- The EiffelStudio preferences system.

	undo_stack: LINKED_STACK [ LIST [ERF_ACTION]]
			--  The stack of list of commands where all actions have to be registered for them to be undoable.

	redo_stack: LINKED_STACK [ LIST [ERF_ACTION]]
			--  The stack of list of commands where all undone actions have to be registered for them to be redoable.


	destroy_undo is
			-- Destroy the undo informations
		local
			l_actions: LIST [ERF_ACTION]
		do
			from
			until
				undo_stack.is_empty
			loop
				from
					l_actions := undo_stack.item
					l_actions.start
				until
					l_actions.after
				loop
					l_actions.item.destroy
					l_actions.forth
				end
				undo_stack.remove
			end
		end

	destroy_redo is
			-- Destroy the redo informations
		local
			l_actions: LIST [ERF_ACTION]
		do
			from
			until
				redo_stack.is_empty
			loop
				from
					l_actions := redo_stack.item
					l_actions.start
				until
					l_actions.after
				loop
					l_actions.item.destroy
					l_actions.forth
				end
				redo_stack.remove
			end
		end

invariant
	preferences_not_void: preferences /= Void
	undo_stack_not_void: undo_stack /= Void
	redo_stack_not_void: redo_stack /= Void
	class_rename_refactoring_not_void: class_rename_refactoring /= Void
	feature_rename_refactoring_not_void: feature_rename_refactoring /= Void
	feature_pull_refactoring_not_void: feature_pull_refactoring /= Void
	pull_command_not_void: pull_command /= Void
	rename_command_not_void: rename_command /= Void
	undo_command_not_void: undo_command /= Void
	redo_command_not_void: redo_command /= Void

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

end
