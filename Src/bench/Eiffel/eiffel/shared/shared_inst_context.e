class SHARED_INST_CONTEXT
	
feature {NONE}

	Inst_context: INST_CONTEXT is
			-- Context of construction of actual types, instances of
			-- CL_TYPE_A
		once
			create Result;
		end;

end
