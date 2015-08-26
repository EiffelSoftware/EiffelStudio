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

	database_service: detachable DATABASE_SERVICE
			-- Database service.

	download_service: detachable DOWNLOAD_SERVICE
			-- Download service.


feature -- Change Element

	set_email_service (a_email_service: like email_service)
		do
			email_service := a_email_service
		end

	set_database_service (a_database_service: like database_service)
		do
			database_service := a_database_service
		end

	set_download_service (a_download_service: like download_service)
		do
			download_service := a_download_service
		end
end
