note
	description: "Formatter that uses a browser to display results"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_BROWSER_FORMATTER

inherit
	EB_FORMATTER
		undefine
			veto_pebble_function
		redefine
			retrieve_sorting_order,
			is_browser_formatter
		end

	EB_SHARED_PREFERENCES

feature -- Access

	browser: EB_CLASS_BROWSER_GRID_VIEW [ANY]
			-- Browser where information gets displayed

	new_browser (a_development_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): like browser
			-- New browser
		require
			a_development_window_attached: a_development_window /= Void
			a_drop_actions_attached: a_drop_actions /= Void
		do
		ensure
			result_attached: Result /= Void
		end

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Possible area to display a tool bar
		do
			if browser /= Void then
				Result := browser.control_bar
			end
		end

	displayer: EB_FORMATTER_BROWSER_DISPLAYER
			-- Displayer to display result of Current formatter

	sorting_status_preference: STRING_PREFERENCE
			-- Preference to store last sorting orders of Current formatter
		deferred
		end

	sorting_order_getter: FUNCTION [ANY, TUPLE, STRING]
			-- Getter to retrieve sorting order status
		do
			if sorting_status_preference /= Void then
				Result := agent sorting_status_preference.value
			end
		end

	sorting_order_setter: PROCEDURE [ANY, TUPLE [STRING]]
			-- Setter to set sorting order given as the only argument
		do
			if sorting_status_preference /= Void then
				Result := agent sorting_status_preference.set_value
			end
		end

	text: STRING
			-- Text in current formatter
		do
		end

	selection: STRING
			-- Selection in `text'
			-- An empty string if no selection is found.
		do
		end

feature -- status report

	is_browser_formatter: BOOLEAN
			-- Is Current formatter based on a browser?
		do
			Result := True
		end

feature -- Setting

	set_browser_displayer (a_displayer: like displayer)
			-- Set `a_displayer' with `a_displayer'.
		require
			a_displayer_not_void: a_displayer /= Void
		do
			displayer := a_displayer
			if {l_browser: like browser} displayer.browser then
				browser := l_browser
			else
					-- Clearly we should not go there, but the code is badely designed here.
					-- For some reasons there is only one kind of displayer which only know
					-- about one type of browser, i.e. EB_CLASS_BROWSER_GRID_VIEW [ANY].
				check
					invalid_type: False
				end
			end
		end

feature{NONE} -- Implementation

	retrieve_sorting_order
			-- Retrieve last recored sorting order.
		local
			l_sorting_status: LINKED_LIST [TUPLE [INTEGER, INTEGER]]
			l_orders: STRING
			l_browser: like browser
		do
			l_browser := browser
			if l_browser /= Void then
				l_browser.set_sorting_order_getter (sorting_order_getter)
				l_browser.set_sorting_order_setter (sorting_order_setter)
				if sorting_order_getter /= Void then
					l_orders := sorting_order_getter.item (Void)
					if l_orders /= Void then
						l_sorting_status := l_browser.sorted_columns_from_string (l_orders)
						if not l_browser.is_sorting_status_valid (l_sorting_status) then
							l_sorting_status := Void
						end
					end
				end
					-- Generate a fallback sorting order if not retrieved any or retrieved value is invalid.
				if l_sorting_status = Void then
					create l_sorting_status.make
					l_sorting_status.extend ([1, 1])
				end
				l_browser.set_sorting_status (l_sorting_status)
			end
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
