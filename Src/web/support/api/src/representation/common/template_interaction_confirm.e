note
	description: "Interaction confirm template page, setting common properties to CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_INTERACTION_CONFIRM

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template)
			add_host (a_host)
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.status, "status")
			template.add_value (a_form, "form")

			if attached a_form.report as l_report then
				if
					attached l_report.status as l_status and then
				   	selected_item_by_synopsis (a_form.status, l_status.synopsis) /= a_form.selected_status
				then
					template.add_value (a_form.selected_status, "new_status")
				end

				if
				    attached l_report.category as l_category and then
				    selected_item_by_synopsis (a_form.categories, l_category.synopsis) /= a_form.category
				then
					template.add_value (a_form.category, "new_category")
				end

				if a_form.private then
					template.add_value (a_form.private, "private")
				end
			end

			if
				attached a_form.temporary_files_names as l_files and then
				not l_files.is_empty
			then
				template.add_value (l_files, "attachments")
			end

			if attached {READABLE_STRING_32} a_user as l_user then
				template.add_value (a_user, "user")
				template.add_value (has_access(l_user, a_form), "has_access")
			end

		end

feature -- Implementation

	selected_item_by_synopsis (a_items: LIST [REPORT_SELECTABLE]; a_synopsis: READABLE_STRING_32): INTEGER
			-- Retrieve the current selected item.
		local
			l_found: BOOLEAN
			l_item: REPORT_SELECTABLE
		do
			from
				a_items.start
			until
				a_items.after or l_found
			loop
				l_item := a_items.item_for_iteration
				if a_synopsis.is_case_insensitive_equal (l_item.synopsis) then
					Result := l_item.id
					l_found := True
				end
				a_items.forth
			end
		end

	has_access (a_user: READABLE_STRING_32; a_form: ESA_INTERACTION_FORM_VIEW): BOOLEAN
				-- Has the current user access to change category and status?
			do
				Result := a_form.is_responsible_or_admin
				if
					attached a_form.report as l_report and then
					attached l_report.contact as l_contact
				then
					Result := Result or else a_user.same_string_general (l_contact.name)
				end

			end

end
