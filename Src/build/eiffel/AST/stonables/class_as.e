-- Abstract description of an Eiffel class

class CLASS_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;
	--STONABLE;
	--CLICKER;

feature -- Attributes

	id: INTEGER;
			-- Class id

	class_name: ID_AS;
			-- Class name

	obsolete_message: STRING_AS;
			-- Obsolete message clause 
			-- (Void if was not present)

	is_deferred: BOOLEAN;
			-- Is the class deferred ?

	is_expanded: BOOLEAN;
			-- Is the class expanded ?

	indexes: EIFFEL_LIST [INDEX_AS];
			-- Index clause

	generics: EIFFEL_LIST [FORMAL_DEC_AS];
			-- Formal generic parameter list

	parents: EIFFEL_LIST [PARENT_AS];
			-- Inheritance clause

	creators: EIFFEL_LIST [CREATE_AS];
			-- Creators

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			-- Feature list

	invariant_part: INVARIANT_AS;
			-- Class invariant

	suppliers: SUPPLIERS_AS;
			-- Supplier types

feature -- Initialization

	set is
			-- Initialization routine
		local
			--click_class_name: CLICK_AST
		do
			class_name ?= yacc_arg (0);
			is_deferred := yacc_bool_arg (0);
			is_expanded := yacc_bool_arg (1);
			indexes ?= yacc_arg (1);
			generics ?= yacc_arg (2);
			parents ?= yacc_arg (3);
			creators ?= yacc_arg (4);
			features ?= yacc_arg (5);
			invariant_part ?= yacc_arg (6);
			if (invariant_part /= Void)
				and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void;
			end;
			suppliers ?= yacc_arg (7);
			--click_list ?= yacc_arg (8);
			obsolete_message ?= yacc_arg (9);	
			--click_class_name ?= click_list.first;
			--click_class_name.set_node (Current);
		ensure then
			class_name_exists: class_name /= Void;
			suppliers_exists: suppliers /= Void;
		end;

feature -- Conveniences

	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does `n' appear in class-text?
		local
			cur: CURSOR
		do
			cur := features.cursor
	
			from
				features.start
			until
				features.after or else Result
			loop
				Result := features.item.has_feature_name (n)
				features.forth
			end

			features.go_to (cur)
		end;

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

	set_class_name (c: like class_name) is
		do
			class_name := c
		end;

	set_indexes (i: like indexes) is
		do
			indexes := i
		end;

	set_features (f: like features) is
		do
			features := f
		end;

	set_generics (g: like generics) is
		do
			generics := g
		end;

	set_parents (p: like parents) is
		do
			parents := p
		end;

	set_creators (c: like creators) is
		do
			creators := c
		end;

	set_invariant_part (i: like invariant_part) is
		do
			invariant_part := i
		end;

	set_suppliers (s: like suppliers) is
		do
			suppliers := s
		end;

	--click_list: CLICK_LIST;

	set_comments (c: EIFFEL_FILE) is
		do
			if features /= Void and then c /= Void then
				from
					features.start
				until
					features.after
				loop
					features.item.set_comments (c)
					features.forth
				end
			end
		end;
 
feature -- formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
		local
			flat: FLAT_AST;
			s: STRING;
		do
			ctxt.put_text_item (ti_Before_class_declaration);
			ctxt.begin;
			ctxt.prepare_class_text;
			--ctxt.flat_struct.format_comments (ctxt);			
			if indexes /= void and not indexes.empty then
				ctxt.put_text_item (ti_Before_indexing);
				ctxt.put_text_item (ti_Indexing_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.new_line_between_tokens;
				indexes.simple_format (ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
				ctxt.next_line;
				ctxt.put_text_item (ti_After_indexing);
			end;

			ctxt.put_text_item (ti_Before_class_header);
			if is_expanded then
				ctxt.put_text_item (ti_Expanded_keyword);
				ctxt.put_space
			elseif is_deferred then
				ctxt.put_text_item (ti_Deferred_keyword);
				ctxt.put_space
			end;
			ctxt.put_text_item (ti_Class_keyword);
			ctxt.indent_one_more;
			--ctxt.next_line;
			ctxt.put_space
			ctxt.put_name_of_class;	
			ctxt.put_text_item (ti_After_class_header);

			if generics /= Void then
				ctxt.put_space;
				ctxt.put_text_item (ti_Before_formal_generics);
				ctxt.put_text_item (ti_L_bracket);
				ctxt.space_between_tokens;
				ctxt.set_separator (ti_Comma);
				generics.simple_format (ctxt);
				ctxt.put_text_item (ti_R_bracket);
				ctxt.put_text_item (ti_After_formal_generics)
			end;
			ctxt.indent_one_less;
			ctxt.next_line;
			ctxt.next_line;

			if obsolete_message /= Void then
				ctxt.put_text_item (ti_Before_obsolete);
				ctxt.put_text_item (ti_Obsolete_keyword);
				ctxt.put_space;
				obsolete_message.simple_format (ctxt);
				ctxt.put_text_item (ti_After_obsolete);
				ctxt.next_line;
				ctxt.next_line
			end;

			if parents /= Void then
				ctxt.put_text_item (ti_Before_inheritance);
				ctxt.put_text_item (ti_Inherit_keyword);
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.new_line_between_tokens;
				ctxt.set_separator (ti_Semi_colon);
				parents.simple_format (ctxt);
				ctxt.put_text_item (ti_After_inheritance);
				ctxt.indent_one_less;
				ctxt.next_line;
			end;

			if creators /= Void then
				ctxt.next_line;
				ctxt.put_text_item (ti_Before_creators);
				--ctxt.continue_on_failure;
				ctxt.new_line_between_tokens;
				ctxt.set_separator (Void);
				creators.simple_format (ctxt);
				if not ctxt.last_was_printed then
					ctxt.put_text_item (ti_Creation_keyword);
					ctxt.next_line;
				end;
				ctxt.put_text_item (ti_After_creators);
				ctxt.next_line;
			end;		

			ctxt.begin;
			
			if features /= Void then
				ctxt.next_line
				ctxt.set_separator (Void)
				features.simple_format (ctxt)
			end

			if invariant_part /= Void then
				ctxt.next_line
				invariant_part.simple_format (ctxt)
			end

			ctxt.commit;	
			ctxt.next_line
			ctxt.put_text_item (ti_Before_class_end);
			ctxt.put_text_item (ti_End_keyword);
			--ctxt.end_class_text;

			ctxt.put_space
			ctxt.put_text_item (ti_Dashdash)
			ctxt.put_space
			ctxt.put_text_item (ti_Class_keyword);

			ctxt.put_space
			ctxt.put_name_of_class
			ctxt.put_text_item (ti_After_class_end);
			ctxt.next_line;
			ctxt.commit;
			ctxt.put_text_item (ti_After_class_declaration)
		end;

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' class equivalent to Current?
		require
			valid_other: other /= Void
		do
			Result := deep_equal (class_name, other.class_name) and then
				deep_equal (creators, other.creators) and then
				deep_equal (generics, other.generics) and then
				deep_equal (indexes, other.indexes) and then
				deep_equal (invariant_part, other.invariant_part) and then
				deep_equal (obsolete_message, other.obsolete_message) and then
				deep_equal (parents, other.parents) and then
				features_deep_equal (other.features) and then
				is_deferred = other.is_deferred and then
				is_expanded = other.is_expanded 
		end;

	features_deep_equal (other: like features): BOOLEAN is
		do
			if features = Void and other = Void then
				Result := True
			elseif features /= Void and then 
				other /= Void and then
				other.count = features.count
			then	
				Result := True
				from
					features.start;
					other.start
				until
					features.after or else not Result
				loop
					Result := features.item.is_equiv (other.item)
					features.forth
					other.forth
				end
			end	
		end

end
