note
	description: "[
		Represent an input type tel
		Example
		<input type="tel" name="tel" id="tel" required>
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=tel", "src=https://html.spec.whatwg.org/multipage/forms.html#telephone-state-(type=tel)"

class
	WSF_FORM_TEL_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "tel"
end
