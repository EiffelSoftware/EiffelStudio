indexing
	description: "A GB_OBJECT representing an EV_CELL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CELL_OBJECT
	
inherit
	GB_CONTAINER_OBJECT
		redefine
			object, display_object, is_full,
			build_display_object, accepts_child,
			add_child_object
		end
	
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_CELL
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.
	
	display_object: GB_CELL_DISPLAY_OBJECT
		-- The representation of `object' used in `build_window'.
		-- This is used in the builder window.
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := object.full
		end

feature -- Basic operations
		
	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current'.
		local
			widget: EV_WIDGET
		do
			check
				object_empty: object.is_empty
			end
			widget ?= an_object.object
			check
				object_is_a_widget: widget /= Void
			end
			object.extend (widget)
			widget ?= an_object.display_object
			check
				display_object_is_a_widget: widget /= Void
			end
			display_object.child.extend (widget)
			if layout_item.data = Void then
				layout_item.extend (an_object.layout_item)
			end
			add_child (an_object, 1)
		ensure then
				-- If we are adding a menu bar, then the normal rule does not apply.
			object_not_empty: not type_conforms_to (dynamic_type (an_object), dynamic_type_from_string ("GB_MENU_BAR_OBJECT")) implies not object.is_empty
		end

feature {NONE} -- Access

	accepts_child (a_type: STRING):BOOLEAN is
			-- Does `Current' accept `an_object'?
			-- Only widgets are accepted.
		do
			if type_conforms_to (dynamic_type_from_string (a_type), dynamic_type_from_string (Ev_widget_string)) 
			and not type_conforms_to (dynamic_type_from_string (a_type), dynamic_type_from_string (Ev_window_string)) then
				Result := True
			end
		end
		
feature {NONE} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		local
			container: EV_CONTAINER
		do
			container ?= vision2_object_from_type (type)
			check
				container_not_void: container /= Void
			end
			create display_object.make_with_name_and_child (type, container)
			connect_display_object_events
		end
		
invariant
	--has_no_more_than_one_child: children.count <= 1
	-- Not true if we are a window with a menu bar inserted.

end -- class GB_CELL_OBJECT
