note
	description: "[
			Represent an input type color
			Example
			<input id="color" name="color" type="color">
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=color", "src=https://html.spec.whatwg.org/multipage/forms.html#color-state-(type=color)"
class
	WSF_FORM_COLOR_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "color"
end

