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

	help: STRING = "[
		Wikitext rendered as HTML
		
		formatting: ''italics'', '''bold''', and '''''both'''''
		link:  	[[WikiName|Title ...]] , [https://example.com Title ...]
		
		sections: ==Level 2 ==
		          ===Level 3 ===
		          ====Level 4 ====
		          (=Level 1= is for page titles)
				  
		List:     * One
		          * Two
		          ** Two point one
		          * Three
						
		Numbered list:  # One
		                # Two
		                ## Two point one
		                # Three
						
		Code:   use `inline code`, or 
		        ```
		           multi lines code
		        ```
		        use ```lang ... ``` to declare the language: replace "lang" by eiffel, shell, xml, ...
		        ```eiffel
		        	class EIFFEL ...
		        ```
		        		
		Indenting:
		        :first indent
		        ::second indent
				
		For more, see https://en.wikipedia.org/wiki/Help:Cheatsheet
	]"

	description: STRING_8 = "Render Wikitext as HTML."

feature -- Conversion

	filter (a_text: STRING_GENERAL)
		local
			wp: WIKI_PAGE
			wk: WIKI_CONTENT_TEXT
			utf: UTF_CONVERTER
			l_wikitext: STRING_8
			vis: WIKITEXT_FILTER_XHTML_GENERATOR
			html: STRING
		do
			if attached {STRING_8} a_text as s8 then
				l_wikitext := s8
			elseif attached {STRING_32} a_text as s32 then
				if s32.is_valid_as_string_8 then
					l_wikitext := s32.to_string_8
				else
					l_wikitext := adapted_text (s32)
				end
			else
				l_wikitext := adapted_text (a_text)
			end
			l_wikitext.prune_all ('%R') -- FIXME: remove later once the wikitext parser handle "%R" and empty line.
			create wk.make_from_string (l_wikitext)
			create wp.make_with_title ("")
			wp.set_text (wk)
			create html.make (l_wikitext.count)
			create vis.make (html)
			vis.set_is_auto_toc_enabled (True)
			vis.code_aliases.extend ("eiffel")
			vis.code_aliases.extend ("e")
			wp.process (vis)
			a_text.set_count (0)
			if attached {STRING_32} a_text as a_unicode_text then
				a_text.append (utf.utf_8_string_8_to_string_32 (html))
			else
				a_text.append (html)
			end
		end

	adapted_text (s: READABLE_STRING_32): STRING_8
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (s)
		end

end
