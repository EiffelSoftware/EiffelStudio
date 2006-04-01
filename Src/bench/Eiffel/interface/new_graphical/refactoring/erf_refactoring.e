indexing
	description: "Base class for a refactoring"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERF_REFACTORING

inherit
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	CONF_REFACTORING

feature {ERF_REFACTORING} -- Initialization

	make (an_undo_stack: STACK [LIST [ERF_ACTION]]; a_preference: PREFERENCES) is
			-- Create
		require
			an_undo_stack_not_void: an_undo_stack /= Void
			a_preference_not_void: a_preference /= Void
		do
			undo_stack := an_undo_stack
			create preferences.make (a_preference)
			create open_classes.make (0)
			checks := create {LINKED_LIST [ERF_CHECK]}.make
		end

feature -- Status

	success: BOOLEAN
			-- Was the last refactoring successful?


feature -- Access

	preferences: ERF_PREFERENCES
			-- The preferences for this refactoring.

feature -- Basic actions

	execute is
			-- Execute the refactoring
		local
			all_checks_ok: BOOLEAN
			compiler_check: ERF_COMPILATION_SUCCESSFUL
			wd: EV_WARNING_DIALOG
			qd: EV_QUESTION_DIALOG
			evcsts: EV_DIALOG_CONSTANTS
		do
			success := False
			status_bar := window_manager.last_focused_development_window.status_bar
			create compiler_check.make

				-- check if compilation is ok
			compiler_check.execute
			if not compiler_check.success then
				create wd.make_with_text (compiler_check.error_message)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
					-- Get open classes
				window_manager.for_all_development_windows (agent add_window_to_open_classes)

					-- Ask settings till the checks all complete successfully or if the user cancels
				ask_run_settings
				if retry_ask_run_settings then
					from
						all_checks_ok := checks.for_all (agent check_successful)
					until
						not retry_ask_run_settings or else all_checks_ok
					loop
						ask_run_settings
						all_checks_ok := checks.for_all (agent check_successful)
					end
						-- Checks ok and user didn't cancel
					if all_checks_ok and retry_ask_run_settings then
							-- Handle undo
						create current_actions.make (0)

						refactor

							-- Execute compilation
						compiler_check.execute
						success := compiler_check.success
							-- on error ask if we should rollback
						if not success then
								-- success, because, now the user can choose to keep the changes or if he rollbacks, success will be set to False
							success := True
							create qd.make_with_text (compiler_check.error_message+" Rollback?")
							create evcsts
							qd.button (evcsts.ev_yes).select_actions.extend (agent rollback)
							qd.button (evcsts.ev_no).select_actions.extend (agent commit)
							qd.button (evcsts.ev_cancel).hide
							qd.show_modal_to_window (window_manager.last_focused_development_window.window)
						else
							commit
						end
					end
					window_manager.for_all_development_windows (agent {EB_DEVELOPMENT_WINDOW}.synchronize)
				end
			end
		rescue
				-- on exception undo any changes
			rollback
		end

feature {EB_WINDOW_MANAGER, EB_DEVELOPMENT_WINDOW} -- Callbacks

	add_window_to_open_classes (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Add `a_window' to open classes.
		local
			class_name: STRING
		do
			class_name := a_window.class_name
			if class_name /= Void then
				if not open_classes.has (class_name) then
					open_classes.put (create {LINKED_LIST [EB_DEVELOPMENT_WINDOW]}.make, class_name)
				end
				open_classes.item (class_name).extend (a_window)
			end
		end

	refresh_window (a_window: EB_DEVELOPMENT_WINDOW; a_class: CLASS_I) is
			-- Refresh `a_window' to show the content of a_class.
		local
			class_stone: CLASSI_STONE
		do
			create class_stone.make (a_class)
			a_window.set_stone (class_stone)
		end

-- TODO: Change this stuff to use the query interface that will be created
feature {NONE} -- Implementation convenience

	all_classes: LINKED_SET [CLASS_I] is
			-- Get all classes that can be changed by the user.
		local
			l_vis: CONF_ALL_CLASSES_VISITOR
			l_classes: ARRAYED_LIST [CONF_CLASS]
			l_cl: CLASS_I
		do
			create l_vis.make
			if universe.target /= Void then
				universe.target.process (l_vis)
			end
			from
				l_classes := l_vis.classes
				l_classes.start
			until
				l_classes.after
			loop
				l_cl ?= l_classes.item
				check
					class_i: l_cl /= Void
				end
				if not l_cl.is_read_only then
					Result.put (l_cl)
				end
				l_classes.forth
			end
		end

	descendant_classes (a_class: CLASS_I): LINKED_SET [CLASS_I] is
			-- Get all descendant classes of `a_class'.
		require
			compiled_class: a_class.compiled
		local
			descendants: ARRAYED_LIST [CLASS_C]
			descendant_class: CLASS_C
		do
			create Result.make
			descendants := a_class.compiled_class.descendants
			if not descendants.is_empty then
				from
					descendants.start
				until
					descendants.after
				loop
					descendant_class := descendants.item

						-- if not already added, add class and its descendants
					if not Result.has (descendant_class.lace_class) then
						Result.extend (descendant_class.lace_class)
						descendants.append (descendant_class.descendants)
					end

					descendants.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	client_classes (a_class: CLASS_I): LINKED_SET [CLASS_I] is
			-- Get all client classes of `a_class'.
		require
			compiled_class: a_class.compiled
		local
			clients: ARRAYED_LIST [CLASS_C]
		do
			create Result.make
			clients := a_class.compiled_class.syntactical_clients
			from
				clients.start
			until
				clients.after
			loop
				Result.extend (clients.item.lace_class)
				clients.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	recursive_client_classes (a_class: CLASS_I): LINKED_SET [CLASS_I] is
			-- Get all client classes of `a_class' or a descendant of `a_class'.
		require
			compiled_class: a_class.compiled
		local
			descendants: LINKED_SET [CLASS_I]
		do
			create Result.make
			Result.append (client_classes (a_class))

			descendants := descendant_classes (a_class)
			from
				descendants.start
			until
				descendants.after
			loop
				Result.append (client_classes (descendants.item))
				descendants.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	usage_classes (a_class: CLASS_I): LINKED_SET [CLASS_I] is
			-- Get all classes that somehow use `a_class' directly or indirectly.
		require
			compiled_class: a_class.compiled
		do
			create Result.make
			Result.extend (a_class)
			Result.append (descendant_classes (a_class))
			Result.append (recursive_client_classes (a_class))
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- undo handling

	rollback is
			-- Rollback the changes and remove the undo information
		local
			compiler_check: ERF_COMPILATION_SUCCESSFUL
		do
			success := False
			if current_actions /= Void then
				from
					current_actions.finish
				until
					current_actions.before
				loop
					current_actions.item.undo
					current_actions.item.destroy
					current_actions.back
				end
			end

			create compiler_check.make
			compiler_check.execute
		end

	commit is
			-- Add the undo information to the undo stack.
		require
			success: success
		do
			undo_stack.put (current_actions)
		end


feature {NONE} -- Implementation

	refactor is
			-- Do the refactoring changes.
		do
		end

	ask_run_settings is
			-- Ask for the settings, that are run specific.
		do
		end

	checks: LIST [ERF_CHECK]
			-- The checks that need to be run before this refactoring can be run.

	current_actions: ARRAYED_LIST [ERF_ACTION]
			-- The list of actions for the current, running refactoring.

	open_classes: HASH_TABLE [LIST [EB_DEVELOPMENT_WINDOW], STRING]
			-- The open classes.

	retry_ask_run_settings: BOOLEAN
			-- Try to ask the settings again?

	status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			-- The status bar to show progress.

	check_successful (c: ERF_CHECK): BOOLEAN is
			-- Was `c' successful?
		require
			c_not_void: c /= Void
		local
			wd: EV_WARNING_DIALOG
		do
			c.execute
			Result := c.success
			if retry_ask_run_settings and not Result then
				create wd.make_with_text (c.error_message)
				wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	undo_stack: STACK [LIST [ERF_ACTION]]
			-- The stack of list of commands where all actions have to be registered for them to be undoable.

invariant
	undo_stack_not_void: undo_stack /= Void
	open_classes_not_void: open_classes /= Void
	checks_not_void: checks /= Void

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

end -- class ERF_REFACTORING
