indexing

	description: 
		"Local feature information currently being formatted.%
		%These features are within the global features being formatted.";
	date: "$Date$";
	revision: "$Revision $"

class LOCAL_FEAT_ADAPTATION 

inherit

	SHARED_OPERATOR_TABLE;
	SHARED_SERVER;
	SHARED_FORMAT_INFO;
	SHARED_INST_CONTEXT;
	COMPILER_EXPORTER

feature -- Update
	
	update_from_global (global_adapt: GLOBAL_FEAT_ADAPTATION) is
			-- Make Current from `global_adapt' information.
		require
			valid_global: global_adapt /= Void;
			valid_source: global_adapt.source_enclosing_class /= Void;
			valid_target: global_adapt.target_enclosing_class /= Void;
		do
			source_type := global_adapt.source_enclosing_class.actual_type;
			target_type := global_adapt.target_enclosing_class.actual_type;
		ensure
			source_type.same_as (global_adapt.source_enclosing_class.actual_type)
			target_type.same_as (global_adapt.target_enclosing_class.actual_type)
		end;

feature -- Properties

	source_type: TYPE_A;
			-- Type of the feature in ancestor class

	target_type: TYPE_A;
			-- Redefined type in descendant class

	source_feature: FEATURE_I;
			-- feature called in ancestor
	
	target_feature: FEATURE_I;
			-- feature called in descendant

	final_name: STRING;
			-- name in descendant

	is_infix: BOOLEAN;
			-- Is the final feature an infix?

	is_prefix: BOOLEAN is
			-- Is the final feature a prefix?
		do
			Result := not (is_normal or else is_infix)
		end;

	is_normal: BOOLEAN;
			-- Is the final feature normal, ie not an operator

	already_evaluated_type: BOOLEAN;
			-- Has the source and target type been evaluated

	void_name: STRING is "void";

	source_class: CLASS_C is
			-- Source class for current adaptation
		do
			if source_type /= Void then
				Result := source_type.associated_class;
			end;
		end;

	target_class: CLASS_C is
			-- Target class for current adaptation
		do
			if target_type /= Void then
				Result := target_type.associated_class;
			end;
		end;

feature -- Access

	is_visible (c: CLASS_C): BOOLEAN is
			-- Is the feature visible for class_c type clients
		do
			if c = Void or target_feature = Void or else 
				target_feature.feature_name.is_equal (Void_name) 
			then
				Result := true
			else
				Result := target_feature.is_exported_for (c) 
			end;
		end;

	compute_feature (name: STRING): FEATURE_I is
			-- Compute feature with feature name `name' using
			-- source class. 
		local
			source_classc: CLASS_C;
		do
			source_classc := source_class;
			if source_classc /= Void then
				Result := source_classc.feature_named (name);
			end
		end;

	adapted_type (f: FORMAL_AS): TYPE_A is
			-- Adapted type of `source_class' for format `f'
		do
			if source_class /= Void then
				Result := f.actual_type.
					instantiation_in (target_type, source_class.class_id);
			end
		end;

feature -- Setting

	set_feature_name (name: STRING) is
			-- Set final_name to `name'.
		require
			valid_name: name /= Void
		do
			final_name := name;
		ensure
			set: final_name = name
		end;

	set_source_type (t: TYPE_A) is
			-- Set source_type to `t'.
		do
			source_type := t;
		ensure
			set: source_type = t
		end;

	set_target_type (t: TYPE_A) is
			-- Set target type to `t'.
		do
			target_type := t;
		ensure
			set: target_type = t
		end;

	set_source_feature (f: FEATURE_I) is
			-- Set source_feature to `f'.
		do
			source_feature := f;
		ensure
			set: source_feature = f
		end;
		
	set_target_feature (f: FEATURE_I) is
			-- Set target_feature to `f'.
		do
			target_feature := f;
		ensure
			set: target_feature = f
		end;
		
	set_is_normal is
			-- Set `is_normal' to True.
		do
			is_normal := True;
		ensure
			is_normal: is_normal
		end;

	set_is_infix is
			-- Set `is_infix' to True.
		do
			is_infix := True;
		ensure
			is_infix: is_infix
		end;

	set_evaluated_type is
			-- Set already_evaluated_type to `True'.
		do
			already_evaluated_type := True
		ensure
			already_evaluated_type: already_evaluated_type
		end;

feature -- Transformation

	adapt_feature (feature_name: STRING;
				global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation with feature `feature_name'
		require
			valid_feature_name: feature_name /= Void;
			valid_global_type: global_type /= Void
		local
			new_feat: FEATURE_I
		do
			new_feat := compute_feature (feature_name)
			if new_feat /= Void then
				create Result
				Result.set_is_normal
				Result.set_feature_name (feature_name)
				Result.set_source_feature (new_feat)
				Result.set_source_type (source_type)
				Result.set_target_type (target_type)
				Result.set_private_select_table 
							(global_type.target_feature_table)
				Result.adapt
			else
				Result := global_type.adapt_argument (feature_name)
				if Result = Void then
					Result := global_type.adapt_local (feature_name)
					if Result = Void then
						create Result
						Result.set_is_normal
						Result.set_feature_name (feature_name)
						Result.set_source_type (source_type)
						Result.set_target_type (target_type)
						Result.set_source_feature (new_feat)
						Result.set_private_select_table 
								(global_type.target_feature_table)
						Result.adapt
					end
				end
			end
		end

	adapt_nested_feature (feature_name: STRING; 
				global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation within nested calls with
			-- feature `feature_name'
		require
			valid_feature_name: feature_name /= Void;
			valid_global_type: global_type /= Void
		do
			Result := new_adapt_from_current (global_type);
			Result.set_is_normal;
			Result.set_feature_name (feature_name);
			Result.set_source_feature (Result.compute_feature 
									(feature_name));
			Result.adapt 
		end;

	adapt_infix (int_name: STRING;
				global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation for infix feature `int_name'
		require
			valid_int_name: int_name /= Void;
			valid_global_type: global_type /= Void
		local
			name: STRING;	
		do
			name := clone (int_name);
			name.tail (name.count - 7);
			Result := new_adapt_from_current (global_type);
			Result.set_is_infix;
			Result.set_feature_name (operator_table.name (name));
			Result.set_source_feature (Result.compute_feature (int_name));
			Result.adapt 
		end;

	adapt_prefix (int_name: STRING; global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Feature adaptation for prefix feature `int_name'
		require
			valid_int_name: int_name /= Void
			valid_global_type: global_type /= Void
		local
			name: STRING; 
		do
			name := clone (int_name)
			name.tail (name.count - 8);
			Result := new_adapt_from_current (global_type);
			Result.set_feature_name (operator_table.name (name));
			Result.set_source_feature (Result.compute_feature (int_name));
			Result.adapt 
		end;

feature {LOCAL_FEAT_ADAPTATION, GLOBAL_FEAT_ADAPTATION} -- Implementation

	adapt is
		local
			rout_id : INTEGER
			select_table : SELECT_TABLE
			new_feat: FEATURE_I
		do
debug ("LOCAL_FEAT_ADAPTATION") 
	io.error.putstring ("before adapting%N");
	trace;
end;
			if source_feature = Void or else 
				source_type = Void or else target_type = Void 
			then
				clear
			elseif (source_type.is_deep_equal (target_type)) then
				if in_bench_mode then 
						-- If it is the same source and target type
						-- then the target feature is the source feature
					target_feature := source_feature
				else
						-- Optimization: in batch mode we don't need
						-- items to be clickable.
					clear
				end
			else
					--| If in bench mode make everything clickable
				rout_id := source_feature.rout_id_set.first;
				select_table := target_select_table;
				new_feat := select_table.item (rout_id);
				target_feature := new_feat;
				if new_feat = Void then
					clear
				end;
				if new_feat /= Void then
					adapt_final_name
				end;
			end;
debug ("LOCAL_FEAT_ADAPTATION") 
	io.error.putstring ("After adapting%N");
	trace;
end
		end;

	adapt_final_name is
			-- Evaluate final_name in target_feature.
		require
			valid_target_feature: target_feature /= Void
		do
			final_name := clone (target_feature.feature_name)
			if final_name.item (1) = '_' then
				if final_name.substring 
						(1, 8).is_equal ("_prefix_") 
				then
					final_name.tail (final_name.count - 8);
					is_infix := False;
					is_normal := False;
				else
					final_name.tail (final_name.count - 7);
					is_normal := False;
					is_infix := True;
				end;
				final_name := operator_table.name (final_name);
			else
				is_normal := True;
				is_infix := False;
			end
		ensure
			valid_final_name: final_name /= Void;
		end;

feature {LOCAL_FEAT_ADAPTATION}

	set_private_select_table (t: FEATURE_TABLE) is
			-- Set `private_target_select_table' to t origin_table.
		do
			if t /= Void then
				private_target_select_table := t.origin_table
			end;
		ensure
			t /= Void implies private_target_select_table = t.origin_table
		end; 

feature {NONE} -- Implementation

	private_target_select_table: SELECT_TABLE;
			-- Private select table. Used for 

	target_select_table: SELECT_TABLE is
			-- Select table for the target_id
		require
			valid_target_class: target_type /= Void
		do
			Result := private_target_select_table;
			if Result = Void then
				Result := Feat_tbl_server.item (target_class.class_id).origin_table
			end;
		end;
				
	clear is
			-- Clear Current.
		do
			source_feature := Void;
			target_feature := Void;
			source_type := Void;
			target_type := Void;
		ensure
			cleared: source_feature = Void and then
					target_feature = Void and then
					source_type = Void and then
					target_type = Void
		end;

	new_adapt_from_current (global_type: GLOBAL_FEAT_ADAPTATION): like Current is
			-- Update the adaptation `adapt' source and target
			-- types with result types information from previous
			-- analyzed features (which is Current).
			--| eg a.b  a->A then A becomes source_type for b
		local
			type: TYPE_A;
			f: FEATURE_I;
			enclosing_class: CLASS_C;
			formal_type: FORMAL_A
		do
			!! Result;
			if already_evaluated_type then
				Result.set_source_type (source_type);
				Result.set_target_type (target_type);
			else
				type := source_type;
				f := source_feature;
				if type /= Void and then f /= Void then
					type := evaluate_type (type, f.type);
					if type.is_formal then
							-- If result is formal then get the
							-- the constraint type from last_class.
						formal_type ?= type;
						enclosing_class := global_type.source_enclosing_class;
						type := enclosing_class.constraint (formal_type.position)
					end;
					check
						is_not_formal: not type.is_formal
					end;
					Result.set_source_type (type);
					type := evaluate_type (target_type, target_feature.type);
					if type.is_formal then
							-- If result is format then get the
							-- the constraint type from last_class.
						formal_type ?= type;
						enclosing_class := global_type.target_enclosing_class;
						type := enclosing_class.constraint (formal_type.position)
					end;
					check
						is_not_formal: not type.is_formal
					end;
					Result.set_target_type (type);
				end
			end;
		end;

feature {NONE} -- Implementation

	evaluate_type (last_type: TYPE_A; type: TYPE): TYPE_A is
			-- Evaluate type `type' in relation to `last_type'.
		local
			last_constrained: TYPE_A;
			old_cluster: CLUSTER_I;
			last_class: CLASS_C;
			formal_type: FORMAL_A
		do
			Result ?= type;
			if Result = Void then	
					-- This is done since the target feature is retrieved from the
					-- select table which doesn't evaluate types (ie. TYPE_A)
				Result := type.actual_type
			end;
			last_class := last_type.associated_class;
			if last_type.is_formal then
				formal_type ?= last_type;
				last_constrained := 
					last_class.constraint (formal_type.position)
			end;
			if last_type.is_formal and then Result.is_formal then
				old_cluster := Inst_context.cluster;
				Inst_context.set_cluster (last_class.cluster);
				formal_type ?= Result;
				Result := last_constrained.generics.item (formal_type.position)
				Inst_context.set_cluster (old_cluster);
			end;
			Result := Result.conformance_type;
				-- Do not forget to call `actual_type' on `last_type' because
				-- `last_type' is not enough by itself:
				-- For example when `last_type' in an anchored type we
				-- need to find out its real type in the current context,
				-- which is done by applying `actual_type'.
				-- Manus: 10/06/1999
			Result := Result.instantiation_in 
						(last_type.actual_type, last_class.class_id).actual_type;
		end

feature -- Debug

	trace is
		do
			io.error.putstring ("Adapting feature: ");
			if final_name /= Void then
				io.error.putstring ("[");
				io.error.putstring (final_name);
				io.error.putstring ("] ");
			end;
			if source_feature = Void then
				io.error.putstring ("VOID");
			else
				io.error.putstring (source_feature.feature_name);
				io.error.putstring (" ");
				io.error.putstring (source_feature.type.out);
			end;
			io.error.putstring (" (");
			if source_class = Void then
				io.error.putstring ("VOID");
			else
				io.error.putstring (source_class.name);
			end;
			io.error.putstring (")");
			io.error.putstring (" target: ");
			if target_feature = Void then
				io.error.putstring ("VOID");
			else
				io.error.putstring (target_feature.feature_name);
				io.error.putstring (" ");
				io.error.putstring (target_feature.type.out);
			end;
			io.error.putstring (" (");
			if target_class = Void then
				io.error.putstring ("VOID");
			else
				io.error.putstring (target_class.name);
			end
			io.error.putstring (")");
			io.error.new_line;
		end;

end -- class class LOCAL_FEAT_ADAPTATION
