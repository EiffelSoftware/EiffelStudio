note
	description:
		"Eiffel Vision tooltipable. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE_IMP

inherit
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

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
		end

feature {NONE} -- Implementation

	internal_tooltip_string: STRING_32

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- EV_TOOLTIPABLE_IMP

