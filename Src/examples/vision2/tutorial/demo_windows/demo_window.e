indexing
	description:
		"Demo window, ancestor of all the window of%
		% demonstration";
	date: "$Date$";
	revision: "$Revision$"
class
	DEMO_WINDOW

feature -- 

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
