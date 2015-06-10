note
	description: "[
		Represent the intput type search
		Example
		<input type="search" name="Search">			
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=search", "src=https://html.spec.whatwg.org/multipage/forms.html#text-(type=text)-state-and-search-state-(type=search)"
class
	WSF_FORM_SEARCH_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "search"
end
