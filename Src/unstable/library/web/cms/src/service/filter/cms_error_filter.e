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
		local
			utf: UTF_CONVERTER
		do
			debug ("refactor_fixme")
				fixme ("Check if it's ok to add new features CMS_API.has_error:BOOLEAN and CMS_API.error_description.")
			end
			if not api.has_error then
				api.logger.put_information (generator + ".execute with req: " + req.debug_output, Void)
				if attached req.raw_header_data as l_header_data  then
					api.logger.put_debug (generator + ".execute with req header: " + utf.escaped_utf_32_string_to_utf_8_string_8 (l_header_data), Void)
				end
				if attached req.raw_input_data as l_input_data  then
					api.logger.put_debug (generator + ".execute with req input: " + utf.escaped_utf_32_string_to_utf_8_string_8 (l_input_data), Void)
				end
				execute_next (req, res)
			else
				api.logger.put_critical (generator + ".execute " + utf_8_encoded (api.string_representation_of_errors), Void)
				(create {INTERNAL_SERVER_ERROR_CMS_RESPONSE}.make (req, res, api)).execute
				api.reset_error
			end
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
