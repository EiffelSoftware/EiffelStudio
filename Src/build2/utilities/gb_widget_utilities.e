indexing
	description: "Objects that provide useful facilities for widgets."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_WIDGET_UTILITIES

feature -- Basic operations

	parent_window (widget: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
		local
			window: EV_WINDOW
		do
			window ?= widget.parent
			if window = Void then
				Result := parent_window (widget.parent)
			else
				Result := window
			end
			
		end
		
	extend_no_expand (a_box: EV_BOX; a_widget: EV_WIDGET) is
			-- Extend `a_widget' into `a_box' and disable expandability.
		require
			box_not_void: a_box /= Void
			a_widget_not_void: a_widget /= Void
		do
			a_box.extend (a_widget)
			a_box.disable_item_expand (a_widget)
		ensure
			box_contains_widget: a_box.has (a_widget)
			widget_not_expanded: not a_box.is_item_expanded (a_widget)
		end

		
end -- class GB_UTILITIES
