indexing
	description	: "Facilities for programming in Vision2. %
				  %Your Class should inherit from the class to use the facilities"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_VISION2_FACILITIES
	
inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic operations

	extend_no_expand (container: EV_BOX; widget: EV_WIDGET) is
			-- Add `widget' to `container' and make `widget' not expandable
		do
			container.extend (widget)
			container.disable_item_expand (widget)
		end

	extend_with_size (container: EV_BOX; widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Add `widget' to `container' and make `widget' not expandable
			-- Set the minimum size of `widget' to (`a_width',`a_height')
		do
			widget.set_minimum_size (a_width, a_height)
			container.extend (widget)
			container.disable_item_expand (widget)
		end

	extend_button (container: EV_BOX; button: EV_BUTTON) is
			-- Add `widget' to `container' and make `widget' not expandable
			-- Set the minimum size of `widget' to the default size for buttons
		do
			Layout_constants.set_default_size_for_button (button)
			container.extend (button)
			container.disable_item_expand (button)
		end

end -- class EB_VISION2_FACILITIES
