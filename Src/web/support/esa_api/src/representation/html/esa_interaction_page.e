note
	description: "Summary description for {ESA_INTERACTION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_PAGE

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
			set_template_file_name ("interaction_form.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.status, "status")
			template.add_value (a_form, "form")

			if attached a_form.temporary_files as l_files then
				template.add_value (l_files, "temporary_files")
			end

			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
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

end
