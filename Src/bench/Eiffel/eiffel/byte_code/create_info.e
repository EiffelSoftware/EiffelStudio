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

feature -- Generic conformance

	generate_start (node : BYTE_NODE) is
			-- Generate new block if necessary for
			-- `node'.
		require
			node_exists : node /= Void
		do
			if is_generic then
				-- We need a new C block with new locals.
				node.generate_block_open;
			end
		end;

	generate_end (node : BYTE_NODE) is
			-- Close new block if necessary for `node'.
		require
			node_exists : node /= Void
		do
			if is_generic then
				node.generate_block_close;
			end
		end;

	generate_gen_type_conversion (node : BYTE_NODE) is
			-- Generate the conversion of a type array into an id
			-- for `node'.
		require
			node_exists : node /= Void
		deferred
		end

	type_to_create : CL_TYPE_I is
			-- Type of this info.
		deferred
		end;

	is_generic : BOOLEAN is
			-- Is generated type generic?
		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= type_to_create
			Result   := (gen_type /= Void)
		end;

feature -- Debug

	trace is
		deferred
		end

end
