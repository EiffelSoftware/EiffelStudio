note
	description: "Summary description for {ESA_INTERACTION_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_CONFIRM_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("interaction_form_confirm.tpl")
			template.add_value (a_host, "host")
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

				if l_report.confidential /= a_form.private then
					template.add_value (a_form.private, "private")
				end
			end

			if attached a_user then
				template.add_value (a_user, "user")
			end

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				debug
					print (representation)
				end
			end
		end


	selected_item_by_synopsis (a_items: LIST [ESA_REPORT_SELECTABLE]; a_synopsis: READABLE_STRING_32): INTEGER
			-- Retrieve the current selected item
		local
			l_found: BOOLEAN
			l_item: ESA_REPORT_SELECTABLE
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

end
