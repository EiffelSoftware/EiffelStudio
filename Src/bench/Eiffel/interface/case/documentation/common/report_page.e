indexing
	description: "Common chr$ of all report pages"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPORT_PAGE

inherit
	EDITOR_WINDOW_PAGE

	ONCES

	CONSTANTS

feature -- Initialization

	make_with_caller(noteb: EV_NOTEBOOK;win: REPORT_WINDOW) is
		do
			window := win
			make(noteb,window)
		end

	do_page is do end

feature -- Implementation

	window: REPORT_WINDOW

end -- class REPORT_PAGE
