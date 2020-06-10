note
	description: "Interaction template page, setting common properties for CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_INTERACTION

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
			template.add_value (a_form.report, "report")

			if attached a_form.temporary_files as l_files and then not l_files.is_empty then
				template.add_value (l_files, "temporary_files")
			end

			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end

			if attached {READABLE_STRING_32} a_user as l_user then
				template.add_value (a_user, "user")
				template.add_value (has_access (l_user, a_form), "has_access")
			end
		end


feature -- Status Report

	has_access (a_user: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW): BOOLEAN
			-- Has the current user access to change category and status?
		do
			Result := a_form.is_responsible_or_admin
			if
				attached a_form.report as l_report and then
				attached l_report.contact as l_contact
			then
				Result := Result or else a_user.same_string (l_contact.name)
			end
		end
end
