note
	description: "XML Parser Callback Handler"
	design: "[
		There is nothing special about this parser callback handler!
		It parses every start tag and its content that it finds without
		regard to hierarchy or containership. At the end of the parse,
		we are left with a list of tags and their content.
		]"

class
	WUI_XML_CALLBACKS

inherit
	XML_CALLBACKS_NULL
		redefine
			default_create,
			on_start_tag,
			on_content
		end

feature {NONE} -- Initialization

	default_create
			--<Precursor>
		do
			Precursor
			create contents.make (10)
		end

feature --

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			--<Precursor>
			-- Make a record of the `a_local_part' in `last_local_part'.
		do
			last_local_part := a_local_part
		end

	last_local_part: STRING_32
			-- What was the `last_local_part' encountered by `on_start_tag'?
		attribute
			create Result.make_empty
		end

	on_content (a_content: READABLE_STRING_32)
			--<Precursor>
			-- Make a record of `a_content' with `last_local_part' in `contents'.
		note
			warning: "[
				The `if' construct does not adequately handle all instances of new-line and tabbing.
				The logic handles the pretty-format of the XML that WrapCUI itself saves,
				but if the user modifies that file in a format other than how it is written
				out by WrapCUI, then one may get unexpected result consequences from 
				this routine.
				
				When it is time to read the `contents' list, the up-side is that any "stray"
				tags-with-content will be ignore because the list-iterator is programmed
				to only pay attention to tags it knows (e.g. data elements like full-header).
				]"
		do
			if not (a_content.count = 1 and then a_content [1] = '%N') and then not (a_content.count = 2 and then (a_content [1] = '%N' and a_content [2] = '%T')) and then not a_content.is_empty then
				contents.force ([last_local_part, a_content])
			end
		end

	contents: ARRAYED_LIST [TUPLE [local_part, content: READABLE_STRING_32]]
			-- A list of `contents' of the parsed XML.
			-- WARNING: This list may contain "strays" (see notes above).

end
