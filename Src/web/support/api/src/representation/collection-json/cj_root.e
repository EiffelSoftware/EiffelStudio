note
	description: "Template class to generate an CJ API root"
	date: "$Date$"
	revision: "$Revision$"


class
	CJ_ROOT

inherit

	TEMPLATE_BAD_REQUEST
		rename
			make as make_template
		end

create
	make, make_with_error

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: collection_json.tpl")
				-- Set path to CJ.
			set_template_folder (cj_path)

				-- Build Common Template
			make_template (a_host, a_user, "collection_json.tpl")

				-- Process the current tempate.
			process

		end

	make_with_error (a_host: READABLE_STRING_GENERAL; a_error: READABLE_STRING_GENERAL; a_code: INTEGER; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make_with_error render template: collection_json.tpl")

				-- Build Common Template
			make_template (a_host, a_user, "collection_json.tpl")

				-- Set path to CJ.
			set_template_folder (cj_path)

			template.add_value (a_error, "error")
			template.add_value (a_code, "code")

				-- Process the current template
			process
		end

end
