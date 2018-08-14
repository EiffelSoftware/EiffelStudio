note
	description: "Abstract interface for cache of value conforming to formal {G}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CACHE [G -> ANY]

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
						d2 := current_date_time
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
			-- Value from the cache.
		deferred
		end

	cache_date_time: DATE_TIME
			-- Date time for current cache if exists.
			-- Note: it may be UTC or not , depending on cache type.
		deferred
		end

	cache_duration_in_seconds: INTEGER_64
			-- Number of seconds since cache was set.
		require
			exists: exists
		do
			Result := current_date_time.relative_duration (cache_date_time).seconds_count
		end

	current_date_time: DATE_TIME
			-- Current date time for relative duration with cache_date_time.
		deferred
		end

feature -- Element change

	delete
			-- Remove cache.
		deferred
		end

	put (g: G)
			-- Put `g' into cache.
		deferred
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
