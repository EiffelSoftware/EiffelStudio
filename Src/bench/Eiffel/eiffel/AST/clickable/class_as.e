indexing
	description: "Abstract description of an Eiffel class. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_AS

inherit
	AST_EIFFEL
		redefine
			format
		end

	CLICKABLE_AST
		redefine
			is_class, associated_eiffel_class
		end
		
	COMPILER_EXPORTER

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	SHARED_INST_CONTEXT

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name;
		ext_name: STRING;
		is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
		top_ind: like top_indexes;
		bottom_ind: like bottom_indexes;
		g: like generics;
		p: like parents;
		c: like creators;
		f: like features;
		inv: like invariant_part;
		s: like suppliers;
		o: like obsolete_message;
		cl: like click_list) is
			-- Create a new CLASS AST node.
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
			cl_not_void: cl /= Void
		do
			class_name := n
			external_class_name := ext_name
			is_deferred := is_d
			is_expanded := is_e
			is_separate := is_s
			is_frozen := is_fc
			is_external := is_ex
			top_indexes := top_ind
			bottom_indexes := bottom_ind
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
				has_empty_invariant := True
			end
			suppliers := s
			obsolete_message := o

				-- Check for Concurrent Eiffel
			if is_separate and not System.Concurrent_eiffel then
				Error_handler.make_separate_syntax_error
			end

				-- Click list management
			click_list := cl
		ensure
			class_name_set: class_name = n
			external_class_name_set: external_class_name = ext_name
			is_deferred_set: is_deferred = is_d
			is_expanded_set: is_expanded = is_e
			is_separate_set: is_separate = is_s
			is_frozen_set: is_frozen = is_fc
			is_external_set: is_external = is_ex
			top_indexes_set: top_indexes = top_ind
			bottom_indexes_set: bottom_indexes = bottom_ind
			generics_set: generics = g
			parents_set: parents = p
			creators_set: creators = c
			features_set: features = f
			empty_invariant_part: invariant_part = Void implies inv = Void or else inv.assertion_list = Void
			invariant_part_set: invariant_part /= Void implies invariant_part = inv
			suppliers_set: suppliers = s
			obsolete_message_set: obsolete_message = o
			click_list_set: click_list = cl
		end

feature -- Attributes

	class_name: ID_AS
			-- Class name

	external_class_name: STRING
			-- External_name of class if `is_external'.

	obsolete_message: STRING_AS
			-- Obsolete message clause 
			-- (Void if was not present)

	top_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause at top of class.

	bottom_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause at bottom of class.

	generics: EIFFEL_LIST [FORMAL_DEC_AS]
			-- Formal generic parameter list

	parents: EIFFEL_LIST [PARENT_AS]
			-- Inheritance clause

	creators: EIFFEL_LIST [CREATE_AS]
			-- Creators

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- Feature list

	invariant_part: INVARIANT_AS
			-- Class invariant

	suppliers: SUPPLIERS_AS
			-- Supplier types

	is_deferred: BOOLEAN
			-- Is the class deferred ?

	is_expanded: BOOLEAN
			-- Is the class expanded ?

	is_separate: BOOLEAN
			-- Is the class separate ?

	is_frozen: BOOLEAN
			-- Is class frozen, ie we cannot inherit from it.

	is_external: BOOLEAN
			-- Is class just an encapsulation of an already generated class.

	click_list: CLICK_LIST
			-- Clickable AST items for current class.

	end_position: INTEGER
			-- Position of last end keyword

	feature_clause_insert_position: INTEGER
			-- Position at end of features

	inherit_clause_insert_position: INTEGER
			-- Position at end of inherit clause.

	generics_start_position: INTEGER
			-- Position at start of formal generics.

	generics_end_position: INTEGER
			-- Position at end of formal generics.

	invariant_insertion_position: INTEGER
			-- Position at end of invariant.

	has_empty_invariant: BOOLEAN
			-- Does class have an empty invariant clause?

feature -- Status report

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature {EIFFEL_PARSER} -- Element change

	set_text_positions (ep, fp, ip, gs, ge, np: INTEGER) is
			-- Set positions in class text.
		require
			ep_positive: ep > 0
			fp_positive: fp > 0
			ip_positive: ip > 0
			gs_positive: gs > 0
			ge_positive_or_not_present: ge >= 0
			np_positive: np > 0
		do
			end_position := ep
			feature_clause_insert_position := fp
			inherit_clause_insert_position := ip
			generics_start_position := gs
			generics_end_position := ge
			invariant_insertion_position := np
		ensure
			end_position_set: end_position = ep
			feature_clause_insert_position_set: feature_clause_insert_position = fp
			inherit_clause_insert_position_set: inherit_clause_insert_position = ip
			generics_start_position: generics_start_position = gs
			generics_end_position: generics_end_position = ge
			invariant_insertion_position: invariant_insertion_position = np
		end

feature -- Access

	feature_with_name (n: STRING): FEATURE_AS is
			-- Feature AST with internal name `n'.
		require
			n_not_void: n /= Void
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
			end
		end

	parent_with_name (n: STRING): PARENT_AS is
			-- Parent AST with class name `n'.
		require
			n_not_void: n /= Void
		local
			cur: CURSOR
			pn: STRING
		do
			if parents /= Void then
				cur := parents.cursor
				from
					parents.start
				until
					parents.after or else Result /= Void
				loop
					pn := parents.item.type.class_name
					if pn.is_equal (n) then
						Result := parents.item
					end
					parents.forth
				end
				parents.go_to (cur)
			end
		end

	clickable_item (a_clickable: CLICKABLE_AST): CLICK_AST is
			-- Corresponding click-item for `a_clickable'.
			-- `Void' if not in `click_list'.
		require
			a_clickable_not_void: a_clickable /= Void
		do
			Result := click_list.item_by_node (a_clickable)
		ensure
			correct_item: Result /= Void implies Result.node = a_clickable
		end

	click_ast: CLICK_AST is
			-- Position of class name.
		do
			Result := clickable_item (Current)
		ensure
			not_void: Result /= Void
			correct_item: Result.node = Current
		end

	generics_as_string: STRING is
			-- Output `formal_decs' as string to `generics'.
			-- `Void' if `generics' `Void'.
		local
			i: INTEGER
		do
			if generics /= Void then
				create Result.make (3)
				Result.extend ('[')
				from i := 1 until i > generics.count loop
					if i > 1 then
						Result.append (", ")
					end
					Result.append (generics.i_th (i).constraint_string)
					i := i + 1
				end
				Result.extend (']')
			end
		end

	custom_attribute: EIFFEL_LIST [CREATION_EXPR_AS] is
			-- Custom attribute of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.custom_attribute
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (creators, other.creators) and then
				equivalent (generics, other.generics) and then
				equivalent (top_indexes, other.top_indexes) and then
				equivalent (bottom_indexes, other.bottom_indexes) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (obsolete_message, other.obsolete_message) and then
				equivalent (parents, other.parents) and then
				equivalent (features, other.features) and then
				is_deferred = other.is_deferred and then
				is_expanded = other.is_expanded and then
				is_separate = other.is_separate 
		end

feature {CLASS_C, COMPILED_CLASS_INFO} -- Class information

	info: CLASS_INFO is
			-- Compiled information about the class produced after
			-- parsing (useful for second pass).
		local
			parent_list: PARENT_LIST
		do
			create Result
			if parents /= Void and not parents.is_empty then
				create parent_list.make_filled (parents.count)
			elseif not ("any").is_equal (class_name) then
				create parent_list.make_filled (1)
			else
				create parent_list.make (0)
			end
			Result.set_parents (parent_list)
				-- List `parent_list' will be filled by feature `init'
				-- of CLASS_C
			Result.set_creators (creators)
		end

feature -- Stoning
 
	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
		do
			Result := Universe.class_named 
						(class_name, 
						reference_class.cluster).compiled_class
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_front_text_item (ti_Before_class_declaration)
			ctxt.prepare_class_text
			format_indexes (ctxt, top_indexes)
			format_header (ctxt)
			if ctxt.is_clickable_format and obsolete_message /= Void then
				ctxt.new_line
				ctxt.put_text_item (ti_Before_obsolete)
				ctxt.put_text_item_without_tabs (ti_Obsolete_keyword)
				ctxt.put_space
				obsolete_message.format (ctxt)
				ctxt.put_text_item_without_tabs (ti_After_obsolete)
				ctxt.new_line
			end
			if ctxt.is_clickable_format and parents /= Void then
				ctxt.new_line
				ctxt.put_text_item (ti_Before_inheritance)
				ctxt.put_text_item_without_tabs (ti_Inherit_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.set_new_line_between_tokens
				ctxt.set_separator (ti_New_line)
				ctxt.set_classes (ctxt.class_c, ctxt.class_c)
				parents.format (ctxt)
				ctxt.set_classes (Void, Void)
				ctxt.put_text_item (ti_After_inheritance)
				ctxt.new_line
				ctxt.exdent
			end

			ctxt.new_line

			if creators /= Void then
				ctxt.put_text_item (ti_Before_creators)
				ctxt.continue_on_failure
				creators.format (ctxt)
				if not ctxt.last_was_printed then
					ctxt.put_text_item (ti_Create_keyword)
					ctxt.new_line
				end
				ctxt.put_text_item (ti_After_creators)
				ctxt.new_line
					-- We reset `ctxt' so that we can print again.
				ctxt.set_last_was_printed (True)
			end;		
			ctxt.format_categories
			ctxt.format_invariants
			format_indexes (ctxt, bottom_indexes)
			ctxt.put_text_item (ti_Before_class_end)
			ctxt.put_text_item (ti_End_keyword)
			ctxt.end_class_text
			ctxt.put_text_item (ti_After_class_end)
			ctxt.put_text_item (ti_After_class_declaration)
			ctxt.new_line
		end

	format_indexes (ctxt: FORMAT_CONTEXT; i: EIFFEL_LIST [INDEX_AS]) is
			-- Format `i'.
		do
			if i /= Void and not i.is_empty then
				ctxt.put_text_item (ti_Before_indexing)
				ctxt.put_text_item (ti_Indexing_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.set_separator (Void)
				ctxt.set_new_line_between_tokens
				i.format (ctxt)
				ctxt.put_text_item (ti_After_indexing)
				ctxt.exdent
				ctxt.new_line
				ctxt.new_line
			end
		end

	format_header (ctxt: FORMAT_CONTEXT) is
			-- Format header, ie classname and generics.
		do
			ctxt.put_text_item (ti_Before_class_header)
			if is_expanded then
				ctxt.put_text_item (ti_Expanded_keyword)
				ctxt.put_space
			elseif is_deferred then
				ctxt.put_text_item (ti_Deferred_keyword)
				ctxt.put_space
			end
			ctxt.put_text_item (ti_Class_keyword)
			ctxt.put_space
			if ctxt.is_short then
				ctxt.put_text_item (ti_Interface_keyword)
			end
			ctxt.indent
			ctxt.new_line
			ctxt.put_classi (ctxt.class_c.lace_class)
			ctxt.put_text_item (ti_After_class_header)
			ctxt.exdent
			format_generics (ctxt)
			ctxt.new_line
		end

	format_generics (ctxt: FORMAT_CONTEXT) is
			-- Format formal generics.
		do
			if generics /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Before_formal_generics)
				ctxt.put_text_item_without_tabs (ti_L_bracket)
				ctxt.set_space_between_tokens
				ctxt.set_separator (ti_Comma)
				generics.format (ctxt)
				ctxt.put_text_item_without_tabs (ti_R_bracket)
				ctxt.put_text_item_without_tabs (ti_After_formal_generics)
			end
		end

feature {AST_REGISTRATION} -- Implementation

	register (ast_reg: AST_REGISTRATION) is
			-- Register the feature clauses and
			-- invariant in `ast_reg'.
		local
			f: like features;	
			fc, next_fc: FEATURE_CLAUSE_AS
			e_file: EIFFEL_FILE
			l_count: INTEGER
			feature_list: EIFFEL_LIST [FEATURE_AS]
			i: INTEGER
		do
			f := features
			if f /= Void then
				l_count := f.count;	
				i := 1
				if ast_reg.already_extracted_comments then
					-- This means that the comments are already 
					-- extracted so there is no record additional 
					-- information to extract comments.
					from
					until
						i > l_count
					loop
						fc := f.i_th (i)
							-- Register all the features.
						fc.register_features (ast_reg)
							-- Now Register feature clause.
						ast_reg.register_feature_clause (fc)
						i := i + 1
					end
				else
					e_file := ast_reg.eiffel_file
					-- This means we are registering non precompiled
					-- features for an eiffel project or we are
					-- current precompiling features.
					from
						if l_count > 0 then
							fc := f.i_th (1)
						end
					until
						i > l_count
					loop
						i := i + 1
						if i > l_count then
							e_file.set_next_feature_clause (Void)
						else
							next_fc := f.i_th (i)
							e_file.set_next_feature_clause (next_fc)
						end
						e_file.set_current_feature_clause (fc)
							-- Need to set next feature if it exists
							-- for extracting feature clause comments.
						feature_list := fc.features;	
							-- Register all the features.
						fc.register_features (ast_reg)
							-- Now Register feature clause.
						if feature_list.is_empty then
							e_file.set_next_feature (Void)
						else
							e_file.set_next_feature (feature_list.i_th (1))
						end
						ast_reg.register_feature_clause (fc)
						fc := next_fc
					end
				end
			end
			if invariant_part /= Void then
				ast_reg.register_invariant (invariant_part)
			end
		end

feature {CLASS_C} -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		require
			associated_class_has_unique: System.current_class.has_unique
			valid_args: counter /= Void and values /= Void
		do
			from
				features.start
			until
				features.after
			loop
				features.item.assign_unique_values (counter, values)
				features.forth
			end
		end

feature {COMPILER_EXPORTER} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		local
			c_name: STRING
		do
			c_name := class_name.string_value
			c_name.to_upper
			format_indexes (ctxt, top_indexes)
			if is_expanded then
				ctxt.put_text_item (ti_Expanded_keyword)
				ctxt.put_space
			elseif is_separate then
				ctxt.put_text_item (ti_Separate_keyword)
				ctxt.put_space
			elseif is_deferred then
				ctxt.put_text_item (ti_Deferred_keyword)
				ctxt.put_space
			end
			ctxt.put_text_item (ti_Class_keyword)
			ctxt.indent
			ctxt.new_line
			ctxt.put_class_name (c_name)
			ctxt.exdent

			if generics /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_L_bracket)
				ctxt.set_space_between_tokens
				ctxt.set_separator (ti_Comma)
				generics.simple_format (ctxt)
				ctxt.put_text_item_without_tabs (ti_R_bracket)
			end
			ctxt.new_line

			if obsolete_message /= Void then
				ctxt.new_line
				ctxt.put_text_item (ti_Obsolete_keyword)
				ctxt.put_space
				obsolete_message.simple_format (ctxt)
				ctxt.new_line
			end

			if parents /= Void then
				ctxt.new_line
				ctxt.put_text_item (ti_Inherit_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.set_new_line_between_tokens
				ctxt.set_separator (ti_Semi_colon)
				parents.simple_format (ctxt)
				ctxt.new_line
				ctxt.exdent
			end

			ctxt.new_line

			if creators /= Void then
				creators.simple_format (ctxt)
				ctxt.new_line
			end

			if features /= Void then
				ctxt.set_new_line_between_tokens
				ctxt.set_separator (ti_Empty)
				features_simple_format (ctxt)
				ctxt.new_line
			end

			if invariant_part /= Void then
				invariant_part.simple_format (ctxt)
			end
			format_indexes (ctxt, bottom_indexes)
			ctxt.put_text_item (ti_End_keyword)

			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Dashdash)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Class_keyword)

			ctxt.put_space
			ctxt.put_class_name (c_name)
			ctxt.new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_top_indexes (i: like top_indexes) is
		do
			top_indexes := i
		end
  
feature {NONE} -- Implementation

	features_simple_format (ctxt :FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER
			f: like features
			fc, next_fc: FEATURE_CLAUSE_AS
			feature_list: EIFFEL_LIST [FEATURE_AS]
			e_file: EIFFEL_FILE
		do
			f := features
			e_file := ctxt.eiffel_file
			ctxt.begin
			from
				i := 1
				l_count := f.count
				if l_count > 0 then
					fc := f.i_th (1)
				end
			until
				i > l_count
			loop
				if i > 1 then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i := i + 1
				if i > l_count then
					e_file.set_next_feature_clause (Void)
				else
					next_fc := f.i_th (i)
					e_file.set_next_feature_clause (next_fc)
				end
				e_file.set_current_feature_clause (fc)
					  -- Need to set next feature if it exists
					  -- for extracting feature clause comments.
				feature_list := fc.features
				if feature_list.is_empty then
					e_file.set_next_feature (Void)
				else
					e_file.set_next_feature (feature_list.i_th (1))
				end
				fc.simple_format (ctxt)
				fc := next_fc
				ctxt.commit
			end
			ctxt.commit
		end

end -- class CLASS_AS
