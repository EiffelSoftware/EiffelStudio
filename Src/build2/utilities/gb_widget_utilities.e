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
		
end -- class GB_UTILITIES
