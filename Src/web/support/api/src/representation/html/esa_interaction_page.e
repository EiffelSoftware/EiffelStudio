note
	description: "Summary description for {ESA_INTERACTION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_PAGE

inherit

	TEMPLATE_SHARED
	
create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: interaction_form.tpl")
			set_template_folder (html_path)
			set_template_file_name ("interaction_form.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.status, "status")
			template.add_value (a_form, "form")

			if
				attached a_form.temporary_files as l_files and then
				not l_files.is_empty
			then
				template.add_value (l_files, "temporary_files")
			end

			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end

			if attached {STRING_32} a_user as l_user then
				template.add_value (a_user, "user")
				template.add_value (has_access(l_user, a_form), "has_access")
			end
				-- Process current template
			process
		end

		has_access (a_user:STRING; a_form: ESA_INTERACTION_FORM_VIEW): BOOLEAN
				-- Has the current user access to change category and status?
			do
				Result := a_form.is_responsible_or_admin
				if
					attached a_form.report as l_report and then
					attached l_report.contact as l_contact then
					Result := Result or else (a_user.same_string (l_contact.name))
				end

			end

end
