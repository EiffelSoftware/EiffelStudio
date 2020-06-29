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
			shop_provider_name := "Eiffel Software"
		end

feature -- Access

	session_expiration_delay: INTEGER assign set_session_expiration_delay
			-- Delay in minutes before marking a session as expired.

	shop_provider_name: IMMUTABLE_STRING_32

	auto_trial_enabled: BOOLEAN

feature -- Element change

	set_session_expiration_delay (d: INTEGER)
		do
			session_expiration_delay := d
		end

	set_shop_provider_name (v: READABLE_STRING_GENERAL)
		do
			create shop_provider_name.make_from_string_general (v)
		end

	enable_auto_trial
		do
			auto_trial_enabled := True
		end

end
