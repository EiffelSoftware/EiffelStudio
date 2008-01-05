indexing
	description: "[
		Base core for all EiffelStudio foundations
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_TOOL_FOUNDATIONS

inherit
	EB_RECYCLABLE

inherit {NONE}
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	frozen make
			-- Initialize foundation tool
		local
			l_init: BOOLEAN
		do
			l_init := is_initializing
			is_initializing := True

			on_before_initialize
			build_interface

			is_initialized := True
			is_initializing := l_init

			on_after_initialized
		ensure
			is_initialized: is_initialized
		end

    on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use `build_dialog_interface' instead
		do
        end

    on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
        require
        	is_initialized: is_initialized
        do
        end

feature {NONE} -- User interface initialization

	build_interface
			-- Builds the foundataion tool's user interface.
		require
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the window has became useless.
		do
			is_initialized := False
		ensure then
			not_is_initialized: not is_initialized
		end

feature {NONE} -- Access

	foundation_widget: EV_WIDGET
			-- Widget used by tool foundation implementation
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
			result_consistent: Result = foundation_widget
		end

feature -- Status report

	is_shown: BOOLEAN
			-- Indicates if foundataion tool is current visible
		do
			if is_initialized and then not is_recycled then
				Result := foundation_widget.is_displayed
			end
		end

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

	is_initializing: BOOLEAN
			-- Indicates if the user interface is currently being initialized

feature {NONE} -- Helpers

	frozen interface_names: !INTERFACE_NAMES
			-- Access to EiffelStudio's interface names
		once
			create Result
		end

	frozen stock_pixmaps: !ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps
		once
			Result ?= (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		end

	frozen mini_stock_pixmaps: !ES_PIXMAPS_10X10
			-- Shared access to stock 10x10 EiffelStudio pixmaps
		once
			Result ?= (create {EB_SHARED_PIXMAPS}).mini_pixmaps
		end

	frozen helpers: !EVS_HELPERS
			-- Helpers to extend the operations of EiffelVision2
		once
			create Result
		end

	frozen preferences: !EB_PREFERENCES
			-- Access to environment preferences
		require
			preferences_initialized: (create {EB_SHARED_PREFERENCES}).preferences_initialized
		once
			Result ?= (create {EB_SHARED_PREFERENCES}).preferences
		end

	frozen session_manager: !SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service {SESSION_MANAGER_S} consumer
		once
			create Result
		end

feature {NONE} -- Basic operations

    execute_with_busy_cursor (a_action: PROCEDURE [ANY, TUPLE])
            -- Executes a action with a wait cursor
            --
            -- `a_action': An action to execute with a wait cursor displayed until the action has been completed
        require
            is_interface_usable: is_interface_usable
            is_initialized: is_initialized
            a_action_attached: a_action /= Void
        local
            l_style: EV_POINTER_STYLE
            l_widget: like foundation_widget
        do
        	l_widget := foundation_widget
			l_style := l_widget.pointer_style
			l_widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
			a_action.call ([])
			l_widget.set_pointer_style (l_style)
		rescue
				-- Action may raise an exception, so we need to restore the
				-- cursor
			if l_style /= Void then
				l_widget.set_pointer_style (l_style)
			end
		end

	propagate_action (a_start_widget: EV_WIDGET; a_action: PROCEDURE [ANY, TUPLE [EV_WIDGET]]; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates a performed action to all child widgets of an initial widget.
			--
			-- `a_start_widget': The starting widget to apply an action, as well as to all it's children widgets.
			-- `a_action': The action to be performed.
			-- `a_excluded': An array of widgets to exluding the the propagation of actions, or Void to include all widgets
		require
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			a_action_attached: a_action /= Void
		local
			l_cursor: CURSOR
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
					-- Perform action
				a_action.call ([a_start_widget])
			end

			if {l_list: !EV_WIDGET_LIST} a_start_widget then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if {l_widget: !EV_WIDGET} l_list.item and then not l_widget.is_destroyed then
							-- Perform action on all child widgets
						propagate_action (l_widget, a_action, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			end
		end

	propagate_register_action (a_start_widget: EV_WIDGET; a_sequence: FUNCTION [ANY, TUPLE [EV_WIDGET], ACTION_SEQUENCE [TUPLE]]; a_action: PROCEDURE [ANY, TUPLE]; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates an actions to all child widgets
			--
			-- `a_exclude': An array of widgets to exluding the the propagation of actions, or Void to include all widgets
		require
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			a_action_attached: a_action /= Void
		local
			l_sequence: ACTION_SEQUENCE [TUPLE]
			l_cursor: CURSOR
			l_start_widget: EV_WIDGET
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
				l_sequence := a_sequence.item ([a_start_widget])
				if l_sequence /= Void then
						-- Add action
					register_action (l_sequence, a_action)
				end
			end

			if {l_window: !EV_WINDOW} a_start_widget then
				if not l_window.is_empty then
					l_start_widget := l_window.item
				end
			else
				l_start_widget := a_start_widget
			end

			if {l_list: !EV_WIDGET_LIST} l_start_widget then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if {l_widget: !EV_WIDGET} l_list.item and then not l_widget.is_destroyed then
							-- Apply addition to all child widgets
						propagate_register_action (l_widget, a_sequence, a_action, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
