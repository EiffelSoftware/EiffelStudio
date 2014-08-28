note
	description: "Summary description for {CMS_FORM}."
	author: ""
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

	prepare (a_execution: CMS_EXECUTION)
		do
			a_execution.service.call_form_alter_hooks (Current, Void, a_execution)
		end

	process (a_execution: CMS_EXECUTION)
		do
			process_form (a_execution.request, agent on_prepared (a_execution, ?), agent on_processed (a_execution, ?))
		end

	on_prepared (a_execution: CMS_EXECUTION; fd: WSF_FORM_DATA)
		do
			a_execution.service.call_form_alter_hooks (Current, fd, a_execution)
		end

	on_processed (a_execution: CMS_EXECUTION; fd: WSF_FORM_DATA)
		do
			if not fd.is_valid or fd.has_error then
				a_execution.report_form_errors (fd)
			end
		end

end
