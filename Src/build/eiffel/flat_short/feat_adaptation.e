class FEAT_ADAPTATION 

inherit

	SPECIAL_AST

creation

	make

feature

	final_name: STRING;
		-- name in descendant

	internal_name: STRING;
		-- internal name in descendant

	is_infix: BOOLEAN;
		-- is the final feature an infix

	is_prefix: BOOLEAN;
		-- is the final feature a prefix

	is_normal: BOOLEAN;
		-- is the final feature normal, ie not an operator

	priority: INTEGER;
		-- operator priority or 12 (dot) if not operator
		-- see priority ETL, p.377

	make is
		do
		end;

	main_adapt_feat: like Current is
		local
			temp: STRING;
			a_str: STRING;
		do
			!! temp.make (0);
			Result := new_object;
			Result.set_feature_name (temp);
			Result.set_is_normal;
			Result.set_priority (12);
		end;

	main_adapt_prefix: like Current is
		local
			temp, temp2: STRING;
			a_str: STRING;
		do
			!! temp.make (0);
--			temp2 := clone (target_enclosing_feature.feature_name)
					--| This is a hack (bug in compiler)
			if temp2.substring (1, 8).is_equal ("_prefix_") then
				temp2.tail (temp2.count - 8);
				--temp2 := operator_name (temp2);
				print_fix_keyword_bool.set_value (True);
			else
				print_fix_keyword_bool.set_value (False);
			end;
			temp.append ("%"");
			temp.append (temp2);
			temp.append ("%"");
			Result := new_object;
			Result.set_feature_name (temp);
			Result.set_is_prefix;
			Result.set_priority (12);
--			Result.set_source_type (source_type);
--			Result.set_target_type (target_type);
--			Result.set_source_feature (source_enclosing_feature);
--			Result.set_target_feature (target_enclosing_feature);
		end;

	main_adapt_infix: like Current is
		local
			temp, temp2: STRING;
			a_str: STRING;
		do
			!! temp.make (0);
--			temp2 := clone (target_enclosing_feature.feature_name)
					--| This is a hack (bug in compiler)
			if temp2.substring (1, 7).is_equal ("_infix_") then
				temp2.tail (temp2.count - 7);
				--temp2 := operator_name (temp2);
				print_fix_keyword_bool.set_value (True);
			else
				print_fix_keyword_bool.set_value (False);
			end;
			temp.append ("%"");
			temp.append (temp2);
			temp.append ("%"");
			Result := new_object;
			Result.set_feature_name (temp);
			Result.set_is_infix;
			Result.set_priority (12);
--			Result.set_source_type (source_type);
--			Result.set_target_type (target_type);
--			Result.set_source_feature (source_enclosing_feature);
--			Result.set_target_feature (target_enclosing_feature);
		end;

	new_adapt_feat (feature_name: STRING): like Current is
		require
			valid_feature_name: feature_name /= Void
		local
			index: INTEGER;
			type: TYPE;
--			source_classc: CLASS_C;
		do
			compute_source (feature_name);
--			if new_feature /= Void then
--				Result := new_object;
--				Result.set_feature_name (feature_name);
--				Result.set_is_normal;
--				Result.set_priority (12);
--				Result.set_source_type (source_type);
--				Result.set_source_feature (new_feature);
--				Result.adapt 
--			else
				index := argument_index (feature_name);
				if index > 0 then
					Result := new_adapt_argument (index);
--				elseif target_locals /= Void and then
--					target_locals.has (feature_name) and then
--					target_locals.item (feature_name) /= Void
--				then
--					Result := new_adapt_local (feature_name);	
				else
					Result := new_object;
					Result.set_feature_name (feature_name);
					Result.set_is_normal;
					Result.set_priority (12);
--					Result.set_source_type (source_type);
--					Result.set_source_feature (new_feature);
--					Result.adapt 
				end
--			end;
		end;

	argument_index (feature_name: STRING): INTEGER is
		local
			i: INTEGER;
			l_count: INTEGER;
			arg_list: EIFFEL_LIST [ID_AS];
		do
--			if 
--				source_enclosing_feature /= void	
--				and target_enclosing_feature /= void
--				and then source_enclosing_feature.arguments /= void
--			then
--				arg_list := source_enclosing_feature.argument_names;
--				if arg_list /= void then
--					l_count := arg_list.count;
--				end;
--				from 
--					i := 1
--				until
--					i > l_count or Result > 0
--				loop
--					if feature_name.is_equal (arg_list.i_th (i)) then
--						Result := i;
--					else
--						i := i + 1;
--					end;
--				end;
--			end;
		end;

	new_adapt_local (f_name: STRING): like Current is
--		require
--			valid_target: target_locals.has (f_name);
--			target_not_void: target_locals.item (f_name) /= Void;
--			valid_source: source_locals.has (f_name);
--			source_not_void: source_locals.item (f_name) /= Void
--		local
--			s_type, t_type: like source_type;
		do
			Result := new_object;
			Result.set_is_normal;
			Result.set_priority (12);
--			s_type := source_locals.item (f_name);
--			if s_type.is_formal then
--				 s_type := source_enclosing_class.constraint (s_type.base_type)
--			end;
--			t_type := target_locals.item (f_name);
--			if t_type.is_formal then
--				 t_type := target_enclosing_class.constraint (t_type.base_type)
--			end;
--			Result.set_source_type (s_type);
--			Result.set_target_type (t_type);
			Result.set_feature_name (f_name);
		end;

	new_adapt_argument (arg_index: INTEGER): like Current is
		require
			arg_index > 0
--		local
--			s_type, t_type: like source_type;
		do
			Result := new_object;
			Result.set_is_normal;
			Result.set_priority (12);
--			s_type := source_enclosing_feature.arguments.i_th (arg_index).actual_type;
--			if s_type.is_formal then
--debug ("FLAT_SHORT")
--	io.error.putstring ("arg name");
--	io.error.putstring (source_enclosing_feature.arguments.argument_names.i_th (
--a--rg_index));
--	io.error.new_line;
--	io.error.putstring ("source_type ");
--	io.error.putstring (s_type.dump);
--	io.error.new_line;
--	io.error.putstring ("class name : ");
--	io.error.putstring (source_enclosing_class.class_name);
--	io.error.new_line
--	io.error.putstring ("source feature : ");
--	io.error.putstring (source_enclosing_feature.feature_name);
--	io.error.new_line;
--	io.error.putstring ("written in: ");
--	io.error.putstring (source_enclosing_feature.written_class.class_name);
--	io.error.new_line;
--	source_enclosing_feature.trace;
--	io.error.putstring ("target feature%N");
--	target_enclosing_feature.trace;
--	io.error.new_line
--end;
--			s_type := source_enclosing_class.constraint (s_type.base_type)
--			end;
--			t_type := target_enclosing_feature.arguments.i_th (arg_index).actual_type;
--			if t_type.is_formal then
--				t_type := target_enclosing_class.constraint (t_type.base_type)
--			end;
--			Result.set_source_type (s_type);
--			Result.set_target_type (t_type);
--			Result.set_feature_name (target_enclosing_feature.argument_names.i_th 
--					(arg_index));
		end;
			
	new_adapt_infix (int_name: STRING): like Current is
		local
			name: STRING;	
		do
			Result := new_object;
			name := clone (int_name)
			name.tail(name.count - 7);
			Result.set_is_infix;
			Result.set_priority (infix_priority (name));
			Result.set_feature_name (operator_name (name));
			compute_source (int_name);
--			Result.set_source_feature (new_feature);
--			Result.adapt 
		end;

	new_adapt_prefix (int_name: STRING): like Current is
		local
			name: STRING; 
		do
			Result := new_object;
			name := clone (int_name)
			name.tail(name.count - 8);
			Result.set_is_prefix;
			Result.set_priority (11);
			Result.set_feature_name (operator_name (name));
			compute_source (int_name);
--			Result.set_source_feature (new_feature);
--			Result.adapt 
		end;

	new_adapt_Result: like Current is
--		local
--			s_type, t_type: like source_type;
		do
			Result := new_object;
			Result.set_feature_name ("Result");
--			if source_enclosing_feature /= Void then
--					-- This is not needed for case storage.
--				s_type := source_enclosing_feature.type.actual_type;
--				if s_type.is_formal then
--				 	s_type := source_enclosing_class.constraint (s_type.base_type)
--				end;
--				t_type := target_enclosing_feature.type.actual_type;
--				if t_type.is_formal then
--				 	t_type := target_enclosing_class.constraint (t_type.base_type)
--				end;
--			end;
--			Result.set_source_type (s_type);
--			Result.set_target_type (t_type)
		end;

	new_adapt_Current: like Current is
--		local
--			s_type, t_type: like source_type;
		do
			Result := new_object;
			Result.set_feature_name ("Current");
--			s_type := source_enclosing_class.actual_type;
--			t_type := target_enclosing_class.actual_type;
--			Result.set_source_type (s_type);
--			Result.set_target_type (t_type)
		end;

	new_adapt_ast (name: FEATURE_NAME): like Current is
		do
			if name.is_infix then
				Result := new_adapt_infix (name.internal_name);
			elseif name.is_prefix then
				Result := new_adapt_prefix (name.internal_name);
			else
				Result := new_adapt_feat (name.internal_name);
			end
		end;
	
	may_need_adaptation: BOOLEAN is
			-- could target feature have another name or type than
			-- source feature

			--| is source type different from target type
		do
--			Result := not source_type.same_as(target_type);
		end;

	
	set_feature_name (name: STRING) is
		do
			final_name := name;
			internal_name := name;
		end;

--	set_source_class (c: CLASS_C) is
--			-- set source type according to c
--		require
--			valid_arg: c /= Void
--		do
--			source_type := c.actual_type;
--		end;

--	set_target_class (c: CLASS_C) is
--			-- set target type according to c
--		require
--			valid_arg: c /= Void
--		do
--			target_type := c.actual_type;
--		end;

--	set_source_feature (f: FEATURE_I) is
--			-- set source_feature to f
--		do
--debug ("FLAT_SHORT")
--	if f /= void then
--		io.error.putstring ("source feature: ");
--		io.error.putstring (f.feature_name);
--		io.error.new_line;
--	end
--end;
--			source_feature := f;
--		end;
		
--	set_target_feature (f: FEATURE_I) is
--			-- set target_feature to f
--		do
--debug ("FLAT_SHORT")
--	if f /= Void then
--		io.error.putstring ("target feature: ");
--		io.error.putstring (f.feature_name);
--		io.error.new_line;
--	end
--end;
--			target_feature := f;
--		end;

--	set_context_features (source, target: FEATURE_I) is
--			-- set source_enclosing_feature 
--			-- and target_enclosing_feature
--		require
--			valid_enclosing_classes: source_enclosing_class /= Void and then
--									target_enclosing_class /= Void
--		local
--			body: FEATURE_AS;
--			body_id: INTEGER;
--			s_locals, t_locals: EXTEND_TABLE [LOCAL_INFO, STRING];
--			old_cluster: CLUSTER_I;
--		do
--debug ("FLAT_SHORT")
--	if source /= Void then
--		io.error.putstring ("source enclosing feature: ");
--		io.error.putstring (source.feature_name);
--		io.error.new_line;
--		io.error.putstring ("written in: ");
--		io.error.putstring (source.written_class.class_name);
--		io.error.new_line;
--	end;
--	if target /= Void then
--		io.error.putstring ("target enclosing feature: ");
--		io.error.putstring (target.feature_name);
--		io.error.new_line;
--		io.error.putstring ("written in: ");
--		io.error.putstring (target.written_class.class_name);
--		io.error.new_line;
--	end;
--end;
--			source_enclosing_feature := source;
--			target_enclosing_feature := target;
--			source_type := source.written_class.actual_type;
--			if 	not is_short then
--				if in_assertion then 
--					source_locals := Void;
--					target_locals := Void;	
--				else
--					body_id := source_enclosing_feature.body_id;
--					if Body_server.has (body_id) or else
--						Tmp_body_server.has (body_id) then
--						body := Body_server.item (body_id)
--					else
--						body := Rep_feat_server.item (body_id)
--					end;
--					old_cluster := Inst_context.cluster;
--					Inst_context.set_cluster (source_enclosing_feature.written_class.cluster);
--					s_locals := body.local_table (source_enclosing_feature);
--					if s_locals /= Void then
--						Inst_context.set_cluster (target_enclosing_feature.written_class.cluster);
--						--t_locals := body.local_table (target_enclosing_feature);
--						Inst_context.set_cluster (old_cluster);
--						optimize_locals (s_locals, t_locals);
--					else
--						Inst_context.set_cluster (old_cluster)
--					end;
--				end
--			end;
--		end;

	copy_context (other: FEAT_ADAPTATION) is
			-- set source_enclosing_feature 
			-- and target_enclosing_feature
		local
			body: FEATURE_AS;
			body_id: INTEGER;
		do
			--source_enclosing_feature := other.source_enclosing_feature;
			--target_enclosing_feature := other.target_enclosing_feature;
			--source_locals := other.source_locals;
			--target_locals := other.target_locals; 
			--source_type := other.source_type;
			--target_type := other.target_type;
		end;

	set_priority (p: INTEGER) is
			-- set 'priority' to 'p'
		do
			priority := p;
		end;

	set_is_prefix is
		do
			is_prefix := true;
			is_infix := false;
			is_normal := false;
		end;

	set_is_infix is
		do
			is_prefix := false;
			is_infix := true;
			is_normal := false;
		end;

	set_is_normal is
		do
			is_prefix := false;
			is_infix := false;
			is_normal := true;
		end;

	ast: FEATURE_NAME;

	compute_ast is
		do
			if is_prefix then
				!PREFIX_AS!ast
			elseif is_infix then
				!INFIX_AS!ast
			else
				!FEAT_NAME_ID_AS!ast
			end;
			ast.set_name (final_name);
--			ast.set_is_frozen (target_feature.is_frozen);
		end;


feature {FEAT_ADAPTATION}

	clean is
			-- keep only source_type and target type.
		do
			--source_feature := void;
			--target_feature := void;
		end;

--	target_select_table: SELECT_TABLE is
--		do
--			Result := Feat_tbl_server.item (target_id).origin_table;
--		end;
				
feature {}

	infix_priority_table: HASH_TABLE [INTEGER, STRING] is
			-- priorities of standard infix operators
			-- see ETL p 377
		once
			!!Result.make (18);
			Result.put (9, "power");
			Result.put (9, "shift");
			Result.put (8, "star");
			Result.put (8, "slash");
			Result.put (8, "div");
			Result.put (8, "mod");
			Result.put (7, "plus");
			Result.put (7, "minus");
			Result.put (6, "lt");
			Result.put (6, "le");
			Result.put (6, "gt");
			Result.put (6, "ge");
			Result.put (5, "and");
			Result.put (5, "and_then");
			Result.put (4, "or");
			Result.put (4, "or_else");
			Result.put (4, "xor");
			Result.put (3, "implies");
		end;

	infix_priority (operator: STRING): INTEGER is
			-- priority of operator
		do
			Result := infix_priority_table @ operator;
			if Result = 0 then Result := 10; end;
		end;

	operator_name_table: HASH_TABLE [STRING, STRING] is
			-- names of standard operator, when not immediatly extracted
			-- from internal mame
		once
			!!Result.make (14);
			Result.put ("^", "power");
			Result.put ("^", "shift");
			Result.put ("*", "star");
			Result.put ("/", "slash");
			Result.put ("//", "div");
			Result.put ("\\", "mod");
			Result.put ("+", "plus");
			Result.put ("-", "minus");
			Result.put ("<", "lt");
			Result.put ("<=", "le");
			Result.put (">", "gt");
			Result.put (">=", "ge");
			Result.put ("and then", "and_then");
			Result.put ("or else", "or_else");
		end;


--	new_feature: like source_feature;
		-- feature I corresponding to the new name in source_class

	compute_source (name: STRING) is
--		local
--			source_classc: CLASS_c;
--			generic_type: GEN_TYPE_A;
		do
--			new_feature := void
--            if source_type /= void then
--                source_classc := source_class;
--                if source_classc /= void then
--                    new_feature := source_classc.feature_named (name);
--                end
--            end
        end;

	new_object: FEAT_ADAPTATION is
		do
			--!!Result.make (source_enclosing_class, target_enclosing_class);
			!!Result.make
			Result.copy_context (Current);
		end;

feature

	operator_name (operator: STRING): STRING is
			-- name of an operator
		do
			Result := operator_name_table @ operator;
			if Result = void then
				Result := operator;
			end;
		end;

feature

	trace is
		do
	--		io.error.putstring ("adapting feature :");
	--		if target_feature /= Void then
	--			io.error.putstring (target_feature.feature_name);
	--			io.error.new_line
	--		end;
	--		io.error.putstring ("source class: ");
	--		if source_class /= Void then
	--			io.error.putstring (source_class.class_name);
	--		else
	--			io.error.putstring (" VOID");
	--		end;
	--		io.error.new_line;
	--		io.error.putstring ("target class: ");
	--		if target_class /= Void then
	--			io.error.putstring (target_class.class_name);
	--		else
	--			io.error.putstring (" VOID");
	--		end;
	--		io.error.new_line;
		end;

end
