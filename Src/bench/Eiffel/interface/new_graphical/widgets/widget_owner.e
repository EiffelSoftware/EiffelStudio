indexing
	description: "An simple and abstract widget container."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIDGET_OWNER

feature -- Status setting

	set_widget (new_widget: EV_WIDGET) is
			-- Notify of a change of the contained widget.
		deferred
		end

	force_display is
			-- Display all parent widgets.
		deferred
		end

end -- class WIDGET_OWNER
