note
	description: "Summary description for {WDOCS_CACHE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_CACHE [G -> ANY]

feature -- Status report

	exists: BOOLEAN
			-- Do associated cache file exists?
		deferred
		end

	expired (a_reference_date: detachable DATE_TIME; a_duration_in_seconds: INTEGER): BOOLEAN
			-- Is associated cached item expired?
			-- If `a_reference_date' is attached, cache is expired if `a_reference' is more recent than cached item.
		local
			d1, d2: DATE_TIME
		do
			if exists then
				if
					a_reference_date /= Void and then
					a_reference_date > cache_date_time
				then
					Result := True
				else
					if a_duration_in_seconds = -1 then
						Result := False -- Never expires
					elseif a_duration_in_seconds = 0 then
						Result := True -- Always expires
					elseif a_duration_in_seconds > 0 then
						d1 := cache_date_time
						create d2.make_now_utc
						d2.second_add (- a_duration_in_seconds) --| do not modify `cache_date_time'
						Result := d2 > d1 -- cached date + duration is older than current date
					else
							-- Invalid expiration value
							-- thus always expired.
						Result := True
					end
				end
			else
				Result := True
			end
		end

feature -- Access

	item: detachable G
		deferred
		end

	cache_date_time: DATE_TIME
			-- UTC date time for current cache if exists.
		require
			exists: exists
		deferred
		end

	cache_duration_in_seconds: INTEGER_64
			-- Number of seconds since cache was set.
		require
			exists: exists
		local
			d1, d2: DATE_TIME
		do
			d1 := cache_date_time
			create d2.make_now_utc
			Result := d2.relative_duration (d1).seconds_count
		end

feature -- Element change

	put (g: G)
		deferred
		end

end
