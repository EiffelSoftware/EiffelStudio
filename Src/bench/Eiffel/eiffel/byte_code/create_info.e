-- Informations on creation type.

deferred class CREATE_INFO 

inherit

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end;
	BYTE_CONST
		export
			{NONE} all
		end
	
feature -- C code generation

	analyze is
			-- Analyze creation type: look for Dtype(Current) usage.
		deferred
		end;

	generate is
			-- Generate creation type
		deferred
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for creation type evaluation
		deferred
		end;

feature -- Debug

	trace is
		deferred
		end

end
