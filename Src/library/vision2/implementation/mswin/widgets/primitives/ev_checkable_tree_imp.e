indexing
	description:
		"[
			A tree which displays a check box to left
			hand side of each item contained. MsWindows implementation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE_IMP
	
inherit
	EV_CHECKABLE_TREE_I
		undefine
			initialize
		redefine
			interface
		end
		
	EV_TREE_IMP
		redefine
			interface,
			make,
			process_message,
			on_left_button_down
		end
	
	EV_CHECKABLE_TREE_ACTION_SEQUENCES_IMP
		
create
	make
	
feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			Precursor {EV_TREE_IMP} (an_interface)
				-- We explicitly set the check boxes style after creation
				-- of the window and before items are populated as per the
				-- MSDN guildines regarding TVS_CHECKBOXES style.
			set_style (default_style + tvs_checkboxes)
		end
		
feature -- Status report

	is_item_checked (tree_item: EV_TREE_NODE): BOOLEAN is
			-- is `tree_item' checked?
		local
			item_imp: EV_TREE_NODE_IMP
			original_mask: INTEGER
			original_state_mask: INTEGER
		do
			item_imp ?= tree_item.implementation
			original_mask := item_imp.mask
			original_state_mask := item_imp.state_mask
			item_imp.set_mask (tvif_state)
			Result := flag_set (item_imp.state, cwin_index_to_state_image_mask (2))
			item_imp.set_mask (original_mask)
			item_imp.set_statemask (original_state_mask)
		end

feature -- Status setting

	check_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		local
			item_imp: EV_TREE_NODE_IMP
			original_mask: INTEGER
			original_state_mask: INTEGER
		do
			item_imp ?= tree_item.implementation
			original_mask := item_imp.mask
			original_state_mask := item_imp.state_mask
			item_imp.set_mask (tvif_state)
			item_imp.set_statemask (tvis_stateimagemask)
			item_imp.set_state (cwin_index_to_state_image_mask (2))
			original_mask := item_imp.state
			set_tree_item (item_imp)		
			item_imp.set_mask (original_mask)
			item_imp.set_statemask (original_state_mask)
				-- Call the check actions if connected.
			if check_actions_internal /= Void then
				check_actions_internal.call ([tree_item])
			end
		end

	uncheck_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		local
			item_imp: EV_TREE_NODE_IMP
			original_mask: INTEGER
			original_state_mask: INTEGER
		do
			item_imp ?= tree_item.implementation
			original_mask := item_imp.mask
			original_state_mask := item_imp.state_mask
			item_imp.set_mask (tvif_state)
			item_imp.set_statemask (tvis_stateimagemask)
			item_imp.set_state (cwin_index_to_state_image_mask (1))
			set_tree_item (item_imp)
			item_imp.set_mask (original_mask)
			item_imp.set_statemask (original_state_mask)
				-- Call the uncheck actions if connected.
			if uncheck_actions_internal /= Void then
				uncheck_actions_internal.call ([tree_item])
			end
		end

feature {EV_ANY_I} -- Implementation

	on_nm_click is
			-- Nm_click has been received from Windows. Update checked state of
			-- pointed check box if any.
		local
			pt: WEL_POINT
			info: WEL_TV_HITTESTINFO
			message_pos: INTEGER
			tree_node: EV_TREE_NODE_IMP
		do
			message_pos := cwel_get_message_pos
			
				-- We use the original position for the press for determining the
				-- point to respond to,
			create pt.make (click_original_x_pos, click_original_y_pos)
			create info.make_with_point (pt)
				-- Send a Tvm_hittest message to determine the pointed node.
			cwin_send_message (wel_item, Tvm_hittest, to_wparam (0), info.item)
				-- Check if the click was performed on the check box state icon.
			if info.flags.is_equal (tvht_onitemstateicon) then
					-- Retreive the tree item that was clicked.
				tree_node ?= (all_ev_children @ info.hitem)
					-- Post a custom message, `Um_checkable_tree_state_change' in order to respond to the
					-- state change at the correct point in the processing. See Microsoft KB entry 261289. 
				cwin_post_message (wel_item, Um_checkable_tree_state_change, info.hitem, to_lparam(0))
			end
		end
		
feature {NONE} -- Implementation

	on_left_button_down (keys: INTEGER; x_pos: INTEGER; y_pos: INTEGER) is
			-- Executed when the left button is pressed. Store `x_pos' and `y_pos'
			-- into `click_original_x_pos' and `click_original_y_pos'.
		do
			click_original_x_pos := x_pos
			click_original_y_pos := y_pos
		end
	
	click_original_x_pos, click_original_y_pos: INTEGER
		-- Position of mouse pointer in relation to `Current' when
		-- left button is pressed. Pressing the left button signifies the
		-- start of a check box selection via `on_nm_click' if the mouse pointer
		-- does not move more than a few pixels. We must store the original position,
		-- as this is the item whose state changes, even if the pointer is moved a few pixels
		-- over the next item before releasing the mouse button. Without doing this, it is
		-- not possible to correctly respond to the check box states.
		
	process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER is
			-- Process all message plus `WM_GETDLGCODE'.
		local
			tree_node: EV_TREE_NODE_IMP
		do
				-- Check to see if we are receiving the user defined message that
				-- we sent within `on_wm_click'. If so, process the state change.
			if msg = um_checkable_tree_state_change then
					-- Retrieve the tree node whose checkable state has changed.
				tree_node ?= (all_ev_children @ wparam)
					-- Determine if the node is being checked or unchecked (reversed as we are about to set it explicitly).
				if is_item_checked (tree_node.interface) then
					tree_node.set_mask (tree_node.mask | tvif_state)
					tree_node.set_statemask (tvis_stateimagemask)
					tree_node.set_state (cwin_index_to_state_image_mask (1))
						-- Call the uncheck actions if connected.
					if uncheck_actions_internal /= Void then
						uncheck_actions_internal.call ([tree_node.interface])
					end
				else
					tree_node.set_mask (tree_node.mask | tvif_state)
					tree_node.set_statemask (tvis_stateimagemask)
					tree_node.set_state (cwin_index_to_state_image_mask (2))
						-- Call the uncheck actions if connected.
					if check_actions_internal /= Void then
						check_actions_internal.call ([tree_node.interface])
					end
				end
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end		
		
	um_checkable_tree_state_change: INTEGER is
			-- User defined message constant we send to windows for processing
			-- when a state icon is clicked in `Current'.
		once
			Result := wm_user + 1
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_TREE;

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




end -- class EV_CHECKABLE_TREE_IMP
