indexing
	description: "Objects that may be used to provide once access to an EV_WIDGET."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_WIDGET_HOLDER

feature -- Access

	widget: EV_WIDGET

feature -- Status setting

	set_widget (a_widget: EV_WIDGET) is
			-- Assign `a_widget' to `widget'.
		require
			widget_not_void: a_widget /= Void
		do
			widget := a_widget
		ensure
			widget_set: widget = a_widget
		end
		
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


end -- class TEST_WIDGET_HOLDER
