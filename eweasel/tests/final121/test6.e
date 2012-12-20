class TEST6 [T]

feature -- Access

	item alias "[]", at alias "@" (i: INTEGER): T assign put
			-- Entry at index `i', if in index interval
		local
			r: detachable T
		do
			check attached r then
				Result := r
			end
		end

feature -- Element change

	put (v: T; i: INTEGER)
			-- Replace `i'-th entry, if in index interval, by `v'.
		do
		end

end

