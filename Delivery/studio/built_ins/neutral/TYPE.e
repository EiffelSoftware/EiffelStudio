class TYPE [G]

feature
	
	has_default: BOOLEAN
		do
			-- Built-in
		end

	default: G
		local
			r: detachable G
		do
				-- Built-in
			check
				r_attached: r /= Void
			end
			Result := r
		end

end
