note
	description: "[
			Represent the input type url
			Example
			<input type="url" name="url" required>
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=url", "src=https://html.spec.whatwg.org/multipage/forms.html#url-state-(type=url)"

class
	WSF_FORM_URL_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "url"
end
