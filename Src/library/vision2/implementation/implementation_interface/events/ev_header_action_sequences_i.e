indexing
	description:
		"Action sequences for EV_HEADER_I."
	date: "$date"
	revision: "$revision"

deferred class
	 EV_HEADER_ACTION_SEQUENCES_I
	 
feature -- Access

	item_resize_start_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when resizing begins on a header item.
		do
			if item_resize_start_actions_internal = Void then
				item_resize_start_actions_internal := create_item_resize_start_actions
			end
			Result := item_resize_start_actions_internal
		ensure
			not_void: Result /= Void
		end
		
	item_resize_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed as a header item is resized.
		do
			if item_resize_actions_internal = Void then
				item_resize_actions_internal := create_item_resize_actions
			end
			Result := item_resize_actions_internal
		ensure
			not_void: Result /= Void
		end
	
	item_resize_end_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when resizing completes on a header item.
		do
			if item_resize_end_actions_internal = Void then
				item_resize_end_actions_internal := create_item_resize_end_actions
			end
			Result := item_resize_end_actions_internal
		ensure
			not_void: Result /= Void
		end
		
feature {EV_ANY_I} -- Implementation

	item_resize_actions_internal: EV_HEADER_ITEM_ACTION_SEQUENCE
		-- Implementation of once per object `item_resize_actions_internal'.
		
	item_resize_start_actions_internal: EV_HEADER_ITEM_ACTION_SEQUENCE
		-- Implementation of once per object `item_resize_start_actions_internal'.
		
	item_resize_end_actions_internal: EV_HEADER_ITEM_ACTION_SEQUENCE
		-- Implementation of once per object `item_resize_end_actions_internal'.
		
	create_item_resize_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Create an item resize actions.
		deferred
		end
		
	create_item_resize_start_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Create an item resize start actions.
		deferred
		end
		
	create_item_resize_end_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Create an item resize end actions.
		deferred
		end
		
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
