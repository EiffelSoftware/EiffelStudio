class SHARED_AST_CONTEXT

feature {NONE}

	Context: AST_CONTEXT is
			-- Context for third pass
		once
			create Result.make
		end

end
