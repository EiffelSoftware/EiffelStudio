note
	description: "Summary description for {ES_CLOUD_LICENSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSE

create
	make_with_id,
	make

feature {NONE} -- Initialization

	make_with_id (a_id: INTEGER_64; k: READABLE_STRING_GENERAL;	pl: ES_CLOUD_PLAN)
		do
			id := a_id
			make (k, pl)
		end

	make (k: READABLE_STRING_GENERAL; pl: ES_CLOUD_PLAN)
		do
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

	platforms: detachable LIST [IMMUTABLE_STRING_32]
			-- Limited to list of platform.

	platforms_as_csv_string: detachable STRING_32
		do
			if attached platforms as l_platforms then
				create Result.make_empty
				across
					l_platforms as ic
				loop
					if not Result.is_empty then
						Result.extend (',')
					end
					Result.append (ic.item)
				end
			end
		end

	version: detachable IMMUTABLE_STRING_32
			-- Limited to version

	status: INTEGER
			-- Status value.

	creation_date: DATE_TIME

	expiration_date: detachable DATE_TIME

	fallback_date: detachable DATE_TIME
			-- Date of the fallback license acquisition (if any)

	is_fallback: BOOLEAN
			-- Is fallback perpetual license
		do
			Result := fallback_date /= Void
		end

	may_be_eligible_to_fallback: BOOLEAN
		local
			dt: DATE_TIME
		do
			if plan.has_price then
				create dt.make_now_utc
				dt.day_add (-365)
				if creation_date < dt then
					Result := True
				end
			end
		end

feature -- Status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	is_active: BOOLEAN
		do
			if is_suspended then
					-- False
			elseif attached expiration_date as l_exp_date then
				Result := l_exp_date >= (create {DATE_TIME}.make_now_utc)
			else
				Result := True
			end
		end

	is_suspended: BOOLEAN
			-- License suspended
			--| note: could be due to failing payment
			--|		  or manual decision
		do
			Result := status = status_suspended
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
				Result := ((secs + 60) // (60 * 60 * 24)).to_integer_32
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

	platforms_limit: NATURAL
		do
			Result := plan.platforms_limit
		end

	heartbeat: NATURAL
		do
			Result := plan.heartbeat
		end

	duration_in_days: NATURAL
			-- Number of days since the creation of the license, until the expiration date, or until today.
		local
			dt, l_creation: DATE_TIME
		do
			l_creation := creation_date
			create dt.make_now_utc
			if attached expiration_date as exp and then
				exp < dt
			then
				dt := exp
			end
			Result := (dt.relative_duration (l_creation).seconds_count // (24 * 60 * 60)).to_natural_32
		end

feature -- Platform restriction

	is_waiting_for_platform_value (a_platform: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached platforms as pfs then
				if
					a_platform /= Void and then
					across pfs as ic some ic.item.is_case_insensitive_equal_general (a_platform) end
				then
						-- Platform `a_platform` is already accepted.
					Result := False
				else
					Result := pfs.count < platforms_limit.to_integer_32
				end
			else
				Result := True
			end
		end

	accept_platform (a_platform: READABLE_STRING_GENERAL)
			-- Add `a_platform` as accepted platform
		local
			l_platforms: like platforms
		do
			l_platforms := platforms
			if l_platforms = Void then
				create {ARRAYED_LIST [IMMUTABLE_STRING_32]} l_platforms.make (1)
				platforms := l_platforms
			end
			l_platforms.force (create {IMMUTABLE_STRING_32}.make_from_string_general (a_platform))
		end

	set_platforms_restriction (a_platforms: detachable READABLE_STRING_GENERAL)
		require
			is_waiting_for_platform_value (Void)
		do
			if a_platforms = Void then
				set_platforms (Void)
			else
				set_platforms (a_platforms.split (','))
			end
		end

feature -- License validity

	is_valid (pf, a_prod_version: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := True
			if is_active then
				Result := is_accepted_platform (pf)
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
					Result := Result and then is_accepted_platform (pf)
				else
					Result := False
				end
			else
				Result := False
			end
		end

	is_accepted_platform (pf: detachable READABLE_STRING_GENERAL): BOOLEAN
		local
			l_platform: READABLE_STRING_32
		do
			if attached platforms as l_platforms then
				if platforms_limit = 0 or else l_platforms.count.to_natural_32 < platforms_limit then
					Result := True
				else
					across
						l_platforms as ic
					until
						Result
					loop
						l_platform := ic.item
						if l_platform.same_string ({STRING_32} "*") then
							Result := True
						elseif pf = Void then
							Result := False
						elseif pf.is_case_insensitive_equal (l_platform) then
							Result := True
		--				elseif generic_platform_name (pf).is_case_insensitive_equal (l_platform) then
		--					Result := True
						else
							Result := False
						end
					end
				end
			else
				Result := True
			end
		end

	generic_platform_name (v: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		do
			if
				v.is_case_insensitive_equal ("windows")
				or v.is_case_insensitive_equal ("win64")
			then
				Result := platform_windows
			elseif v.as_lower.starts_with ("linux") then
				Result := platform_linux
			elseif v.as_lower.starts_with ("macos") then
				Result := platform_macos
			else
				Result := v
			end
		end

feature -- Element change

	reset_date
		do
			create creation_date.make_now_utc
			expiration_date := Void
		end

	set_plan (p: like plan)
		do
			plan := p
		end

	set_platforms (v: detachable LIST [READABLE_STRING_GENERAL])
		local
			lst: ARRAYED_LIST [IMMUTABLE_STRING_32]
			pf: READABLE_STRING_GENERAL
		do
			if v = Void then
				platforms := Void
			else
				create lst.make (v.count)
				across
					v as ic
				loop
					pf := ic.item
					if not pf.is_whitespace then
						lst.force (create {IMMUTABLE_STRING_32}.make_from_string_general (pf))
					end
				end
				if lst.is_empty then
					platforms := Void
				else
					platforms := lst
				end
			end
				-- Do not use general platform, but specific!
-- TODO: to restore general platform cases, take the platforms `v` as comma separated values!				
--				if
--					v.is_case_insensitive_equal ("windows")
--					or 	v.is_case_insensitive_equal ("win64")
--				then
--					platform := platform_windows
--				elseif v.as_lower.starts_with ("linux") then
--					platform := platform_linux
--				elseif v.as_lower.starts_with ("macos") then
--					platform := platform_macos
--				else
--					..
--				end
--			end
		end

	set_version (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void or else v.is_whitespace then
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

	set_status (st: like status)
		do
			status := st
		end

	suspend
		do
			status := status_suspended
		end

	resume
		require
			is_suspended
		do
			status := 0
		end

	set_remaining_days (nb_days: NATURAL_32)
		local
			dt: DATE_TIME
		do
			create dt.make_now_utc
			dt.day_add (nb_days.to_integer_32)
			expiration_date := dt
		ensure
			days_remaining = nb_days.to_integer_32
		end

	set_fallback_date (dt: like fallback_date)
		do
			fallback_date := dt
		end

feature -- Constants

	status_suspended: INTEGER = 8

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
