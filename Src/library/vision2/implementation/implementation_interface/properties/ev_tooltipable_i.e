indexing
	description:
		"Eiffel Vision tooltipable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	tooltip: STRING_32 is
			-- Tooltip displayed on `Current'.
		deferred
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

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




end -- class EV_TOOLTIPABLE_I

