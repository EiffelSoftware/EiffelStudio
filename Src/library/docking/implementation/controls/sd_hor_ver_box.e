indexing
	description: "Objects that wrapper EV_HORIZONTAL_BOX and EV_VERTICAL_BOX. Actually this is EV_VERTICAL_BOX contain a EV_HORIZONTAL_BOX."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOR_VER_BOX
	
inherit
	EV_VERTICAL_BOX
		rename
			extend as extend_vertical_box,
			disable_item_expand as disable_item_expand_vertical_box,
			prune as prune_vertical_box,
			start as start_vertical_box,
			after as after_vertical_box,
			forth as forth_vertical_box,
			item as item_vertical_box,
			count as count_vertical_box,
			has as has_vertical_box,
			search as search_vertical_box,
			pointer_enter_actions as pointer_enter_actions_vertical_box,
			wipe_out as wipe_out_vertical_box
		end

feature {NONE} -- Initlization

	init (a_vertical_style: BOOLEAN)is
			-- Creation method.
		do
			internal_vertical_style := a_vertical_style
			if not internal_vertical_style then
				create horizontal_box
			end			
			default_create
			if not internal_vertical_style then
				init_horizontal_style
			end
			create pointer_enter_actions.default_create
		end
	
	init_horizontal_style is
			-- 
		do
				-- First change the style, so the horizontal_box can be added in.
				internal_vertical_style := not internal_vertical_style
				extend (horizontal_box)
				-- Then change the style back.
				internal_vertical_style := not internal_vertical_style			
		end
		
	
feature {NONE} -- Implementation

	internal_vertical_style: BOOLEAN
			-- If current box show vertically? Otherwise is show horizontally.
	
	horizontal_box: EV_HORIZONTAL_BOX
			-- The horizontal box in the Current when show horizontally.


feature -- Basic operations
	
	change_direction is	
			-- Change `interal_direction', then change all items layout.
		local
			l_items: ARRAYED_LIST [EV_WIDGET]
		do
			create l_items.make (0)
			from
				start
			until
				after
			loop
				l_items.extend (item)
				forth
			end
			
			internal_vertical_style := not internal_vertical_style
			
			wipe_out
			
			if not internal_vertical_style then
				init_horizontal_style					
			end
			
			from 
				l_items.start
			until
				l_items.after
			loop
				extend (l_items.item)
				l_items.forth
			end
		end
		
feature

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE

feature -- Redefine

	extend (v: like item) is
			-- Extend the item base on the direction.
		do
			if internal_vertical_style then
				extend_vertical_box (v)
			else
				horizontal_box.extend (v)
			end
		end
		
	prune (v: like item) is
			-- Prune the item base on the direction.
		do
			if internal_vertical_style then
				prune_vertical_box (v)
			else
				horizontal_box.prune (v)
			end
		end
		
	start is
			-- 
		do
			if internal_vertical_style then
				start_vertical_box
			else
				horizontal_box.start
			end
		end
	
	
	after: BOOLEAN is
			-- 
		do
			if internal_vertical_style then
				Result := after_vertical_box
			else
				Result := horizontal_box.after
			end
		end
	
	forth is
			-- 
		do
			if internal_vertical_style then
				forth_vertical_box
			else
				horizontal_box.forth
			end
		end
	
	item: EV_WIDGET is
			-- 
		do
			if internal_vertical_style then
				Result := item_vertical_box
			else
				Result := horizontal_box.item
			end
		end
		
	count: INTEGER is
			-- 
		do
			if internal_vertical_style then
				Result := count_vertical_box
			else
				Result := horizontal_box.count
			end
		end
	
	disable_item_expand (an_item: EV_WIDGET) is
			-- 
		do
			if internal_vertical_style then
				disable_item_expand_vertical_box (an_item)
			else
				horizontal_box.disable_item_expand (an_item)
			end
		end
	
	has (v: like item): BOOLEAN is
			-- 
		do
			if internal_vertical_style then
				Result := has_vertical_box (v)
			else
				Result := horizontal_box.has (v)
			end			
		end
		
	search (v: like item) is
			-- 
		do
			if internal_vertical_style then
				search_vertical_box (v)
			else
				horizontal_box.search (v)
			end				
		end
	
	wipe_out is
			-- 
		do
			if internal_vertical_style then
				wipe_out_vertical_box
			else
				horizontal_box.wipe_out
			end
		end
		
end
