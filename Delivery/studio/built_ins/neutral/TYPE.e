class TYPE [G]

feature
	
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
