class FORMAT_CONTEXT

inherit

	SPECIAL_AST;
	SHARED_ERROR_HANDLER;

creation
	make

feature -- Status setting

	set_ast (new_ast: CLASS_AS) is
			-- Set `ast' to `new_ast'.
			-- Used for class name.
		do
			ast := new_ast
		end;

feature -- Initialization

	make (c: ANY) is
		do
			in_assertion_bool.set_value (False)
		end;

	execute is
				-- Execute the flat or flat_short.
		local
			first_format: LOCAL_FORMAT;
			name: STRING;
		do
			if not rescued then
				execution_error := false;
				Error_handler.wipe_out;
				!!previous.make;
				!!text.make;
				!! first_format
				upper_name := clone (ast.class_name.string_value)
				upper_name.to_upper
				previous.extend (first_format)
			else
				execution_error := true;
				rescued := False
			end
		end;

feature -- Implementation

	operator_table: OPERATOR_TABLE is
			-- An operator table.
		once
			!! Result.make
		end;

	is_normal, is_infix: BOOLEAN;

	ast: CLASS_AS;

	execution_error: BOOLEAN;
			-- Did an error occur during `execute'?

 	format: LOCAL_FORMAT is
			-- Current internal formatting directives.
		do
			Result := previous.item;
		end;

	previous: LINKED_STACK [LOCAL_FORMAT];
			-- Stack to keep track of previous format.
			-- Push at begin, pop at commit and rollback.

	rescued: BOOLEAN;

	text: STRUCTURED_TEXT;
			-- Formatted text

	upper_name: STRING;
	
	name_of_current_feature: STRING;
			-- Name of feature currently being processed

feature

	begin is
			-- Save current format before a change.
			-- (To keep track of indent depth, separator etc.)
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
			-- Go back to previous format. 
			-- Keep text modifications.
		local
			i: INTEGER
		do
			previous.remove;
debug ("FS_RBRF")
		io.error.putstring ("committing...%N");
		i := text.index;
		io.error.putstring (text.image);
		text.go_i_th (i);
		io.error.new_line;
end
		end;

feature -- Text construction

	put_keyword (k: STRING) is
			-- Append `k' to `text', known as a keyword.
		local
			item: BASIC_TEXT;
		do
			!!item.make (k);
			item.set_is_keyword;
			text.add (item);	
		end;

	put_string, put_identifier (s: STRING) is
			-- Append `s' to `text'.
		local
			item: BASIC_TEXT;	
		do
			if s /= void then
				!!item.make (s);
				text.add (item);
			end
		end;

	put_special (s: STRING) is
			-- Append `s' to `text', known as a special character.
		local
			item: BASIC_TEXT;
		do
			!!item.make (s);
			item.set_is_special;
			text.add (item);	
		end;

	put_separator is
			-- Append the current separator to `text'.
		do
			if format.new_line_before_separator then
				next_line;
			end;
			if format.separator /= Void then
				put_text_item (format.separator)
			end;
			if format.space_between_tokens then
				put_space
			elseif format.indent_between_tokens then
				next_line
			end;
		end;

	next_line is
			-- Go to next line in `text', indent as necessary.
		local
			item: NEW_LINE_TEXT;
		do
			!!item.make (format.indent_depth);
			text.add (item)
		end;

	put_space is
			-- Append a space character to `text'.
		do
			text.add (ti_Space)
		end;

	put_text_item (t: TEXT_ITEM) is
			-- Append `t' to `text'.
		require
			t_not_void: t /= Void
		do
			text.add (t)
		end;

	put_breakable is
		do
		end;

feature -- Local formatting control

	set_separator (s: TEXT_ITEM) is
			-- Set current separator to `s'.
		do
			format.set_separator (s);
		end;

	new_line_between_tokens is
			-- Use a new line between tokens.
		do
			format.set_must_indent (true);
			format.set_space_between_tokens (false)
		end;

	space_between_tokens is
			-- Add a space character after the separator.
		do
			format.set_must_indent (false);
			format.set_space_between_tokens (true)
		end;

	no_new_line_between_tokens is
			-- Neither new line nor space between tokens.
		do
			format.set_must_indent (false);
			format.set_space_between_tokens (false)
		end;

	indent_one_more is
			-- Increase indent depth.
		do
			format.indent_one_more;
		end;

	indent_one_less is
			-- Decrease indent depth.
		do
			format.indent_one_less;
		end;

	set_illegal_operator is
			-- Set illegal operator to true.
		do
			format.set_illegal_operator;
		end;

feature -- Type control

	new_expression is
			-- Prepare for a new expression.
		do
			format.set_dot_needed (False)
		end;
			
	arguments: AST_EIFFEL;

	illegal_operator: BOOLEAN is
			-- Is operator illegal?
			-- True after `$' or `like'.
			-- If true, operator must be written (prefix/infix "operator")
		do
			Result := format.illegal_operator;
		end;

	put_name_of_class is
			-- Put the name of the class in the text.
		local
			name: STRING
		do
			name := ast.class_name.string_value
			name.to_upper
			put_string (name)
		end;

	prepare_for_current is
			-- Prepare for Current.
		do
			arguments := Void;
		end;

	prepare_for_feature (name: STRING; arg: EIFFEL_LIST [EXPR_AS]) is
			-- Prepare for features within main features.
		do
			name_of_current_feature := clone (name);
			arguments := arg
			is_infix := False
			is_normal := True
		end;

	prepare_for_main_infix is
			-- Prepare for class features.
		do
			arguments := Void;
		end;

	prepare_for_main_feature is
			-- Prepare for class features.
		do
			arguments := Void
debug ("FS_RBRF")
	io.error.putstring ("ANALYZING FEATURE FOR ROLLBACK/COMMIT: ");
	io.error.putstring (name_of_current_feature);
	io.error.new_line
end;
		end;

	prepare_for_main_prefix is
			-- Prepare for class features.
		do
			arguments := Void
		end;

	prepare_for_result is
			-- Prepare for Result.
		do
			arguments := Void
		end;

	prepare_for_infix (internal_name: STRING; right: EXPR_AS) is
			-- Prepare for infix feature.
		local
			name: STRING
		do
			name := clone (internal_name);
			name.tail (name.count - 7);
			name_of_current_feature := operator_table.name (name);
			arguments := right
			is_infix := True
			is_normal := False
		end;

	prepare_for_prefix (internal_name: STRING) is
			-- Prepare for prefix feature.
		do
			arguments := Void
		end;

	put_current_feature is
			-- Put current feature in text.
		do
			if is_normal then
				put_normal_feature
			elseif is_infix then
				put_infix
			else
				put_prefix
			end
		end;

	put_normal_feature is
			-- Put a normal feature.
		local
			arg: EIFFEL_LIST [EXPR_AS];
			item: BASIC_TEXT;
			i, nb: INTEGER;
		do
			if dot_needed then
				put_dot
			end;
			!!item.make (name_of_current_feature)
			text.add (item);
			arg ?= arguments;
			if arg /= void then
				begin;
				set_separator (ti_Comma);
				space_between_tokens;
				put_space;
				put_text_item (ti_L_parenthesis);
				--abort_on_failure;
				arguments.simple_format (Current);
				put_text_item (ti_R_parenthesis);
				commit;
				from
					arg.start;
					nb := arg.count;
					i := 1;
				until
					i > nb
				loop
					i := i + i
				end
			end;
		end;

	put_main_fix is
			-- Put main pre or infix.
		local
			item: BASIC_TEXT;
		do
			if print_fix_keyword then
				if is_infix then
					put_text_item (ti_Infix_keyword);
					put_string (" ")
				else
					put_text_item (ti_Prefix_keyword);
					put_string (" ")
				end
			end;
			!!item.make (name_of_current_feature)
			text.add (item)
		end;

	put_prefix is
			-- Put prefix feature in `text'.
		local
			item: BASIC_TEXT;
		do
			if illegal_operator then
				put_text_item (ti_L_parenthesis);
				put_text_item (ti_Prefix_keyword);
				put_space;
				put_text_item (ti_Double_quote);
				!!item.make (name_of_current_feature);
				put_text_item (item);
				put_text_item (ti_Double_quote);
				put_text_item (ti_R_parenthesis)
			else
				!!item.make (name_of_current_feature)
				insert_text_item (item);
			end;
			if 
				name_of_current_feature /= Void 
			and then 
				(name_of_current_feature .item (1) >= 'a' 
			and 
				name_of_current_feature.item (1) <= 'z') 
			then
				item.set_is_keyword
			else
				item.set_is_special
			end
		end;

	put_result is
			-- Put keyword `Result'.
		do
			put_string ("Result")
		end;

	put_current is
			-- Put keyword `Current'.
		do
			put_string ("Current");
		end;

	put_infix is
			-- Put infix feature in `text'.
		local
			arg: EXPR_AS;
			item: BASIC_TEXT
		do
			if illegal_operator then
				put_text_item (ti_L_parenthesis);
				put_text_item (ti_Infix_keyword);
				put_space;
				put_text_item (ti_Double_quote);
				!!item.make (name_of_current_feature);
				put_text_item (item);
				put_text_item (ti_Double_quote);
				put_text_item (ti_R_parenthesis);
			else
				put_space;
				!!item.make (operator_table.name (name_of_current_feature))
			   put_text_item (item);
				put_space;
				arg ?= arguments;
				if arg /= void then
					begin;
					new_expression;
					arg.simple_format (Current);
					commit;
				end
			end ;
			if 
				name_of_current_feature /= Void 
			and then
				(name_of_current_feature.item (1) >= 'a' 
			and 
				name_of_current_feature.item (1) <= 'z') 
			then
				item.set_is_keyword
			else
				item.set_is_special
			end
		end;

feature -- infix and prefix control

	put_fix_name (f_name: STRING) is
			-- Append `f_name' (an infix or prefix operator) to `text'.
		require
			f_name_not_void: f_name /= Void
		local
			item: BASIC_TEXT
		do
			!!item.make (f_name);
			if f_name.item (1) >= 'a' and f_name.item (1) <= 'z' then
				item.set_is_keyword
			else
				item.set_is_special
			end;
			text.add (item)
		end;

	insert (s: STRING) is
			-- Insert `s' in `text'.
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
			-- Insert `s' in `text', known as a special character.
		local
			item: BASIC_TEXT;
		do
			!!item.make (s);
			item.set_is_special;
		 	text.insert (format.insertion_point, item);	
		end;
	
	insert_text_item (t: TEXT_ITEM) is
			-- Insert `t' in `text'.
		require
			t_not_void: t /= Void
		do
		 	text.insert (format.insertion_point, t);
		end;

	need_dot is
			-- Formatting needs dot.
		do
			format.set_dot_needed (true);
		end;

	dot_needed: BOOLEAN is
			-- Is a dot needed for formatting?
		do
			Result := format.dot_needed;
		end;

	put_dot is
			-- Put a dot in the text.
		do
			put_text_item (ti_Dot)
		end;

feature -- Comments

	put_comment (comment: EIFFEL_COMMENTS) is
			-- Put `comment' in `text'.
		local
			i: INTEGER;
		do
			begin;
			if comment /= void then
				from
					from
						i := 1
					until
						i > comment.count or else
						comment.text.item (i).empty or else
						comment.text.item (i).item (1) /= '|'
					loop
						i := i + 1
					end;
					if i <= comment.count then
						put_text_item (ti_Dashdash);
						put_comment_text (comment.text.item (i))
					end;
					i := i + 1
				until
					i > comment.count
				loop
					if 
						comment.text.item (i).empty or else
						comment.text.item (i).item (1) /= '|' 
					then
						next_line;
						put_text_item (ti_Dashdash);
						put_comment_text (comment.text.item (i))
					end;
					i := i + 1
				end
			end;
			commit;
		end;
			
	put_comment_text (c: STRING) is
			-- Interprete the ` and ' signs of the comment
			-- and append it to `text'.
		require
			c_not_void: c /= Void
		local
			item: BASIC_TEXT;
			i, c_count: INTEGER;
			c_area: SPECIAL [CHARACTER];
			between_quotes: BOOLEAN;
			s: STRING
		do
			from
				!!s.make (0);
				c_count := c.count;
				c_area := c.area
			until
				i >= c_count
			loop
				if between_quotes and c_area.item (i) = '%'' then
					if not s.empty then
						!!item.make (s);
						put_text_item (item);
						!!s.make (0)
					end;
					between_quotes := false
				elseif not between_quotes and c_area.item (i) = '`' then
					if not s.empty then
						!!item.make (s);
						item.set_is_comment;
						put_text_item (item);
						!!s.make (0)
					end;
					between_quotes := true
				else
					s.extend (c_area.item (i))
				end;
				i := i + 1
			end;
			if not s.empty then
				!!item.make (s);
				item.set_is_comment;
				put_text_item (item)
			end
		end;

end	-- class FORMAT_CONTEXT
