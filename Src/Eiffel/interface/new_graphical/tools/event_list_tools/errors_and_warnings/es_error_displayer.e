indexing
	description: "[
		An error display for the graphical version of EiffelStudio, used in combination with the event list service {EVENT_LIST_SERVICE_I}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_ERROR_DISPLAYER

inherit
	ERROR_DISPLAYER
		redefine
			clear_errors,
			clear_warnings
		end

	SHARED_SERVICE_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: like window_manager)
			-- Initialize error displayer for EiffelStudio
		require
			a_manager_attached: a_manager /= Void
		do
			window_manager := a_manager
			event_list_service ?= service_provider.query_service ({EVENT_LIST_SERVICE_S})
		ensure
			window_manager_set: window_manager = a_manager
		end

feature {NONE} -- Access

	frozen error_context: UUID is
			-- Error event list context identifier
		once
			create Result.make_from_string ("E1FFE10E-D722-4249-A34C-39290C2C194A")
		ensure
			result_attached: Result /= Void
			not_result_is_default: not Result.is_equal (create {UUID})
		end

	frozen warning_context: UUID
			-- Warning event list context identifier
		once
			create Result.make_from_string ("E1FFE10F-E9C5-42C3-B5F4-F61AD1206D5B")
		ensure
			result_attached: Result /= Void
			not_result_is_default: not Result.is_equal (create {UUID})
		end

	event_list_service: EVENT_LIST_SERVICE_I
			-- Event list service to log errors and warnings to

	window_manager: EB_WINDOW_MANAGER
			-- Manager of all development windows

feature {NONE} -- Status report

	is_event_list_service_available: BOOLEAN
			-- Determines if the event list service is available
		do
			Result := event_list_service /= Void
		ensure
			result_implies_event_list_service_attached: Result implies event_list_service /= Void
		end

feature -- Basic operations

	clear_errors
			-- Clears display of any stored error information.
		do
			if is_event_list_service_available then
				event_list_service.prune_event_items (error_context)
			end
		end

	clear_warnings
			-- Clears display of any stored warning information.
		do
			if is_event_list_service_available then
				event_list_service.prune_event_items (warning_context)
			end
		end

feature {NONE} -- Basic operations

	show_errors_and_warnings_tool (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Shows the error and warnings tool for window `a_window'
			--
			-- `a_window': The EiffelStudio development window to display the errors and warnings tool for
		require
			a_window_attached: a_window /= Void
			is_event_list_service_available: is_event_list_service_available
		local
			l_tool: ES_ERRORS_AND_WARNINGS_TOOL
		do
			if not a_window.is_recycled and then a_window.is_visible then
				l_tool := a_window.tools.errors_and_warnings_tool
				if l_tool /= Void and then not l_tool.is_recycled then
						-- Force tool to be shown
					l_tool.show
				end
			end
		end

feature -- Output

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		local
			l_warnings: LIST [ERROR]
			l_warning: WARNING
			l_cursor: CURSOR
			l_service: like event_list_service
			l_context: UUID
		do
			if is_event_list_service_available then
				l_warnings := handler.warning_list
				if not l_warnings.is_empty then
					l_service := event_list_service
					l_context := warning_context
					l_cursor := l_warnings.cursor
					from l_warnings.start until l_warnings.after loop
						l_warning ?= l_warnings.item
						check
							l_warning_attached: l_warning /= Void
						end
						if l_warning /= Void then
							l_service.put_event_item (l_context, create_warning_event_item (l_warning))
						end
						l_warnings.forth
					end
					l_warnings.go_to (l_cursor)
				end
			end
		end

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		local
			l_errors: LIST [ERROR]
			l_error: ERROR
			l_cursor: CURSOR
			l_service: like event_list_service
			l_context: UUID
		do
			if is_event_list_service_available then
				l_errors := handler.error_list
				if not l_errors.is_empty then
					l_service := event_list_service
					l_context := error_context
					l_cursor := l_errors.cursor
					from l_errors.start until l_errors.after loop
						l_error ?= l_errors.item
						check
							l_error_attached: l_error /= Void
						end
						if l_error /= Void then
							l_service.put_event_item (l_context, create_error_event_item (l_error))
						end
						l_errors.forth
					end
					l_errors.go_to (l_cursor)
				end
			end
		end

	force_display is
			-- Make sure the user can see the messages we send.
		do
			if is_event_list_service_available then
					-- Only force the display if the service is available, else there is
					-- nothing to display in the window
				window_manager.for_all_development_windows (agent show_errors_and_warnings_tool)
			end
		end

feature {NONE} -- Factory

	create_warning_event_item (a_warning: WARNING): EVENT_LIST_ITEM_I
			-- Creates a new event list item for a warning.
			--
			-- `a_warning': Warning to create an event list item for.
			-- `Result': The event list item associated with the warning `a_warning'
		require
			a_warning_attached: a_warning /= Void
		do
			Result := create_error_event_item (a_warning)
		ensure
			result_attached: Result /= Void
			result_user_data_set: Result.data = a_warning
		end

	create_error_event_item (a_error: ERROR): EVENT_LIST_ITEM_I
			-- Creates a new event list item for a error.
			--
			-- `a_error': Error to create an event list item for.
			-- `Result': The event list item associated with the error `a_error'
		require
			a_error_attached: a_error /= Void
		do
			create {EVENT_LIST_ERROR_ITEM}Result.make ({ENVIRONMENT_CATEGORIES}.compilation, a_error.out, a_error)
		ensure
			result_attached: Result /= Void
			result_user_data_set: Result.data = a_error
		end

invariant
	event_list_service_attached: is_event_list_service_available implies event_list_service /= Void
	window_manager_attached: window_manager /= Void

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
