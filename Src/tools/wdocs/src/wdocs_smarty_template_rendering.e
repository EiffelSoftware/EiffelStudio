note
	description: "Summary description for {WDOCS_SMARTY_TEMPLATE_RENDERING}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_SMARTY_TEMPLATE_RENDERING

inherit
	WDOCS_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_tpl: PATH)
		do
			path := a_tpl
		end

feature -- Access

	path: PATH

feature -- Rendering

	xhtml (req: WSF_REQUEST; a_values: STRING_TABLE [detachable ANY]): STRING
		local
--			p: PATH
			tpl: TEMPLATE_FILE
		do
			template_context.set_template_folder (path.parent)
			if attached path.entry as l_entry then
				create tpl.make_from_file (l_entry.name)
			else
				create tpl.make_from_file (path.name)
			end
			across
				a_values as ic
			loop
				tpl.add_value (ic.item, ic.key.as_string_8)
			end

--			if a_main.is_case_insensitive_equal_general ("root") then
--				template.add_value (a_main, "root")
--			elseif  a_main.is_case_insensitive_equal_general ("contribute") then
--				template.add_value (a_main, "contribute")
--			elseif  a_main.is_case_insensitive_equal_general ("document") then
--				template.add_value (a_main, "document")
--			end

			if attached req.http_host as l_host then
				tpl.add_value (req.http_host, "host")
			else
				tpl.add_value ("localhost", "host")
			end
			template_context.enable_verbose
			tpl.analyze
			tpl.get_output
			if attached tpl.output as l_output then
				Result := l_output
			else
				create Result.make_from_string ("ERROR: template issue.")
			end
		end

end
