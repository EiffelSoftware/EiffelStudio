indexing

	description: 
		"Formatting context for class ast (flat, flat/short & clickable format).";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_CONTEXT_B

inherit

	FORMAT_CONTEXT
		rename
			make as simple_format_make
		redefine 
			format, new_expression, arguments,
			prepare_for_current, prepare_for_result, 
			prepare_for_main_feature, put_normal_feature, 
			prepare_for_prefix, prepare_for_infix,
			put_infix_feature, put_prefix_feature,
			begin, commit, prepare_for_feature,
			formal_name, put_origin_comment,
			format_ast, is_feature_visible,
			reversed_format_list, put_current_feature,
			set_type_creation, put_class_name
		end;
	SHARED_SERVER;
	SHARED_INST_CONTEXT;
	SHARED_RESCUE_STATUS;
	SHARED_FORMAT_INFO;
	COMPILER_EXPORTER;

creation

	make

feature -- Initialization

	make (c: E_CLASS) is
			-- Initialize Current for bench.
		require
			valid_c: c /= Void
		do
			class_c ?= c;
			current_class_only := False;
			reset_format_booleans;
			last_was_printed := True;
			initialize;
		ensure then
			class_c_set: class_c /= Void and then class_c = c;
			batch_mode:	not in_bench_mode;
			analyze_ancestors: not current_class_only;
			do_flat: not is_short;
		end;

	init_uncompiled_feature_context (source_class: CLASS_C; feature_as: FEATURE_AS_B) is
			-- Initialize Current context to analyze
			-- uncompiled feature ast `feature_as'.
			-- This ast is not in the feature table (ie has
			-- not been compiled) but has been entered by
			-- the user.
		require
			valid_source_class: source_class /= Void
			valid_ast: feature_as /= Void
		do
			!! global_adapt.make_with_classes (source_class, class_c);
			global_adapt.set_locals (feature_as);
			!! unnested_local_adapt;
			unnested_local_adapt.update_from_global (global_adapt)
			local_adapt := unnested_local_adapt;
		ensure
			valid_global_adapt: global_adapt /= Void
			valid_unnested_local_adapt: unnested_local_adapt /= Void
			valid_unnested_local_adapt: local_adapt /= Void
		end;

	init_feature_context (source, target: FEATURE_I; 
				feature_as: FEATURE_AS_B) is
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		require
			valid_source: source /= Void;
			valid_ast: feature_as /= Void;
			valid_target: target /= Void
		do
			!! global_adapt.make (source, target, class_c)
			global_adapt.set_locals (feature_as);
			!! unnested_local_adapt;
			unnested_local_adapt.update_from_global (global_adapt)
			local_adapt := unnested_local_adapt;
		ensure
			valid_global_adapt: global_adapt /= Void
			valid_unnested_local_adapt: unnested_local_adapt /= Void
			valid_unnested_local_adapt: local_adapt /= Void
		end;

feature -- Properties

	client: CLASS_C;
			-- Client class for Current flat

	class_name: STRING;
			-- Class name of `class_c'

	last_class_printed: TYPE_A;
			-- Last class printed (used for !TYPE! creation)

	first_assertion: BOOLEAN;
			-- Are we about to format the first assertion?
		
	format_registration: FORMAT_REGISTRATION;
			-- Structure registerd for formatting

	current_class_only: BOOLEAN;
			-- Is Current only processing `class_c' and not
			-- its ancestors?

	feature_clause_order: ARRAY [STRING];
			-- Array of feature clause comment ordering

	is_clickable_format: BOOLEAN is
			-- Is the generated format the "clickable" format?
		do
			Result := current_class_only and not is_short
		end;

	is_flat_short: BOOLEAN is
			-- Is the Current format doing a flat-short?
		do
			Result := is_short and then not current_class_only
		end;

	is_feature_short: BOOLEAN is
			-- Is the Current format doing a flat-short?
		local
			f: FEATURE_I;
			written_in: E_CLASS
		do
			Result := is_short;
			if not Result then
				f := global_adapt.target_enclosing_feature;
				if f /= Void then
					written_in := f.written_class;
					if 
						written_in.is_precompiled and then 
						written_in.lace_class.hide_implementation 
					then
						Result := True
					end
				end
			end
		end;

	class_c: CLASS_C;
			-- Current class being processed
	
	format: LOCAL_FORMAT_B;
			-- Current internal formatting directives

	last_was_printed: BOOLEAN;
			-- Were we able to print a structure?

	was_infix_arguments: BOOLEAN;
			-- Were the arguments when preparing for
			-- a feature came from an infix?

	must_abort_on_failure: BOOLEAN is
			-- Must we abort on failure?
		require
			valid_format: format /= Void
		do
			Result := format.must_abort_on_failure
		end;

	arguments: AST_EIFFEL_B;
			-- Arguments for Current feature being analyzed

	is_feature_visible: BOOLEAN  is
			-- should the feature be visible
		do
			Result := client = void
				or else local_adapt.is_visible (client)
		end;

	global_adapt: GLOBAL_FEAT_ADAPTATION;
			-- Has 2 purposes:
			-- 1. Store information for each main feature
			-- being adapted
			-- 2. Store source and target enclosing class
			--| Analyzing features 1 and 2 is used
			--| Analyzing invariants and inherit clauses 2 is used

	saved_global_adapt: GLOBAL_FEAT_ADAPTATION;
			-- Saved feature adaptation information for enclosing
			-- features being analyzed

	unnested_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Feature adaptation information for non nested features
			-- within the enclosing features

	saved_unnested_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Saved feature adaptation information for non nested features
			-- within the enclosing features

	local_adapt: LOCAL_FEAT_ADAPTATION
			-- Current feature adaptation information for features
			-- within the enclosing features

	saved_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Saved Current feature adaptation information for features
			-- within the enclosing features

	execution_error: BOOLEAN;
			-- Did an error occur during `execute'?

	rescued: BOOLEAN;
			-- Was Current format rescued?

feature -- Access

	has_feature_i: BOOLEAN is
			-- Does the currently analyzed features has
			-- associated feature_i (ie. is it compiled)?
		do
			Result := global_adapt.target_enclosing_feature /= Void
		ensure
			Result implies global_adapt.target_enclosing_feature /= Void
		end;

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		require
			valid_global_adapt: global_adapt /= Void;
		do
			if global_adapt.target_enclosing_feature /= Void then
				Result := format_registration.chained_assertion
			end
		end;

	formal_name (pos: INTEGER): ID_AS_B is
			-- Formal name of class_c generics at position `pos.
		do
			Result := clone (class_c.generics.i_th (pos).formal_name)
			Result.to_upper;
		end;

feature -- Setting

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'
		require
			valid_fco: fco /= Void
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

	set_type_creation (t: TYPE) is
			-- Set last_class_printed to the actual type of `t'.
		local
			type_b: TYPE_B
		do
			type_b ?= t;
			if type_b = Void then
				last_class_printed := Void
			else
				last_class_printed := type_b.actual_type
			end;
		end;

	set_insertion_point is
			-- Remember text position for parantheses 
			-- and prefix operator.
		do
			if not tabs_emitted then
				emit_tabs
			end;
			format.set_insertion_point (text.cursor);
		end;

	set_current_class_only is
			-- Set current_class_only to True.
		do
			current_class_only := True;	
		ensure
			current_class_only: current_class_only
		end

	set_first_assertion (b: BOOLEAN) is
			-- Set first_assertion `b'.
		do
			first_assertion := b;
		ensure
			first_assertion = b
		end;

	set_source_class (c: CLASS_C) is
			-- Set source class to `c'.
		require
			good_class: c /= void
		do
			set_classes (c, class_c)
		ensure
			non_void_global: global_adapt /= Void;
			source_set: global_adapt.source_enclosing_class = c;
			target_set: global_adapt.target_enclosing_class = class_c
		end;

	set_classes (source, target: CLASS_C) is
			-- Initialize global_adapt with classes
			-- `source' and `target'.
			--| Used in the inherit clause.
		require
			both_void: source = Void implies target = Void;
			both_non_void: source /= Void implies target /= Void;
		do
			!! global_adapt.make_with_classes (source, target);
			!! local_adapt;
			if source /= Void then
				local_adapt.update_from_global (global_adapt);
			end;
			unnested_local_adapt := local_adapt;
		ensure
			valid_global_adapt: global_adapt /= Void
			valid_local_adapt: local_adapt /= Void
			unnested_local_adapt = local_adapt
		end;

	set_source_feature_for_assertion (source: FEATURE_I) is
			-- Set source feature to be analyzed to `source'.
		require
			valid_source: source /= Void
		do
			global_adapt := clone (global_adapt);
			global_adapt.update_new_source_in_assertion (source);
			!! unnested_local_adapt;
			unnested_local_adapt.update_from_global (global_adapt)
			local_adapt := unnested_local_adapt;
		end;

	save_adaptations is
			-- Save adapt.
		do
			saved_global_adapt := global_adapt;
			saved_local_adapt := local_adapt;
			saved_unnested_local_adapt := unnested_local_adapt;
		ensure
			saved_global_adapt = global_adapt
		end;

	restore_adaptations is
			-- Restore adaptations.
		require
			valid_saved_global_adapt: saved_global_adapt /= Void
			valid_saved_local_adapt: saved_local_adapt /= Void
			valid_saved_unnested_adapt: saved_unnested_local_adapt /= Void
		do
			global_adapt := saved_global_adapt;
			local_adapt := saved_local_adapt;
			unnested_local_adapt := saved_unnested_local_adapt;
			saved_global_adapt := Void;
			saved_local_adapt := Void;
			saved_unnested_local_adapt := Void;
		ensure
			saved_global_adapt = Void;
			saved_local_adapt = Void;
			saved_unnested_local_adapt = Void;
			(old saved_global_adapt) = global_adapt;
			(old saved_unnested_local_adapt) = unnested_local_adapt;
			(old saved_local_adapt) = local_adapt
		end;

feature -- Setting local format details

	abort_on_failure is
			-- Set abort flag for format to be True.
		do
			format.set_must_abort (True);
		ensure
			must_abort_on_failure: must_abort_on_failure
		end;
	
	continue_on_failure is
			-- Set abort flag for format to be False.
		do
			format.set_must_abort (false);
		ensure
			not_must_abort_on_failure: not must_abort_on_failure
		end;

feature -- Execution

	execute is
				-- Execute the flat or flat_short.
		local
			name: STRING;
			simple_ctxt: FORMAT_CONTEXT;
			prev_class: CLASS_C;
			prev_cluster: CLUSTER_I
		do
			if not rescued then
				prev_class := System.current_class;
				prev_cluster := Inst_context.cluster;
				execution_error := false;
				class_name := clone (class_c.name)
				class_name.to_upper;

				if is_short then
					client := system.any_class.compiled_class;
				end;

				!! format_registration.make (class_c, client);
				if is_flat_short then
					format_registration.initialize_creators;
				end;

				if not order_same_as_text then
					format_registration.set_feature_clause_order (feature_clause_order);
				end;

				format_registration.fill (current_class_only);
				System.set_current_class (class_c);

				if format_registration.target_ast /= void then
					Inst_context.set_cluster (class_c.cluster);
					format_registration.target_ast.format (Current);
					Inst_context.set_cluster (Void);
				else
					execution_error := true
				end;
debug ("FLAT_SHORT")
	!! simple_ctxt.make (format_registration.target_ast, class_c.file_name)
	format_registration.target_ast.simple_format (simple_ctxt);
	io.error.putstring (simple_ctxt.text.image)
end
			else
				execution_error := True;
				rescued := False
			end;
			System.set_current_class (prev_class);
			Inst_context.set_cluster (prev_cluster);
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end;
		end;

feature -- Update

	initialize is
			-- Initialize structures for Current.
		do
			!! format_stack.make;
			!! text.make;
			!! format;
			format_stack.extend (format);
		end;

	begin is
			-- Save current format before a change.
			-- (To keep track of indent depth, separator etc.)
		local
			new_format: like format;
		do
			new_format := clone (format);
			new_format.set_position (text.cursor);
			format_stack.extend (new_format);
			format := new_format;
		end;

	commit is
			-- Go back to previous format. 
			--| Keep text modifications.
		do
			format_stack.remove;
			format := format_stack.item;
			last_was_printed := True;
		ensure then
			last_was_printed: last_was_printed;
		end;

	rollback is
			-- Go back to the previous format.
			-- Discard text modifications.
		do
			text.head (format.position_in_text);
			format_stack.remove;
			format := format_stack.item;
			last_was_printed := false;
		ensure
			not_last_was_printed: not last_was_printed;
			format_removed: not format_stack.has (old format)
		end;

feature -- Element change

	put_class_name (s: STRING) is
			-- Append class name to 'text', treated as a stone.
		local
			tmp: STRING;
			classi: CLASS_I
		do
			if not tabs_emitted then
				emit_tabs
			end;
			tmp := clone (s);
			tmp.to_lower;
			classi := Universe.class_named (tmp, class_c.cluster);
			if classi = Void then
				text.add_default_string (s)
			else
				text.add_classi (classi, s)
			end
		end;

	put_classi (c: CLASS_I) is
			-- Append class name to 'text', treated as a stone.
		local
			s: STRING;
		do
			if not tabs_emitted then
				emit_tabs
			end;
			s := clone (c.name);
			s.to_upper;
			text.add_classi (c, s)
		end;

	prepare_class_text is
			-- Append standard text before class.
		do
			text.add_before_class (class_c);
		end;

	end_class_text is
			-- Append standard text after class.
		do
			text.add_end_class (class_c);
		end;

	put_origin_comment is
			-- Put original comment.
		local
			c: CLASS_C;
		do
			if global_adapt.source_enclosing_class 
				/= global_adapt.target_enclosing_class
			then
				put_text_item (ti_Dashdash);
				text.add_space;
				put_comment_text ("(from ");
				c := global_adapt.source_enclosing_class;
				put_classi (c.lace_class);
				put_comment_text (")");
				new_line
			end;
		end;

	new_expression is
			-- Prepare for a new expression.
		local
			f: like format
		do
			f := format;
				-- For features that go from
				-- normal to an infix and
				-- for rolling back.
			f.set_insertion_point (text.cursor)
			f.set_dot_needed (false);
			local_adapt := unnested_local_adapt;
			last_was_printed := true;
		end;
			
	prepare_for_feature (name: STRING; args: EIFFEL_LIST_B [EXPR_AS_B]) is
			-- Prepare for features within main features.
		local
			adapt: like local_adapt;
			type: TYPE_A
		do
			if format.dot_needed then
				adapt := local_adapt.adapt_nested_feature (name, global_adapt)
			else
				adapt := unnested_local_adapt.adapt_feature (name, 
											global_adapt)
				type := last_class_printed;
				if type /= Void then
						-- Need to update type local_adapt for
						-- ! TYPE ! name.make
					adapt.set_source_type (type);
					adapt.set_target_type (type);
					adapt.set_evaluated_type
				end
			end;
			local_adapt := adapt;
			arguments := args;
			was_infix_arguments := False;
		end;

	prepare_for_main_feature is
			-- Prepare for enclosing context feature.
		do
			local_adapt := global_adapt.adapt_main_feature;
			arguments := Void;
		end;

	prepare_for_current is
			-- Prepare for Current.
		do
			local_adapt := global_adapt.adapt_current;	
			arguments := Void;
		end;

	prepare_for_result is
			-- Prepare for Result.
		local
			adapt: like local_adapt;
			type: TYPE_A;
		do
			adapt := global_adapt.adapt_result;
			type := last_class_printed;
			if type /= Void then 
					-- Clone result adaptation.
					-- Need to update type in result for
					-- ! TYPE ! Result.make 
				adapt := clone (adapt);
				adapt.set_source_type (type);
				adapt.set_target_type (type);
				adapt.set_evaluated_type;
			end;
			local_adapt := adapt;
			arguments := Void;
		end;

	prepare_for_infix (internal_name: STRING; right: EXPR_AS_B) is
			-- Prepare for infix with feature `internal_name'
			-- and arg `right'.
		do
			local_adapt := local_adapt.adapt_infix (internal_name, global_adapt);
			arguments := right;
			was_infix_arguments := True;
		end;

	prepare_for_prefix (internal_name: STRING) is
			-- Prepare for infix with feature `internal_name'.
		do
			local_adapt := local_adapt.adapt_prefix (internal_name, global_adapt);
			arguments := void;
		end;

feature -- Output

	reversed_format_list (list: EIFFEL_LIST_B [AST_EIFFEL_B]) is
			-- Format `list' in reverse order.
		do
			list.reversed_format (Current)
		end;

	register_ancestors_invariants is
			-- Register the invariants for target class.
		do
			!! format_registration.make (class_c, client);
			format_registration.register_ancestors_invariants
		end;

	format_ast (ast: AST_EIFFEL_B) is
			-- Call simple_for on `ast'.
		do
			ast.format (Current)
		end;

	format_categories is
			-- Format the categories for class_c.
		do
			format_registration.format_categories (Current);
		end;

	format_invariants is
			-- Format the categories for class_c.
		do
			format_registration.format_invariants (Current);
		end;

	put_main_feature_name is
			-- Put feature name of anlayzed feature.
		do
				-- For infix features and for
				-- features becoming infixes
			format.set_insertion_point (text.cursor)
			if local_adapt.is_normal then
				put_normal_feature
			elseif local_adapt.is_infix then
					-- Don't want space around `infix'
				put_infix_name (local_adapt)
			else
				put_prefix_feature
			end
		end;

	put_current_feature is
			-- Put Current feature.
		do
			if local_adapt.is_normal then
				put_normal_feature
			elseif local_adapt.is_infix then
				put_infix_feature
			else
				put_prefix_feature
			end;
		end;

feature {NONE} -- Implementation

	put_normal_feature is
			-- Put normal feature (not infix or prefix feature).
		local
			feature_i: FEATURE_I;
			args: like arguments;
			item: BASIC_TEXT;
			f_name: STRING;
			adapt: like local_adapt;
			c: E_CLASS
		do
			if format.dot_needed then
				text.add (ti_Dot)
			else
				if not tabs_emitted then
					emit_tabs
				end
				if (in_assertion and then not is_feature_visible) then
					last_was_printed := false;
				end
			end;
			if last_was_printed then
				adapt := local_adapt;
				feature_i := adapt.target_feature;
				f_name := adapt.final_name;
				if feature_i /= void and then in_bench_mode then
					c := adapt.target_class;
					!FEATURE_TEXT! item.make (feature_i.api_feature (c.id), f_name);
				else			
					!! item.make (f_name)
				end;
				text.add (item);
				args := arguments;
				if args /= void then
					begin;
					if was_infix_arguments then
							-- Feature in source class was
							-- an infix (need to create new_expression).
						new_expression;
					end;
					set_separator (ti_Comma);
					set_space_between_tokens;
					text.add_space;
					text.add (ti_L_parenthesis);
					abort_on_failure;
					args.format (Current);
					text.add (ti_R_parenthesis);
					if last_was_printed then
						commit;
					else
						rollback;
					end;
					-- Reestablish local adaptations.
					local_adapt := adapt;
				else
					last_was_printed := true;
				end;			
			end;
		end;

	put_prefix_feature is
			-- Put prefix feature.
		local
			feature_i: FEATURE_I; 
			item: BASIC_TEXT;
			ot: OPERATOR_TEXT;
			f_name: STRING;
			adapt: like local_adapt;
			is_key: BOOLEAN;
			c: E_CLASS
		do
			adapt := local_adapt;
			f_name := adapt.final_name;
				-- Use source feature for stone.
			feature_i := adapt.target_feature;
			if f_name.item (1).is_alpha then
				is_key := True
			end
			last_was_printed := True;
			if feature_i /= Void and then in_bench_mode then
				c := adapt.target_class;
				!! ot.make (feature_i.api_feature (c.id), f_name)
				if is_key then
					ot.set_is_keyword
				end;
				item := ot;
				text.insert_two (format.insertion_point, item, ti_Space)
			else
				if is_key then
					!KEYWORD_TEXT! item.make (f_name)
				else
					!SYMBOL_TEXT! item.make (f_name)
				end;
				text.go_to (format.insertion_point)
				text.add (item);
			end;
			last_was_printed := True;
		end;

	put_infix_feature is
			-- Put infix feature.
		local
			args: like arguments;
			adapt: like local_adapt
		do
			adapt := local_adapt;
			text.add_space;
			put_infix_name (adapt);
			text.add_space;
			args := arguments;
			if args /= void then
				begin;
				new_expression;
				args.format (Current);
				if last_was_printed then
					commit;
				else
					rollback;
				end;
					-- Reestablish adaptations.
				local_adapt := adapt;
			end
		end;

	put_infix_name (adapt: like local_adapt) is
			-- Put infix feature.
		local
			feature_i: FEATURE_I;
			f_name: STRING;
			item: BASIC_TEXT;
			ot: OPERATOR_TEXT
			is_key: BOOLEAN;
			c: E_CLASS
		do
			f_name := adapt.final_name;
				-- Use source feature for stone.
			if f_name.item (1).is_alpha then
				is_key := True
			end;
			feature_i := adapt.target_feature;
			if feature_i /= Void and then in_bench_mode then
				c := adapt.target_class;
				!! ot.make (feature_i.api_feature (c.id), f_name)
				if is_key then
					ot.set_is_keyword
				end;
				item := ot
			elseif is_key then
				!KEYWORD_TEXT! item.make (f_name)
			else
				!SYMBOL_TEXT! item.make (f_name)
			end;
			text.add (item);
			last_was_printed := true;
		end;	
				
end	 -- class FORMAT_CONTEXT_B
