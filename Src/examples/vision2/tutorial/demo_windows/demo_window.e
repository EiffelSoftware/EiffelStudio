indexing
	description:
		"Demo window, ancestor of all the window of%
		% demonstration";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DEMO_WINDOW

feature {NONE} -- Initialization

  	make (par: EV_CONTAINER) is
   			-- Create the demo in `par'.
		deferred
		end

feature {DEMO_ITEM} -- Initialise tabs when the window is shown.

	set_tabs is
			-- Set the tabs for the action window.
		deferred
		end

feature -- Status report

	action_window_shown: BOOLEAN is
			-- Is the action window shown ?
		do
			if action_window /= Void then
				Result := action_window.shown
			else
				Result := False
			end
		end

	has_action_window: BOOLEAN is
			-- Does the demo_window has an action_window?
		do
			Result := action_window /= Void
		end

feature -- Basic operation

	show_action_window is
			-- Shows the action window.
		do
			if (action_window /= Void) then
				action_window.show
			end
		end

	hide_action_window is
			-- Hides the action window.
		do
			if (action_window /= Void) then
				action_window.hide
			end
		end
	
	set_widget_tabs is
			-- Sets the widget tabs
		do
			create tab_list.make
			tab_list.extend(widget_tab)
		end
	set_container_tabs is
			-- Sets the container tabs
		do
			set_widget_tabs
			tab_list.extend(container_tab)
		end

	set_primitive_tabs is
			-- Sets the primitive tabs
		do
			set_widget_tabs
			tab_list.extend(primitive_tab)
		end
		
	set_gauge_tabs is
			-- Sets the gauge tabs
		do
			set_primitive_tabs
			tab_list.extend(gauge_tab)
		end

	tab_list:LINKED_LIST[ANY_TAB]

	action_window:ACTION_WINDOW

	widget_tab:WIDGET_TAB IS
			-- Creation of the widget_tab.
			-- Only done once.
		once
			 create Result.make (Void)
		end

	container_tab:CONTAINER_TAB is
			-- Creation of the box_tab.
			-- Only done once.
		once
			create Result.make (Void)
		end

	box_tab:BOX_TAB is
			-- Creation of the box_tab.
			-- Only done once.
		once
			create Result.make (Void)
		end

	table_tab:TABLE_TAB is
			-- Creation of the table_tab.
			-- Only done once.
		once
			create Result.make (Void)
		end

	scrollable_area_tab: SCROLLABLE_AREA_TAB is
			-- Creation of the scrollable_area_tab.
			-- Only done once.
		once
			create Result.make (Void)
		end

	notebook_tab: NOTEBOOK_TAB is
			-- Creation of the notebook_tab.
			-- Only done once.
		once
			create Result.make (Void)
		end

	dyntable_tab: DYNTABLE_TAB is
			-- Creation of the dynamic_table_tab.
		once
			create Result.make (Void)
		end

	window_tab: WINDOW_TAB is
			-- Creation of the window_tab.
		once
			create Result.make (Void)
		end

	split_area_tab: SPLIT_AREA_TAB is
			-- Creation of the split area tab.
		once
			create Result.make (Void)
		end

	primitive_tab: PRIMITIVE_TAB is
			-- Creation of the primitive tab.
		once
			create Result.make (Void)
		end



	gauge_tab: GAUGE_TAB is
			-- Creation of the gauge tab.
		once
			create Result.make (Void)
		end

	scroll_bar_tab: SCROLL_BAR_TAB is
			-- Creation of the scroll bar tab.
		once
			create Result.make (Void)
		end
	
	range_tab: RANGE_TAB is
			-- Creation of the range tab.
		once
			create Result.make (Void)
		end

	spin_button_tab: SPIN_BUTTON_TAB is
			-- Creation of the spin button tab.
		once
			create Result.make (Void)
		end

	progress_tab: PROGRESS_TAB is
			-- Creation of the progress tab.
		once
			create Result.make (Void)
		end

	combo_tab: COMBO_TAB is
			-- Creation of the combo box tab
		once
			create Result.make (Void)
		end

	textable_tab: TEXTABLE_TAB is
			-- Creation of the textable tab.
		once
			create Result.make (Void)
		end

	fontable_tab: FONTABLE_TAB is
			-- Creation of the fontable tab.
		once
			create Result.make (Void)
		end

	pixmapable_tab: PIXMAPABLE_TAB is
			-- Creation of the pixmapable_tab.
		once
			create Result.make (Void)
		end

	toggle_button_tab: TOGGLE_BUTTON_TAB is
			-- Creation of the toggle_button_tab.
		once
			create Result.make (Void)
		end

	check_button_tab: CHECK_BUTTON_TAB is
			-- Creation of the check_button_tab.
		once
			create Result.make (Void)
		end

	radio_button_tab: RADIO_BUTTON_TAB is
			-- Creation of the radio_button_tab.
		once
			create Result.make (Void)
		end

	rich_tab: RICH_TAB is
			-- Creation of the rich text tab
		once
			create Result.make (Void)
		end

	option_tab: OPTION_TAB is
			-- Creation of the option _tab.
		once
			create Result.make (Void)
		end

	multi_column_list_tab: MULTI_COLUMN_LIST_TAB is
			-- Creation of the multi_column_list_tab.
		once
			create Result.make (Void)
		end

	text_field_tab: TEXT_FIELD_TAB is
			-- Creation of the text_field_tab.
		once
			create Result.make (Void)
		end

	text_component_tab: TEXT_COMPONENT_TAB is
			-- Creation of the text_component_tab.
		once
			create Result.make (Void)
		end


	text_tab: TEXT_TAB is
			-- Creation of the text_tab.
		once
			create Result.make (Void)
		end
	
	list_tab: LIST_TAB is
			-- Creation of the list tab.
		once
			create Result.make (Void)
		end

	tree_tab: TREE_TAB is
			-- Creation of the tree tab.
		once
			create Result.make (Void)
		end




feature -- Deferred features

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		deferred
		end

		
end -- class DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
