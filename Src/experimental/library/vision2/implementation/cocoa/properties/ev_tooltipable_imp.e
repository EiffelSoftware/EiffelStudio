note
	description: "Eiffel Vision tooltipable. Cocoa implementation."
	author: "Daniel Furrer"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE_IMP

inherit
	EV_TOOLTIPABLE_I

feature -- Initialization

	tooltip: STRING_32
			-- Tooltip that has been set.
		do
			if internal_tooltip_string = Void then
				Result := ""
			else
				Result := internal_tooltip_string.twin
			end
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		do
			internal_tooltip_string := a_tooltip.twin
			if attached {NS_VIEW} cocoa_item as l_view then
				l_view.set_tool_tip (create {NS_STRING}.make_with_string (a_tooltip))
			end
		end

feature {NONE} -- Implementation

	internal_tooltip_string: STRING_32

	cocoa_item: NS_OBJECT
	deferred
	end

end -- EV_TOOLTIPABLE_IMP
