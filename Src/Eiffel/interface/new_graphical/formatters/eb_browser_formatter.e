indexing
	description: "Formatter that uses a browser to display results"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_BROWSER_FORMATTER

inherit
	EB_FORMATTER
		redefine
			retrieve_sorting_order,
			internal_recycle,
			is_browser_formatter
		end

	EB_SHARED_PREFERENCES

feature -- Access

	browser: EB_CLASS_BROWSER_GRID_VIEW [ANY]
			-- Browser where information gets displayed

	new_browser (a_development_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): like browser is
			-- New browser
		require
			a_development_window_attached: a_development_window /= Void
			a_drop_actions_attached: a_drop_actions /= Void
		do
		ensure
			result_attached: Result /= Void
		end

	control_bar: EV_WIDGET is
			-- Possible area to display a tool bar
		do
			if browser /= Void then
				Result := browser.control_bar
			end
		end

	displayer: EB_FORMATTER_BROWSER_DISPLAYER
			-- Displayer to display result of Current formatter

	sorting_status_preference: STRING_PREFERENCE is
			-- Preference to store last sorting orders of Current formatter
		deferred
		end

	sorting_order_getter: FUNCTION [ANY, TUPLE, STRING] is
			-- Getter to retrieve sorting order status
		do
			if sorting_status_preference /= Void then
				Result := agent sorting_status_preference.value
			end
		end

	sorting_order_setter: PROCEDURE [ANY, TUPLE [STRING]] is
			-- Setter to set sorting order given as the only argument
		do
			if sorting_status_preference /= Void then
				Result := agent sorting_status_preference.set_value
			end
		end

feature -- status report

	is_browser_formatter: BOOLEAN is
			-- Is Current formatter based on a browser?
		do
			Result := True
		end

feature -- Setting

	set_browser_displayer (a_displayer: like displayer) is
			-- Set `a_displayer' with `a_displayer'.
		do
			displayer := a_displayer
			browser := displayer.browser
		end

feature{NONE} -- Implementation

	retrieve_sorting_order is
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

feature{NONE} -- Recycle

	internal_recycle is
			-- Recycle
		do
			Precursor {EB_FORMATTER}
			if displayer /= Void then
				displayer.recycle
			end
			displayer := Void
		end

end
