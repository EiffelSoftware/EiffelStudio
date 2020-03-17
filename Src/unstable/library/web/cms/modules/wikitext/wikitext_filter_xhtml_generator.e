note
	description: "Summary description for {WIKITEXT_FILTER_XHTML_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKITEXT_FILTER_XHTML_GENERATOR

inherit
	WIKI_XHTML_GENERATOR
		redefine
			make,
			visit_page,
			is_newline_required_after_code_block
		end

create
	make

feature {NONE} -- Initialization

	make (b: like buffer)
		do
			Precursor (b)
			set_is_auto_toc_enabled (True)
		end
feature -- Page processing

	visit_page (a_page: WIKI_PAGE)
		local
			b: like is_html_encoded_output
		do
			current_page := a_page
			if attached a_page.structure as st then
				output ("<div class=%"wikipage%">")

				if attached page_title (a_page) as t and then not t.is_whitespace then
					output ("<h1 class=%"wikititle%">")
					b := is_html_encoded_output
					set_html_encoded_output (True)
					output (page_title (a_page))
					set_html_encoded_output (b)
					output ("</h1>%N")
				end

				if is_auto_toc_enabled then
					output_toc (Void, True)
				end
				st.process (Current)
				output ("</div>%N")
			end
			current_page := Void
		end

feature -- Settings

	is_newline_required_after_code_block: BOOLEAN = False
		-- <Precursor>
		-- should be handled by css style.

end
