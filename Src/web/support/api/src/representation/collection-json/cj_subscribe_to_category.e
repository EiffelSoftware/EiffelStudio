note
	description: "Summary description for {CJ_SUBSCRITE_TO_CATEGORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_SUBSCRIBE_TO_CATEGORY

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_list: LIST [ESA_CATEGORY_SUBSCRIBER_VIEW ])
			-- Initialize `Current'.
		do
			log.write_information (generator  +"make render template: cj_subscribe_to_category.tpl" )
			set_template_folder (cj_path)
			set_template_file_name ("cj_subscribe_to_category.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_user, "user")
			template.add_value ("responsible", "responsible")
			template.add_value (a_list, "categories")

				-- Process current template
			process
		end

end
