class LOCAL_FORMAT

creation
	make

feature

--	make (c: TYPE_A) is
--		do
--			!FEAT1_ADAPTATION!global_types.make (c.associated_class,
--				c.associated_class);
--			global_types.set_source_type (c);
--			global_types.set_target_type (global_types.source_type);
--			local_types := global_types;
--		end;

	make is
		do
			!! global_types.make
			local_types := global_types
		ensure
			global_types_not_void: global_types /= Void
			local_types_not_void: local_types /= Void
		end;

	position_in_text: CURSOR;
		-- end of text at creation
	
	insertion_point: CURSOR;
		-- last position for left parantheses
	
	separator: TEXT_ITEM;
		-- separator between token of the processed EIFFEL_LIST

	indent_between_tokens: BOOLEAN;
		-- must insert new_line and indent between EIFFEL_LIST token?

	space_between_tokens: BOOLEAN;
		-- Must insert a space character between EIFFEL_LIST token?

	new_line_before_separator: BOOLEAN;
		-- must insert new_line and indent before a separator?

	indent_depth : INTEGER;
		-- number of tab after new_line

	must_abort_on_failure : BOOLEAN;
		-- rollback all the EIFFEL_LIST if one token cannot be printed?

		--| eg : true for a manifest array: don't print the array at
		--| all if one item is not exported
		--| false for an assertion: keep printing the following items even
		--| if one must be ommited 

	local_types: FEAT_ADAPTATION;
		-- source and target type when parsing nested calls

	global_types: FEAT_ADAPTATION;
		-- source and target class for a flat 

	priority: INTEGER is
			-- operator priority
		require
			local_types_not_void: local_types /= Void
		do
			Result := local_types.priority;
			if Result = 0 then
				Result := 12;
			end;
		end;

	call_level: BOOLEAN;
		-- are feature name to be printed as call (vs declaration)
		-- if true, write feature name or operator
		-- if false, write frozen if needed and infix/prefix "operator"
		
	illegal_operator: BOOLEAN;
		-- is an operator illegal here (after $ or like).
		-- if true, operator must be written (prefix/infix "operator")
	

	dot_needed: BOOLEAN;
		-- will a dot be needed before next call
		

	set_position(pos : like position_in_text) is
		do
			position_in_text := pos;
		end;

	set_separator (s: like separator) is
		do
			separator := s;
		end;

	set_must_indent(b : BOOLEAN) is
		do
			indent_between_tokens := b;
		end;

	set_space_between_tokens (b: BOOLEAN) is
		do
			space_between_tokens := b
		end;

	set_must_abort (b: BOOLEAN) is
		do
			must_abort_on_failure := b;
		end;

	indent_one_more is
		do
			indent_depth := indent_depth + 1;
		end;

	indent_one_less is
		do
			indent_depth := indent_depth - 1;
		end;

--	set_classes (source_class, target_class: CLASS_C) is
--			-- flat, text from source class rewritten for target_class
--		require	
--			source_not_void: source_class /= void;
--			target_not_void: target_class /= void;
--		do
--			!FEAT1_ADAPTATION!global_types.make (source_class, target_class);
--			global_types.set_source_type(source_class.actual_type);
--			global_types.set_target_type(target_class.actual_type);
--		end;

--	set_context_features (source, target: FEATURE_I) is
--		do
--			global_types.set_context_features (source, target);
--		end;

	set_global_types (f: FEAT_ADAPTATION) is
			-- set global_types to f
		do
			global_types := f;
		end;

	set_local_types (f: FEAT_ADAPTATION) is
			-- set local_types to f
		do
			if f /= Void then
				local_types := f;
			end -- if
		end;
	
	set_insertion_point (p : like insertion_point) is
		do
			insertion_point := p;
		end;

	set_priority (p: INTEGER) is
		do
			local_types.set_priority (p);
		end;

	set_dot_needed (b: BOOLEAN) is
			-- set dot_needed to b
		do
			dot_needed := b;
		end;

	set_call_level is
			-- set call level to true
		do
			call_level := true;
		end;


	set_illegal_operator is
			-- set illegal operator to true
		do
			illegal_operator := true;
		end;
	

end
