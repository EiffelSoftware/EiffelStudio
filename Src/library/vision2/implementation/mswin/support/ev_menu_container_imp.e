indexing
	description:
		"Eiffel Vision menu container. Abstract notion of a container for menu."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_CONTAINER_IMP
	
inherit
	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	process_menu_message (msg, wparam, lparam: INTEGER): BOOLEAN is
			-- Process `msg' which has not been processed by
			-- `process_message' concerning menus.
			--
			-- Return `True' if the message has been processed, `False' otherwise.
		local
			draw_item_struct: WEL_DRAW_ITEM_STRUCT
			measure_item_struct: WEL_MEASURE_ITEM_STRUCT
			corresponding_menu: WEL_MENU
			char_code: CHARACTER
		do
			if msg = (feature {WEL_WINDOW_CONSTANTS}.Wm_drawitem) then
				create draw_item_struct.make_by_pointer (integer_to_pointer (lparam))
				on_draw_item (wparam, draw_item_struct)
				Result := True
			elseif msg = (feature {WEL_WINDOW_CONSTANTS}.Wm_measureitem) then
				create measure_item_struct.make_by_pointer (integer_to_pointer (lparam))
				on_measure_item (wparam, measure_item_struct)
				Result := True
			elseif msg = (feature {WEL_WINDOW_CONSTANTS}.Wm_menuchar) then
				if (wparam & 0xFFFF0000) |>> 16 /= (feature {WEL_MF_CONSTANTS}.Mf_sysmenu) then
					char_code := chconv (wparam & 0x0000FFFF)
					create corresponding_menu.make_by_pointer (integer_to_pointer (lparam))
					on_menu_char (char_code, corresponding_menu)
				end
				Result := True
			end
		end

feature {NONE} -- WEL Implementation

	on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU) is
			-- The menu char `char_code' has been typed within `corresponding_menu'.
		deferred
		end

	on_measure_item (control_id: INTEGER; measure_item: WEL_MEASURE_ITEM_STRUCT) is
			-- Handle Wm_measureitem messages.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `measure_item' contains
			-- information that the control must fill.
		require
			measure_item_valid: measure_item /= Void
		local
			menu_item_imp: EV_MENU_ITEM_IMP
			item_type: INTEGER
		do
			item_type := measure_item.ctl_type
			if item_type = (feature {WEL_ODT_CONSTANTS}.Odt_menu) then
				menu_item_imp ?= eif_id_object (measure_item.item_data)
				if menu_item_imp /= Void then
					menu_item_imp.on_measure_item (measure_item)
				end
			end
		end

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Handle Wm_drawitem messages.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		require
			draw_item_valid: draw_item /= Void
		local
			item_type: INTEGER
			menu_item_imp: EV_MENU_ITEM_IMP
		do
			item_type := draw_item.ctl_type
			if item_type = (feature {WEL_ODT_CONSTANTS}.Odt_menu) then
				menu_item_imp ?= eif_id_object (draw_item.item_data)
				if menu_item_imp /= Void then
					menu_item_imp.on_draw_item (draw_item)
				end
			end
		end

feature {NONE} -- Externals

	integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		alias
			"cwel_integer_to_pointer"
		end

	chconv (i: INTEGER): CHARACTER is
			-- Character associated with integer value `i'
		external
			"C [macro %"eif_misc.h%"]"
		end

end -- class EV_MENU_CONTAINER_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

