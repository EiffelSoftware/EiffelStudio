indexing
	description: "Formatting context for class ast (produces image for class_ast).";
	date: "$Date$";
	revision: "$Revision $"

class FORMAT_CONTEXT

inherit
	SHARED_ERROR_HANDLER

	SHARED_OPERATOR_TABLE

	SHARED_TEXT_ITEMS

	COMPILER_EXPORTER

creation
	make, make_for_case

feature -- Initialization

	make (ast: CLASS_AS; file_name: STRING) is
			-- Initialize current for simple format with 
			-- file_name `file_name' and then format AST
			-- placing the result into `text'.
		require
			valid_ast: ast /= Void;
		do
			make_for_case;
			!! eiffel_file.make (file_name, ast.end_position);
			class_ast := ast;
			ast.simple_format (Current)
		ensure
			set: class_ast = ast
		end;

	make_for_case is
			-- Initialize current for simple
			-- format for eiffelcase (to get
			-- image of precondition and postcondition).
		do
			!! format_stack.make;
			!! text.make;
			!! format;
			format_stack.extend (format);
		end;

	set_class_ast ( cl : CLASS_AS ) is
		-- added by pascalf, for filling the body of feature
		require
			valid_ast: cl /= Void;
		do
			class_ast := cl
		ensure
			set: class_ast = cl
		end

feature -- Properties

	class_ast: CLASS_AS;
			-- Class ast being formatted

	feature_comments: EIFFEL_COMMENTS;
			-- Comments for current analyzed feature

	eiffel_file: EIFFEL_FILE;
			-- Eiffel file associated with class_ast
			--| (Not used in format context b).

 	format: LOCAL_FORMAT;
			-- Current internal formatting directives.

	format_stack: LINKED_STACK [like format];
			-- Stack to keep track of all formats.
			-- Push at begin, pop at commit and rollback.

	text: STRUCTURED_TEXT;
			-- Formatted text

	name_of_current_feature: STRING;
			-- Name of feature currently being processed

	arguments: AST_EIFFEL;
			-- Argument for feature being adapted

	special_nl_symbol: TEXT_ITEM

feature -- Access

	formal_name (pos: INTEGER): ID_AS is
			-- Formal name of `class_ast'
		require
			valid_pos: pos > 0;
		do
			Result := clone (class_ast.generics.i_th (pos).formal_name)
			Result.to_upper;
		end;

	is_feature_visible: BOOLEAN is
			-- Is Current analyzed feature visible?
			-- (Yes it is)
		do
			Result := True
		end;

feature -- Local format setting details

	reset_special_nl_symbol is
		do
			special_nl_symbol := Void
		ensure
			special_nl_symbol_reset: special_nl_symbol = Void
		end

	set_special_nl_symbol (nls: like special_nl_symbol) is
		do
			special_nl_symbol := nls
		ensure
			special_nl_symbol_set: special_nl_symbol = nls
		end

	set_type_creation (t: TYPE) is
			-- Set _type_creation to `t'.
		do
		end;

	set_separator (s: TEXT_ITEM) is
			-- Set current separator to `s'.
		do
			format.set_separator (s);
		ensure
			format.separator = s
		end;

	set_new_line_between_tokens is
			-- Use a new line between tokens.
		do
			format.set_new_line_between_tokens (True);
			format.set_space_between_tokens (False)
		ensure
			format.new_line_between_tokens;
			not format.space_between_tokens;
		end;

	set_space_between_tokens is
			-- Add a space character after the separator.
		do
			format.set_new_line_between_tokens (false);
			format.set_space_between_tokens (true)
		ensure
			not format.new_line_between_tokens;
			format.space_between_tokens
		end;

	set_no_new_line_between_tokens is
			-- Neither new line nor space between tokens.
		do
			format.set_new_line_between_tokens (false);
			format.set_space_between_tokens (false)
		ensure
			not format.new_line_between_tokens;
			not format.space_between_tokens
		end;

	indent is
			-- Indent next output line by one tab.
		do
			format.indent;
		end;

	exdent is
			-- Remove one leading tab for next line.
		require
			valid_indent: format.indent_depth > 0
		do
			format.exdent;
		end;

	need_dot is
			-- Formatting needs dot.
		do
			format.set_dot_needed (true);
		ensure
			format.dot_needed
		end;

feature -- Setting

	set_feature_comments (c: like feature_comments) is
			-- Set feature_comment to `c'
		do
			feature_comments := c
		ensure
			feature_comments = c
		end;

feature -- Update

	begin is
			-- Save current format before a change.
			-- (To keep track of indent depth, separator etc.)
		local
			new_format: like format;
		do
			new_format := clone (format);
			format_stack.extend (new_format);
			format := new_format;
		ensure
			valid_format: format /= Void and then
					format = format_stack.item
		end;

	commit is
			-- Go back to previous format. 
			-- Keep text modifications.
		do
			format_stack.remove;
			format := format_stack.item;
		ensure
			format_removed: not format_stack.has (old format)
		end;

feature -- Indentation

	tabs_emitted: BOOLEAN;
			-- Have leading tabs already been emitted?

	emit_tabs is
			-- Emit tabs according to indent depth of current `format'.
		require
			not_tabs_emitted: not tabs_emitted	
		local
			i: INTEGER
		do
			i := format.indent_depth;
			if i > 0 then
				text.add (tab_with (i));
			end;
			tabs_emitted := True;
		end;

feature -- Element change

	prepare_for_current is
			-- Prepare for Current.
		do
			arguments := Void;
		ensure
			arguments = Void
		end;

	prepare_for_feature (name: STRING; arg: EIFFEL_LIST [EXPR_AS]) is
			-- Prepare for features within main features.
		do
			name_of_current_feature := clone (name);
			arguments := arg
		ensure
			arguments = arg;
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
		end;

	prepare_for_prefix (internal_name: STRING) is
			-- Prepare for prefix feature.
		local
			name: STRING
		do
			name := clone (internal_name);
			name.tail (name.count - 8);
			name_of_current_feature := operator_table.name (name);
			arguments := Void
		end;

feature -- Output

	reversed_format_list (list: EIFFEL_LIST [AST_EIFFEL]) is
			-- Format `list' in reverse order.
		require
			valid_list: list /= Void
		do
			list.reversed_simple_format (Current)
		end;

	format_ast (ast: AST_EIFFEL) is
			-- Call simple_for on `ast'.
		require
			valid_ast: ast /= Void
		do
			ast.simple_format (Current)
		end;

	put_breakable is
			-- Put breakable point.
			--| Do nothing - convenience routine.
		do
		end;

	put_string (s: STRING) is
			-- Append `s' to `text'.
		require
			s_exists: s /= Void;
		do
			if not tabs_emitted then
				emit_tabs;
			end;
			text.add_default_string (s);
		end;

	put_class_name (s: STRING) is
			-- Append `s' to `text'.
		require
			s_exists: s /= Void;
		do
			if not tabs_emitted then
				emit_tabs;
			end;
			text.add_default_string (s);
		end;

	put_space is
			-- Append space.
		do
			text.add_space
		end;

	put_separator is
			-- Append the current separator to `text'.
		do
			if format.separator /= Void then
				text.add (format.separator)
			end;
			if format.space_between_tokens then
				text.add_space
			elseif format.new_line_between_tokens then
				new_line
			end;
		end;

	new_line is
			-- Go to beginning of next line in `text'.
		do
			text.add_new_line;
			if special_nl_symbol /= Void then
				text.add (special_nl_symbol)
			end
			tabs_emitted := False
		end;

	put_text_item_without_tabs (t: TEXT_ITEM) is
			-- Append `t' to `text'. Do not emit tabs.
		do
			text.add (t)
		end

	put_front_text_item (t: TEXT_ITEM) is
			-- Insert `t' to `text' in front of list.
		do
			text.put_front (t);
			text.finish
		end

	put_text_item (t: TEXT_ITEM) is
			-- Append `t' to `text'. Emit tabs if needed.
		require
			t_not_void: t /= Void
		do
			if not tabs_emitted then
				emit_tabs;
			end
			text.add (t)
		end;

	new_expression is
			-- Prepare for a new expression.
		do
			format.set_dot_needed (False)
		ensure
			not format.dot_needed
		end;
			
	put_current_feature, put_normal_feature is
			-- Put a normal feature.
		local
			arg: EIFFEL_LIST [EXPR_AS];
			item: BASIC_TEXT;
			i, nb: INTEGER;
		do
			if format.dot_needed then
				text.add (ti_Dot)
			elseif not tabs_emitted then
				emit_tabs
			end;
			text.add_default_string (name_of_current_feature);
			arg ?= arguments;
			if arg /= void then
				begin;
				set_separator (ti_Comma);
				set_space_between_tokens;
				text.add_space;
				text.add (ti_L_parenthesis);
				arg.simple_format (Current);
				text.add (ti_R_parenthesis);
				commit;
				arg.start
			end
		end;

	put_prefix_feature is
			-- Put prefix feature in `text'.
		local
			item: BASIC_TEXT;
			name: STRING
		do
			if not tabs_emitted then
				emit_tabs
			end;
			name := name_of_current_feature;
			if name.item (1).is_alpha then
				!KEYWORD_TEXT! item.make (name)
			else
				!SYMBOL_TEXT! item.make (name)
			end
			text.add (item)
		end;

	put_infix_feature is
			-- Put infix feature in `text'.
		local
			arg: EXPR_AS;
			item: BASIC_TEXT;
			name: STRING
		do
			name := name_of_current_feature;
			if name.item (1).is_alpha then
				!KEYWORD_TEXT! item.make (name)
			else
				!SYMBOL_TEXT! item.make (name)
			end
			text.add_space;
			text.add (item);
			text.add_space;
			arg ?= arguments;
			if arg /= void then
				begin;
				new_expression;
				arg.simple_format (Current);
				commit;
			end;
		end;

	put_comments (comments: EIFFEL_COMMENTS) is
			-- Put `comment' in `text'.
		require
			valid_comments: comments /= Void
		local
			txt: STRING
		do
			from
				comments.start
			until
				comments.after
			loop
				txt := comments.item;
				if txt.is_empty or else txt.item (1) /= '|' then
					put_text_item (ti_Dashdash);
					put_comment_text (comments.item)
					new_line;
				end;
				comments.forth
			end
		end;

	put_origin_comment is
		do
		end;

	put_comment_text (c: STRING) is
			-- Interprets the ` and ' signs of the comment
			-- and append it to `text'.
		require
			c_not_void: c /= Void
		local
			quoted_text: QUOTED_TEXT;
			comment_text: COMMENT_TEXT;
			i, c_count: INTEGER;
			c_area: SPECIAL [CHARACTER];
			between_quotes: BOOLEAN;
			s: STRING
		do
			from
				!! s.make (0);
				c_count := c.count;
				c_area := c.area
			until
				i >= c_count
			loop
				if between_quotes and c_area.item (i) = '%'' then
					if not s.is_empty then
						text.add_quoted_text (s);
						!! s.make (0)
					end;
					between_quotes := false
				elseif not between_quotes and c_area.item (i) = '`' then
					if not s.is_empty then
						text.add_comment_text (s)
						!! s.make (0)
					end;
					between_quotes := true
				else
					s.extend (c_area.item (i))
				end;
				i := i + 1
			end;
			if not s.is_empty then
				text.add_comment_text (s)
			end
		end;

feature {NONE} -- Implementation

	tabs_array: ARRAY [INDENT_TEXT] is
			-- Array of five tab texts
		once
			Result := <<ti_Tab1, ti_Tab2, ti_Tab3, ti_Tab4, ti_Tab5>>
		end;

	tab_with (i: INTEGER): INDENT_TEXT is
			-- Tab text with indent depth of `i'
		require
			positive_i: i > 0
		do
			if i > 5 then
				!! Result.make (i)
			else
				Result := tabs_array @ i
			end
		ensure
			valid_result: Result /= Void
		end;

invariant

	valid_stack: format_stack /= Void;
	valid_format: format /= Void and then format_stack.item = format
	valid_text: text /= Void

end	-- class FORMAT_CONTEXT
