note
	description: "Displayer for formatters"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FORMATTER_DISPLAYER

inherit
	EB_RECYCLABLE

feature -- Access

	widget: EV_WIDGET
			-- Widget of Current displayer
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_refresher (a_refresher: PROCEDURE [ANY, TUPLE])
			-- Set `a_refresher' into Current, it serves as a refresher to be invoked to update Current displayer
		do
		end

end
