indexing
	description: "Figure representations of type selector items"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FIGURE_TYPE_SELECTOR_ITEM
	
inherit
	GB_TYPE_SELECTOR_ITEM
		export
			{NONE} all
		redefine
			item
		end
		
	GB_SHARED_STATUS_BAR
		export
			{NONE} all
		end
		
create
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current', assign `a_text' to `text'
			-- and "EV_" + `a_text' to `type'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			type := a_text
			create pixmaps
			create item.make_with_pixmap (pixmaps.pixmap_by_name (type.as_lower))
			item.pointer_motion_actions.force_extend (agent display_type)
			item.set_pebble_function (agent generate_transportable)
		end

feature -- Access

	item: EV_FIGURE_PICTURE
		-- Graphical representation of `Current' used in the type selector.

feature {NONE} -- Implementation

	process_number_key is
			-- Begin processing by `digit_checker', so that
			-- it can be determined if a digit key is held down.
		do
			digit_checker.begin_processing (type_selector.drawing_area)
		end
		
	display_type is
			-- Display type of `Current' on status bar.
		do
			set_timed_status_text (type)
		end

end -- class GB_FIGURE_TYPE_SELECTOR_ITEM
