indexing

	description: "Abstract description of an Eiffel class. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_AS_B

inherit
	CLASS_AS
		redefine
			class_name, obsolete_message, indexes,
			generics, parents, creators, features,
			invariant_part, suppliers, set,
			associated_eiffel_class
		end

	AST_EIFFEL_B
		redefine
			format
		end

	IDABLE

	SHARED_INST_CONTEXT

feature -- Attributes

	id: CLASS_ID
			-- Class id

	class_name: ID_AS_B
			-- Class name

	obsolete_message: STRING_AS_B
			-- Obsolete message clause 
			-- (Void if was not present)

	indexes: EIFFEL_LIST_B [INDEX_AS_B]
			-- Index clause

	generics: EIFFEL_LIST_B [FORMAL_DEC_AS_B]
			-- Formal generic parameter list

	parents: EIFFEL_LIST_B [PARENT_AS_B]
			-- Inheritance clause

	creators: EIFFEL_LIST_B [CREATE_AS_B]
			-- Creators

	features: EIFFEL_LIST_B [FEATURE_CLAUSE_AS_B]
			-- Feature list

	invariant_part: INVARIANT_AS_B
			-- Class invariant

	suppliers: SUPPLIERS_AS_B
			-- Supplier types

feature -- Initialization

	set is
			-- Initialization routine
		local
			click_class_name: CLICK_AST
		do
			{CLASS_AS} precursor

				-- Check for Concurrent Eiffel
			if is_separate and not System.Concurrent_eiffel then
				Error_handler.make_separate_syntax_error
			end

				-- Click list management
			click_list ?= yacc_arg (8)
			click_class_name ?= click_list.first
			click_class_name.set_node (Current)
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

	format (ctxt: FORMAT_CONTEXT_B) is
		local
			s: STRING
		do
			ctxt.put_front_text_item (ti_Before_class_declaration)
			ctxt.prepare_class_text
			if indexes /= void and not indexes.empty then
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
					ctxt.put_text_item (ti_Creation_keyword)
					ctxt.new_line
				end
				ctxt.put_text_item (ti_After_creators)
				ctxt.new_line
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
			fc, next_fc: FEATURE_CLAUSE_AS_B
			inv_adapter: INVARIANT_ADAPTER
			e_file: EIFFEL_FILE
			l_count: INTEGER
			feature_list: EIFFEL_LIST_B [FEATURE_AS_B]
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
			s_chart: S_CLASS_CHART
			gen: FORMAL_DEC_AS_B
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

end -- class CLASS_AS_B
