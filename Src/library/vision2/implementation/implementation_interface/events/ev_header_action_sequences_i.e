indexing
	description:
		"Action sequences for EV_HEADER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end

