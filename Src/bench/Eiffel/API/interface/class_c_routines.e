indexing

	description: 
		"Representation of a eiffel class."
	date: "$Date$"
	revision: "$Revision $"

deferred class CLASS_C_ROUTINES

inherit
	TOPOLOGICAL
		rename
			successors as descendants
		end

	IDABLE

	PROJECT_CONTEXT

	SHARED_WORKBENCH

	SHARED_EIFFEL_PROJECT

	SHARED_SERVER
		export
			{ANY} all
		end

	SHARED_INSTANTIATOR

	SHARED_INST_CONTEXT

	SHARED_ERROR_HANDLER

	SHARED_RESCUE_STATUS

	SHARED_PASS	

	SHARED_TEXT_ITEMS

feature -- Initialization

	initialize (l: CLASS_I) is
			-- Initialization of Current.
		require
			good_argument: l /= Void
		do
			lace_class := l
				-- Creation of the descendant list
			!! descendants.make
				-- Creation of the supplier list
			!! suppliers.make
				-- Creation of the client list
			!! clients.make
				-- Types list creation
			!! types.make
		end

feature -- Properties

	id: CLASS_ID
			-- Class id

	lace_class: CLASS_I
			-- Lace class 

	parents: FIXED_LIST [CL_TYPE_A]
			-- Parent classes

	descendants: LINKED_LIST [CLASS_C]
			-- Direct descendants of the current class

	clients: LINKED_LIST [CLASS_C]
			-- Clients of the class

	suppliers: SUPPLIER_LIST
			-- Suppliers of the class in terms of calls
			-- [Useful for incremental type check].

	generics: EIFFEL_LIST [FORMAL_DEC_AS]
			-- Formal generical parameters

	topological_id: INTEGER
			-- Unique number for a class. Could change during a topological
			-- sort on classes.

	reverse_engineered: BOOLEAN
			-- Does the Storage mechanism for EiffelCase need
			-- to regenerate the EiffelCase description for Current class?

	is_deferred: BOOLEAN
			-- Is the class deferred ?

	is_expanded: BOOLEAN
			-- Is the class expanded ?

	is_separate: BOOLEAN
			-- Is the class separate ?

	obsolete_message: STRING
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_debuggable: BOOLEAN is
			-- Is the class able to be debugged?
			-- (not if it doesn't have class types 
			-- or is a special class)
		deferred
		end

	name: STRING is
			-- Class name
		do
			Result := lace_class.name
		end

	text: STRING is
			-- Class text
		require
			valid_file_name: file_name /= Void
		do
			Result := lace_class.text
		end

feature -- status

	hash_code: INTEGER is
			-- Hash code value corresponds to `id.hash_code'.
		do
			Result := id.hash_code
		end

feature -- Access

	name_in_upper: STRING is
			-- Class name in upper case
		do
			Result := clone (name)
			Result.to_upper
		end

	ast: CLASS_AS is
			-- Associated AST structure
		do
			if Ast_server.has (id) then
				Result := Ast_server.item (id)
			elseif Tmp_ast_server.has (id) then
				Result := Tmp_ast_server.item (id)
			end
		ensure
			non_void_result_if: has_ast implies Result /= Void 
		end

	invariant_ast: INVARIANT_AS is
			-- Associated invariant AST structure
		do
			if invariant_feature /= Void then
				Result := Inv_ast_server.item (id)
			end
		end

	has_types: BOOLEAN is
			-- Are there any generic instantiations of Current
			-- in the system or is Current a non generic class?
		do
			Result := (types /= Void) and then (not types.empty)
		end

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end

	feature_with_name (n: STRING): E_FEATURE is
			-- Feature whose internal name is `n'
		require
			valid_n: n /= Void
			has_feature_table: Feat_tbl_server.has (id)
		local
			f: FEATURE_I
		do
			f := feature_table.item (n)
			if f /= Void then
				Result := f.api_feature (id)
			end
		end

	feature_with_body_id (bid: BODY_ID): E_FEATURE is
			-- Feature whose body id `bid'.
		require
			valid_body_id: bid /= Void
			has_feature_table: Feat_tbl_server.has (id)
		local
			feat: FEATURE_I
		do
			feat := feature_table.feature_of_body_id (bid)
			if feat /= Void then
				Result := feat.api_feature (id)
			end
		end

	feature_with_rout_id (rout_id: ROUTINE_ID): E_FEATURE is
			-- Feature whose routine id `rout_id'.
		require
			valid_rout_id: rout_id /= Void
			has_feature_table: Feat_tbl_server.has (id)
		local
			feat: FEATURE_I
		do
			feat := feature_table.origin_table.item (rout_id)
			if feat /= Void then
				Result := feat.api_feature (id)
			end
		end

	api_feature_table: E_FEATURE_TABLE is	
			-- Feature table for current class
		require
			has_feature_table: Feat_tbl_server.has (id)
		do
			Result := feature_table.api_table
		ensure
			valid_result: Result /= Void
		end

	once_functions: SORTED_TWO_WAY_LIST [E_FEATURE] is
			-- List of once functions
		local
			f_table: FEATURE_TABLE
			feat: FEATURE_I
			class_id: CLASS_ID
		do
			class_id := id
			!! Result.make
			f_table := feature_table
			from
				f_table.start
			until
				f_table.after
			loop
				feat := f_table.item_for_iteration
				if feat.is_once and then feat.is_function then
					Result.put_front (feat.api_feature (class_id))
				end
				f_table.forth
			end
			Result.sort
		ensure
			non_void_result: Result /= Void
			result_sorted: Result.sorted
		end

	is_valid: BOOLEAN is
			-- Is the current class valid?
			-- (After a compilation Current may become 
			-- invalid)
		do
			Result := id.is_valid and then
				id.associated_eclass = Current
		end

	written_in_features: LIST [E_FEATURE] is
			-- List of features defined in current class
		require
			has_feature_table: Feat_tbl_server.has (id)
		do
			Result := feature_table.written_in_features
		ensure
			non_void_Result: Result /= Void
		end

feature -- Precompilation Access

	is_precompiled: BOOLEAN is
			-- Is class precompiled?
		do	
			Result := id.is_precompiled
		end

feature -- Server Access

	has_ast: BOOLEAN is
			-- Does Current class have an AST structure?
		do
			Result := Ast_server.has (id) or else Tmp_ast_server.has (id)
		end

	click_list: CLICK_LIST is
			-- Associated click list
		do
			if Tmp_ast_server.has (id) then
				Result := Tmp_ast_server.item (id).click_list
			elseif Ast_server.has (id) then
				Result := Ast_server.item (id).click_list
			end
		ensure
			valid_result: Result /= Void implies has_ast
		end

	cluster: CLUSTER_I is
			-- Cluster to which the class belongs to
		do
			Result := lace_class.cluster
		end

	hidden: BOOLEAN is
			-- Is the class hidden in the precompilation sets?
		do
			Result := lace_class.hidden
		ensure
			hide_only_when_precompiled: Result implies is_precompiled
		end

	file_name: STRING is
			-- File name of the class
		do
			Result := lace_class.file_name
		end

	file_is_readable: BOOLEAN is
			-- Is file with `file_name' readable?
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (file_name)
			Result := f.is_readable	
		end

	has_syntax_error: BOOLEAN is
			-- Does class have a syntax error (after calling `parse_ast')?
		do
			Result := last_syntax_error /= Void
		ensure
			ok_implies_last_syn_void: Result implies last_syntax_error = Void
			not_ok_implies_last_syn_not_void: Result implies last_syntax_error /= Void
		end

	last_syntax_error: SYNTAX_ERROR is
			-- Last syntax error generated after calling
			-- routine `parse_ast'
		do
			Result := last_syntax_cell.item
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Order relation on classes
		do
			Result := topological_id < other.topological_id
		end

feature -- Element change

	parse_ast is
			-- Parse the AST structure of current class if it has changed.
			-- Set `last_syntax_error' if a syntax error ocurred.
			--| Save the AST in the temporary server and add it to the
			--| pass one controller (need to still do the end of pass1 process).
		require
			not_precompiled: not is_precompiled
			file_is_readable: file_is_readable
		local
			class_ast: CLASS_AS
			error: BOOLEAN
			syntax_error: SYNTAX_ERROR
			compiled_info: CLASS_C
			prev_class: CLASS_C
		do
			if not error then
				prev_class := System.current_class
				compiled_info ?= Current
				System.set_current_class (compiled_info)
				last_syntax_cell.put (Void)
				class_ast := build_ast
				class_ast.set_id (id)
					-- Mark the class if it has syntactically changed
					--| Improvement: We can retrieve the previous version of
					--| the AST and compare the new one with the old one.
					--| If they are different, we should put the new one in the
					--| server and make the old one obsolete (so that it can be
					--| removed from the server and avoided a growing EIFGEN).
				set_changed (True)
				Tmp_ast_server.put (class_ast)
				pass1_controler.insert_parsed_class (compiled_info)
				pass2_controler.insert_new_class (compiled_info)
				pass3_controler.insert_new_class (compiled_info)
				pass4_controler.insert_new_class (compiled_info)
				lace_class.set_date
			else
				syntax_error ?= Error_handler.error_list.first
				check
					syntax_error_not_void: syntax_error /= Void
				end
				Error_handler.error_list.wipe_out
				last_syntax_cell.put (syntax_error)
				error := False
			end
			System.set_current_class (prev_class)
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False)
				error := True
				retry
			end
		end

feature -- Output

	signature: STRING is
			-- Signature of class
		local
			formal_dec: FORMAL_DEC_AS
			constraint_type: TYPE
			old_cluster: CLUSTER_I
			gens: like generics
		do
			!!Result.make (50)
			Result.append (name)
			Result.to_upper
			gens := generics
			if gens /= Void then
				old_cluster := Inst_context.cluster
				Inst_context.set_cluster (cluster)
				Result.append (" [")
				from
					gens.start
				until
					gens.after
				loop
					formal_dec ?= gens.item
					Result.append (formal_dec.constraint_string)
					gens.forth
					if not gens.after then
						Result.append (", ")
					end
				end
				Inst_context.set_cluster (old_cluster)
				Result.append ("]")
			end
		end

	append_signature (st: STRUCTURED_TEXT) is
			-- Append the signature of current class in `st'
		require
			non_void_st: st /= Void
		local
			formal_dec: FORMAL_DEC_AS
			constraint_type: TYPE
			old_cluster: CLUSTER_I
			gens: like generics
		do
			append_name (st)
			gens := generics
			if gens /= Void then
				old_cluster := Inst_context.cluster
				Inst_context.set_cluster (cluster)
				st.add (ti_Space)
				st.add (ti_L_bracket)
				from
					gens.start
				until
					gens.after
				loop
					formal_dec ?= gens.item
					formal_dec.append_signature (st)
					gens.forth
					if not gens.after then
						st.add (ti_Comma)
						st.add (ti_Space)
					end
				end
				st.add (ti_R_bracket)
				Inst_context.set_cluster (old_cluster)
			end
		end

	append_name (st: STRUCTURED_TEXT) is
			-- Append the name ot the current class in `st'
		require
			non_void_st: st /= Void
		do
			st.add_classi (lace_class, name_in_upper)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_topological_id (i: INTEGER) is
			-- Assign `i' to `topological_id'.
		do
			topological_id := i
		end

	set_is_deferred (b: BOOLEAN) is
			-- Assign `b' to `is_deferred'.
		do
			is_deferred := b
		end

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b
		end

	set_is_separate (b: BOOLEAN) is
			-- Assign `b' to `is_separate'.
		do
			is_separate := b
		end

	set_id (i: like id) is
			-- Assign `i' to `id'.
		do
			id := i
		end

	set_parents (p: like parents) is
			-- Assign `p' to `parents'.
		do
			parents := p
		end

	set_suppliers (s: like suppliers) is
			-- Assign `s' to `suppliers'.
		do
			suppliers := s
		end

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g
		end

	set_reverse_engineered (b: BOOLEAN) is
			-- Set reversed_engineered to `b'.
		do
			reverse_engineered := b
		ensure
			reverse_engineered_set: reverse_engineered = b
		end

	set_obsolete_message (m: like obsolete_message) is
			-- Set `obsolete_message' to `m'.
		do
			obsolete_message := m
		end

feature -- Removal

	clear_syntax_error is
			-- Clear the syntax error information.
		do
			last_syntax_cell.put (Void)
		ensure
			not_has_syntax: not has_syntax_error
		end

feature {COMPILER_EXPORTER} -- Implementation

	invariant_feature: INVARIANT_FEAT_I
			-- Invariant feature

	types: TYPE_LIST
			-- Meta-class types associated to the class: it contains
			-- only one type if the class is not generic

	feature_named (n: STRING): FEATURE_I is
			-- Feature whose internal name is `n'
		do
			if Tmp_feat_tbl_server.has (id) then
				Result := Tmp_feat_tbl_server.item (id).item (n)
			elseif Feat_tbl_server.server_has (id) then
				Result := Feat_tbl_server.server_item (id).item (n)
			end
		end

feature {NONE} -- Implementation

	feature_table: FEATURE_TABLE is
			-- Compiler feature table
		require
			has_feature_table: Feat_tbl_server.has (id)
		do
			Result := Feat_tbl_server.item (id)
		ensure
			valid_result: Result /= Void
		end

feature {NONE} -- Implementation

	last_syntax_cell: CELL [SYNTAX_ERROR] is
			-- Stored value of last generated syntax error generated calling
			-- routine `parse_ast'
		once
			!! Result.put (Void)
		end

feature {NONE} -- Deferred routines to be implemented in CLASS_C

	build_ast: CLASS_AS is
			-- Build the AST structure of Current class
		deferred
		end

	set_changed (b: BOOLEAN) is
			-- Mark the associated lace class changed.
		deferred
		end

invariant

	lace_class_exists: lace_class /= Void
	descendants_exists: descendants /= Void
	suppliers_exisis: suppliers /= Void
	clients_exists: clients /= Void

end -- class CLASS_C_ROUTINES
