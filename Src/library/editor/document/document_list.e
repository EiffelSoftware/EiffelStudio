indexing
	description	: "Abstract List of Item for DOCUMENT_ITEM"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	DOCUMENT_LIST [G -> DOCUMENT_ITEM]

inherit
	ARRAYED_LIST [G]
		redefine
			remove,
			extend
		end

feature -- List operations

	remove is
			-- Remove current item.
			-- Move cursor to previously focused item.
		local
			removed_item: like item
		do
			removed_item := item
			Precursor
			on_item_removed (removed_item)			
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			Precursor (v)
			on_item_added (v)				
		end

feature -- Basic Operations

	enable_duplicates is
			-- Enable to contain duplicate items
		do
			duplicates_enabled := True
		end
	
	disable_duplicates is
			-- Enable to contain duplicate items
		do
			duplicates_enabled := False
		end	

feature -- Query

	duplicates_enabled: BOOLEAN
			-- Can contain identical items?

	contains_name (a_name: STRING): BOOLEAN is
			-- Does Current contains an item with name `a_name'.
			-- The name comparison is not case-sensitive.			
		local
			item_name: STRING
			curr_name: STRING
		do
			curr_name := a_name.as_lower
			from
				start
			until
				after or Result
			loop
				item_name := item.name.as_lower
				Result := item_name.is_equal (curr_name)
				forth
			end
		end
		
feature -- Observer Pattern

	add_observer (a_observer: DOCUMENT_OBSERVER) is
		do
			observer_list.extend (a_observer)
		end

	remove_observer (a_observer: DOCUMENT_OBSERVER) is
		do
			observer_list.start
			observer_list.prune_all (a_observer)
		end

	on_item_added (a_item: DOCUMENT_ITEM) is
			-- `a_item' has been added.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_item_added (a_item)
				observer_list.forth
			end
		end

	on_item_removed (a_item: DOCUMENT_ITEM) is
			-- `a_item' has been removed.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_item_removed (a_item)
				observer_list.forth
			end
		end

	on_update is
			-- The favorites have changed. Recompute the observers.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_update
				observer_list.forth
			end
		end
		
feature {NONE} -- Attributes

	in_operation: BOOLEAN
			-- Are we in the middle of a list operation (put, extend, remove, ...)?
			
	observer_list: ARRAYED_LIST [DOCUMENT_OBSERVER] is
			-- 
		once
			create Result.make (1)
		end	
		
	previous_item: like item;
			-- Previously focused item

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




end -- class DOCUMENT_LIST
