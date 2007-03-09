indexing
	description: "Displayer for formatters"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FORMATTER_DISPLAYER

inherit
	EB_RECYCLABLE

feature -- Access

	widget: EV_WIDGET is
			-- Widget of Current displayer
		deferred
		ensure
			result_attached: Result /= Void
		end

end
