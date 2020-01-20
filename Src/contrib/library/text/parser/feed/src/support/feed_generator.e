note
	description: "Common ancestor for feed generator."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEED_GENERATOR

inherit
	XML_UTILITIES

feature {NONE} -- Initialization

	make (a_buffer: STRING_8)
		do
			buffer := a_buffer
			create indentation.make_empty
		end

feature -- Access		

	buffer: STRING_8
			-- Output of feed conversion.

feature -- 	Conversion

	process_feed (a_feed: FEED)
			-- Convert `a_feed' into string representation in `buffer'.
		deferred
		end

feature {NONE} -- Helpers

	indent
		do
			indentation.append ("%T")
		end

	exdent
		require
			has_indentation: indentation.count > 0
		do
			indentation.remove_tail (1)
		end

	indentation: STRING

	append_content_tag_to (a_tagname: READABLE_STRING_8; a_attr: detachable ITERABLE [TUPLE [name: READABLE_STRING_8; value: detachable READABLE_STRING_GENERAL]]; a_content: detachable READABLE_STRING_GENERAL; a_output: STRING)
		local
			l_is_xhtml_type: BOOLEAN
		do
			if a_content /= Void or a_attr /= Void then
				a_output.append (indentation)
				a_output.append ("<")
				a_output.append (a_tagname)
				if a_attr /= Void then
					across
						a_attr as ic
					loop
						if attached ic.item.value as l_att_value then
							a_output.append_character (' ')
							a_output.append (ic.item.name)
							a_output.append_character ('=')
							a_output.append_character ('%"')
							a_output.append (escaped_xml (l_att_value))
							a_output.append_character ('%"')
							if ic.item.name.same_string ("type") and then l_att_value.same_string ("xhtml") then
								l_is_xhtml_type := True
							end
						end
					end
				end
				if a_content = Void then
					a_output.append ("/>%N")
				else
					a_output.append (">")
					if l_is_xhtml_type then
						a_output.append ("<div xmlns=%"http://www.w3.org/1999/xhtml%">")
						a_output.append (escaped_xml (a_content))
						a_output.append ("</div>")
					else
						a_output.append (escaped_xml (a_content))
					end
					a_output.append ("</" + a_tagname + ">%N")
				end
			end
		end

	append_cdata_content_tag_to (a_tagname: READABLE_STRING_8; a_attr: detachable ITERABLE [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_32]]; a_content: detachable READABLE_STRING_32; a_output: STRING)
		do
			if a_content /= Void then
				a_output.append (indentation)
				a_output.append ("<")
				a_output.append (a_tagname)
				if a_attr /= Void then
					across
						a_attr as ic
					loop
						a_output.append_character (' ')
						a_output.append (ic.item.name)
						a_output.append_character ('=')
						a_output.append_character ('%"')
						a_output.append (escaped_xml (ic.item.value))
						a_output.append_character ('%"')
					end
				end
				a_output.append (">")
				a_output.append (to_cdata_element (a_content))
				a_output.append ("</" + a_tagname + ">%N")
			end
		end

	to_cdata_element (a_value: READABLE_STRING_GENERAL): STRING
		local
			cdata: XML_CHARACTER_DATA
			xdoc: XML_DOCUMENT
			pprinter: XML_NODE_PRINTER
			l_output: XML_STRING_8_OUTPUT_STREAM
		do
			create xdoc.make
			create cdata.make (xdoc.root_element, a_value.as_string_32)
			create pprinter.make
			create Result.make (cdata.content_count)
			create l_output.make (Result)
			pprinter.set_output (l_output)
			pprinter.process_character_data (cdata)
		end


end
