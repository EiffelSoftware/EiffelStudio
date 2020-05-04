note
	description: "Summary description for {ES_CLOUD_LICENSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSE

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER_64; k: READABLE_STRING_GENERAL;	pl: ES_CLOUD_PLAN)
		do
			id := a_id
			create key.make_from_string_general (k)
			plan := pl
			create creation_date.make_now_utc
		end

feature -- Access

	id: INTEGER_64
			-- License unique id.

	key: IMMUTABLE_STRING_32
			-- License key

	plan: ES_CLOUD_PLAN

	platform: detachable IMMUTABLE_STRING_32
			-- Limited to platform

	version: detachable IMMUTABLE_STRING_32
			-- Limited to version

	creation_date: DATE_TIME

	expiration_date: detachable DATE_TIME

	fallback_date: detachable DATE_TIME
			-- Date of the fallback license acquisition (if any)

	is_fallback: BOOLEAN
			-- Is fallback perpetual license
		do
			Result := fallback_date /= Void
		end

feature -- Status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	is_active: BOOLEAN
		do
			if attached expiration_date as l_exp_date then
				Result := l_exp_date >= (create {DATE_TIME}.make_now_utc)
			else
				Result := True
			end
		end

	is_expired: BOOLEAN
		do
			Result := not is_active
		end

	days_remaining: INTEGER
			-- Number of days remaining.
			-- Relevant only when `expiration_date` is set!
		local
			now: DATE_TIME
			secs: INTEGER_64
			is_neg: BOOLEAN
		do
			create now.make_now_utc
			if attached expiration_date as exp then
				secs := exp.relative_duration (now).seconds_count
				if secs < 0 then
					is_neg := True
					secs := -secs
				end
				Result := (secs // (60 * 60 * 24)).to_integer_32
				if is_neg then
					Result := - Result
				end
			else
				Result := 0
			end
		end

	concurrent_sessions_limit: NATURAL
		do
			Result := plan.concurrent_sessions_limit
		end

	installations_limit: NATURAL
		do
			Result := plan.installations_limit
		end

	heartbeat: NATURAL
		do
			Result := plan.heartbeat
		end

feature -- License validity

	is_valid (pf, a_prod_version: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := True
			if is_active then
				if
					attached platform as l_platform and then
					(pf = Void or else not pf.is_case_insensitive_equal (l_platform))
				then
					Result := False
				end
				if
					attached version as l_version and then
					(a_prod_version = Void or else not a_prod_version.is_case_insensitive_equal (l_version))
				then
					Result := False
				end
			elseif is_fallback then
				if attached version as l_version then
					if
						(a_prod_version = Void or else not a_prod_version.is_case_insensitive_equal (l_version))
					then
						Result := False
					end
					if
						attached platform as l_platform and then
						(pf = Void or else not pf.is_case_insensitive_equal (l_platform))
					then
						Result := False
					end
				else
					Result := False
				end
			else
				Result := False
			end
		end

feature -- Element change

	set_plan (p: like plan)
		do
			plan := p
		end

	set_platform (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				platform := Void
			else
				if
					v.is_case_insensitive_equal ("windows")
					or 	v.is_case_insensitive_equal ("win64")
				then
					platform := platform_windows
				elseif v.as_lower.starts_with ("linux") then
					platform := platform_linux
				elseif v.as_lower.starts_with ("macos") then
					platform := platform_macos
				else
					create platform.make_from_string_general (v)
				end
			end
		end

	set_version (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				version := Void
			else
				create version.make_from_string_general (v)
			end
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end

	set_expiration_date (dt: like expiration_date)
		do
			expiration_date := dt
		end

	set_remaining_days (nb_days: NATURAL_32)
		local
			dt: DATE_TIME
		do
			create dt.make_now_utc
			dt.day_add (nb_days.to_integer_32)
			expiration_date := dt
		end

	set_fallback_date (dt: like fallback_date)
		do
			fallback_date := dt
		end

feature -- Constants

	platform_windows: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ("windows")
		end

	platform_linux: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ("linux")
		end

	platform_macos: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ("macos")
		end

feature {CMS_STORAGE_SQL_I} -- Element change

	update_id (a_id: like id)
		do
			id := a_id
		end

end
