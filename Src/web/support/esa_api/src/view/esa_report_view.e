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

	order_by: detachable STRING_32

	direction : detachable STRING_32

feature -- Change Element

	set_selected_status (a_val: INTEGER)
		do
			selected_status := a_val
		end


	set_selected_category (a_val: INTEGER)
		do
			selected_category := a_val
		end


	set_order_by (a_order_by: READABLE_STRING_32)
			-- Set `orger_by' with `a_order_by'
		do
			order_by := a_order_by
		end

	set_direction (a_direction: STRING)
			-- Set `direction' with `a_direction'
			-- direction (ASC|DESC)
		do
			direction := a_direction
		end
end
