note
	description: "Summary description for {ESA_INTERACTION_FORM_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_FORM_VIEW

create
	make

feature -- Intialization

	make (a_status: like status; a_categories: like categories)
		do
			status := a_status
			categories := a_categories
		ensure
			status_set:  status = a_status
			categories_set:  categories = a_categories
		end


feature -- Access

	status: LIST[ESA_REPORT_STATUS]
			-- Possible list of status

	categories:  LIST[ESA_REPORT_CATEGORY]
			-- Possible list of categories

	description: detachable READABLE_STRING_32
			-- Interaction description

	private: BOOLEAN
			-- is the interaction public or private?

	selected_status: INTEGER;
			-- Current selected status

	category: INTEGER
			-- Current selected category

	report: detachable ESA_REPORT
			-- Current report to add an interaction

	id: INTEGER
		-- Current interaction id.		

feature -- Status Report

	is_valid_form: BOOLEAN
			-- An interaction form is valid iff
			-- A description is defined and it's not empty
			-- A selected status it's not 0
			-- A category it's not 0.
		do
			if attached description as l_description and then
			   not l_description.is_empty  and then
			   selected_status > 0 and then category > 0 then
			   	Result := True
			end
		end

feature -- Element Change

	set_selected_status (a_status: like selected_status)
			-- Set `selected_status' with `a_status'
		do
			selected_status := a_status
		ensure
			selected_status_set: selected_status = a_status
		end

	set_category (a_category: like category)
			-- Set `category' with `a_category'
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_private (a_val: BOOLEAN)
			-- Set `private' to `a_val'.
		do
			private := a_val
		ensure
			private_set: private = a_val
		end

	set_report (a_report: like report)
			-- Set `report' with `a_report'
		do
			report := a_report
		ensure
			report_set: report = a_report
		end

	set_description (a_description: like description)
			-- Set `description' with `a_description'
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_id (a_id: INTEGER)
			-- Set `id' with `a_id'
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_status_by_synopsis (a_synopsis: READABLE_STRING_32)
			-- Set `selected_status' id by synosis, if match.
		do
			across status as c loop
				if c.item.synopsis.same_string (a_synopsis) then
					set_selected_status (c.item.id)
				end
			end
		end

	set_category_by_synopsis (a_synopsis: READABLE_STRING_32)
			-- Set `category' id by synosis, if match.
		do
			across categories as c loop
				if c.item.synopsis.same_string (a_synopsis) then
					set_category (c.item.id)
				end
			end
		end
end
