-- Byte code for external features

class EXT_BYTE_CODE 

inherit

	STD_BYTE_CODE
		rename
			generate as old_generate
		redefine
			generate_return_exp, generate_compound,
			generate_current, is_external, pre_inlined_code,
			inlined_byte_code
		end;

	STD_BYTE_CODE
		redefine
			generate,
			generate_return_exp,generate_compound,
			generate_current, is_external, pre_inlined_code,
			inlined_byte_code
		select
			generate
		end

	SHARED_INCLUDE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	EXTERNAL_CONSTANTS
	
feature -- Attributes for externals

	external_name: STRING is
			-- External name to call
		do
			Result := Names_heap.item (external_name_id)
		end
		
	external_name_id: INTEGER
			-- Name ID of external.

	encapsulated: BOOLEAN;
			-- Has the call to `external_name' to be encapsulated?

feature -- Routines for externals

	set_external_name_id (a_name_id: INTEGER) is
			-- Assign `s' to `a_name_id'.
		require
			a_name_id_positive: a_name_id > 0
		do
			external_name_id := a_name_id
		ensure
			external_name_id_set: external_name_id = a_name_id
		end;

	set_encapsulated (e: BOOLEAN) is
			-- Assign `e' to `encapsulated'
		do
			encapsulated := e;
		end;

	is_external: BOOLEAN is True
			-- Is the current byte code a byte code for external
			-- features ?

feature -- IL code generation

	generate_c_il is
		do
			generate
		end

feature -- Byte code generation

	generate is
			-- Byte code generation
		do
			add_in_log (external_name)
		end;

	generate_compound is
			-- Call the external function
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

			if not result_type.is_void then
				buf.putstring ("return ")
				result_type.c_type.generate_cast (buf)
			end

			buf.putstring (external_name);
			buf.putchar ('(');
			generate_arguments;
			buf.putchar (')');
			buf.putchar (';');
			buf.new_line;
		end;

	generate_return_exp is
			-- Generate the final return
		local
			buf: GENERATION_BUFFER
		do
			if context.result_used or postcondition /= Void or context.has_invariant then
				buf := buffer
				buf.putstring ("return Result;");
				buf.new_line;
			end;
		end;

	generate_current: BOOLEAN is False
			-- Do we need to generate `Current'?

feature -- Inlining

	pre_inlined_code: like Current is
			-- An external does not have a body
			-- Inlining is done differently
		do
		end

	inlined_byte_code: like Current is
		do
			Result := Current
		end

end
