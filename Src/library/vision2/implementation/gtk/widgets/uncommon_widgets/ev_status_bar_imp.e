indexing
	description: "Eiffel Vision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_IMP

inherit
	EV_STATUS_BAR_I
		redefine
			parent_imp
		end

	EV_PRIMITIVE_IMP
		rename
			make as wrong_make
		redefine
			parent_imp,
			set_foreground_color,
			set_background_color
		end

creation
	make

feature {NONE}-- Initialization

	make (par: EV_WINDOW) is
			-- Create a horizontal box in which we will put
			-- the different status bar, with `par' as parent.
			-- Create a gtk status bar, with the horizontal box as parent
		local
			statusbar_widget: POINTER
		do
			widget := gtk_hbox_new (False, 0)
				-- create the horizontal box with a spacing of 2:

			parent_imp ?= par.implementation
			check
				good_implementation: parent_imp /= Void
			end
			show
			parent_imp.add_status_bar (Current)
				-- add the status bar to the parent, which is a EV_WINDOW

			create ev_children.make
				-- create the array, where the status_bar_items will be listed
		end

feature -- Access

	parent_imp: EV_WINDOW_IMP

	ev_children: LINKED_LIST [EV_STATUS_BAR_ITEM_IMP]
		-- list of status bar contained in the horizontal box

	count: INTEGER is
		do
			Result := ev_children.count
		end

feature -- Element change

	add_status_bar_item (stat_bar: EV_STATUS_BAR_ITEM_IMP) is
		do
			gtk_box_pack_start ( widget, stat_bar.widget, False, False, 0)
			stat_bar.set_width (-1)
				-- Tell the item to expand.
			if (ev_children.count > 0) then
				-- if there were already items in the status
				-- bar, tell the last item not to expand
				-- anylonger.
				ev_children.last.set_width (120)
			end
			ev_children.extend (stat_bar)
		end

	remove_status_bar_item (stat_bar: EV_STATUS_BAR_ITEM_IMP) is
		do
			gtk_container_remove ( widget, stat_bar.widget)
			ev_children.search (stat_bar)
			if (ev_children.index = count) then
				-- See if it is the last status item.
				-- If so, set the width of the new last
				-- status item to expand.
				ev_children.remove
				ev_children.last.set_width (-1)
			else
				ev_children.remove
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		local
			array: LINKED_LIST [EV_STATUS_BAR_ITEM_IMP]
			child: EV_STATUS_BAR_ITEM_IMP
		do
			c_gtk_widget_set_bg_color (widget, color.red, color.green, color.blue)

			from
				array := ev_children
				array.start
			until
				array.after
			loop
				child := array.item
				child.set_background_color (color)
				array.forth
			end
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		local
			array: LINKED_LIST [EV_STATUS_BAR_ITEM_IMP]
			child: EV_STATUS_BAR_ITEM_IMP
		do
			c_gtk_widget_set_fg_color (widget, color.red, color.green, color.blue)

			from
				array := ev_children
				array.start
			until
				array.after
			loop
				child := array.item
				child.set_foreground_color (color)
				array.forth
			end
		end

end -- class EV_STATUS_BAR_IMP
