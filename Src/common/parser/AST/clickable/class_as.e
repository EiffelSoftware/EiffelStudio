indexing

	description: "Abstract description of an Eiffel class.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_AS

inherit

	AST_EIFFEL;
	CLICKABLE_AST
		redefine
			is_class
		end

feature -- Properties

	id: INTEGER;
			-- Class id

	class_name: ID_AS;
			-- Class name

	end_position: INTEGER;
			-- Position of last end keyword

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

	is_class: BOOLEAN is
			-- Does the Current AST represent a class?
		do
			Result := True
		end;

feature -- Access

	feature_with_name (n: STRING): FEATURE_AS is
			-- Feature ast with internal name `n'
		local
			cur: CURSOR
		do
			if features /= Void then
				cur := features.cursor
				from
					features.start
				until
					features.after or else Result /= Void
				loop
					Result := features.item.feature_with_name (n)
					features.forth
				end
				features.go_to (cur)
			end;
		end;

feature -- Initialization

	set is
			-- Initialization routine
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
			obsolete_message ?= yacc_arg (9);	
			end_position := yacc_int_arg (0);
		ensure then
			class_name_exists: class_name /= Void;
			suppliers_exists: suppliers /= Void;
		end;

feature -- Access

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

feature -- Setting

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

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
		local
			c_name: STRING;
		do
			c_name := class_name.string_value;
			c_name.to_upper;
			if indexes /= void and not indexes.empty then
				ctxt.put_text_item (ti_Indexing_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				indexes.simple_format (ctxt);
				ctxt.exdent;
				ctxt.new_line;
				ctxt.new_line;
			end;

			if is_expanded then
				ctxt.put_text_item (ti_Expanded_keyword);
				ctxt.put_space
			elseif is_deferred then
				ctxt.put_text_item (ti_Deferred_keyword);
				ctxt.put_space
			end;
			ctxt.put_text_item (ti_Class_keyword);
			ctxt.put_space;
			ctxt.put_string (c_name);

			if generics /= Void then
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_L_bracket);
				ctxt.set_space_between_tokens;
				ctxt.set_separator (ti_Comma);
				generics.simple_format (ctxt);
				ctxt.put_text_item_without_tabs (ti_R_bracket);
			end;
			ctxt.new_line;

			if obsolete_message /= Void then
				ctxt.new_line;
				ctxt.put_text_item (ti_Obsolete_keyword);
				ctxt.put_space;
				obsolete_message.simple_format (ctxt);
				ctxt.new_line;
			end;

			if parents /= Void then
				ctxt.new_line;
				ctxt.put_text_item (ti_Inherit_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_new_line_between_tokens;
				ctxt.set_separator (ti_Semi_colon);
				parents.simple_format (ctxt);
				ctxt.new_line;
				ctxt.exdent;
			end;

			ctxt.new_line;

			if creators /= Void then
				creators.simple_format (ctxt);
				ctxt.new_line;
			end;

			if features /= Void then
				ctxt.set_new_line_between_tokens;
				ctxt.set_separator (Void);
				features_simple_format (ctxt)
				ctxt.new_line;
			end

			if invariant_part /= Void then
				invariant_part.simple_format (ctxt)
			end

			ctxt.put_text_item (ti_End_keyword);

			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Dashdash)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Class_keyword);

			ctxt.put_space
			ctxt.put_string (c_name)
			ctxt.new_line
		end;
 
feature -- Equivalence

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

feature {NONE} -- Implementation

	features_simple_format (ctxt :FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER;
			f: like features;
			fc, next_fc: FEATURE_CLAUSE_AS;
			feature_list: EIFFEL_LIST [FEATURE_AS];
			e_file: EIFFEL_FILE
		do
			f := features;
			e_file := ctxt.eiffel_file;
			ctxt.begin;
			from
				i := 1;
				l_count := f.count;
				if l_count > 0 then
					fc := f.i_th (1);
				end;
			until
				i > l_count
			loop
				if i > 1 then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				ctxt.begin;
				i := i + 1;
				if i > l_count then
					e_file.set_next_feature_clause (Void);
				else
					next_fc := f.i_th (i);
					e_file.set_next_feature_clause (next_fc);
				end;
				e_file.set_current_feature_clause (fc);
					  -- Need to set next feature if it exists
					  -- for extracting feature clause comments.
				feature_list := fc.features;
				if feature_list.empty then
					e_file.set_next_feature (Void);
				else
					e_file.set_next_feature (feature_list.i_th (1));
				end;
				fc.simple_format (ctxt);
				fc := next_fc;
				ctxt.commit;
			end;
			ctxt.commit;
		end;

end -- class CLASS_AS
