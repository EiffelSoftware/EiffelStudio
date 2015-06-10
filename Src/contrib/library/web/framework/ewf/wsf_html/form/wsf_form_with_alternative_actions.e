note
	description: "[
		Represent alternative actions for forms
		The formaction, formenctype, formmethod, and formtarget attributes.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=form submission", "src=https://html.spec.whatwg.org/multipage/forms.html#form-submission"

class
	WSF_FORM_WITH_ALTERNATIVE_ACTIONS

feature -- Access

	formnovalidate: BOOLEAN
			-- indicate that the form shouldn’t be validated when submitted.
			-- it's only applicable to input type=submit or image.

	formaction: detachable READABLE_STRING_32
			-- formaction specifies the file or application that will submit the form.
			-- It has the same effect as the action attribute on the form element and
			-- can only be used with a submit or image button (type="submit" or type="image").
			-- When the form is submitted, the browser first checks for a formaction attribute;
			-- if that isn’t present, it proceeds to look for an action attribute on the form.

	formenctype: detachable READABLE_STRING_32
			-- formenctype details how the form data is encoded with the POST method type.
			-- It has the same effect as the enctype attribute on the form element and
			-- can only be used with a submit or image button (type="submit" or type="image").
			-- The default value if not included is application/x-www-formurlencoded.
			--! At the moment the value is not validated.

	formmethod: detachable READABLE_STRING_32
			-- formmethod specifies which HTTP method (GET, POST, PUT, DELETE) will be used to submit the form data.
			-- It has the same effect as the method attribute on the form element and can only be used with a
			-- submit or image button (type="submit" or type="image").
			--!At the moment the value is not validated.

	formtarget: detachable READABLE_STRING_32
			-- formtarget specifies the target window for the form results.
			--  It has the same effect as the target attribute on the form element and can only be used with a submit or image button (type="submit" or type="image").


feature -- Element Change


	set_formnovalidate
			-- Set formnovalidate to True.
		do
			formnovalidate := True
		ensure
			formnovalidate_true: formnovalidate
		end

	unset_formnovalidate
			-- Set formnovalidate to False.
		do
			formnovalidate := False
		ensure
			formnovalidate_false: not formnovalidate
		end

	set_formaction (a_action: READABLE_STRING_32)
			-- Set `formaction' with `a_action'.
			-- Example:<input type="submit" value="Submit" formaction="/users">
		do
			formaction := a_action
		ensure
			formaction_set: attached formaction as l_action implies l_action = a_action
		end

	set_formenctype (a_enctype: READABLE_STRING_32)
			-- Set `formenctype' with `a_enctype'.
			-- Example: <input type="submit" value="Submit" formenctype="application/x-www-form-urlencoded">
		do
			formenctype := a_enctype
		ensure
			formenctype_set: attached formenctype as l_enctype implies l_enctype = a_enctype
		end

	set_formmethod (a_method: READABLE_STRING_32)
			-- Set `formmethod' with `a_method'.
			-- Example: <input type="submit" value="Submit" formmethod="POST">
			--! require is_valid_method: [PUT, POST, DELETE, GET, ...]
		do
			formmethod := a_method
		ensure
			formmethod_set: attached formmethod as l_method implies l_method = a_method
		end

	set_formtarget (a_target: READABLE_STRING_32)
			-- Set `formtarget' with `a_target'.
			-- Example: <input type="submit" value="Submit" formtarget="_self">
		do
			formtarget := a_target
		ensure
			formtarget_set: attached formtarget as l_target implies l_target = a_target
		end


feature {NONE} -- Conversion

	append_submit_image_input_attributes_to (a_target: STRING_8)
				-- Append specific input attributes for submit/image to a_target,
		do
				--formnovalidate
			if formnovalidate then
				a_target.append (" formnovalidate")
			end
				--formaction
			if attached formaction as l_formaction then
				a_target.append (" formaction=%"")
				a_target.append (l_formaction)
				a_target.append_character ('%"')
			end
				--formenctype
			if attached formenctype as l_enctype then
				a_target.append (" formenctype=%"")
				a_target.append (l_enctype)
				a_target.append_character ('%"')
			end
				-- formmethod
			if attached formmethod as l_method then
				a_target.append (" formmethod=%"")
				a_target.append (l_method)
				a_target.append_character ('%"')
			end

				-- formmethod
			if attached formtarget as l_target then
				a_target.append (" formtarget=%"")
				a_target.append (l_target)
				a_target.append_character ('%"')
			end
		end

end
