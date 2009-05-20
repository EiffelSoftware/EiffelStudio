class SPECIAL [T]

feature
	
	frozen item alias "[]" (i: INTEGER): T assign put
		local
			r: detachable T
		do
			check
				r_attached: r /= Void
			end
			Result := r
		end

	frozen make (n: INTEGER)
		do
		end

	frozen make_empty (n: INTEGER)
		do
		end

	frozen put (v: T; i: INTEGER)
		do
		end

	frozen extend (v: T)
		do
		end

	frozen put_default (i: INTEGER)
		do
		end

end
