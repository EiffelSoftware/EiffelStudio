note
	description: "Summary description for {WDOCS_THEME}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_THEME

create
	make

feature {NONE} -- Initialization

	make (a_theme_directory: PATH)
		do
			path := a_theme_directory
		end

feature -- Access

	path: PATH

feature -- Template

	template (a_content_type: READABLE_STRING_GENERAL): WDOCS_TEMPLATE
			-- Page template
		do
			if attached template_for_content ({STRING_32} "page-" + a_content_type) as tpl then
				Result := tpl
			elseif attached template_for_content ("page") as tpl then
				Result := tpl
			else
				create {WDOCS_DEBUG_TEMPLATE} Result
			end
		end

	template_for_content (a_type: READABLE_STRING_GENERAL): detachable like template
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_path (path.extended (a_type).appended_with_extension ("tpl"))
			if f.exists and then f.is_access_readable then
				create {WDOCS_SMARTY_TEMPLATE_RENDERING} Result.make (f.path)
			end
		end

end
