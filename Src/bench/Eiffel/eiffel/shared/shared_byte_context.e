class SHARED_BYTE_CONTEXT
	
feature {NONE}

	context: BYTE_CONTEXT is
			-- Context for byte code processing
		once
			!!Result.make;
		end;

end
