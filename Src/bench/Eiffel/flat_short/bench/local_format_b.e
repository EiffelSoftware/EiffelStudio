class LOCAL_FORMAT_B

inherit

	LOCAL_FORMAT

creation
	make, make_for_case

feature

	make (c: TYPE_A) is
		do
			!FEAT1_ADAPTATION!global_types.make (c.associated_class,
				 c.associated_class);
			global_types.set_source_type (c);
			global_types.set_target_type (global_types.source_type);
			local_types := global_types;
		end;

	make_for_case (c: TYPE_A) is
		do
			!FEAT_ADAPTATION!global_types.make (c.associated_class,
					c.associated_class);
			local_types := global_types;
		end;

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
		do
			Result := local_types.priority;
			if Result  = 0 then
				Result := 12;
			end;
		end;

	call_level: BOOLEAN;
		-- are feature name to be printed as call (vs declaration)
		-- if true, write feature name or operator
		-- if false, write frozen if needed and infix/prefix "operator"
		
	set_must_abort (b: BOOLEAN) is
		do
			must_abort_on_failure := b;
		end;

	set_classes (source_class, target_class: CLASS_C) is
			-- flat, text from source class rewritten for target_class
		require	
			source_not_void: source_class /= void;
			target_not_void: target_class /= void;
		do
			!FEAT1_ADAPTATION!global_types.make (source_class, target_class);
			global_types.set_source_type(source_class.actual_type);
			global_types.set_target_type(target_class.actual_type);
		end;

	set_context_features (source, target: FEATURE_I) is
		do
			global_types.set_context_features (source, target);
		end;

	set_global_types (f: FEAT_ADAPTATION) is
			-- set global_types to f
		do
			global_types := f;
		end;

	set_local_types (f: FEAT_ADAPTATION) is
			-- set local_types to f
		do
			local_types := f;
		end;
	
	set_priority (p: INTEGER) is
		do
			local_types.set_priority (p);
		end;

	set_call_level is
			-- set call level to true
		do
			call_level := true;
		end;

end -- class LOCAL_FORMAT_B
