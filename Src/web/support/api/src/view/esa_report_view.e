note
	description: "Object that represent a Report problem to be rendered in a View, for example HTML, JSON, etc"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_VIEW

create

	make

feature {NONE} -- Initialization

	make (a_reports: LIST [REPORT]; a_index: INTEGER; a_pages: INTEGER; a_categories: LIST [REPORT_CATEGORY]; a_status: LIST [REPORT_STATUS]; a_user: detachable ANY; a_count_bugs: INTEGER)
			-- Create a new object with reports `a_reports'
			-- current page `a_index'
			-- number of pages `a_pages'
			-- a possible list of categories `a_categories'
			-- a possible list of status `a_status'
			-- an a logged-in user or Guest `a_user'
			-- total number of bugs `a_count_bugs'
		do
			reports := a_reports
			index := a_index
			pages := a_pages
			categories := a_categories
			status := a_status
			user := a_user
			count_bugs := a_count_bugs
		ensure
			reports_set: reports = a_reports
			index_set: index = a_index
			pages_set: pages = a_pages
			categories_set: categories = a_categories
			status_set: status = a_status
			user_set: user = a_user
			count_bugs_set: count_bugs = a_count_bugs
		end

feature -- Access

	id: detachable STRING
		-- Report id.

	reports: LIST [REPORT]
		-- Possible list of reports.

	index: INTEGER
		--  Current index.

	size: INTEGER
		-- Page Size.	

	pages: INTEGER
		-- Number of pages.

	categories: LIST [REPORT_CATEGORY]
		-- Possible list of report problem categories.

	status: LIST [REPORT_STATUS]
		-- Possible list of report problem status.

	responsibles: detachable LIST [USER]
		-- Possible list of report problem responsibles.

	priorities: detachable LIST [REPORT_PRIORITY]
		-- Possible list of report problem  priorities.

	severities: detachable LIST [REPORT_SEVERITY]
		-- Possible list of report problem severities.

	user: detachable ANY
		-- Current logged in user or Guest.

	selected_status: INTEGER
		-- Status selected.

	selected_category: INTEGER
		-- Category selected.

	selected_responsible: INTEGER
		-- Reponsible selected.

	selected_priority: INTEGER
		-- Priority selected.

	selected_severity: INTEGER
		-- Severity selected.

	order_by: detachable READABLE_STRING_8
		-- Field used to sort the reports.

	direction: detachable READABLE_STRING_8
		-- Direction ASC|DESC.

	submitter: detachable STRING_32
		-- User submit a problem.

	filter: detachable STRING_32
		-- Filter text to search
		-- By default search by synopsis.
		-- If content is checked, also search by ToReproduce, Descriptions and Interactions Contents.

	filter_content: INTEGER
		-- Is filter by content checked?
		-- 1: yes, 0: no.

	count_bugs: INTEGER
		-- Total number of bugs.

	has_closed_reports: BOOLEAN

feature -- Change Element

	set_id (a_id: STRING)
			-- Set `id' to `a_id'.
		do
			id := a_id
		ensure
			selected_id: id = a_id
		end


	set_selected_status (a_val: INTEGER)
			-- Set `selected_status' to selected value `a_val'.
		do
			selected_status := a_val
		ensure
			selected_status_set: selected_status = a_val
		end

	set_selected_category (a_val: INTEGER)
			-- Set `selected_category' to selected value `a_val'.
		do
			selected_category := a_val
		ensure
			selected_category_set: selected_category = a_val
		end

	set_selected_responsible (a_val: INTEGER)
			-- Set `selected_responsible' to selected value `a_val'.
		do
			selected_responsible := a_val
		ensure
			selected_responsible_set: selected_responsible = a_val
		end

	set_selected_priority (a_val: INTEGER)
			-- Set `selected_priority' to selected value `a_val'.
		do
			selected_priority := a_val
		ensure
			selected_priority_set: selected_priority = a_val
		end

	set_selected_severity (a_val: INTEGER)
			-- Set `selected_severity' to selected value `a_val'.
		do
			selected_severity := a_val
		ensure
			selected_severity_set: selected_severity = a_val
		end

	set_order_by (a_order_by: READABLE_STRING_8)
			-- Set `orger_by' to `a_order_by'.
		do
			order_by := a_order_by
		end

	set_direction (a_direction: READABLE_STRING_8)
			-- Set `direction' to `a_direction'.
			-- direction (ASC|DESC)
		do
			direction := a_direction
		end

	set_responsibles (a_responsibles: like responsibles)
			-- Set `responsibles' to `a_responsibles'.
		do
			responsibles := a_responsibles
		end

	set_priorities (a_priorities: like priorities)
			-- Set `priorities' to `a_priorities'.
		do
			priorities := a_priorities
		end

	set_severities (a_severities: like severities)
			-- Set `severities' to `a_severities'.
		do
			severities := a_severities
		end

	set_size (a_size: INTEGER)
			-- Set `size' to `size'
		do
			size := a_size
		ensure
			size_set: size = a_size
		end

	set_submitter ( a_submitter: like submitter)
			-- Set `submitter' to `a_submitter'.
		do
			submitter := a_submitter
		ensure
			submitter_set: submitter = a_submitter
		end

	set_filter (a_filter: like filter)
			-- Set `filter' to `a_filter'.
		do
			filter := a_filter
		ensure
			filter_set: filter = a_filter
		end

	set_filter_content (a_filter_content: like filter_content)
			-- Set `filter_content' to `a_filter_content'.
		do
			filter_content := a_filter_content
		ensure
			filter_content_set: filter_content = a_filter_content
		end

	set_count_bugs (a_count_bugs: INTEGER)
			-- Set `count_bugs' to `a_count_bugs'.
		do
			count_bugs := a_count_bugs
		ensure
			count_bugs_set: count_bugs = a_count_bugs
		end


	set_has_closed_reports	(a_boolean: BOOLEAN)
			-- Set `has_closed_reports` with `a_boolean`.
		do
			has_closed_reports := a_boolean
		ensure
			has_closed_reports_set: has_closed_reports = a_boolean
		end

end
