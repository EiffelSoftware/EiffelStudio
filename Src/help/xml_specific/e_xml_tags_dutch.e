indexing
	description: "Objects that represent the help-format XML tags in Dutch."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	E_XML_TAGS_DUTCH

feature -- Miscellaneous

	get_start_tag (name, attr: STRING): STRING is
			-- A XML-start-tag with `name' and attributes `attr'.
		do
			Result := "<" + name + attr + ">"
		end

	get_end_tag (name: STRING): STRING is
			-- A XML-end-tag with `name'.
		do
			Result := "</" + name + ">"
		end

	get_single_tag (name: STRING): STRING is
			-- A stand-alone XML tag with `name'.
		do
			Result := "<" + name + "/>"
		end

	get_line_break: STRING is
			-- Get stand-alone line-break tag.
		do
			Result := get_single_tag (line_break_tag)
		end

	get_attr (name, value: STRING): STRING is
			-- Attribute `name' with `value'.
		do
			Result := " " + name + "=%"" + value + "%""
		end

	remove_excess_whitespace (s: STRING) is
			-- Reduces all occurences of returns, tabs and spaces with 1 space.
		do
			s.replace_substring_all ("%N", " ")
			s.replace_substring_all ("%T", " ")
			s.replace_substring_all ("  ", " ")
		end

	format_for_xml (s: STRING) is
			-- Converts special characters into special tags.
		do
			s.replace_substring_all (chconv (226).out + chconv (128).out + chconv (156).out, "&quot;")
			s.replace_substring_all (chconv (226).out + chconv (128).out + chconv (157).out, "&quot;")
			s.replace_substring_all (chconv (226).out + chconv (128).out + chconv (153).out, " ")
			s.replace_substring_all (chconv (226).out + chconv (126).out + chconv (151).out, "*")
			s.replace_substring_all ("<", "&lt;")
			s.replace_substring_all (">", "&gt;")
			s.replace_substring_all ("%"", "&quot;")
		end

feature -- Constants

	eiffel_document_tag: STRING is
			-- The document-start-tag.
		once
			Result := "EIFFEL_DOCUMENT"
		end

	topic_tag: STRING is
			-- The topic-tag. Has 2 attributes: location and id.
		once
			Result := "ONDERWERP"
		end

	topic_location_attr: STRING is
			-- The location attribute of topic.
		once
			Result := "LOCATIE"
		end

	topic_id_attr: STRING is
			-- The location attribute of topic.
		once
			Result := "ID"
		end

	text_tag: STRING is
			-- The paragraph tag.
		once
			Result := "TEKST"
		end

	head_tag: STRING is
			-- The topic-title tag.
		once
			Result := "TITEL"
		end

	font_tag: STRING is
			-- The font properties tag. Has 3 attributes: color, name and size.
		once
			Result := "LETTER"
		end

	font_color_attr: STRING is
			-- The color attribute of font.
		once
			Result := "KLEUR"
		end

	font_name_attr: STRING is
			-- The name attribute of font.
		once
			Result := "NAAM"
		end

	font_size_attr: STRING is
			-- The size attribute of font.
		once
			Result := "GROOTTE"
		end

	line_break_tag: STRING is
			-- The line-break tag. Recommended use: single tag.
		once
			Result := "REGELEINDE"
		end

	anchor_tag: STRING is
			-- The anchor tag. Has 1 attribute: topic_id.
		once
			Result := "ANKER"
		end

	anchor_topic_id_attr: STRING is
			-- The topic_id attribute of anchor.
		once
			Result := "ONDERWERP_ID"
		end

	list_item_tag: STRING is
			-- The bulleted list-item tag.
		once
			Result := "LIJSTONDERDEEL"
		end

	list_tag: STRING is
			-- The unnumbered list tag.
		once
			Result := "LIJST"
		end

	bold_tag: STRING is
			-- The bold-tag.
		once
			Result := "VET"
		end

	italics_tag: STRING is
			-- The italics-tag.
		once
			Result := "CURSIEF"
		end

	underlined_tag: STRING is
			-- The underlined-tag.
		once
			Result := "ONDERSTREEPT"
		end

	keyword_tag: STRING is
			-- The keyword-tag. Words between keyword tags are added to the index.
		once
			Result := "TREFWOORD"
		end

feature {NONE} -- Implementation

	chconv (i: INTEGER): CHARACTER is
			-- Character associated with integer value `i'
			--! FIXME <Vincent 10/19/99>
			--! I had to copy this since it is not exported from CHARACTER_REF.
		external
			"C [macro %"eif_misc.h%"]"
		end

indexing
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
end -- class E_XML_TAGS_DUTCH
