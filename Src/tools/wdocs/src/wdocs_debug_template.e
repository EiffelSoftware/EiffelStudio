note
	description: "Summary description for {WDOCS_DEBUG_TEMPLATE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DEBUG_TEMPLATE

inherit
	WDOCS_TEMPLATE

feature -- Rendering

	xhtml (req: WSF_REQUEST; a_values: STRING_TABLE [detachable ANY]): STRING
		local
			utf: UTF_CONVERTER
		do
			create Result.make_empty
			across
				a_values as ic
			loop
				Result.append ("<h1>")
				Result.append (ic.key.as_string_8)
				Result.append ("</h1>")
				Result.append ("<div>")
				if attached ic.item as obj then
					if attached {READABLE_STRING_32} obj as s32 then
						Result.append (utf.string_32_to_utf_8_string_8 (s32))
					else
						Result.append (obj.out)
					end
				end
				Result.append ("</div>")
			end
		end

end
