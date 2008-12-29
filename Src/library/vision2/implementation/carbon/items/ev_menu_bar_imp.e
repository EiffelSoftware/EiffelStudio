note
	description: "Eiffel Vision menu bar. Carbon implementation."

class
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			insert_menu_item
		end

	CFSTRING_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	MENUS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end


create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN = False

	make (an_interface: like interface)
		do
			base_make (an_interface)
			set_c_object ($current)
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
		end
		
feature {EV_WINDOW_IMP} -- Implementation

	set_parent_window_imp (a_wind: EV_WINDOW_IMP)
			-- Set `parent_window' to `a_wind'.
		require
			a_wind_not_void: a_wind /= Void
		do
			parent_imp := a_wind
		end

	parent: EV_WINDOW
			-- Parent window of Current.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end
		end

	remove_parent_window
			-- Set `parent_window' to Void.
		do
			parent_imp := Void
		end

	parent_imp: EV_WINDOW_IMP

feature {NONE} -- Implementation

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER)
			-- Generic menu item insertion.
		local
			ptr: POINTER
		do
			an_item_imp.set_item_parent_imp (Current)

			ptr := an_item_imp.c_object
			insert_menu_external (ptr, 0)

			child_array.go_i_th (pos)
			child_array.put_left (an_item_imp.interface)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR;

note
	copyright:	"Copyright (c) 2006, the ETH Eiffel.Mac Team"

end -- class EV_MENU_BAR_IMP

