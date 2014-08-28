note
	description: "Summary description for {CMS_HOOK_FORM_ALTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_HOOK_FORM_ALTER

inherit
	CMS_HOOK

feature -- Hook

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_execution: CMS_EXECUTION)
		deferred
		end

end
