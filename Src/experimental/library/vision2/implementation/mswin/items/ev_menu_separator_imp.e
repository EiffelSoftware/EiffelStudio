note
	description:
		"Eiffel Vision menu separator. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
--			initialize,
			interface,
			desired_height,
			on_measure_item,
			on_draw_item
		end

	EV_SYSTEM_PEN_IMP
		export
			{NONE} all
		end

create
	make

--feature {NONE} -- Initialization

--	initialize
--		do
--			Precursor
--			is_sensitive := False
--		end

feature {EV_MENU_ITEM_LIST_IMP} -- Access

	radio_group: detachable LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radio items following this separator.

	create_radio_group
			-- Create `radio_group'.
		require
			radio_group_void: radio_group = Void
		do
			create radio_group.make
		ensure
			radio_group_not_void: radio_group /= Void
		end

	set_radio_group (a_list: detachable like radio_group)
			-- Assign `a_list' to `radio_group'.
		require
			a_list_not_void: a_list /= Void
		do
			radio_group := a_list
		ensure
			assigned: radio_group = a_list
		end

	remove_radio_group
			-- Set `radio_group' to `Void'.
		do
			radio_group := Void
		ensure
			radio_group_void: radio_group = Void
		end

feature -- WEL Implementation

	on_draw_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Process `Wm_drawitem' message.
		local
			draw_dc: WEL_CLIENT_DC
			draw_item_struct_rect: WEL_RECT
			background_color: WEL_COLOR_REF
			cur_height_div_two: INTEGER
			r: WEL_RECT
			pen: WEL_PEN
			item_width: INTEGER
			item_height: INTEGER
			item_top: INTEGER
			item_left: INTEGER
			item_right: INTEGER
			item_bottom: INTEGER
		do
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			item_width := draw_item_struct_rect.width
			item_height := draw_item_struct_rect.height
			item_top := draw_item_struct_rect.top
			item_left := draw_item_struct_rect.left
			item_right := draw_item_struct_rect.right
			item_bottom := draw_item_struct_rect.bottom

			cur_height_div_two := item_height // 2

			create background_color.make_system (Wel_color_constants.Color_menu)
			if cur_height_div_two > 1 then
					-- We need to draw a background.
				create r.make (item_left, item_top, item_right, item_top + cur_height_div_two - 1)
				erase_background (draw_dc, r, background_color)
			end

			pen := shadow_pen
			draw_dc.select_pen (pen)
			draw_dc.line (item_left, item_top + cur_height_div_two - 1, item_right, item_top + cur_height_div_two - 1)
			draw_dc.unselect_pen
			pen.delete

			pen := highlight_pen
			draw_dc.select_pen (pen)
			draw_dc.line (item_left, item_top + cur_height_div_two, item_right, item_top + cur_height_div_two)
			draw_dc.unselect_pen
			pen.delete

				-- We need to draw a background.
			if cur_height_div_two < item_height then
				create r.make (item_left, item_top + cur_height_div_two + 1, item_right, item_bottom)
				erase_background (draw_dc, r, background_color)
			end
		end

	on_measure_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT)
			-- Process `Wm_measureitem' message.
		do
			measure_item_struct.set_item_width (0)
			measure_item_struct.set_item_height (desired_height)
		end

feature {EV_ANY_I} -- Implementation

	desired_height: INTEGER
			-- Desired height.
		do
			Result := (menu_font.string_height ("W") // 2) + 2
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_SEPARATOR_IMP











