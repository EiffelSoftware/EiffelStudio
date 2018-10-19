note
	description: "Summary description for {EIFFEL_COMMUNITY_WEB_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB_EXECUTION

inherit
	CMS_EXECUTION
		redefine
			clean,
			execute_rescue
		end

	EIFFEL_COMMUNITY_WEB_STORAGE_SETUP

	EIFFEL_COMMUNITY_WEB_MODULE_SETUP

	EIFFEL_COMMUNITY_SITE_SERVICE

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature -- Cleaning

	clean
			-- Cleaning after request.
		do
			if attached api.storage as l_storage then
				l_storage.close
			end
			Precursor
		end

	execute_rescue (e: detachable EXCEPTION)
		local
			s: STRING
		do
			if e /= Void and then attached e.trace as l_trace then
				if not response.status_is_set then
					response.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
				end
				s := "Sorry an error occurred ..."
				if not response.header_committed then
					response.put_header_text ("Content-Type: text/html%R%NContent-Length: " + s.count.out + "%R%N%R%N")
				end
				if response.message_writable then
					response.put_string (s)
				end
			end
		end

feature {NONE} -- Implementation

	new_cms_environment: CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create Result.make_with_directory_name (l_dir)
			else
				create Result.make_default
			end
			Result.set_name ("eiffel_org")
		end

end

