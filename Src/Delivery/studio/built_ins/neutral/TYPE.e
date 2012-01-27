class TYPE [G]

feature
	
	default: G
		local
			r: detachable G
		do
				-- Can get here only for expanded or detachable reference types.
				-- The latter are taken care by the compiler during code generation.
			check attached r then
				Result := r
			end
		end

end
