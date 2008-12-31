note
	description: "Objects that represent the help-format XML tags in English."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	E_XML_TAGS

feature -- Miscellaneous

	get_start_tag (name, attr: STRING): STRING
			-- A XML-start-tag with `name' and attributes `attr'.
		do
			Result := "<" + name + attr + ">"
		end

	get_end_tag (name: STRING): STRING
			-- A XML-end-tag with `name'.
		do
			Result := "</" + name + ">"
		end

	get_single_tag (name: STRING): STRING
			-- A stand-alone XML tag with `name'.
		do
			Result := "<" + name + "/>"
		end

	get_line_break: STRING
			-- Get stand-alone line-break tag.
		do
			Result := get_single_tag (line_break_tag)
		end

	get_attr (name, value: STRING): STRING
			-- Attribute `name' with `value'.
		do
			Result := " " + name + "=%"" + value + "%""
		end

	remove_excess_whitespace (s: STRING)
			-- Reduces all occurences of returns, tabs and spaces with 1 space.
		do
			s.replace_substring_all ("%N", " ")
			s.replace_substring_all ("%T", " ")
			s.replace_substring_all ("  ", " ")
		end

	format_for_xml (s: STRING)
			-- Converts special characters into special tags.
		do
			s.replace_substring_all (chconv (226).out + chconv (128).out + chconv (156).out, "&quot;")
			s.replace_substring_all (chconv (226).out + chconv (128).out + chconv (157).out, "&quot;")
			s.replace_substring_all (chconv (226).out + chconv (128).out + chconv (153).out, "'")
			s.replace_substring_all (chconv (226).out + chconv (120).out + chconv (151).out, "*")
			s.replace_substring_all ("<", "&lt;")
			s.replace_substring_all (">", "&gt;")
			s.replace_substring_all ("%"", "&quot;")
		end

feature -- Constants

	eiffel_document_tag: STRING
			-- The document-start-tag.
		once
			Result := "EIFFEL_DOCUMENT"
		end

	topic_tag: STRING
			-- The topic-tag. Has 2 attributes: location and id.
		once
			Result := "TOPIC"
		end

	topic_location_attr: STRING
			-- The location attribute of topic.
		once
			Result := "LOCATION"
		end

	topic_id_attr: STRING
			-- The location attribute of topic.
		once
			Result := "ID"
		end

	text_tag: STRING
			-- The paragraph tag.
		once
			Result := "TEXT"
		end

	head_tag: STRING
			-- The topic-title tag.
		once
			Result := "HEAD"
		end

	font_tag: STRING
			-- The font properties tag. Has 3 attributes: color, name and size.
		once
			Result := "FONT"
		end

	font_color_attr: STRING
			-- The color attribute of font.
		once
			Result := "COLOR"
		end

	font_name_attr: STRING
			-- The name attribute of font.
		once
			Result := "NAME"
		end

	font_size_attr: STRING
			-- The size attribute of font.
		once
			Result := "SIZE"
		end

	line_break_tag: STRING
			-- The line-break tag. Recommended use: single tag.
		once
			Result := "BR"
		end

	anchor_tag: STRING
			-- The anchor tag. Has 1 attribute: topic_id.
		once
			Result := "A"
		end

	anchor_topic_id_attr: STRING
			-- The topic_id attribute of anchor.
		once
			Result := "TOPIC_ID"
		end

	list_item_tag: STRING
			-- The bulleted list-item tag.
		once
			Result := "LI"
		end

	list_tag: STRING
			-- The unnumbered list tag.
		once
			Result := "UL"
		end

	bold_tag: STRING
			-- The bold-tag.
		once
			Result := "B"
		end

	italics_tag: STRING
			-- The italics-tag.
		once
			Result := "I"
		end

	underlined_tag: STRING
			-- The underlined-tag.
		once
			Result := "U"
		end

	keyword_tag: STRING
			-- The keyword-tag. Words between keyword tags are added to the index.
		once
			Result := "IMP"
		end

feature {NONE} -- Implementation

	chconv (i: INTEGER): CHARACTER
			-- Character associated with integer value `i'
			--! FIXME <Vincent 10/19/99>
			--! I had to copy this since it is not exported from CHARACTER_REF.
		external
			"C [macro %"eif_misc.h%"]"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class E_XML_TAGS
