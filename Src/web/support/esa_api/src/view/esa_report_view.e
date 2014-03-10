note
	description: "Summary description for {ESA_REPORT_VIEW}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_VIEW

create

	make

feature -- Initialization

	make (a_reports: TUPLE[REPORT_STATISTICS,LIST[REPORT]]; a_index: INTEGER; a_pages: INTEGER; a_categories: LIST[REPORT_CATEGORY]; a_status: LIST[REPORT_STATUS]; a_user: detachable ANY)
		do
			reports := a_reports
			index := a_index
			pages := a_pages
			categories := a_categories
			status := a_status
			user := a_user
		end

feature -- Access

	reports: TUPLE[REPORT_STATISTICS,LIST[REPORT]]

	index: INTEGER;

	pages: INTEGER;

	categories: LIST[REPORT_CATEGORY];

	status: LIST[REPORT_STATUS]

	user: detachable ANY

	selected_status: INTEGER

	selected_category: INTEGER


feature -- Change Element

	set_selected_status (a_val: INTEGER)
		do
			selected_status := a_val
		end


	set_selected_category (a_val: INTEGER)
		do
			selected_category := a_val
		end

end
