indexing

	description: 
		"AST representation of an Eiffel class.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_AS

inherit

	AST_EIFFEL
		redefine
			is_equivalent
		end;
	CLICKABLE_AST
		redefine
			is_class
		end
	COMPILER_EXPORTER

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name;
		is_d, is_e, is_s: BOOLEAN;
		ind: like indexes;
		g: like generics;
		p: like parents;
		c: like creators;
		f: like features;
		inv: like invariant_part;
		s: like suppliers;
		o: like obsolete_message;
		e: INTEGER) is
			-- Create a new CLASS AST node.
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
		do
			class_name := n
			is_deferred := is_d
			is_expanded := is_e
			is_separate := is_s
			indexes := ind
			generics := g
			parents := p
			creators := c
			features := f
			invariant_part := inv
			if
				invariant_part /= Void and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void
			end
			suppliers := s
			obsolete_message := o
			end_position := e
		ensure
			class_name_set: class_name = n
			is_deferred_set: is_deferred = is_d
			is_expanded_set: is_expanded = is_e
			is_separate_set: is_separate = is_s
			indexes_set: indexes = ind
			generics_set: generics = g
			parents_set: parents = p
			creators_set: creators = c
			features_set: features = f
			invariant_part_set: invariant_part = inv
			suppliers_set: suppliers = s
			obsolete_message_set: obsolete_message = o
			end_position_set: end_position = e
		end

feature {NONE} -- Initialization

	set is
			-- Initialization routine.
		do
			class_name ?= yacc_arg (0);
			is_deferred := yacc_bool_arg (0);
			is_expanded := yacc_bool_arg (1);
			is_separate := yacc_bool_arg (2);
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

feature -- Properties

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

	is_separate: BOOLEAN;
			-- Is the class separate ?

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

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Access

	feature_clause_of_feature (f: FEATURE_AS): INTEGER is
			-- Number of feature clause containing feature `f'.
			-- 0 if `f' is not in Current class.
		local
			saved: INTEGER
			name: STRING
			fc: FEATURE_CLAUSE_AS
		do
			if features /= Void then
				saved := features.index
				from
					features.start
				until
					features.after
				loop
					fc := features.item
					if fc.has_feature (f) then
						Result := features.index
						features.finish
					end
					features.forth
				end
				features.go_i_th (saved)
			end;
		end

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

	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does `n' appear in class-text?
		local
			cur: CURSOR
		do
			if features /= Void then
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
			end
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
-- FIXME: suppliers_AS not used ???!!!
			Result := equivalent (class_name, other.class_name) and then
				equivalent (creators, other.creators) and then
				equivalent (generics, other.generics) and then
				equivalent (indexes, other.indexes) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (obsolete_message, other.obsolete_message) and then
				equivalent (parents, other.parents) and then
				equivalent (features, other.features) and then
				is_deferred = other.is_deferred and then
				is_expanded = other.is_expanded and then
				is_separate = other.is_separate 
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' class equivalent to Current?
		require
			valid_other: other /= Void
		do
-- FIXME
-- FIXME
-- FIXME
			Result := is_equivalent (other)
		end;

feature {COMPILER_EXPORTER} -- Element change

	add_feature_to_feature_clause (fc_num: INTEGER; f: FEATURE_AS) is
			-- Add feature `f' to feature clause number `fc_num'
		require
			feature_clauses_exist: features /= Void
			fc_num_ok: features.valid_index (fc_num)
		local
			saved, feat_count, offset: INTEGER
		do
			saved := features.index
			features.go_i_th (fc_num)
			features.item.add_feature (f)
			features.forth
			from
				offset := f.end_position - f.start_position + 2
					--| feature size + 1 semicolumn
			until
				features.off
			loop
				features.item.update_positions_with_offset (offset)
				features.forth
			end
			if features.valid_cursor_index (saved) then
				features.go_i_th (saved)
			end
		end

	remove_feature_from_feature_clause (fc_num: INTEGER; f: FEATURE_AS) is
			-- Remove feature `f' from feature clause number `fc_num'
		require
			feature_clauses_exist: features /= Void
			fc_num_ok: features.valid_index (fc_num)
		local
			index, offset: INTEGER
		do
			index := features.index
			features.go_i_th (fc_num)
			features.item.remove_feature (f)
			features.forth
			from
				offset := - (f.end_position - f.start_position + 2) --%%%%
					--| feature size + 1 semicolumn
	
			until
				features.off
			loop
				features.item.update_positions_with_offset (offset)
				features.forth
			end
			if features.valid_cursor_index (index) then
				features.go_i_th (index)
			end
		end

	replace_feature_of_feature_clause (fc_num: INTEGER; old_f, new_f: FEATURE_AS) is
			-- Replace feature `old_f' in feature clause number `fc_num'
			-- by feature `new_f'
		require
			feature_clauses_exist: features /= Void
			fc_num_ok: features.valid_index (fc_num)
		local
			index, offset: INTEGER
		do
			index := features.index
			features.go_i_th (fc_num)
			features.item.replace_feature (old_f, new_f)
			features.forth
			from
				offset := (new_f.end_position - old_f.end_position) --%%%%
			until
				features.off
			loop
				features.item.update_positions_with_offset (offset)
				features.forth
			end
			if features.valid_cursor_index (index) then
				features.go_i_th (index)
			end
		end

feature {COMPILER_EXPORTER} -- Output

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
			elseif is_separate then
				ctxt.put_text_item (ti_Separate_keyword);
				ctxt.put_space
			elseif is_deferred then
				ctxt.put_text_item (ti_Deferred_keyword);
				ctxt.put_space
			end;
			ctxt.put_text_item (ti_Class_keyword);
			ctxt.put_space;
			ctxt.put_class_name (c_name);

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
				ctxt.set_separator (ti_Empty);
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
			ctxt.put_class_name (c_name)
			ctxt.new_line
		end;

feature {COMPILER_EXPORTER} -- Setting

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
