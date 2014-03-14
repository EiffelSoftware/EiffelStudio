note
	description: "Summary description for {ESA_REPORT_FORM_CONFIRM_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_FORM_CONFIRM_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REPORT_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("report_form_confirm.tpl")
			template.add_value (a_host, "host")
			template.add_value (retrieve_selected_item (a_form.categories), "categories")
			template.add_value (retrieve_selected_item (a_form.severities), "severities")
			template.add_value (retrieve_selected_item (a_form.classes), "classes")
			template.add_value (retrieve_selected_item (a_form.priorities), "priorities")
			template.add_value (a_form.confidential, "confidential")
			template.add_value (a_form.description, "description")
			template.add_value (a_form.environment, "environment")
			template.add_value (a_form.to_reproduce,"to_reproduce")
			template.add_value (a_form.release, "release")
			template.add_value (a_form.synopsis, "synopsis")
			template.add_value (a_form.id, "id")


			if attached a_user as l_user then
				template.add_value (l_user, "user")
			end
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end

feature  {NONE} -- Implementation

	retrieve_selected_item (a_priority: LIST[ESA_REPORT_SELECTABLE]): detachable READABLE_STRING_32
			-- Retrieve an item
		local
			found: BOOLEAN
		do
			from
				a_priority.start
			until
				a_priority.after or found
			loop
				if a_priority.item.is_selected then
					Result := a_priority.item.synopsis
					found := True
				end
				a_priority.forth
			end
		end


end
