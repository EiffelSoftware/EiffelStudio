indexing
	description: "A GB_OBJECT representing an EV_SPLIT_AREA"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SPLIT_AREA_OBJECT

inherit
	GB_CONTAINER_OBJECT
		redefine
			object,
			add_child_object,
			display_object
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_SPLIT_AREA
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.
	
	display_object: GB_SPLIT_AREA_DISPLAY_OBJECT
		-- The representation of `object' used in `build_window'.
		-- This is used in the builder window.

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			widget: EV_WIDGET
			widget2: EV_WIDGET
			moved_object: GB_OBJECT
			constructor: GB_LAYOUT_CONSTRUCTOR_ITEM
			temp_widget: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_not_void: widget /= Void
			end
			widget2 ?= an_object.display_object
			check
				display_object_not_void: widget2 /= Void
			end
			
				-- We need to put in the first position if
				-- there is currently a second position.
			if position = 1 or (position = 2 and object.second /=  Void) then
					-- If we are trying to insert before the first item with a shift pick, then
					-- we must first move the first item to the second position.
				if (position = 1) and (not layout_item.is_empty and then layout_item.first /= Void) then
					constructor ?= layout_item.first
					moved_object ?= constructor.object
						-- If we are doing a type change, we will have already unparented this, so we
						-- must not do it again. There is no nice way to know whether we are currently
						-- in a type change.
					temp_widget ?= moved_object.object
					if temp_widget.parent /= Void then
						moved_object.unparent
						add_child_object (moved_object, 2)
					end
				end
				object.set_first (widget)
				display_object.child.set_first (widget2)
				if not layout_item.has (an_object.layout_item) then
					layout_item.go_i_th (1)
					layout_item.put_left (an_object.layout_item)
				end
			else
				object.set_second (widget)
				display_object.child.set_second (widget2)
					-- Special case when moving the first item to the
					-- second position.
				if position = 2 and (layout_item.is_empty) then
					layout_item.extend (an_object.layout_item)
				elseif not layout_item.has (an_object.layout_item) then
					layout_item.go_i_th (2)
					layout_item.put_left (an_object.layout_item)
				end
			end	
		end

end -- class GB_SPLIT_AREA_OBJECT