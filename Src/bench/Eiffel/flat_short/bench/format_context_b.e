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
			reversed_format_list, put_current_feature
		end
	SHARED_SERVER;
	SHARED_INST_CONTEXT;
	SHARED_RESCUE_STATUS;
	SHARED_FORMAT_INFO;

creation

	make

feature -- Initialization

	make (c: CLASS_C) is
			-- Initialize Current for bench.
		do
			class_c := c;
			current_class_only := False;
			reset_format_booleans;
			troff_format := False;
			last_was_printed := True;
		ensure then
			class_c_set: class_c = c;
			batch_mode:	not in_bench_mode;
			analyze_ancestors: not current_class_only;
			do_flat: not is_short;
			not_troff_format: not troff_format
		end;

	init_feature_context (source, target: FEATURE_I; 
				feature_as: FEATURE_AS_B) is
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		require
			valid_source: source /= Void;
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

	first_assertion: BOOLEAN;
			-- Are we about to format the first assertion?
		
	format_registration: FORMAT_REGISTRATION;
			-- Structure registerd for formatting

	current_class_only: BOOLEAN;
			-- Is Current only processing `class_c' and not
			-- its ancestors?

	is_clickable_format: BOOLEAN is
			-- Is the generated format the "clickable" format?
		do
			Result := current_class_only and not is_short
		end;

	troff_format: BOOLEAN;
			-- Is Current going to be a troff format? (Used 
			-- remove from CLASSNAME within assertions)

	class_c: CLASS_C;
			-- Current class being processed
	
	format: LOCAL_FORMAT_B;
			-- Current internal formatting directives

	last_was_printed: BOOLEAN;
			-- Was we able to print a structure?

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
			-- Feature adaptation information for enclosing
			-- features being analyzed

	saved_global_adapt: GLOBAL_FEAT_ADAPTATION;
			-- Saved feature adaptation information for enclosing
			-- features being analyzed

	unnested_local_adapt: LOCAL_FEAT_ADAPTATION
			-- Feature adaptation information for non nested features
			-- within the enclosing features

	local_adapt: LOCAL_FEAT_ADAPTATION
			-- Current feature adaptation information for features
			-- within the enclosing features

	execution_error: BOOLEAN;
			-- Did an error occur during `execute'?

	rescued: BOOLEAN;
			-- Was Current format rescued?

feature -- Access

	chained_assertion: CHAINED_ASSERTIONS is
			-- Chained assertion for current analyzed feature.
		require
			valid_global_adapt: global_adapt /= Void;
			has_target_feat: global_adapt.target_enclosing_feature /= Void;
		local
			chained_prec: CHAINED_ASSERTIONS;
			t_feat: FEATURE_I;
			assert_id_set: ASSERT_ID_SET
		do
			t_feat := global_adapt.target_enclosing_feature;
			assert_id_set := t_feat.assert_id_set
			if assert_id_set /= Void and then
				assert_id_set.count > 0 
			then
				chained_prec := 
					format_registration.chained_assertion_of_fid (t_feat.feature_id)
			end
		end;

	formal_name (pos: INTEGER): ID_AS_B is
			-- Formal name of class_c generics at position `pos.
		do
			Result := clone (class_c.generics.i_th (pos).formal_name)
			Result.to_upper;
		end;

feature -- Setting

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

	set_troff_format is
			-- Set troff_format to True.
		do
			troff_format := True
		ensure
			troff_format: troff_format
		end;

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
			global_adapt := clone (global_adapt);
			global_adapt.set_source_enclosing_class (c);
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
		end;

	save_global_adapt is
			-- Save global adapt.
		do
			saved_global_adapt := global_adapt;
		ensure
			saved_global_adapt = global_adapt
		end;

	restore_global_adapt is
			-- Restore global adapt.
		require
			valid_saved_global_adapt: saved_global_adapt /= Void
		do
			global_adapt := saved_global_adapt;
			saved_global_adapt := Void;
		ensure
			saved_global_adapt = Void;
			(old saved_global_adapt) = global_adapt
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
			simple_ctxt: FORMAT_CONTEXT
		do
			if not rescued then
				execution_error := false;
				Error_handler.wipe_out;
				initialize;
				class_name := clone (class_c.class_name)
				class_name.to_upper;
				if is_short then
					client := system.any_class.compiled_class;
				end;
				!! format_registration.make (class_c, client);
				format_registration.fill (current_class_only);
				System.set_current_class (class_c);
				if format_registration.target_ast /= void then
					Inst_context.set_cluster (class_c.cluster);
					format_registration.target_ast.format (Current);
					Inst_context.set_cluster (Void);
				else
					execution_error := true
				end;
				System.set_current_class (Void);
debug ("FLAT_SHORT")
	!! simple_ctxt.make (format_registration.target_ast)
	format_registration.target_ast.simple_format (simple_ctxt);
	io.error.putstring (simple_ctxt.text.image)
end
			else
				execution_error := True;
				rescued := False
			end;
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

	put_class_name (c: CLASS_C) is
			-- Append class name to 'text', treated as a stone.
		local
			p : CLASSC_STONE;
			s: STRING;
			item: CLASS_NAME_TEXT
		do
			if not tabs_emitted then
				emit_tabs
			end;
			!! p.make(c);
			s := clone (c.class_name)
			s.to_upper;
			!! item.make (s, p);
			text.add (item);
		end;

	put_classi_name (c: CLASS_I) is
			-- Append class name to 'text', treated as a stone.
		local
			p : CLASSI_STONE;
			s: STRING;
			item: CLASS_NAME_TEXT
		do
			if not tabs_emitted then
				emit_tabs
			end;
			!!p.make(c);
			s := clone (c.class_name)
			s.to_upper;
			!!item.make (s, p);
			text.add (item);
		end;

	prepare_class_text is
			-- Append standard text before class.
		local
			item: BEFORE_CLASS;
		do
			!! item.make (class_c);
			text.add (item);
		end;

	end_class_text is
			-- Append standard text after class.
		local
			item: AFTER_CLASS
		do
			!! item.make (class_c);
			text.add (item);
		end;

	end_feature is
			-- Append standard text after feature declaration.
		local
			item: AFTER_FEATURE;
		do
			if troff_format then
				!! item.make (class_name, Void);
				text.add (item);
			end
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
				text.add (ti_Space);
				put_comment_text ("(from ");
				c := global_adapt.source_enclosing_class;
				put_class_name (c);
				put_comment_text (")");
				new_line;
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
		do
			if format.dot_needed then
				local_adapt := local_adapt.adapt_nested_feature (name)
			else
				local_adapt := unnested_local_adapt.adapt_feature (name, 
											global_adapt)
			end;
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
		do
			local_adapt := global_adapt.adapt_result;	
			arguments := Void;
		end;

	prepare_for_infix (internal_name: STRING; right: EXPR_AS_B) is
			-- Prepare for infix with feature `internal_name'
			-- and arg `right'.
		do
			local_adapt := local_adapt.adapt_infix (internal_name);
			arguments := right;
			was_infix_arguments := True;
		end;

	prepare_for_prefix (internal_name: STRING) is
			-- Prepare for infix with feature `internal_name'.
		do
			local_adapt := local_adapt.adapt_prefix (internal_name);
			arguments := void;
		end;

feature -- Output

	reversed_format_list (list: EIFFEL_LIST_B [AST_EIFFEL_B]) is
			-- Format `list' in reverse order.
		do
			list.reversed_format (Current)
		end;

	format_ast (ast: AST_EIFFEL_B) is
			-- Call simple_for on `ast'.
		do
			ast.format (Current)
		end;

	format_class_comments is
			-- Format comments at the top of the class
			-- for class_c.
		do
			format_registration.format_class_comments (Current);
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

	prepare_feature (feature_name: STRING; is_pref, is_inf: BOOLEAN) is
			-- Append standard text before feature declaration.
		local
			item: BEFORE_FEATURE;
			temp: STRING;
		do
			if troff_format then
				temp := clone (feature_name)
				if is_inf then
					if temp.substring (1, 7).is_equal ("_infix_") then
						temp.tail (feature_name.count - 7);
						temp := operator_table.name (temp);
						!! item.make (class_name, temp);
					else
						!! item.make (class_name, feature_name);
					end;
					item.set_is_infix
				elseif is_pref then
					if feature_name.substring (1, 8).is_equal ("_prefix_") then
						temp.tail (feature_name.count - 8);
						temp := operator_table.name (temp);
						!! item.make (class_name, temp);
					else
						!! item.make (class_name, feature_name);
					end;
					item.set_is_prefix
				else
					!! item.make(class_name, feature_name);
				end;
				text.add (item);
			end
		end;

feature {NONE} -- Implementation

	put_normal_feature is
			-- Put normal feature (not infix or prefix feature).
		local
			feature_i: FEATURE_I;
			stone: FEATURE_STONE;
			args: like arguments;
			item: BASIC_TEXT;
			f_name: STRING;
			adapt: like local_adapt
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
					stone := feature_i.stone (adapt.target_class);
					!CLICKABLE_TEXT!item.make (f_name, stone);
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
					text.add (ti_Space);
					text.add (ti_L_parenthesis);
					abort_on_failure;
					args.format (Current);
					text.add (ti_R_parenthesis);
					if last_was_printed then
						commit;
					else
						rollback;
					end;
					-- Reestablish adaptations.
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
			stone: FEATURE_STONE;
			f_name: STRING;
			adapt: like local_adapt;
		do
			adapt := local_adapt;
			f_name := adapt.final_name;
				-- Use source feature for stone.
			feature_i := adapt.target_feature;
			if feature_i /= Void and then in_bench_mode then
				stone := feature_i.stone (adapt.target_class);
				! CLICKABLE_TEXT !item.make (f_name, stone)
			else
				!! item.make (f_name)
			end;
			text.insert_two (format.insertion_point, item, ti_Space)
			if f_name.item (1).is_alpha then
				item.set_is_keyword
			else
				item.set_is_special
			end
			last_was_printed := True;
		end;

	put_infix_feature is
			-- Put infix feature.
		local
			args: like arguments;
			adapt: like local_adapt
		do
			adapt := local_adapt;
			text.add (ti_Space);
			put_infix_name (adapt);
			text.add (ti_Space);
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
			stone: FEATURE_STONE;
			f_name: STRING;
			item: BASIC_TEXT;
		do
			f_name := adapt.final_name;
				-- Use source feature for stone.
			feature_i := adapt.target_feature;
			if feature_i /= Void and then in_bench_mode then
				stone := feature_i.stone (adapt.target_class);
				!CLICKABLE_TEXT!item.make (f_name, stone)
			else	
				!!item.make (f_name)
			end;
			if f_name.item (1).is_alpha then
				item.set_is_keyword
			else
				item.set_is_special
			end;
			text.add (item);
			last_was_printed := true;
		end;	
				
end	 -- class FORMAT_CONTEXT_B
