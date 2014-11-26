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
				log.write_information (generator + ".execute with req: " + req.debug_output)
				if attached req.raw_header_data as l_header_data  then
					log.write_debug (generator + ".execute with req header: " + l_header_data)
				end
				if attached req.raw_input_data as l_input_data  then
					log.write_debug (generator + ".execute with req input: " + l_input_data)
				end
				execute_next (req, res)
			else
				log.write_critical (generator + ".execute" + api.as_string_representation )
				(create {ERROR_500_CMS_RESPONSE}.make (req, res, api)).execute
				api.reset
			end
		end

end
