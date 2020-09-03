note
	description: "Summary description for {EWF_DOWNLOAD_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DOWNLOAD_CONFIGURATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make (a_layout: APPLICATION_LAYOUT)
		do
			layout := a_layout
		end

feature --Access Services

	layout: APPLICATION_LAYOUT

	email_service: detachable EMAIL_SERVICE
			-- Email service.

	data_service: detachable DATA_SERVICE
			-- Data service.

	enterprise_download_service: detachable DOWNLOAD_SERVICE
			-- Download service.
		do
			create Result.make ((create {DOWNLOAD_JSON_CONFIGURATION}).new_download_configuration (layout.config_path.extended ("downloads_enterprise_configuration.json")))
		end

	standard_download_service: detachable DOWNLOAD_SERVICE
			-- Download service.
		do
			create Result.make ((create {DOWNLOAD_JSON_CONFIGURATION}).new_download_configuration (layout.config_path.extended ("downloads_standard_configuration.json")))
		end

	is_using_safe_redirection: BOOLEAN assign set_is_using_safe_redirection
			-- Use safe redirection when url contains embedded credential.

feature -- Change Element

	set_email_service (a_email_service: like email_service)
		do
			email_service := a_email_service
		end

	set_data_service (a_data_service: like data_service)
		do
			data_service := a_data_service
		end

	set_is_using_safe_redirection (b: BOOLEAN)
		do
			is_using_safe_redirection := b
		end

end
