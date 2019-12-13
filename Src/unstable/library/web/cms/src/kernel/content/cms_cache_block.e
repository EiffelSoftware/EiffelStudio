note
	description: "[
			CMS_BLOCK implemented with a `cache'
			as caching solution.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CACHE_BLOCK

inherit
	CMS_BLOCK

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_cache: like cache)
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			is_enabled := True
			name := a_name
			cache := a_cache
			set_is_raw (True)
		end

feature -- Access

	name: READABLE_STRING_8
			-- <Precursor>

feature {NONE} -- Access			

	cache: CMS_CACHE [READABLE_STRING_8]
			-- Cache content.

feature -- Cache update

	set_cache_content (a_cache_content: READABLE_STRING_8)
		do
			cache.put (a_cache_content)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is current block empty?
		do
			Result := is_raw and not cache.exists
		end

	is_raw: BOOLEAN assign set_is_raw
			-- Is raw?
			-- If True, do not get wrapped it with block specific div	

feature -- Element change

	set_is_raw (b: BOOLEAN)
		do
			is_raw := b
		end

	set_name (n: like name)
			-- Set `name' to `n'.
		require
			not n.is_whitespace
		do
			name := n
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		do
			debug
				print ("REUSE CACHE for [" + name + "]!!!%N")
			end
				-- Why in this particular case theme is not used to generate the content?
			if attached cache.item as l_content then
				create Result.make (l_content.count + 50)
				Result.append ("<!-- Block %"")
				Result.append (name)
				Result.append ("%" cached: ")
				Result.append (cache.cache_date_time.out)
				Result.append (" -->%N")
				Result.append (l_content)
			else
				Result := ""
				check exists: False end
			end
		end
note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
