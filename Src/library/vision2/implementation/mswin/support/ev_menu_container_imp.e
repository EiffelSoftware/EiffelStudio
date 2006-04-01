indexing
	description:
		"Eiffel Vision menu container. Abstract notion of a container for menu."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_CONTAINER_IMP

inherit
	ANY

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	process_menu_message (msg: INTEGER; wparam, lparam: POINTER): BOOLEAN is
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
			if msg = ({WEL_WINDOW_CONSTANTS}.Wm_drawitem) then
				create draw_item_struct.make_by_pointer (lparam)
				on_draw_item (wparam, draw_item_struct)
				Result := True
			elseif msg = ({WEL_WINDOW_CONSTANTS}.Wm_measureitem) then
				create measure_item_struct.make_by_pointer (lparam)
				on_measure_item (wparam, measure_item_struct)
				Result := True
			elseif msg = ({WEL_WINDOW_CONSTANTS}.Wm_menuchar) then
				if (cwin_hi_word (wparam) /= {WEL_MF_CONSTANTS}.Mf_sysmenu) then
					char_code := cwin_lo_word(wparam).to_character_8
					create corresponding_menu.make_by_pointer (lparam)
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

	on_measure_item (control_id: POINTER; measure_item: WEL_MEASURE_ITEM_STRUCT) is
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
			if item_type = ({WEL_ODT_CONSTANTS}.Odt_menu) then
				menu_item_imp ?= eif_id_any_object (measure_item.item_data.to_integer_32)
				if menu_item_imp /= Void then
					menu_item_imp.on_measure_item (measure_item)
				end
			end
		end

	on_draw_item (control_id: POINTER; draw_item: WEL_DRAW_ITEM_STRUCT) is
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
			if item_type = ({WEL_ODT_CONSTANTS}.Odt_menu) then
				menu_item_imp ?= eif_id_any_object (draw_item.item_data.to_integer_32)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_CONTAINER_IMP

