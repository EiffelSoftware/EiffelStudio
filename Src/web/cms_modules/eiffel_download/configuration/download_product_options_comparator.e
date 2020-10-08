note
	description: "Summary description for {DOWNLOAD_PRODUCT_OPTIONS_COMPARATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_PRODUCT_OPTIONS_COMPARATOR

inherit
	PART_COMPARATOR [DOWNLOAD_PRODUCT_OPTIONS]

feature -- Status report

	less_than (u, v: DOWNLOAD_PRODUCT_OPTIONS): BOOLEAN
			-- Is `u' considered less than `v'?
		local
			up,vp: READABLE_STRING_GENERAL
			uw, vw: INTEGER
		do
			up := u.platform
			vp := v.platform
			if up.same_string (vp) then
				uw := extension_weight (extension (u.filename))
				vw := extension_weight (extension (v.filename))
				if uw = vw then
					Result := u.filename < v.filename
				else
					Result := uw < vw
				end
			else
				uw := platform_weight (up)
				vw := platform_weight (vp)
				if uw = vw then
					Result := up < vp
				else
					Result := uw < vw
				end
			end
		end

	extension (fn: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		local
			i: INTEGER
		do
			i := fn.last_index_of ('.', fn.count)
			if i > 0 then
				Result := fn.substring (i + 1, fn.count)
			else
				Result := ""
			end
		end

	extension_weight (e: READABLE_STRING_GENERAL): INTEGER
		local
			tb: like extensions_weights
		do
			tb := extensions_weights
			if tb = Void then
				create tb.make_caseless (5)
				extensions_weights := tb
			end
			Result := tb.item (e)
			if Result = 0 then
				if e.is_case_insensitive_equal ("msi") then
					Result := 1
				elseif e.is_case_insensitive_equal ("7z") then
					Result := 2
				elseif e.is_case_insensitive_equal ("tar.bz2") then
					Result := 3
				else
					Result := 10
				end
				tb.put (Result, e)
			end
		end

	platform_weight (p: READABLE_STRING_GENERAL): INTEGER
		local
			tb: like platform_weights
		do
			tb := platform_weights
			if tb = Void then
				create tb.make_caseless (5)
				platform_weights := tb
			end
			Result := tb.item (p)
			if Result = 0 then
				if p.starts_with ("win") then
					Result := 1
				elseif p.is_case_insensitive_equal ("linux-x86-64") then
					Result := 2
				elseif p.is_case_insensitive_equal ("linux-x86") then
					Result := 3
				elseif p.starts_with ("linux") then
					Result := 4
				elseif p.starts_with ("macosx") then
					Result := 5
				else
					Result := 10
				end
				tb.put (Result, p)
			end
		end

	extensions_weights: detachable STRING_TABLE [INTEGER]

	platform_weights: detachable STRING_TABLE [INTEGER]

end
