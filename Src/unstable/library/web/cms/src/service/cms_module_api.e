note
	description: "Common ancestor for all module apis."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MODULE_API

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API)
		do
			cms_api := a_api
			initialize
		end

	initialize
			-- Initialize Current api.
		do
			create error_handler.make
		end

feature -- Access: error handling

	error_handler: ERROR_HANDLER
			-- Error handler.

	reset_error
			-- Reset error handler.
		do
			error_handler.reset
		end

	has_error: BOOLEAN
			-- Error occurred?
		do
			Result := error_handler.has_error
		end

feature {CMS_API_ACCESS, CMS_MODULE, CMS_API} -- Restricted access		

	cms_api: CMS_API

	storage: CMS_STORAGE
		do
			Result := cms_api.storage
		end

feature -- Bridge to CMS API

	html_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded for html output.
		do
			Result := cms_api.html_encoded (a_string)
		end

	url_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded with percent encoding, mainly used for url.
		do
			Result := cms_api.url_encoded (a_string)
		end

	utf_8_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string` encoded using UTF-8.
		do
			Result := cms_api.utf_8_encoded (a_string)
		end

	percent_encoded (a_string: READABLE_STRING_GENERAL): STRING_8
			-- `a_string' encoded with percent encoding, mainly used for url.
		do
			Result := cms_api.percent_encoded (a_string)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
