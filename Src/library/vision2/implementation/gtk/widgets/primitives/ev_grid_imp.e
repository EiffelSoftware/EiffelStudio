indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		GTK implementation.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_IMP
	
inherit

	EV_GRID_I
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface,
			initialize
		end

	EV_CELL_IMP
		rename
			item as cell_item
		undefine
			drop_actions,
			has_focus,
			set_focus
		redefine
			interface,
			initialize,
			make,
			needs_event_box,
			set_background_color,
			set_foreground_color
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create grid
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
		end

	initialize is
			-- Initialize `Current'
		do
			Precursor {EV_CELL_IMP}
			initialize_grid
			set_focused_selection_color (create {EV_COLOR}.make_with_8_bit_rgb (83, 85, 161))
			set_non_focused_selection_color (create {EV_COLOR}.make_with_8_bit_rgb (160, 189, 238))
			set_is_initialized (True)
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

	set_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `focused_selection_color'.
		do
			focused_selection_color := a_color
		end
		
	set_non_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `non_focused_selection_color'.
		do
			non_focused_selection_color := a_color
		end

feature {EV_GRID_ITEM_I} -- Implementation

	focused_selection_color: EV_COLOR
			-- Color used for selected items while focused.

	focused_selection_text_color: EV_COLOR is
			-- Color used for text of selected items while focused.
		once
			create Result.make_with_8_bit_rgb (239, 251, 254)
		end

	non_focused_selection_color: EV_COLOR
			-- Color used for selected items while not focused.

	non_focused_selection_text_color: EV_COLOR is
			-- Color used for text of selected items while not focused.
		once
			create Result.make_with_8_bit_rgb (196, 236, 253)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
