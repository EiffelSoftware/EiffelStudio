class SHARED_AST_CONTEXT
	
feature {NONE}

	context: AST_CONTEXT is
			-- Context for third pass
		once
			!!Result.make;
		end;

end
