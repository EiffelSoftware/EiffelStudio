note
	description: "Summary description for {ES_CLOUD_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_CONFIG

create
	make

feature {NONE} -- Initialization

	make
		do
			session_expiration_delay := 60 -- minutes
			session_archive_age := 730 -- ~ 2 years
			shop_provider_name := "Eiffel Software"
		end

feature -- Access

	api_secret: detachable IMMUTABLE_STRING_8

	session_expiration_delay: INTEGER assign set_session_expiration_delay
			-- Delay in minutes before marking a session as expired.

	shop_provider_name: IMMUTABLE_STRING_32

	auto_trial_enabled: BOOLEAN

	auto_trial_plan_name: detachable IMMUTABLE_STRING_32

	additional_notification_email: detachable IMMUTABLE_STRING_8

	additional_error_notification_email: detachable IMMUTABLE_STRING_8

	session_archive_age: INTEGER assign set_session_archive_age
			-- Age in days for sessions to be archived.

feature -- Element change

	set_api_secret (s: detachable READABLE_STRING_GENERAL)
		do
			if s /= Void then
				create api_secret.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s))
			else
				api_secret := Void
			end
		end

	set_session_expiration_delay (d: INTEGER)
		do
			session_expiration_delay := d
		end

	set_session_archive_age (d: INTEGER)
		require
			d > 0
		do
			session_archive_age := d
		end

	set_shop_provider_name (v: READABLE_STRING_GENERAL)
		do
			create shop_provider_name.make_from_string_general (v)
		end

	set_additional_notification_email (v: READABLE_STRING_GENERAL)
		do
			create additional_notification_email.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (v))
		end

	set_additional_error_notification_email (v: READABLE_STRING_GENERAL)
		do
			create additional_error_notification_email.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (v))
		end

	enable_auto_trial (a_pl_name: detachable READABLE_STRING_GENERAL)
		do
			auto_trial_enabled := True
			if a_pl_name = Void then
				auto_trial_plan_name := Void
			else
				create auto_trial_plan_name.make_from_string_general (a_pl_name)
			end
		end

end
