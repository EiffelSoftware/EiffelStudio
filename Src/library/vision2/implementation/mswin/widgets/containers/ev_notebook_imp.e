indexing
	description: 
		"EiffelVision notebook, Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK_IMP
	
inherit
	EV_NOTEBOOK_I

	EV_CONTAINER_IMP
		redefine
			add_child,
			child_minheight_changed,
			child_height_changed
		end

	EV_FONTABLE_IMP

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy
		undefine
			remove_command,
			set_width,
			set_height,
--			destroy,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		redefine
			default_style
		end

creation
	make
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a fixed widget with, `par' as
			-- parent
		local
			comctrl: WEL_COMMON_CONTROLS_DLL
			wel_imp: WEL_WINDOW
		do
			!! comctrl.make
			wel_imp ?= par.implementation
			check
				parent_not_void: wel_imp /= Void
			end
			wel_make (wel_imp, 0, 0, 0, 0, 0)
			set_minimum_height (tab_height)
			set_font (font)
		end

feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		do
		end
	
feature -- Element change
	
	append_page (child_imp: EV_WIDGET_I; label: STRING) is
		-- Add a new page for notebook containing 'child_imp' with tab 
		-- label `label'.
		local
			wel_item: WEL_TAB_CONTROL_ITEM
			widget_imp: WEL_WINDOW
		do
			widget_imp ?= child_imp
			!! wel_item.make
			wel_item.set_text (label)
			wel_item.set_window (widget_imp)
			insert_item (count, wel_item)
		end

feature -- Implementation

	add_child (child_imp: EV_WIDGET_I) is
			-- Add child into composite. In this container, `child' is the
			-- child of the container whose page is currently selected.
		do
			child ?= child_imp
--			child.set_y (tab_height)
--			ev_children.extend (child)
		end

feature {EV_WIDGET_IMP} -- Implementation

	child_height_changed (new_child_height: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the size of the container because of the child.
		do
			set_height (new_child_height + tab_height)
		end

	child_minheight_changed (new_child_minimum: INTEGER) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
			-- By default, the minimum width of a container is
			-- the one of its child, to change this, just use
			-- set_minimum_width
		do
			set_minimum_height (new_child_minimum + tab_height)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := {WEL_TAB_CONTROL} Precursor + Ws_clipchildren
					+ Ws_clipsiblings
		end

	tab_height: INTEGER is
			-- The height of the bar with the pages.
		do
			Result := wel_font.log_font.height + 8
		end

end -- EV_NOTEBOOK_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
