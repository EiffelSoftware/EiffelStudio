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

end
