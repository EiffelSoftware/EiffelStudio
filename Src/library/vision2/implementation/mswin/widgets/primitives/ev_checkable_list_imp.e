indexing
	description: "Eiffel Vision checkable list. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_LIST_IMP
	
inherit
	EV_CHECKABLE_LIST_I
		undefine
			wipe_out,
			selected_items
		redefine
			interface
		end
	
	EV_LIST_IMP
		redefine
			interface,
			default_ex_style,
			on_lvn_itemchanged,
			insert_i_th--,
			--on_erase_background
		end
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP
	
create
	make

feature -- Status report

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN is
			-- is `list_item' checked?
		local
			item_imp: EV_LIST_ITEM_IMP
			i: INTEGER
		do
			item_imp ?= list_item.implementation
			i := ev_children.index_of (item_imp, 1) - 1
			Result := cwin_listview_getcheckstate (wel_item, i)
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			i: INTEGER
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation
			i := ev_children.index_of (item_imp, 1) - 1
			cwin_listview_setcheckstate (wel_item, i, True)
	
		end

	uncheck_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			i: INTEGER
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= list_item.implementation
			i := ev_children.index_of (item_imp, 1) - 1
			cwin_listview_setcheckstate (wel_item, i, False)
		end

feature {NONE} -- Implementation

--	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
--			--
--		do
--			-- Do nothing here.
--			-- To reduce flickering, call `disable_default_processing' and
--			-- redraw only the parts that need redrawing.
--		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
			-- Redefined from EV_LIST_IMP to prevent `uncheck_actions'
			-- frombeing fired when an item is inserted to `Current'.
		do
			if uncheck_actions_internal /= Void then
				uncheck_actions_internal.block
			end
			Precursor {EV_LIST_IMP} (v, i)
			if uncheck_actions_internal /= Void then
				uncheck_actions_internal.resume
			end
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed.
		local
			item_imp: EV_LIST_ITEM_IMP
			item_interface: EV_LIST_ITEM
		do
			if info.uchanged = Lvif_state and info.isubitem = 0 then
				if (info.unewstate - info.uoldstate).abs = 4096 then
					item_imp := ev_children @ (info.iitem + 1)
					item_interface := item_imp.interface
					if flag_set (info.unewstate, 4096) then
						if uncheck_actions_internal /= Void then
							uncheck_actions_internal.call ([item_interface])
						end
					else
						if check_actions_internal /= Void then
							check_actions_internal.call ([item_interface])
						end	
					end
				else
					Precursor {EV_LIST_IMP} (info)
				end
			end
		end

	cwin_listview_setcheckstate (hwnd: POINTER; iindex: INTEGER; fcheck: BOOLEAN) is
			-- Code below is inlined as old version of C compilers do not define
			-- ListView_SetCheckState although they define ListView_GetCheckState.
		external
			"C inline use <commctrl.h>"
		alias
			"ListView_SetItemState($hwnd, $iindex, INDEXTOSTATEIMAGEMASK(($fcheck)?2:1), LVIS_STATEIMAGEMASK)"
		end
		
	cwin_listview_getcheckstate (hwnd: POINTER; iindex: INTEGER): BOOLEAN is
			--
		external
			"C macro signature (HWND, UINT): EIF_BOOLEAN use <commctrl.h>"
		alias
			"ListView_GetCheckState"
		end

	default_ex_style: INTEGER is
			-- Default extended style for `Current'.
		once
			Result := Precursor {EV_LIST_IMP} + Lvs_ex_checkboxes
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST;
	
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




end -- class EV_CHECKABLE_LIST_IMP

