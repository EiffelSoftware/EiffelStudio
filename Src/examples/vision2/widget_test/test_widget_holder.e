indexing
	description: "Objects that may be used to provide once access to an EV_WIDGET."
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
		
end -- class TEST_WIDGET_HOLDER
