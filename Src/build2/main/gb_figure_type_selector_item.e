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

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', assign `a_text' to `text'
			-- , "EV_" + `a_text' to `type' and `a_components' to `components'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			components := a_components
			type := a_text
			create pixmaps
			create item.make_with_pixmap (pixmaps.pixmap_by_name (type.as_lower))
			item.set_data (Current)
			item.pointer_motion_actions.force_extend (agent display_type)
			item.set_pebble_function (agent generate_transportable)
			item.drop_actions.extend (agent replace_layout_item (?))
			item.drop_actions.set_veto_pebble_function (agent can_drop_object)
		end

feature -- Access

	item: FIGURE_PICTURE_WITH_DATA
		-- Graphical representation of `Current' used in the type selector.

feature {NONE} -- Implementation

	process_number_key is
			-- Begin processing by `digit_checker', so that
			-- it can be determined if a digit key is held down.
		do
			components.digit_checker.begin_processing (components.tools.type_selector.drawing_area)
		end

	display_type is
			-- Display type of `Current' on status bar.
		do
			components.status_bar.set_timed_status_text (type)
		end

end -- class GB_FIGURE_TYPE_SELECTOR_ITEM
