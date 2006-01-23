indexing
	description:
		"[
			Base class for simple, non container widgets.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget, primitive"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_PRIMITIVE

inherit
	EV_WIDGET
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_TOOLTIPABLE
		redefine
			implementation,
			is_in_default_state
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_WIDGET} and Precursor {EV_TOOLTIPABLE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PRIMITIVE_I;
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRIMITIVE

