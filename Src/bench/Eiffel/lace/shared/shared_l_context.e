-- Shared access to lace context compilation

class SHARED_L_CONTEXT

feature

	context: LACE_CONTEXT is
			-- Lace compilation context
		once
			create Result
		end

end
