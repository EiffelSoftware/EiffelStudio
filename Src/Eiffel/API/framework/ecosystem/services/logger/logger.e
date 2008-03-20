indexing
	description: "[
		A service for logging interal messages in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	LOGGER

inherit
	LOGGER_S
		redefine
			on_sited
		end

	EVENT_LIST_EVENT_OBSERVER
		redefine
			on_event_item_added,
			on_event_item_removed
		end

	SAFE_AUTO_DISPOSABLE
		redefine
			safe_dispose
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize logger service.
		do
			log_cache_length := 50
			create log_cache.make

				-- Initialize events
			create message_logged_events

				-- Set up automatic cleaning of event object
			auto_dispose (message_logged_events)
		end

	on_sited
			-- <Precursor>
		local
			l_service: like event_list_service
		do
			l_service := event_list_service
			if l_service.is_service_available and then {l_observer: !EVENT_LIST_EVENT_OBSERVER} Current then
					-- Connect observer
				l_service.service.connect_events (l_observer)
			end
			Precursor {LOGGER_S}
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- <Precursor>
		local
			l_service: like event_list_service
		do
			if a_disposing then
				clear_log

				l_service := event_list_service
				if l_service.is_service_available and then {l_observer: !EVENT_LIST_EVENT_OBSERVER} Current and then l_service.service.is_connected (l_observer) then
						-- Disconnect observer
					l_service.service.disconnect_events (l_observer)
				end
			end
			Precursor {SAFE_AUTO_DISPOSABLE} (a_disposing)
		end

feature -- Access

	log_cache_length: INTEGER_32 assign set_log_cache_length
			-- Length of sustained logged item cache.

feature {NONE} -- Access

	frozen event_list_service: !SERVICE_CONSUMER [EVENT_LIST_S]
			-- Event list service to send log item to.
		once
				-- Use local service provider when creating the event list service consumer.
			check sited: site /= Void end
			create Result.make_with_provider (site)
		end

	context_cookie: !UUID
			-- Context cookie for event list service
		once
			create Result.make_from_string ("E1FFE100-0106-4145-A53F-ED44CE92714D")
		end

	log_cache: !DS_LINKED_LIST [!EVENT_LIST_LOG_ITEM_I]
			-- Cache of all logged items

feature -- Element change

	set_log_cache_length (a_length: like log_cache_length)
			-- Sets the upper limit on the length of log cache.
			-- See `log_cache_length' for more details.
			--
			-- `a_length': Length of logger cache.
		local
			l_items: like log_cache
			l_service: EVENT_LIST_S
		do
			if a_length < log_cache_length then
				if event_list_service.is_service_available then
					l_service := event_list_service.service
				end
				l_items := log_cache
				if l_items.count > a_length then
					from l_items.start until l_items.count = a_length loop
						if l_service /= Void then
							l_service.prune_event_item (l_items.item_for_iteration)
						end
					end
				end
			end
			log_cache_length := a_length
		end

feature -- Extension

	put_message_with_severity (a_msg: STRING_GENERAL; a_cat: NATURAL_8; a_level: INTEGER_8)
			-- <Precursor>
		local
			l_item: like create_event_list_log_item
			l_service: like event_list_service
		do
			if {l_string: !STRING_32} a_msg.as_string_32 then
				l_service := event_list_service
				if l_service.is_service_available then
					l_item := create_event_list_log_item (l_string, a_cat, a_level)
					l_service.service.put_event_item (context_cookie, l_item)
				end

					-- Publish events
				message_logged_events.publish ([l_string, a_cat, a_level])
			end
		end

	put_message_format_with_severity (a_msg: STRING_GENERAL; a_args: TUPLE; a_cat: NATURAL_8; a_level: INTEGER_8)
			-- <Precursor>
		do
			put_message_with_severity ((create {STRING_FORMATTER}).format_unicode (a_msg, a_args), a_cat, a_level)
		end

feature -- Removal

	clear_log
			-- <Precursor>
		local
			l_service: like event_list_service
		do
			l_service := event_list_service
			if l_service.is_service_available then
				l_service.service.prune_event_items (context_cookie)
			end
		end

feature -- Events

	message_logged_events: !EVENT_TYPE [TUPLE [message: !STRING_32; category: NATURAL_8; level: INTEGER_8]]
			-- <Precursor>

feature {EVENT_LIST_S} -- Event handlers

	on_event_item_added (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_service: like event_list_service
			l_cache: like log_cache
		do
			if {l_log_item: !EVENT_LIST_LOG_ITEM_I} a_event_item then
				l_cache := log_cache
				if l_cache.count = log_cache_length then
						-- Too many items, remove the first.
					l_service := event_list_service
					if l_service.is_service_available then
						l_service.service.prune_event_item (l_cache.first)
					end
				end

					-- Add new log item
				l_cache.force_last (l_log_item)
			end
		ensure then
			log_cache_has_a_event_item: (({EVENT_LIST_LOG_ITEM_I}) #? a_event_item /= Void) implies log_cache.has (({!EVENT_LIST_LOG_ITEM_I}) #? a_event_item)
		end

	on_event_item_removed (a_service: EVENT_LIST_S; a_event_item: EVENT_LIST_ITEM_I)
			-- <Precursor>
		local
			l_cache: like log_cache
		do
			if {l_log_item: !EVENT_LIST_LOG_ITEM_I} a_event_item then
				l_cache := log_cache
				if not l_cache.is_empty then
					if l_cache.first = a_event_item then
							-- Remove the first item.
						l_cache.remove_first
					else
							-- Remove arbitary item.
						l_cache.start
						l_cache.search_forth (l_log_item)
						if not l_cache.after then
							l_cache.remove_at
						end
					end
				end
			end
		ensure then
			not_log_cache_has_a_event_item: (({EVENT_LIST_LOG_ITEM_I}) #? a_event_item /= Void) implies not log_cache.has (({!EVENT_LIST_LOG_ITEM_I}) #? a_event_item)
		end

feature {NONE} -- Factory

	create_event_list_log_item (a_msg: !STRING_32; a_cat: NATURAL_8; a_level: INTEGER_8): !EVENT_LIST_LOG_ITEM_I
			-- <Precursor>
		require
			not_a_msg_is_empty: not a_msg.is_empty
			a_cat_is_empty_is_valid_category: is_valid_category (a_cat)
			a_level_is_valid_severity_level: is_valid_severity_level (a_level)
			is_event_list_service_available: event_list_service.is_service_available
		do
			create {!EVENT_LIST_LOG_ITEM} Result.make (a_cat, a_msg, a_level)
		ensure
			result_is_log_item: Result.type = {EVENT_LIST_ITEM_TYPES}.log
		end

invariant
	log_cache_count_small_enought: log_cache.count <= log_cache_length

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
