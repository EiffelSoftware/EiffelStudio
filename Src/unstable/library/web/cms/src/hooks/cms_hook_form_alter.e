note
	description: "[
			Hook providing a way to alter a form.
		]"
	date: "$Date$"

deferred class
	CMS_HOOK_FORM_ALTER

inherit
	CMS_HOOK

feature -- Hook

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Hook execution on form `a_form' and its associated data `a_form_data',
			-- for related response `a_response'.
		deferred
		end

end
