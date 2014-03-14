note
	description: "Summary description for {ESA_REPORT_VIEW}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_VIEW

create

	make

feature -- Initialization

	make (a_reports: TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]; a_index: INTEGER; a_pages: INTEGER; a_categories: LIST[ESA_REPORT_CATEGORY]; a_status: LIST[ESA_REPORT_STATUS]; a_user: detachable ANY)
		do
			reports := a_reports
			index := a_index
			pages := a_pages
			categories := a_categories
			status := a_status
			user := a_user
		end

feature -- Access

	reports: TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]

	index: INTEGER;

	pages: INTEGER;

	categories: LIST[ESA_REPORT_CATEGORY];

	status: LIST[ESA_REPORT_STATUS]

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
