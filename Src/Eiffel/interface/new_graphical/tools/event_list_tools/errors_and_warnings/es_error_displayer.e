note
	description: "[
		An error display for the graphical version of EiffelStudio, used in combination with the event list service {EVENT_LIST_SERVICE_S}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_ERROR_DISPLAYER

inherit
	ERROR_DISPLAYER
		rename
			clear_errors as clear_compiler_errors,
			clear_warnings as clear_compiler_warnings,
			trace as trace_from_compiler,
			trace_errors as trace_compiler_errors,
			trace_warnings as trace_compiler_warnings
		redefine
			clear_compiler_errors,
			clear_compiler_warnings
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
		ensure
			window_manager_set: window_manager = a_manager
		end

feature {NONE} -- Access

	frozen error_context: UUID
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

	window_manager: EB_WINDOW_MANAGER
			-- Manager of all development windows

feature {NONE} -- Access

	syntax_errors: DS_ARRAYED_LIST [EVENT_LIST_ERROR_ITEM_I]
			-- Managed list of syntax errors/warnings.
		once
			create Result.make_default
			Result.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [EVENT_LIST_ERROR_ITEM_I]}.make (
				agent (ia_item: EVENT_LIST_ERROR_ITEM_I; ia_other: EVENT_LIST_ERROR_ITEM_I): BOOLEAN
						-- Equality tester to ensure two like syntax errors are considered the same.
					do
						Result := ia_item = ia_other
						if not Result and then ia_item /= Void and then ia_other /= Void then
							if attached {SYNTAX_ERROR} ia_item.data as l_error and then attached {SYNTAX_ERROR} ia_other.data as l_other then
								Result := l_error.line = l_other.line and then
									l_error.column = l_other.column and then
									l_error.file_name ~ l_other.file_name
							elseif attached {SYNTAX_WARNING} ia_item.data as l_error and then attached {SYNTAX_WARNING} ia_other.data as l_other then
								Result := l_error.line = l_other.line and then
									l_error.column = l_other.column and then
									l_error.file_name ~ l_other.file_name
							end
						end
					end))
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Helpers

	event_list: SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to the event list service
		once
			create Result
			if Result.is_service_available then
					-- Subscribe to the remove action so we know when to remove an entry from the managed
					-- syntax errors.
				Result.service.item_removed_event.subscribe (agent (ia_sender: EVENT_LIST_S; ia_item: EVENT_LIST_ITEM_I)
						-- Agent used to remove the syntax error
					local
						l_errors: like syntax_errors
						l_tester: detachable KL_EQUALITY_TESTER [EVENT_LIST_ERROR_ITEM_I]
					do
						if attached {EVENT_LIST_ERROR_ITEM_I} ia_item as l_item then
							l_errors := syntax_errors
								-- We remove the equality tester to ensure we are testing just the actual reference.
							l_tester := l_errors.equality_tester
							l_errors.set_equality_tester (Void)
							l_errors.start
							l_errors.search_forth (l_item)
							if not l_errors.after then
								l_errors.remove_at
							end
							if l_tester /= Void then
									-- Restore the equality tester.
								l_errors.set_equality_tester (l_tester)
							end
						end
					end)
			end

		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	clear (a_cookie: UUID)
			-- Clears all error/warnings associated with a cookie.
			--
			-- `a_cookie': The cookie used to trace the error.
		require
			a_cookie_attached: a_cookie /= Void
			not_a_cookie_is_null: not a_cookie.is_null
		local
			l_service: detachable EVENT_LIST_S
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.lock
				l_service.prune_event_items (a_cookie)
				l_service.unlock
			end
		end

	trace (a_category: NATURAL_8; a_error_cookie: UUID; a_warning_cookie: UUID; a_handler: ERROR_HANDLER)
			-- Traces all errors and warnings in the supplied error handler.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_error_cookie': A context identifier used to manage error items.
			-- `a_warning_cookie': A context identifier used to manage warning items.
			-- `a_handler': An error handler to produce errors and warning from.
		require
			a_error_cookie_attached: a_error_cookie /= Void
			not_a_error_cookie_is_null: not a_error_cookie.is_null
			a_warning_cookie_attached: a_warning_cookie /= Void
			not_a_warning_cookie_is_null: not a_warning_cookie.is_null
			a_handler_attached: a_handler /= Void
		local
			l_service: detachable EVENT_LIST_S
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.lock
			end

				-- For EiffelStudio, we report the errors first to ensure they are display on the top of the
				-- error list tool.
			if a_handler.has_error then
				trace_errors (a_category, a_error_cookie, a_handler)
			end
			if a_handler.has_warning then
				trace_warnings (a_category, a_warning_cookie, a_handler)
			end

			if l_service /= Void and then l_service.is_interface_usable then
				l_service.unlock
			end
		ensure
			error_list_unmoved: a_handler.error_list.cursor ~ old a_handler.error_list.cursor
			warning_list_unmoved: a_handler.warning_list.cursor ~ old a_handler.warning_list.cursor
		end

	trace_errors (a_category: NATURAL_8; a_cookie: UUID; a_handler: ERROR_HANDLER)
			-- Traces all errors in the supplied error handler.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_cookie': A context identifier used to manage error items.
			-- `a_handler': An error handler to produce errors from.
		require
			a_cookie_attached: a_cookie /= Void
			not_a_cookie_is_null: not a_cookie.is_null
			a_handler_attached: a_handler /= Void
			not_a_handler_error_list_is_empty: not a_handler.error_list.is_empty
		local
			l_service: detachable EVENT_LIST_S
			l_errors: LIST [ERROR]
			l_cursor: CURSOR
			l_locked: BOOLEAN
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.lock
				l_locked := True
			end

			l_errors := a_handler.error_list
			l_cursor := l_errors.cursor
			from l_errors.start until l_errors.after loop
				if attached l_errors.item as l_item then
					extend_event_item (l_service, a_cookie, create_error_event_item (a_category, l_item))
				end
				l_errors.forth
			end
			l_errors.go_to (l_cursor)

			if l_service /= Void and then l_service.is_interface_usable then
				l_locked := False
				l_service.unlock
			end
		ensure
			error_list_unmoved: a_handler.error_list.cursor ~ old a_handler.error_list.cursor
		rescue
			if l_locked and then l_service /= Void and then l_service.is_interface_usable then
				l_service.unlock
			end
		end

	trace_warnings (a_category: NATURAL_8; a_cookie: UUID; a_handler: ERROR_HANDLER)
			-- Traces all warnings in the supplied error handler.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_cookie': A context identifier used to manage warnings items.
			-- `a_handler': An error handler to produce warnings from.
		require
			a_cookie_attached: a_cookie /= Void
			not_a_cookie_is_null: not a_cookie.is_null
			a_handler_attached: a_handler /= Void
			not_a_handler_warning_list_is_empty: not a_handler.warning_list.is_empty
		local
			l_service: detachable EVENT_LIST_S
			l_warnings: LIST [ERROR]
			l_cursor: CURSOR
			l_locked: BOOLEAN
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.lock
				l_locked := True
			end

			l_warnings := a_handler.warning_list
			l_cursor := l_warnings.cursor
			from l_warnings.start until l_warnings.after loop
				if attached l_warnings.item as l_item then
					extend_event_item (l_service, a_cookie, create_warning_event_item (a_category, l_item))
				end
				l_warnings.forth
			end
			l_warnings.go_to (l_cursor)

			if l_service /= Void and then l_service.is_interface_usable then
				l_locked := False
				l_service.unlock
			end
		ensure
			warning_list_unmoved: a_handler.warning_list.cursor ~ old a_handler.warning_list.cursor
		rescue
			if l_locked and then l_service /= Void and then l_service.is_interface_usable then
				l_service.unlock
			end
		end

	trace_error (a_category: NATURAL_8; a_cookie: UUID; a_error: ERROR)
			-- Traces all warnings in the supplied error handler.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_cookie': A context identifier used to manage warnings items.
			-- `a_handler': An error handler to produce warnings from.
		require
			a_cookie_attached: a_cookie /= Void
			not_a_cookie_is_null: not a_cookie.is_null
			a_error_attached: a_error /= Void
		local
			l_service: detachable EVENT_LIST_S
			l_locked: BOOLEAN
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.lock
				l_locked := True
				extend_event_item (l_service, a_cookie, create_error_event_item (a_category, a_error))
				l_locked := False
				l_service.unlock
			end
		rescue
			if l_locked and then l_service /= Void and then l_service.is_interface_usable then
				l_service.unlock
			end
		end

	trace_warning (a_category: NATURAL_8; a_cookie: UUID; a_warning: WARNING)
			-- Traces all warnings in the supplied error handler.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_cookie': A context identifier used to manage warnings items.
			-- `a_handler': An error handler to produce warnings from.
		require
			a_cookie_attached: a_cookie /= Void
			not_a_cookie_is_null: not a_cookie.is_null
			a_warning_attached: a_warning /= Void
		local
			l_service: detachable EVENT_LIST_S
			l_locked: BOOLEAN
		do
			if event_list.is_service_available then
				l_service := event_list.service
				l_service.lock
				l_locked := True
				extend_event_item (l_service, a_cookie, create_warning_event_item (a_category, a_warning))
				l_locked := False
				l_service.unlock
			end
		rescue
			if l_locked and then l_service /= Void and then l_service.is_interface_usable then
				l_service.unlock
			end
		end

feature {NONE} -- Basic operations

	clear_compiler_errors
			-- <Precursor>
		do
			clear (error_context)
		end

	clear_compiler_warnings
			-- <Precursor>
		do
			clear (warning_context)
		end

	trace_from_compiler (handler: ERROR_HANDLER)
			-- <Precursor>
		do
			trace ({ENVIRONMENT_CATEGORIES}.compilation, error_context, warning_context, handler)
		end

	trace_compiler_warnings (handler: ERROR_HANDLER)
			-- <Precursor>
		do
			trace_warnings ({ENVIRONMENT_CATEGORIES}.compilation, warning_context, handler)
		end

	trace_compiler_errors (handler: ERROR_HANDLER)
			-- <Precursor>
		do
			trace_warnings ({ENVIRONMENT_CATEGORIES}.compilation, error_context, handler)
		end

	force_display
			-- <Precursor>
		do
			if event_list.is_service_available then
					-- Only force the display if the service is available, else there is
					-- nothing to display in the window
				window_manager.for_all_development_windows (agent show_errors_and_warnings_tool)
			end
		end

feature {NONE} -- Basic operations

	extend_event_item (a_service: EVENT_LIST_S; a_cookie: UUID; a_item: EVENT_LIST_ERROR_ITEM_I)
			-- Extends an event error item to the event list service.
			--
			-- `a_service': The service to extend the event item to.
			-- `a_cookie': A context identifier used to manage warnings items.
			-- `a_item': The event item to add to the event list service.
		require
			a_service_attached: a_service/= Void
			a_service_is_interface_usable: a_service.is_interface_usable
			a_service_is_locked: a_service.is_locked
			a_cookie_attached: a_cookie /= Void
			not_a_cookie_is_null: not a_cookie.is_null
			a_item_attached: a_item /= Void
			not_a_item_is_invalidated: not a_item.is_invalidated
		local
			l_item: detachable EVENT_LIST_ERROR_ITEM_I
			l_errors: like syntax_errors
		do
			if attached {ERROR} a_item.data as l_error then
				l_errors := syntax_errors
				if a_item.category = {ENVIRONMENT_CATEGORIES}.editor then
						-- Open editor editor should adopt all other errors, hence the check.
					if l_errors.has (a_item) then
						l_errors.start
						l_errors.search_forth (a_item)
						l_item := l_errors.item_for_iteration

							-- Even thought we are doing a search and retreive the item from a list of stored errors, the
							-- item should differ from the passed one. This is because we use a comparison agent (see `make'.)							
						check l_item_not_a_item: l_item /= a_item end
					else
						l_errors.force_last (a_item)
						l_item := a_item
					end
				elseif attached {SYNTAX_ERROR} a_item.data or else attached {SYNTAX_WARNING} a_item.data then
					if not l_errors.has (a_item) then
						l_errors.force_last (a_item)
						l_item := a_item
					end
				else
					l_item := a_item
				end
			end

			if l_item /= Void then
				if a_item = l_item then
						-- The item is the same so no adoption is going to take place.
					a_service.put_event_item (a_cookie, l_item)
				else
						-- Change the category and priority.
					l_item.category := a_item.category
					l_item.priority := a_item.priority

						-- Adopt the item.
					a_service.adopt_event_item (a_cookie, l_item)
				end
			end
		end

	show_errors_and_warnings_tool (a_window: EB_DEVELOPMENT_WINDOW)
			-- Shows the error and warnings tool for window `a_window'
			--
			-- `a_window': The EiffelStudio development window to display the errors and warnings tool for
		require
			a_window_attached: a_window /= Void
		do
			if
				a_window.is_interface_usable and then
				a_window.is_visible and then
				a_window = window_manager.last_focused_development_window
			then
				a_window.shell_tools.show_tool ({ES_ERROR_LIST_TOOL}, False)
			end
		end

feature {NONE} -- Factory

	create_warning_event_item (a_category: NATURAL_8; a_warning: ERROR): EVENT_LIST_ERROR_ITEM_I
			-- Creates a new event list item for a warning.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_warning': Warning to create an event list item for.
			-- `Result': The event list item associated with the warning `a_warning'
		require
			a_warning_attached: a_warning /= Void
		do
			--| FIXME IEK Direct use of `out' for some errors is very inoptimal, the description could be queried dynamically.
			--create {EVENT_LIST_WARNING_ITEM} Result.make ({ENVIRONMENT_CATEGORIES}.compilation, a_warning.out, a_warning)
			create {EVENT_LIST_WARNING_ITEM} Result.make (a_category, once "Eiffel Warning", a_warning)
		ensure
			result_attached: Result /= Void
			result_user_data_set: Result.data = a_warning
			result_is_warning: Result.is_warning
		end

	create_error_event_item (a_category: NATURAL_8; a_error: ERROR): EVENT_LIST_ERROR_ITEM_I
			-- Creates a new event list item for a error.
			--
			-- `a_category': An error item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_error': Error to create an event list item for.
			-- `Result': The event list item associated with the error `a_error'
		require
			a_error_attached: a_error /= Void
		do
			--| FIXME IEK Direct use of `out' for some errors is very inoptimal, the description could be queried dynamically.
			--create {EVENT_LIST_ERROR_ITEM} Result.make ({ENVIRONMENT_CATEGORIES}.compilation, once a_error.out, a_error)
			create {EVENT_LIST_ERROR_ITEM} Result.make (a_category, once "Eiffel Error", a_error)
		ensure
			result_attached: Result /= Void
			result_user_data_set: Result.data = a_error
			not_result_is_warning: not Result.is_warning
		end

invariant
	window_manager_attached: window_manager /= Void

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
