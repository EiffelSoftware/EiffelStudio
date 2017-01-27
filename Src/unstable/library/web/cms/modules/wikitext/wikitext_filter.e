note
	description: "Summary description for {WIKITEXT_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKITEXT_FILTER

inherit
	CONTENT_FILTER
		redefine
			help
		end

	STRING_HANDLER

feature -- Access

	name: STRING_8 = "wikitext_renderer"

	title: STRING_8 = "Wikitext renderer"

	help: STRING = "Wikitext rendered as HTML"

	description: STRING_8 = "Render Wikitext as HTML."

feature -- Conversion

	filter (a_text: STRING_GENERAL)
		local
			wk: WIKI_CONTENT_TEXT
			utf: UTF_CONVERTER
			l_wikitext: STRING_8
			vis: WIKI_XHTML_GENERATOR
			html: STRING
		do
			if attached {STRING_8} a_text as s8 then
				l_wikitext := s8
			elseif attached {STRING_32} a_text as s32 then
				if s32.is_valid_as_string_8 then
					l_wikitext := s32.as_string_8
				else
					l_wikitext := adapted_text (s32)
				end
			else
				l_wikitext := adapted_text (a_text)
			end
			create wk.make_from_string (l_wikitext)
			if attached wk.structure as st then
				create html.make (l_wikitext.count)
				create vis.make (html)
				vis.code_aliases.extend ("eiffel")
				vis.code_aliases.extend ("e")
				st.process (vis)
				a_text.set_count (0)
--				if attached {STRING_8} a_text as s8 then
--					s8.wipe_out
--				elseif attached {STRING_32} a_text as s32 then
--					s32.wipe_out
--				end
				if attached {STRING_32} a_text as a_unicode_text then
					a_text.append (utf.utf_8_string_8_to_string_32 (html))
				else
					a_text.append (html)
				end
			end
		end

	adapted_text (s: READABLE_STRING_32): STRING_8
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (s)
		end

end
