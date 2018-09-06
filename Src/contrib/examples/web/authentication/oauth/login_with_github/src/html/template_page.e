note
	description: "Summary description for {TEMPLATE_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEMPLATE_PAGE

inherit

	SHARED_TEMPLATE_CONTEXT


feature -- Status

	representation: detachable STRING

	set_template_folder (v: PATH)
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: STRING)
		do
			create template.make_from_file (v)
		end

	set_template (v: like template)
		do
			template := v
		end

	template: TEMPLATE_FILE
end


