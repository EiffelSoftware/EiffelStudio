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
			if not api.has_error then
				api.logger.put_information (generator + ".execute with req: " + req.debug_output, Void)
				if attached req.raw_header_data as l_header_data  then
					api.logger.put_debug (generator + ".execute with req header: " + l_header_data, Void)
				end
				if attached req.raw_input_data as l_input_data  then
					api.logger.put_debug (generator + ".execute with req input: " + l_input_data, Void)
				end
				execute_next (req, res)
			else
				api.logger.put_critical (generator + ".execute" + api.string_representation_of_errors, Void)
				(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				api.reset_error
			end
		end

end
