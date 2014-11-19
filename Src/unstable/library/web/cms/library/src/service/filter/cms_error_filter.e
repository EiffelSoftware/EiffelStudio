note
	description: "Summary description for {CMS_ERROR_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ERROR_FILTER

inherit

	WSF_URI_TEMPLATE_HANDLER
	CMS_HANDLER
	WSF_FILTER

create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		do
			fixme ("Check if it's ok to add new fetures CMS_API.has_error:BOOLEAN and CMS_API.error_description.")
			if not api.error_handler.has_error then
				log.write_information (generator + ".execute")
				execute_next (req, res)
			else
				log.write_critical (generator + ".execute" + api.error_handler.as_string_representation )
				(create {ERROR_500_CMS_RESPONSE}.make (req, res, api)).execute
				api.error_handler.reset
			end
		end

end
