note
	description: "Summary description for {ES_CLOUD_LICENSE_SUBSCRIPTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSE_SUBSCRIPTION

create
	make_yearly,
	make_monthly,
	make_weekly,
	make_daily,
	make

feature {NONE} -- Initialization

	make (a_license: like license; a_interval_type: NATURAL_8; a_interval_count: NATURAL_8)
		require
			a_license.has_id
		do
			license := a_license
			set_interval (a_interval_type, a_interval_count)
		end

	make_yearly (a_license: like license)
		do
			make (a_license, yearly, 1)
		end

	make_monthly (a_license: like license)
		do
			make (a_license, monthly, 1)
		end

	make_weekly (a_license: like license)
		do
			make (a_license, weekly, 1)
		end

	make_daily (a_license: like license)
		do
			make (a_license, daily, 1)
		end

feature -- Access

	license: ES_CLOUD_LICENSE

	subscription_reference: detachable IMMUTABLE_STRING_32

	cancellation_date: detachable DATE_TIME

	interval_type: NATURAL_8
			-- onetime, daily, ...,  monthly, yearly.

	interval_count: NATURAL_8
			-- interval quantity.
			-- note: 3 + monthly -> every 3 months.

feature -- Query

	is_yearly: BOOLEAN
		do
			Result := interval_type = yearly
		end

	is_monthly: BOOLEAN
		do
			Result := interval_type = monthly
		end

	is_weekly: BOOLEAN
		do
			Result := interval_type = weekly
		end

	is_daily: BOOLEAN
		do
			Result := interval_type = daily
		end

feature -- Interval constants

	undefined_interval: NATURAL_8 = 0

	yearly: NATURAL_8 = 1

	monthly: NATURAL_8 = 2

	weekly: NATURAL_8 = 3

	daily: NATURAL_8 = 4

	is_valid_interval (v: NATURAL_8): BOOLEAN
		do
			inspect v
			when yearly, monthly, weekly, daily then
				Result := True
			when undefined_interval then
				Result := True
			else

			end
		end

feature -- Basic operations

	cancel
		do
			if attached license.expiration_date as dt then
				cancellation_date := dt
			else
				create cancellation_date.make_now_utc
			end
		end

feature -- Element change

	set_interval (a_type: NATURAL_8; a_count: NATURAL_8)
		require
			is_valid_interval (a_type)
		do
			interval_type := a_type
			interval_count := a_count
		end

	set_cancellation_date (dt: DATE_TIME)
		do
			cancellation_date := dt
		end

	set_subscription_reference (ref: detachable READABLE_STRING_GENERAL)
		do
			if ref = Void then
				subscription_reference := Void
			else
				create subscription_reference.make_from_string_general (ref)
			end
		end

end
