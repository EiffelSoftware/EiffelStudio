indexing
	description: "Abstract description of an Eiffel class. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_AS

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

	SHARED_INST_CONTEXT

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
		cl: like click_list;
		e: INTEGER) is
			-- Create a new CLASS AST node.
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
			cl_not_void: cl /= Void
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

				-- Check for Concurrent Eiffel
			if is_separate and not System.Concurrent_eiffel then
				Error_handler.make_separate_syntax_error
			end

				-- Click list management
			click_list := cl
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
			click_list_set: click_list = cl
			end_position_set: end_position = e
		end

feature {NONE} -- Initialization

	set is
			-- Initialization routine.
		local
			click_class_name: CLICK_AST
		do
			class_name ?= yacc_arg (0)
			is_deferred := yacc_bool_arg (0)
			is_expanded := yacc_bool_arg (1)
			is_separate := yacc_bool_arg (2)
			indexes ?= yacc_arg (1)
			generics ?= yacc_arg (2)
			parents ?= yacc_arg (3)
			creators ?= yacc_arg (4)
			features ?= yacc_arg (5)
			invariant_part ?= yacc_arg (6)
			if (invariant_part /= Void)
				and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void
			end
			suppliers ?= yacc_arg (7)
			obsolete_message ?= yacc_arg (9);	
			end_position := yacc_int_arg (0)

				-- Check for Concurrent Eiffel
			if is_separate and not System.Concurrent_eiffel then
				Error_handler.make_separate_syntax_error
			end

				-- Click list management
			click_list ?= yacc_arg (8)
			click_class_name ?= click_list.first
			click_class_name.set_node (Current)
		ensure then
			class_name_exists: class_name /= Void
			suppliers_exists: suppliers /= Void
		end

feature -- Attributes

	id: CLASS_ID
			-- Class id

	class_name: ID_AS
			-- Class name

	obsolete_message: STRING_AS
			-- Obsolete message clause 
			-- (Void if was not present)

	indexes: EIFFEL_LIST [INDEX_AS]
			-- Index clause

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

	is_deferred: BOOLEAN;
			-- Is the class deferred ?

	is_expanded: BOOLEAN;
			-- Is the class expanded ?

	is_separate: BOOLEAN;
			-- Is the class separate ?

	end_position: INTEGER;
			-- Position of last end keyword

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
			end
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
			end
		end

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
		end

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
			Result := is_equivalent (other)
		end

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

feature {COMPILER_EXPORTER} -- Setting

	set_id (i: CLASS_ID) is
			-- Assign `i' to `id'.
		do
			id := i
		end

feature {CLASS_C, COMPILED_CLASS_INFO} -- Class information

	info: CLASS_INFO is
			-- Compiled information about the class produced after
			-- parsing (useful for second pass).
		local
			parent_list: PARENT_LIST
		do
			!!Result
			if parents /= Void then
				!!parent_list.make_filled (parents.count)
			elseif not ("general").is_equal (class_name) then
				!!parent_list.make_filled (1)
			else
				!!parent_list.make (0)
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

	click_list: CLICK_LIST

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT) is
		local
			s: STRING
		do
			ctxt.put_front_text_item (ti_Before_class_declaration)
			ctxt.prepare_class_text
			if indexes /= Void and not indexes.empty then
				ctxt.put_text_item (ti_Before_indexing)
				ctxt.put_text_item (ti_Indexing_keyword)
				ctxt.indent
				ctxt.new_line
				if ctxt.is_short then
					ctxt.set_separator (Void)
				else
					ctxt.set_separator (ti_Semi_colon)
				end
				ctxt.set_new_line_between_tokens
				indexes.format (ctxt)
				ctxt.put_text_item (ti_After_indexing)
				ctxt.exdent
				ctxt.new_line
				ctxt.new_line
			end

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
				ctxt.indent
				ctxt.new_line
			end
			ctxt.put_classi (ctxt.class_c.lace_class);	
			ctxt.put_text_item (ti_After_class_header)
			if ctxt.is_short then
				ctxt.exdent
			end

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
			ctxt.new_line
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
				ctxt.set_separator (ti_Semi_colon)
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
			ctxt.format_categories;	
			ctxt.format_invariants;	
			ctxt.put_text_item (ti_Before_class_end)
			ctxt.put_text_item (ti_End_keyword)
			ctxt.end_class_text
			ctxt.put_text_item (ti_After_class_end)
			ctxt.put_text_item (ti_After_class_declaration)
			ctxt.new_line
		end

feature {AST_REGISTRATION} -- Implementation

	register (ast_reg: AST_REGISTRATION) is
			-- Register the feature clauses and
			-- invariant in `ast_reg'.
		local
			f: like features;	
			fc, next_fc: FEATURE_CLAUSE_AS
			inv_adapter: INVARIANT_ADAPTER
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
						if feature_list.empty then
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

feature {CASE_CLASS_INFO} -- Case storage output

	header_storage_info (classc: CLASS_C): S_CLASS_DATA_R331 is
			-- Header storage information for Current
			-- (such as index and class name)
		require
			valid_classc: classc /= Void
		local
			g_l: FIXED_LIST [S_GENERIC_DATA]
			i_l: FIXED_LIST [S_TAG_DATA]
			c_l: LINKED_LIST [STRING]
			f_l: EIFFEL_LIST [FEATURE_NAME]
			s_chart: S_CLASS_CHART
			gen: FORMAL_DEC_AS
			gen_name: STRING
			gen_data: S_GENERIC_DATA
			type_info: S_TYPE_INFO
			name: STRING
		do
			!! name.make (1)
			name.make_from_string (class_name.string_value)
			name.to_upper
			!! Result.make (name)
			Result.set_reversed_engineered
			if indexes /= Void then
				!! s_chart
				from
					!! i_l.make_filled (indexes.count)
					i_l.start
					indexes.start
				until
					indexes.after
				loop
					i_l.replace (indexes.item.storage_info)
					i_l.forth
					indexes.forth
				end
				s_chart.set_indexes (i_l)
				Result.set_chart (s_chart)
			end
			if generics /= Void then
				!! g_l.make_filled (generics.count)
				from
					generics.start
					g_l.start
				until
					generics.after
				loop
					gen := generics.item
					!! gen_name.make (0)
					gen_name.append (gen.formal_name)
					gen_name.to_upper
					if gen.constraint = Void then
						!! gen_data.make (gen_name, Void)
					else
						type_info := gen.constraint_type.storage_info (classc)
						!! gen_data.make (gen_name, type_info)
					end
					g_l.replace (gen_data)
					g_l.forth
					generics.forth
				end
				Result.set_generics (g_l)
			end
			if creators /= Void then
				from
					!! c_l.make
					creators.start
				until
					creators.after
				loop
					f_l := creators.item.feature_list
					if f_l /= Void then
						from
							f_l.start
						until
							f_l.after
						loop
							c_l.extend (f_l.item.visual_name)
							f_l.forth
						end
					end
					creators.forth
				end
				Result.set_creation_features (c_l)
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
			if indexes /= Void and not indexes.empty then
				ctxt.put_text_item (ti_Indexing_keyword)
				ctxt.indent
				ctxt.new_line
				ctxt.set_separator (ti_Semi_colon)
				ctxt.set_new_line_between_tokens
				indexes.simple_format (ctxt)
				ctxt.exdent
				ctxt.new_line
				ctxt.new_line
			end

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
			ctxt.put_space
			ctxt.put_class_name (c_name)

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

	set_class_name (c: like class_name) is
		do
			class_name := c
		end

	set_indexes (i: like indexes) is
		do
			indexes := i
		end

	set_features (f: like features) is
		do
			features := f
		end

	set_generics (g: like generics) is
		do
			generics := g
		end

	set_parents (p: like parents) is
		do
			parents := p
		end

	set_creators (c: like creators) is
		do
			creators := c
		end

	set_invariant_part (i: like invariant_part) is
		do
			invariant_part := i
		end

	set_suppliers (s: like suppliers) is
		do
			suppliers := s
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
				if feature_list.empty then
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
