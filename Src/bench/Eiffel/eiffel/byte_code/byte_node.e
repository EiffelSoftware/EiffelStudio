-- Main description of a byte code tree node. All the classes which
-- describe the byte code inherit from us.

class BYTE_NODE 

inherit

	SHARED_BYTE_CONTEXT
		export
			{ANY} all
		end;
	SHARED_WORKBENCH
		export
			{NONE} all
		end;
	SHARED_TYPE_I
		export
			{NONE} all
		end;
	BYTE_CONST
		export
			{NONE} all
		end;
	SHARED_GENERATION_CONSTANTS;
	COMPILER_EXPORTER

feature 

	generated_file: INDENT_FILE is
			-- Generated file
		do
			Result := context.generated_file;
		end;

	real_type (typ: TYPE_I): TYPE_I is
			-- Real type
		do
			Result := context.constrained_type (typ);
			Result := context.instantiation_of (Result);
		end;

	enlarge_tree is
			-- Enlarges the tree for suitable decoration
		do
		end;

	enlarged: like Current is
			-- Enlarge current node for C code generation
		do
			Result := Current;
		end;

	need_enlarging: BOOLEAN is
			-- Does current node need to be enlarged ?
		do
		end;

	analyze is
			-- First pass to build a proper context
		do
		end;
	
	generate is
			-- Generate C code in `generated_file'
		do
		end;

	find_assign_result is
			-- Find assignments in Result at the very last
			-- instruction in a function.
		do
		end;

	mark_last_instruction is
			-- Mark a last instruction if it needs special
			-- considerations (as formatting is concerned).
		do
		end;

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in a function occupied
			-- by an assignment in Result ?
		do
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Build byte code array for Current byte node
		do
			-- Do nothing
		end;

	make_breakable (ba: BYTE_ARRAY) is
			-- Put a breakable point token
			-- hook when generating debuggable byte code.
		do
			if context.debug_mode then
				context.record_breakable (ba);
			end
		end; -- make_breakable

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
		end

	is_unsafe: BOOLEAN is
		do
		end;

	has_loop: BOOLEAN is
			-- Does this byte node use loops?
		do
		end;

	assigns_to (i: INTEGER): BOOLEAN is
			-- i > 0:	Does this byte node assign something to the attribute
			--			of `feature_id' `i'?
			-- i = 0:	Does this byte node assign something to `Result'
			-- i < 0:	Does this byte node assign something to the local # <-n>
		do
		end

	optimized_byte_node: like Current is
			-- Modify the byte code if the loop optimization is safe
		do
			Result := Current
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1
		end

	pre_inlined_code: like Current is
			-- Modified byte code: all the accesses to locals, Result,
			-- arguments, Current are modified to use local variables of
			-- the client
		do
			Result := Current
		end

	inlined_byte_code: like Current is
			-- Perform inlining in the current byte node
		do
			Result := Current
		end

feature -- Concurrent Eiffel

	has_separate_call: BOOLEAN is
			-- Is there a separate call in this byte node?
		do
			Result := False;
		end

end
