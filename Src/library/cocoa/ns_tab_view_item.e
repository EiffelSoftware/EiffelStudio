note
	description: "Wrapper for NSTabViewItem."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW_ITEM

inherit
	NS_OBJECT

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer ({NS_TAB_VIEW_ITEM_API}.new)
		end

	init_with_identifier (a_identifier: NS_OBJECT): NS_OBJECT
		do
			create Result.make_from_pointer ({NS_TAB_VIEW_ITEM_API}.init_with_identifier (item, a_identifier.item))
		end

feature -- Working with Labels

	label: NS_STRING
			-- The label text.
		do
			create Result.share_from_pointer ({NS_TAB_VIEW_ITEM_API}.label (item))
		end

	set_label (a_label: READABLE_STRING_GENERAL)
			-- Sets the label text to a_label.
		do
			{NS_TAB_VIEW_ITEM_API}.set_label (item, (create {NS_STRING}.make_with_string (a_label)).item)
		end

	draw_label_in_rect (a_should_truncate_label: BOOLEAN; a_tab_rect: NS_RECT)
			-- Draws the label in a_tab_rect, which is the area between the curved end caps.
		do
			{NS_TAB_VIEW_ITEM_API}.draw_label_in_rect (item, a_should_truncate_label, a_tab_rect.item)
		end

	size_of_label (a_compute_min: BOOLEAN): NS_SIZE
			-- Calculates the size of the receiver's label.
		do
			create Result.make_by_pointer ({NS_TAB_VIEW_ITEM_API}.size_of_label (item, a_compute_min))
		end

feature -- Checking the Tab Display State

	tab_state: INTEGER
		do
			Result := {NS_TAB_VIEW_ITEM_API}.tab_state (item)
		end

feature -- Assigning an Identifier Object

	identifier: NS_OBJECT
		do
			create Result.share_from_pointer ({NS_TAB_VIEW_ITEM_API}.identifier (item))
		end

	set_identifier (a_identifier: NS_OBJECT)
			-- Sets the optional identifier object to a_identifier.
		do
			{NS_TAB_VIEW_ITEM_API}.set_identifier(item, a_identifier.item)
		end

feature -- Setting the Color

	color: NS_COLOR
			-- The color, specified by the current theme.
		do
			create Result.share_from_pointer ({NS_TAB_VIEW_ITEM_API}.color (item))
		end

	set_color (a_color: NS_COLOR)
		obsolete
			"Deprecated. NSTabViewItems use a color supplied by the current theme [2017-05-31]."
		do
			{NS_TAB_VIEW_ITEM_API}.set_color(item, a_color.item)
		end

feature -- Assigning a View

	view: NS_VIEW
		do
			Result := (create {NS_VIEW}.share_from_pointer ({NS_TAB_VIEW_ITEM_API}.view (item)))
		end

	set_view (a_view: NS_VIEW)
			-- Sets the associated view to a_view.
			-- This is the view displayed when a user clicks the tab. When you set a new view, the old view is released.
		do
			{NS_TAB_VIEW_ITEM_API}.set_view (item, a_view.item)
		end

feature -- Setting the Initial First Responder

	initial_first_responder: NS_OBJECT
		do
			create Result.share_from_pointer ({NS_TAB_VIEW_ITEM_API}.initial_first_responder (item))
		end

	set_initial_first_responder (a_view: NS_VIEW)
		do
			{NS_TAB_VIEW_ITEM_API}.set_initial_first_responder(item, a_view.item)
		end

feature -- Accessing the Parent Tab View

	tab_view: NS_TAB_VIEW
		do
			create Result.share_from_pointer ({NS_TAB_VIEW_ITEM_API}.tab_view (item))
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
