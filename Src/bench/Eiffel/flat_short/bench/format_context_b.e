class FORMAT_CONTEXT

inherit

	SPECIAL_AST;
	SHARED_SERVER;
	SHARED_INST_CONTEXT;
	SHARED_RESCUE_STATUS;
	SHARED_ERROR_HANDLER;
	WINDOWS

creation

	make

feature -- Flat and flat/short modes

	set_in_bench_mode is
		do
			in_bench_mode_bool.set_value (True);
		end;

	set_current_class_only is
		do
			current_class_only := True;	
		end

	set_is_short is
		do
			is_short_bool.set_value (True);
		end;

	set_troff_format is
		do
			troff_format := True
		end;

	set_order_same_as_text is
		do
			order_same_as_text_bool.set_value (True)
		end;

feature

	rescued: BOOLEAN;

	make (c: CLASS_C) is
		do
			class_c := c;
			current_class_only := False;
			is_short_bool.set_value (False);
			in_bench_mode_bool.set_value (False);
			order_same_as_text_bool.set_value (False);
			in_assertion_bool.set_value (False);
			troff_format := False;
		ensure
			class_c_set: class_c = c;
			batch_mode:	not in_bench_mode;
			analyze_ancestors: not current_class_only;
			do_flat: not is_short;
			not_troff_format: not troff_format
		end;

	execute is
				-- Execute the flat or flat_short.
		require
			class_set: class_c /= Void
		local
			first_format: LOCAL_FORMAT;
			ast: CLASS_AS;
			name: STRING;
		do
			if not rescued then
				Error_handler.wipe_out;
				!!previous.make;
				!!text.make;
				!!first_format.make(class_c.actual_type);
				upper_name := clone (class_c.class_name)
				upper_name.to_upper;
				previous.extend (first_format);
				if is_short then
					client := system.any_class.compiled_class;
				end;
				!!flat_struct.make (class_c, client);
				flat_struct.fill (current_class_only);
				System.set_current_class (class_c);
				if flat_struct.ast /= void then
					prepare_class_text;
					Inst_context.set_cluster (class_c.cluster);
					flat_struct.ast.format (Current);
					Inst_context.set_cluster (Void);
				end;
				System.set_current_class (Void);
			else
				rescued := False
			end
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end
		end;

	current_class_only: BOOLEAN;
			-- Is Current only processing `class_c' and not
			-- its ancestors?

	troff_format: BOOLEAN;
			-- Is Current going to be a troff format? (Used 
			-- remove from CLASSNAME within assertions)

	flat_struct: FLAT_STRUCT
			-- Structure used for processing the flat (or short)

	class_c: CLASS_C;
			-- Current class being processed
	
	upper_name: STRING; 

	previous: LINKED_STACK[LOCAL_FORMAT];
			-- previous  format (push at begin, pop at commit and rollback)

 	format: LOCAL_FORMAT is
			-- Current internal formatting directives
		do
			Result := previous.item;
		end;

	begin is
		-- Save format before a change
		local
			new_format: LOCAL_FORMAT;
			i: INTEGER
		do
			new_format := clone (format);
			text.finish;
			new_format.set_position(text.cursor);
			previous.extend (new_format);
debug ("FS_RBRF")
			io.error.putstring ("beginning format... %N");
			i := text.index;
			io.error.putstring (text.image);
			text.go_i_th (i);
			io.error.new_line;
end
		end;

	commit is
		-- go back to previous format. keep text modifications
		local
			i: INTEGER
		do
			previous.remove;
			last_was_printed := true;
debug ("FS_RBRF")
			io.error.putstring ("committin..%N");
			i := text.index;
			io.error.putstring (text.image);
			text.go_i_th (i);
			io.error.new_line;
end
		end;


	again is
			-- keep current format, Discard text modifications
			-- since last begin.
			-- Commit or rollback still to be done.
		do
			text.head(format.position_in_text);
		end;


	rollback is
		-- go back to previous format.Discard text modifications 
		do
			text.head (format.position_in_text);
			previous.remove;
			last_was_printed := false;
debug ("FS_RBRF")
			io.error.putstring ("rollback to..%N");
			io.error.putstring (text.image);
			io.error.new_line;
end
		end;


	always_succeed is
		-- do as if begin and commit had been done. quicker, but can't rollback
		do
			last_was_printed := true;
		end;

	last_was_printed: BOOLEAN;

	is_in_first_pass: BOOLEAN;

	set_in_assertion is
		do
			in_assertion_bool.set_value (True);
		end

	set_not_in_assertion is
		do
			in_assertion_bool.set_value (False);
		end

feature -- text construction

	client: CLASS_C;

	no_inherited: BOOLEAN;
		-- immediate feature only;
		--| not yet implemented

	first_assertion: BOOLEAN;
		
	set_first_assertion (b: BOOLEAN) is
		do
			first_assertion := b;
		end;

	text: STRUCTURED_TEXT;
		-- formatted text

	put_string, put_identifier (s : STRING) is
			-- append s to 'text'
		local
			item: BASIC_TEXT;	
		do
			if s /= void then
				!!item.make (s);
				text.add (item);
			end
		end;

	put_keyword(k : STRING) is
			-- append k to 'text', known as a keyword
		local
			item: BASIC_TEXT;
		do
			!!item.make (k);
			item.set_is_keyword;
			text.add (item);	
		end;

	put_special(s : STRING) is
		-- append s to 'text', known as a comment
		local
			item: BASIC_TEXT;
		do
			!!item.make (s);
			item.set_is_special;
			text.add (item);	
		end;

	put_class_name (c: CLASS_C) is
			-- append class name to 'text', treated as a stone.
		local
			p : CLASSC_STONE;
			s: STRING;
			item: CLICKABLE_TEXT
		do
			!!p.make(c);
			s := clone (c.class_name)
			s.to_upper;
			!!item.make (s, p);
			text.add (item);
		end;

	put_classi_name (c: CLASS_I) is
			-- append class name to 'text', treated as a stone.
		local
			p : CLASSI_STONE;
			s: STRING;
			item: CLICKABLE_TEXT
		do
			!!p.make(c);
			s := clone (c.class_name)
			s.to_upper;
			!!item.make (s, p);
			text.add (item);
		end;

	put_separator is
			-- append the separator
		local
			sep_item: BASIC_TEXT;
			line_item: NEW_LINE_TEXT;
		do
			if format.new_line_before_separator then
				next_line;
			end;
			if format.separator /= void then
				!!sep_item.make (format.separator);
				if format.is_separator_special then
					sep_item.set_is_special
				elseif format.is_separator_keyword then
					sep_item.set_is_keyword
				end;
				text.add (sep_item);
			end;
			if format.indent_between_tokens then
				next_line;
			end;
		end;

	next_line is
			--	 go to next line, indent as necessary
		local
			item: NEW_LINE_TEXT;
		do
			!!item.make (format.indent_depth);
			text.add (item)
		end;

	prepare_class_text is
			-- append standard text before class 
		local
			item: BEFORE_CLASS;
		do
			!!item.make (upper_name);
			text.add (item);
		end;

	end_class_text is
			-- append standard text after class
		local
			item: AFTER_CLASS
		do
			!!item.make (upper_name);
			text.add (item);
		end;

	prepare_feature (feature_name: STRING; is_prefix, is_infix: BOOLEAN) is
			-- append standard text before feature declaration 
		local
			item: BEFORE_FEATURE;
			temp: STRING;
		do
			if troff_format then
				old_types := format.local_types;
				temp := clone (feature_name)
				if is_infix then
					if temp.substring (1, 7).is_equal ("_infix_") then
						temp.tail (feature_name.count - 7);
						temp := old_types.operator_name (temp);
						!!item.make (upper_name, temp);
					else
						!!item.make (upper_name, feature_name);
					end;
					item.set_is_infix
				elseif is_prefix then
					if feature_name.substring (1, 8).is_equal ("_prefix_") then
						temp.tail (feature_name.count - 8);
						temp := old_types.operator_name (temp);
						!!item.make (upper_name, temp);
					else
						!!item.make (upper_name, feature_name);
					end;
					item.set_is_prefix
				else
					!!item.make(upper_name, feature_name);
				end;
				text.add (item);
			end
		end;

	end_feature is
			-- append standard text after feature declaration
		local
			item: AFTER_FEATURE;
		do
			if troff_format then
				!!item.make (upper_name, Void);
				text.add (item);
			end
		end;

	put_breakable is
		do
		end;
			

feature -- local_control

	set_separator (s: STRING) is
		do
			format.set_separator(s);
		end;

	separator_is_special is
		do
			format.set_is_special(true);
		end;

	separator_is_normal is
		do
			format.set_is_special(false);
		end;

	abort_on_failure is
		do
			format.set_must_abort(true);
		end;
	
	continue_on_failure is
		do
			format.set_must_abort( false);
		end;


	new_line_between_tokens is
		do
			format.set_must_indent (true);
		end;

	no_new_line_between_tokens is
		do
			format.set_must_indent (false);
			format.set_is_special (true);
		end;

	indent_one_more is
		do
			format.indent_one_more;
		end;

	indent_one_less is
		do
			format.indent_one_less;
		end;

	must_abort_on_failure: BOOLEAN is
		do
			Result := format.must_abort_on_failure
		end;

	
	set_illegal_operator is
			-- set illegal operator to true
		do
			format.set_illegal_operator;
		end;

feature -- type control

	new_expression is
			-- prepare for a new expression
		do
			format.set_local_types (format.global_types);
			set_insertion_point;
			format.set_priority (12);
			format.set_dot_needed (false);
			last_was_printed := true;
		end;
			
	may_need_adaptation: BOOLEAN is
			-- is the type of the expression (may be implicit Current) in
			-- the source class to change in the target class
		do	
			Result := format.local_types.may_need_adaptation;
		end;
	
	arguments: AST_EIFFEL;


	illegal_operator: BOOLEAN is
			-- are operator illegal, while other feature name are
			-- ie after $ and like
		do
			Result := format.illegal_operator;
		end;

	put_name_of_class is
		do
			put_class_name (class_c);
		end;
			

	prepare_for_feature (name: STRING; arg: EIFFEL_LIST [EXPR_AS]) is
			-- Prepare for features within main features
		do
			old_types := format.local_types;
			new_types := format.local_types.new_adapt_feat (name);
			format.set_local_types (new_types);
			arguments := arg;
		end;

	prepare_for_main_infix is
			-- Prepare for class features
		do
			set_types_back_to_global;
			old_types := format.local_types;
			new_types := format.local_types.main_adapt_infix;
			format.set_local_types (new_types);
			arguments := Void;
		end;

	prepare_for_main_prefix is
			-- Prepare for class features
		do
			set_types_back_to_global;
			old_types := format.local_types;
			new_types := format.local_types.main_adapt_prefix;
			format.set_local_types (new_types);
			arguments := Void;
		end;

	prepare_for_main_feature is
			-- Prepare for class features
		do
			set_types_back_to_global;
			old_types := format.local_types;
			new_types := format.local_types.main_adapt_feat;
			format.set_local_types (new_types);
			arguments := Void;
debug ("FS_RBRF")
	io.error.putstring ("ANALZYING FEATURE FOR ROLLBACK/COMMIT: ");
	io.error.putstring (format.local_types.final_name);
	io.error.new_line;
end;
		end;

	prepare_for_current is
			-- Prepare for Current
		do
			old_types := format.local_types;
			new_types := format.local_types.new_adapt_current;
			format.set_local_types (new_types);
			arguments := Void;
		end;

	prepare_for_result is
			-- Prepare for Result
		do
			old_types := format.local_types;
			new_types := format.local_types.new_adapt_result;
			format.set_local_types (new_types);
			arguments := Void;
		end;

	prepare_for_infix (internal_name: STRING; right: EXPR_AS) is
		do
			old_types := format.local_types;
			new_types := format.local_types.new_adapt_infix (internal_name);
			format.set_local_types (new_types);
			arguments := right;
		end;

	prepare_for_prefix (internal_name: STRING) is
		do
			old_types := format.local_types;
			new_types := format.local_types.new_adapt_prefix (internal_name);
			format.set_local_types (new_types);
			arguments := void;
		end;

	put_current_feature is
		do
			if priority < format.local_types.priority then
				insert_special ("(");
				put_special (")");
			end;
			if format.local_types.is_normal then
				put_normal_feature
			elseif format.local_types.is_infix then
				put_infix
			else
				put_prefix
			end
			old_types := Void
		end;

	index_feature is
		local
			name: STRING;
		do
		end;
			
	put_normal_feature is
		local
			feature_i: FEATURE_I;
			stone: FEATURE_STONE;
			arg: EIFFEL_LIST [EXPR_AS];
			item: BASIC_TEXT;
			i, nb: INTEGER;
			f_name: STRING;
		do
			feature_i := format.local_types.target_feature;
			if dot_needed then
				put_dot
			elseif (in_assertion and then not is_feature_visible) then
				last_was_printed := false;
			end;
			if last_was_printed then
				f_name := format.local_types.final_name;
				if feature_i /= void and then in_bench_mode then
					stone := feature_i.stone (old_types.target_class);
					!CLICKABLE_TEXT!item.make (f_name, stone);
				else			
					!!item.make (f_name)
				end;
				text.add (item);
				arg ?= arguments;
				if arg /= void then
					begin;
					set_separator(",");
					no_new_line_between_tokens;
					put_special (" (");
					abort_on_failure;
					arguments.format (Current);
					put_special (")");
					if last_was_printed then
						commit;
						keep_types;
					else
						rollback;
					end;
					from
						arg.start;
						nb := arg.count;
						i := 1;
					until	
						i > nb	
					loop
						i := i + i
					end
				else
					last_was_printed := true;
				end;			
			end;
		end;

	put_main_fix is
				-- Print main pre or infix
		local
			feature_i: FEATURE_I; 
			item: BASIC_TEXT;
			stone: FEATURE_STONE;
			f_name: STRING;
		do
			feature_i := format.local_types.target_feature;
			f_name := format.local_types.final_name;
			if print_fix_keyword then
				if format.local_types.is_prefix then
					put_keyword ("prefix ")
				else
					put_keyword ("infix "); 
				end
			end;
			if feature_i /= Void and then in_bench_mode then
				stone := feature_i.stone (old_types.target_class)
				!CLICKABLE_TEXT!item.make (f_name, stone);
			else
				!!item.make (f_name)
			end;
			text.add (item)
		end;

	put_prefix is
		local
			feature_i: FEATURE_I; 
			item: BASIC_TEXT;
			stone: FEATURE_STONE;
			f_name: STRING;
		do
			if illegal_operator then
				put_special ("(");
				put_keyword ("prefix");
				put_string (" ");		
				!!item.make (format.local_types.final_name);
				if item.image.item (1) >= 'a' and item.image.item (1) <= 'z' then
					item.set_is_keyword
				end;
				text.add (item);	
				put_special ("%")");
			else
				feature_i := format.local_types.target_feature;
				f_name := format.local_types.final_name;
				insert (" ");
				if feature_i /= Void and then in_bench_mode then
					stone := feature_i.stone (old_types.target_class);
					!CLICKABLE_TEXT!item.make (f_name, stone);
					item.set_is_special;
					text.insert (format.insertion_point, item);
				else
					insert_special (f_name);
				end;
					-- careful: stone + keyword or special
				if not dot_needed then
					put_keyword ("Current");
				end;
				keep_types;
				last_was_printed := true;
			end;
		end;

	put_infix is
		local
			arg: EXPR_AS;
			old_priority : INTEGER;
			feature_i: FEATURE_I;
			stone: FEATURE_STONE;
			f_name: STRING;
			item: BASIC_TEXT
		do
			if illegal_operator then
				put_special ("(");
				put_keyword ("infix");
				put_string (" ");
				put_string ("%"");
				put_string (format.local_types.final_name);
				put_special ("%")");
				last_was_printed := true;
			else
				feature_i := format.local_types.target_feature;
				f_name := format.local_types.final_name;
				if not dot_needed then
					put_keyword ("Current");
				end;
				put_string(" ");
				if feature_i /= Void and then in_bench_mode then
					stone := feature_i.stone (old_types.target_class);
					!CLICKABLE_TEXT!item.make (f_name, stone);
					item.set_is_special;
					text.add (item);
				else	
					put_special (format.local_types.final_name);
				end;
				put_string(" ");
				old_priority := format.local_types.priority;
				arg ?= arguments;
				if arg /= void then
					begin;
					new_expression;
					arg.format (Current);
					if last_was_printed then
						commit;
					else
						rollback;
					end;
					if format.local_types.priority < old_priority then
						insert_special("(");
						put_special(")");
					end;
				end;
			end;		
		end;	
	
				
	is_feature_visible: BOOLEAN  is
			-- should the feature be visible
		do
			Result := client = void
				or else format.local_types.is_visible (client)
		end;

	old_types, new_types: FEAT_ADAPTATION;
	new_priority: INTEGER;
	
	set_source_class (c: CLASS_C) is
		require
			good_class: c /= void
		do
			format.set_classes (c, format.global_types.target_class)
		end;

	set_context_features (source, target: FEATURE_I) is
		do
			format.set_context_features (source, target);
		end;

	set_source_context (source: FEATURE_I) is
		do
			format.set_context_features (source, 
				format.global_types.target_enclosing_feature);
		end;

	keep_types is
		do
			format.set_local_types (new_types);
			format.set_priority (new_priority);
		end;
	
	set_types_back_to_global is
		do
			format.set_local_types (format.global_types);
			format.set_priority (12);
		end;

	set_new_types(t: like new_types; p: like new_priority) is
		do
			new_types := t;
			new_priority := p;
		end;


feature -- infix and prefix control

	set_insertion_point is
			-- Remember text position for parantheses and prefix operator
		do
			format.set_insertion_point(text.cursor);
		end;

	insert (s: STRING) is
		local
			item: BASIC_TEXT;	
		do
			if 
				s /= void 
			then
				!!item.make (s);
				text.insert (format.insertion_point, item)
			end;	
		end;

	insert_special (s: STRING) is
		local
			item: BASIC_TEXT;
		do
			!!item.make (s);
			item.set_is_special;
		 	text.insert (format.insertion_point, item);	
		end;
	
	need_dot is
		do
			format.set_dot_needed (true);
		end;

	dot_needed: BOOLEAN is
		do
			Result := format.dot_needed;
		end;

	put_dot is
		do
			put_special(".");
		end;


	priority: INTEGER is
		do
			Result := format.priority;
		end;


feature -- comments

	put_comment (comment: EIFFEL_COMMENTS) is
		local
				i: INTEGER;
		do
			begin;
			if comment /= void then
				if comment.count > 0 
					and comment.text.item (1).item (1) /= '|'
				then
					put_string ("-- ");
					put_string (comment.text.item (1));
					from
						i := 2
					until
						i > comment.count
						or else comment.text.item (i).item (1) = '|'
					loop
						next_line;
						put_string ("-- ");
						put_string (comment.text.item (i));
						i := i + 1;
					end;
				end;
			end;
			commit;
		end;
			
	put_origin_comment is
		local
			s: STRING;
			c: CLASS_C;
		do
			if 
				format.global_types.source_class 
				/= format.global_types.target_class
			then
				begin;
				next_line;
				!!s.make (50);
				put_string ("--  (from ");
				c := format.global_types.source_class;
				put_class_name (c);
				put_string (")");
				commit;
			end;
		end;

	formal_name (pos: INTEGER): ID_AS is
		require
			pos > 0;
			pos <= class_c.generics.count
		do
			Result := clone (class_c.generics.i_th (pos).formal_name)
			Result.to_upper;
		end;

end	
