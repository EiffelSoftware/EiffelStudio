class FORMAT_CONTEXT

inherit

	SHARED_SERVER;
	SHARED_INST_CONTEXT

creation

	make

feature -- compilation test

	flat_struct: FLAT_STRUCT

feature -- commit / rollback system

	make (c: CLASS_C; is_short: BOOLEAN) is
		local
			first_format: LOCAL_FORMAT;
			ast: CLASS_AS;
			name: STRING;
			file: UNIX_FILE;
		do
			class_c := c;
			!!previous.make;
			!!text.make;
			!!first_format.make(c.actual_type, is_short);
			upper_name := c.class_name.duplicate;
			upper_name.to_upper;
			previous.add (first_format);
			if is_short then
				no_internals := true;
				client := system.any_class.compiled_class;
			end;
			!!flat_struct.make (c, client, no_internals);
			flat_struct.fill;
			--!!file.make ("FLAT.FILE");
			--if not file.exists then
				if flat_struct.ast /= void then
					prepare_class_text;
					System.set_current_class (class_c);
					Inst_context.set_cluster (class_c.cluster);
					flat_struct.ast.format (Current);
					System.set_current_class (Void);
					Inst_context.set_cluster (Void);
					--file.open_write;
					--text.basic_store (file);
					--file.close;
				end
			--else
				--file.open_read;
				--text ?= text.retrieved (file);
				--file.close;
			--end;
		end;

	class_c: CLASS_C;
	
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
		do
			new_format := format.twin;
			new_format.set_position(text.cursor);
			previous.add(new_format);
		end;

	commit is
		-- go back to previous format. keep text modifications
		do
			previous.remove;
			last_was_printed := true;
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
		end;


	always_succeed is
		-- do as if begin and commit had been done. quicker, but can't rollback
		do
			last_was_printed := true;
		end;

	last_was_printed: BOOLEAN;

	is_in_first_pass: BOOLEAN;



feature -- text construction

	no_internals: BOOLEAN;

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


	put_class_name(c : CLASS_C) is
			-- append class name to 'text', treated as a stone.
		local
			p : CLASSC_STONE;
			s: STRING;
			item: CLICKABLE_TEXT
		do
			!!p.make(c);
			s := c.class_name.duplicate;
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

	prepare_feature (feature_names: EIFFEL_LIST [FEATURE_NAME]) is
			-- append standard text before feature declaration 
		local
			item: BEFORE_FEATURE;
		do
			!!item.make(upper_name, feature_names);
			text.add (item);
		end;

	end_feature (feature_names: EIFFEL_LIST [FEATURE_NAME]) is
			-- append standard text after feature declaration
		local
			item: AFTER_FEATURE;
		do
			!!item.make (upper_name, feature_names);
			text.add (item);
		end;

	put_breakable is
		local
			mark: BREAKABLE_MARK;
		do
			!!mark;
			text.add (mark);
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
		do
			old_types := format.local_types;
			new_types := format.local_types.new_adapt_feat (name);
			format.set_local_types (new_types);
			arguments := arg;
		end;

	prepare_for_infix (internal_name: STRING; right: EXPR_AS) is
		do
			new_types := format.local_types.new_adapt_infix (internal_name);
			format.set_local_types (new_types);
			arguments := right;
		end;

	prepare_for_prefix (internal_name: STRING) is
		do
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
			end;
			f_name := format.local_types.final_name;
			if feature_i /= void then
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


	put_prefix is
		local
			feature_i: FEATURE_I; 
			item: BASIC_TEXT;
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
				insert (" ");
				insert_special (format.local_types.final_name);
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
				if not dot_needed then
					put_keyword ("Current");
				end;
				put_string(" ");
				put_special (format.local_types.final_name);
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
			format.set_classes (c, format.global_types.target_class, no_internals);
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

	set_in_assertion (b: BOOLEAN) is
		do
			format.set_in_assertion (b);
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
			origin_comment: EIFFEL_COMMENTS;
			class_name: STRING;
		do
			if 
				format.global_types.source_class 
				/= format.global_types.target_class
			then
				begin;
				next_line;
				!!s.make (50);
				s.append (" (from ");
				class_name := format.global_types.
					source_class.class_name.duplicate;
				class_name.to_upper;
				s.append (class_name);
				s.append (")");
				!!origin_comment.make (-1);
				origin_comment.add (s);
				put_comment (origin_comment);
				commit;
			end;
		end;

	formal_name (pos: INTEGER): ID_AS is
		require
			pos > 0;
			pos <= class_c.generics.count
		do
			Result := class_c.generics.i_th (pos).formal_name.duplicate;
			Result.to_upper;
		end;


feature -- Feature comments (for FORMAT_FEAT_CONTEXT)

	start_position: INTEGER is
		do
			Result := -1
		end

	put_feature_comments is do end;

end	
