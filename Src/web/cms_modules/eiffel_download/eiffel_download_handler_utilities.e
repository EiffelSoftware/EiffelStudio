note
	description: "Summary description for {EIFFEL_DOWNLOAD_HANDLER_UTILITIES}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_DOWNLOAD_HANDLER_UTILITIES

inherit
	SHARED_LOGGER

	CMS_ENCODERS

feature {NONE} -- Implementation

	configuration_from_content (a_string: READABLE_STRING_GENERAL): detachable DOWNLOAD_CONFIGURATION
		local
			s: READABLE_STRING_8
		do
			s := utf_8_encoded (a_string)
			Result := (create {DOWNLOAD_JSON_CONFIGURATION}).configuration_from_string (s, Void)
		end

	configuration_from_file (a_uploaded_file: WSF_UPLOADED_FILE): detachable DOWNLOAD_CONFIGURATION
		do
			if attached a_uploaded_file.tmp_path as l_path then
				Result := (create {DOWNLOAD_JSON_CONFIGURATION}).configuration_from_file (l_path, Void)
				delete_uploaded_file (l_path)
			end
		end

	delete_uploaded_file (p: PATH)
			-- Remove uploaded temporal file at path `p'.
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if retried then
				write_error_log (generator + "Can not delete file %"" + p.utf_8_name + "%"")
			else
				create f.make_with_path (p)
				if f.exists then
					f.delete
				else
						-- Not considered as failure.
				end
			end
		rescue
			retried := True
			retry
		end

end
