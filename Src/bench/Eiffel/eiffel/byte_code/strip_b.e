-- Byte code for strip expression

class STRIP_B 

inherit

	EXPR_B
		redefine
			make_byte_code, analyze, generate, print_register
		end;

creation

	make
	
feature 

	feature_ids: LINKED_SET [INTEGER];
			-- Set of attributes feature ids to strip from the current
			-- type

	make is
		do
			!!feature_ids.make;
		end;

	type: GEN_TYPE_I is
			-- Type of byte code strip expression
		local
			meta_generic: META_GENERIC;
		once
			!!Result;
			Result.set_base_id (System.array_id);
			!!meta_generic.make (1);
			meta_generic.put (Reference_c_type, 1);
			Result.set_meta_generic (meta_generic);
		end;

	used (r: REGISTRABLE): BOOLEAN is
			--## FIXME
		do
		end;

	analyze is
			-- Analyze expression
		do
			--## FIXME
		end;
	
	generate is
			-- Generate expression
		do
			--## FIXME
		end;

	print_register is
			-- Print current register (the one holding the strip array).
		do
			--## FIXME
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a strip expression
		do
			-- FIXME
		end;

invariant

	set_exists: feature_ids /= Void

end
