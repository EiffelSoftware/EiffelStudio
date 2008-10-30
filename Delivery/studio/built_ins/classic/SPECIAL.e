class SPECIAL [T]

feature
	
	frozen item alias "[]" (i: INTEGER): T assign put is
		local
			r: ?T
		do
			check
				r_attached: r /= Void
			end
			Result := r
		end

	frozen make (n: INTEGER)
		do
		end

	frozen put (v: T; i: INTEGER) is
		do
		end

end
