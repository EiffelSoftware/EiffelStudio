class FORMAT_CONTEXT
inherit
	SHARED_SERVER

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
		do
			io.putstring ("FORMATTING A CLASS %N");
			class_c := c;
			!!previous.make;
			!!text.make;
			!!first_format.make(c.actual_type);
			upper_name := c.class_name.duplicate;
			upper_name.to_upper;
			previous.add (first_format);
			if is_short then
				!FLAT_SHORT_TROFF_DEF!definition.make;
			else
				!FLAT_DEF!definition.make;
			end;
			!!flat_struct.make (c, definition.client);
			flat_struct.fill;
			if flat_struct.ast /= void then
				prepare_class_text (upper_name);
				flat_struct.ast.format (Current);
			end;
	end;

	class_c: CLASS_C;
	
	upper_name: STRING; 

	previous: LINKED_STACK[LOCAL_FORMAT];
		-- previous  format (push at begin, pop at commit and rollback)

 	format : LOCAL_FORMAT is
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
			new_format.set_position(text.count);
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


	is_reconstitution: BOOLEAN;


feature -- text construction

	definition : FORMAT_DEFINITION;
		-- pretty printer options

	no_internals: BOOLEAN is
			-- short or flat /short form
		do	
			Result := definition.no_internals;
		end;

	no_inherited: BOOLEAN;
		-- immediate feature only;
		--| not yet implemented

	first_assertion: BOOLEAN;
		
	set_first_assertion (b: BOOLEAN) is
		do
			first_assertion := b;
		end;

	text : CLICK_STRUCT;
		-- formatted text

	put_string(s : STRING) is
			-- append s to 'text'
		do
			text.put_string (s);
		end;


	put_keyword(k : STRING) is
			-- append k to 'text', including keyword formatting command.

		do
			text.put_string (definition.before_keyword);
			text.put_string (k);
			text.put_string (definition.after_keyword);
		end;

	
	put_special(s : STRING) is
		-- append s to 'text', including special symbol formatting command.
		do
			text.put_string(definition.before_special);
			text.put_string(s);
			text.put_string(definition.after_special);
		end;




	put_class_name(c : CLASS_C) is
			-- append class name to 'text', treated as a stone.
		local
			p : CLASSC_STONE;
			s: STRING;
		do
			!!p.make(c);
			s := c.class_name.duplicate;
			s.to_upper;
			text.put_clickable_string(p, s);
		end;




	put_identifier(s : STRING) is
			--append s to text
		do
			text.put_string(s);
		end;



	put_separator is
			-- append the separator
		local
			s: STRING;
		do
			s := format.separator;
			if s /= void then
				if format.is_separator_special then
					put_special(format.separator)
				else
					put_string(format.separator)
				end
			end;
			if format.indent_between_tokens then
				next_line;
			else
				put_string (" ");
			end;
		end;

	trace is
		local
			i: INTEGER;
			s: STRING;
		do
			!!s.make (20);
			i := previous.count;
			s.append("|");
			s.append_integer(i);
			s.append ("|");
			s.append_integer (format.indent_depth);
			s.append ("|");
			put_string (s);
		end;

			

	next_line is
			--	 go to next line, indent as necessary
		local
			i : INTEGER;
			s: STRING;
		do
			new_line;
			from
				i := 1;
			until 
				i > format.indent_depth
			loop
				indent;	
				i := i + 1
			end;
		end;

	new_line is
			-- append new_line character to text
			--|might change according to definition in future release
		do
			put_string("%N");
		end;

	indent is
			-- add one tab or equivalent, as specified in definition
		local
			i : INTEGER;
		do
			if definition.use_blank_as_tab then
				from 
					i := 1
				until
					i > definition.tab_length 
				loop
					put_string(" ");
				    i := i + 1
				end
			else
				put_string("%T")
			end
		end;

	

	prepare_class_text (class_name: STRING) is
			-- append standard text before class according to definition
		do
			put_string(definition.before_class (class_name));
		end;

	end_class_text (class_name: STRING) is
			-- append standard text after class according to definition
		do
			put_string(definition.after_class (class_name));
		end;

	prepare_feature (class_name, feature_name: STRING) is
			-- append standard text before feature declaration according to definition
		do
			put_string(definition.before_feature (class_name, feature_name));
		end;

	end_feature (class_name, feature_name: STRING) is
			-- append standard text after feature declaration according to definition
		do
			put_string(definition.after_feature (class_name, feature_name));
		end;


feature -- local_control

	set_separator (s: STRING) is
		do
			format.set_separator(s);
		end;

	separator_is_special is
		do
			format.set_is_special(false);
		end;

	separator_is_normal is
		do
			format.set_is_special(true);
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

	set_call_level is
			-- set call level to true
		do
			format.set_call_level;
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

	call_level: BOOLEAN is 
			-- should feature name be written as identifier
			-- (vs  complete declaration)
		do
			Result := format.call_level;
		end;		

	illegal_operator: BOOLEAN is
			-- are operator illegal, while other feature name are
			-- ie after $ and like
		do
			Result := format.illegal_operator;
		end;

	prepare_for_feature (name: STRING; arg: EIFFEL_LIST [EXPR_AS]) is
		do
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
			if is_feature_visible then
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
			else
				last_was_printed := false;
			end;
		end;

	index_feature is
		local
			name: STRING;
		do
			!!name.make (50);
			if format.local_types.is_prefix then
				name.append (definition.before_keyword);
				name.append ("prefix");
				name.append (definition.after_keyword);
				name.append (" ");
			elseif format.local_types.is_infix then
				name.append (definition.before_keyword);
				name.append ("prefix");
				name.append (definition.after_keyword);
				name.append (" ");
			end;
			name.append (format.local_types.final_name);
			prepare_feature (upper_name, name);
		end;
			

			
			
	
	put_normal_feature is
		local
			feature_i: FEATURE_I;
			stone: FEATURE_STONE;
			feature_as: FEATURE_AS;
			arg: EIFFEL_LIST [EXPR_AS];
		do
			feature_i := format.local_types.target_feature;
			if dot_needed then
				put_dot
			end;
			if feature_i /= void then
				feature_as := body_server.item (feature_i.body_id);
				!!stone.make (feature_i, feature_as.start_position,
						feature_as.end_position);
				text.put_clickable_string (stone,
						format.local_types.final_name)
			else
				text.put_string (format.local_types.final_name)
			end;
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
			else
				last_was_printed := true;
			end;			
		end;


	put_prefix is
		local
			feature_i: FEATURE_I; 
		do
			if illegal_operator then
				put_special ("(");
				put_keyword ("prefix");
				put_string (" ");		
				put_string (format.local_types.final_name);
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
			Result := definition.client = void
				or else format.local_types.is_visible (definition.client)
		end;

	new_types: FEAT_ADAPTATION;
	new_priority: INTEGER;
	
	set_source_class (c: CLASS_C) is
		do
			format.set_classes (c, format.global_types.target_class);
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
			format.set_insertion_point(text.count);
		end;

    insert (s: STRING) is
        do
			if 
				s /= void 
			--	and format.insertion_point < text.count
			then
				text.insert_string (s, format.insertion_point + 1);
			end;	
        end;

    insert_special (s: STRING) is
		local
			printed: STRING;
        do
			printed := s.duplicate;
			if definition.before_special /= void then
				printed.prepend(definition.before_special);
			end;
			if definition.after_special /= void then
				printed.append (definition.after_special);
			end;	
			insert (printed);	
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

	file_list: TABLE [EIFFEL_FILE, INTEGER];

	trailing_comment_exists (pos: INTEGER): BOOLEAN is
			-- is there a comment after pos
		local
			file: EIFFEL_FILE;
		do
			if pos >= 0 then
				file := file_list.item (format.global_types.source_id);
				if file /= void then
					file.go_after (pos);
					Result := file.trailing_comment  /= void;
				end;
			end;
		end;


	put_comment (comment: EIFFEL_COMMENTS) is
		local
			i: INTEGER;
		do
			begin;
			if comment /= void then
				if comment.count > 0 then
					put_string (definition.before_comment);
					put_string ("-- ");
					put_string (comment.text.item (0));
				end;
				if comment.count > 1 then
					from
						i := 1
					until
						i >= comment.count
						or else comment.text.item (i).item (1) = '|'
					loop
						next_line;
						put_string ("-- ");
						put_string (comment.text.item (i));
						i := i + 1;
					end;
				end;
			end;
			put_string (definition.after_comment);
			commit;
		end;
			
				
	
	put_trailing_comment (pos: INTEGER) is
		local
			file: EIFFEL_FILE;
			comment: EIFFEL_COMMENTS;
		do
			if pos >= 0 then
				--file := file_list.item (format.global_types.source_id);
				if file /= void then
					file.go_after (pos);
					comment := file.trailing_comment;
				end;
				if comment /= void then
					begin;
					indent_one_more;
					next_line;
					--put_comment 
					commit;
				end;
			end;
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
	

end	
