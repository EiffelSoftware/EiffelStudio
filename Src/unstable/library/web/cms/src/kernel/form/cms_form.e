note
	description: "Summary description for {CMS_FORM}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORM

inherit
	WSF_FORM
		rename
			process as process_form
		end

create
	make

feature -- Basic operation

	prepare (a_response: CMS_RESPONSE)
		do
			a_response.api.hooks.invoke_form_alter (Current, Void, a_response)
		end

	process (a_response: CMS_RESPONSE)
		do
			process_form (a_response.request, agent on_prepared (a_response, ?), agent on_processed (a_response, ?))
		end

	on_prepared (a_response: CMS_RESPONSE; fd: WSF_FORM_DATA)
		do
			a_response.api.hooks.invoke_form_alter (Current, fd, a_response)
		end

	on_processed (a_response: CMS_RESPONSE; fd: WSF_FORM_DATA)
		do
			if not fd.is_valid or fd.has_error then
				a_response.report_form_errors (fd)
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
