note
	description: "[
		Represent the intput type email
		Example:
		<input type="email" name="email" required>
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=email", "src=https://html.spec.whatwg.org/multipage/forms.html#e-mail-state-(type=email)"

class
	WSF_FORM_EMAIL_INPUT

inherit

	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "email"

end
