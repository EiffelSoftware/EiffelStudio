indexing

	description: "Abstract description of an Eiffel class. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_AS_B

inherit

	CLASS_AS
		redefine
			class_name, obsolete_message, indexes,
			generics, parents, creators, features,
			invariant_part, suppliers, set
		end;

	AST_EIFFEL_B
		redefine
			format
		end;

	IDABLE;

	SHARED_INST_CONTEXT;

	STONABLE;

	CLICKER;

feature -- Attributes

	class_name: ID_AS_B;
			-- Class name

	obsolete_message: STRING_AS_B;
			-- Obsolete message clause 
			-- (Void if was not present)

	indexes: EIFFEL_LIST_B [INDEX_AS_B];
			-- Index clause

	generics: EIFFEL_LIST_B [FORMAL_DEC_AS_B];
			-- Formal generic parameter list

	parents: EIFFEL_LIST_B [PARENT_AS_B];
			-- Inheritance clause

	creators: EIFFEL_LIST_B [CREATE_AS_B];
			-- Creators

	features: EIFFEL_LIST_B [FEATURE_CLAUSE_AS_B];
			-- Feature list

	invariant_part: INVARIANT_AS_B;
			-- Class invariant

	suppliers: SUPPLIERS_AS_B;
			-- Supplier types

feature -- Initialization

	set is
			-- Initialization routine
		local
			click_class_name: CLICK_AST
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
			click_list ?= yacc_arg (8);
			obsolete_message ?= yacc_arg (9);	
			click_class_name ?= click_list.first;
			click_class_name.set_node (Current);
		ensure then
			class_name_exists: class_name /= Void;
			suppliers_exists: suppliers /= Void;
		end;

feature {CLASS_C} -- Class information

	info: CLASS_INFO is
			-- Compiled information about the class produced after
			-- parsing (useful for second pass).
		local
			parent_list: PARENT_LIST;
		do
			!!Result;
			if parents /= Void then
				!!parent_list.make (parents.count);
			elseif not ("general").is_equal (class_name) then
				!!parent_list.make (1);
			else
				!!parent_list.make (0);
			end;
			Result.set_parents (parent_list);
				-- List `parent_list' will be filled by feature `init'
				-- of CLASS_C
			Result.set_creators (creators);
		end;

feature -- Stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		local
			aclass: CLASS_C;
		do
			aclass := Universe.class_named 
						(class_name, reference_class.cluster).compiled_class;
			!!Result.make (aclass)
		end;

	click_list: CLICK_LIST;
 
feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
		local
			s: STRING;
		do
			ctxt.put_text_item (ti_Before_class_declaration);
			ctxt.prepare_class_text;
			ctxt.format_class_comments;			
			if indexes /= void and not indexes.empty then
				ctxt.put_text_item (ti_Before_indexing);
				ctxt.put_text_item (ti_Indexing_keyword);
				ctxt.indent;
				ctxt.new_line;
				if ctxt.is_short then
					ctxt.set_separator (Void);
				else
					ctxt.set_separator (ti_Semi_colon);
				end;
				ctxt.set_new_line_between_tokens;
				indexes.format (ctxt);
				ctxt.put_text_item (ti_After_indexing);
				ctxt.exdent;
				ctxt.new_line;
				ctxt.new_line;
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
			ctxt.put_space;
			if ctxt.is_short then
				ctxt.put_text_item (ti_Interface_keyword)
				ctxt.indent;
				ctxt.new_line;
			end;
			ctxt.put_class_name (ctxt.class_c);	
			ctxt.put_text_item (ti_After_class_header);
			if ctxt.is_short then
				ctxt.exdent
			end;

			if generics /= Void then
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Before_formal_generics);
				ctxt.put_text_item_without_tabs (ti_L_bracket);
				ctxt.set_space_between_tokens;
				ctxt.set_separator (ti_Comma);
				generics.format (ctxt);
				ctxt.put_text_item_without_tabs (ti_R_bracket);
				ctxt.put_text_item_without_tabs (ti_After_formal_generics)
			end;
			ctxt.new_line;
			if ctxt.is_clickable_format and obsolete_message /= Void then
				ctxt.new_line;
				ctxt.put_text_item (ti_Before_obsolete);
				ctxt.put_text_item_without_tabs (ti_Obsolete_keyword);
				ctxt.put_space;
				obsolete_message.format (ctxt);
				ctxt.put_text_item_without_tabs (ti_After_obsolete);
				ctxt.new_line;
			end;
			if ctxt.is_clickable_format and parents /= Void then
				ctxt.new_line;
				ctxt.put_text_item (ti_Before_inheritance);
				ctxt.put_text_item_without_tabs (ti_Inherit_keyword);
				ctxt.indent;
				ctxt.new_line;
				ctxt.set_new_line_between_tokens;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_classes (ctxt.class_c, ctxt.class_c);
				parents.format (ctxt);
				ctxt.set_classes (Void, Void);
				ctxt.put_text_item (ti_After_inheritance);
				ctxt.new_line;
				ctxt.exdent;
			end;

			ctxt.new_line;

			if creators /= Void then
				ctxt.put_text_item (ti_Before_creators);
				ctxt.continue_on_failure;
				creators.format (ctxt);
				if not ctxt.last_was_printed then
					ctxt.put_text_item (ti_Creation_keyword);
					ctxt.new_line;
				end;
				ctxt.put_text_item (ti_After_creators);
				ctxt.new_line;
			end;		
			ctxt.format_categories;	
			ctxt.format_invariants;	
			ctxt.put_text_item (ti_Before_class_end);
			ctxt.put_text_item (ti_End_keyword);
			ctxt.end_class_text;
			ctxt.put_text_item (ti_After_class_end);
			ctxt.put_text_item (ti_After_class_declaration)
			ctxt.new_line;
		end;

feature {FORMAT_REGISTRATION} -- Implementation

	register (format_reg: FORMAT_REGISTRATION) is
			-- Register the feature clauses and
			-- invariant in `format_reg'.
		local
			f: like features;	
			fc: FEATURE_CLAUSE_AS_B;
			inv_adapter: INVARIANT_ADAPTER
		do
			f := features;
			if f /= Void then
				from
					f.start
				until
					f.after
				loop
					fc := f.item;
					fc.register_features (format_reg);
						-- Register the feature clause
						-- after registering the features
					format_reg.register_feature_clause (fc);
					f.forth
				end
			end;
			if invariant_part /= Void then
				!! inv_adapter;
				inv_adapter.register (invariant_part, format_reg);
			end
		end;

feature {CASE_CLASS_INFO} -- Case storage output

	header_storage_info (classc: CLASS_C): S_CLASS_DATA_R331 is
			-- Header storage information for Current
			-- (such as index and class name)
		require
			valid_classc: classc /= Void
		local
			g_l: FIXED_LIST [S_GENERIC_DATA];
			i_l: FIXED_LIST [S_TAG_DATA];
			s_chart: S_CLASS_CHART;
			gen: FORMAL_DEC_AS_B;
			gen_name: STRING;
			gen_data: S_GENERIC_DATA;
			type_info: S_TYPE_INFO;
			name: STRING;
		do
			name := class_name.string_value;
			name.to_upper;
			!! Result.make (name);
			Result.set_reversed_engineered;
			if indexes /= Void then
				!! s_chart;
				from
					!! i_l.make (indexes.count);
					i_l.start;
					indexes.start
				until
					indexes.after
				loop
					i_l.replace (indexes.item.storage_info);
					i_l.forth;
					indexes.forth
				end
				s_chart.set_indexes (i_l);
				Result.set_chart (s_chart);
			end;
			if generics /= Void then
				!! g_l.make (generics.count);
				from
					generics.start;
					g_l.start
				until
					generics.after
				loop
					gen := generics.item;
					!! gen_name.make (0);
					gen_name.append (gen.formal_name);
					gen_name.to_upper;
					if gen.constraint = Void then
						!! gen_data.make (gen_name, Void)
					else
						type_info := gen.constraint_type.storage_info (classc);
						!! gen_data.make (gen_name, type_info)
					end;
					g_l.replace (gen_data);
					g_l.forth;
					generics.forth
				end;
				Result.set_generics (g_l);
			end;
		end;

end -- class CLASS_AS_B
