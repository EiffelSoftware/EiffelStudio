-- Instance of an Eiffel feature: for every inherited feature there is
-- an instance of FEATURE_I with its final name, the class name where it
-- is written, the body id of its content and the routine table ids to
-- which the feature is attached.
-- Attribute `type' is the real type of the feature in the class where it
-- is inherited (or written), that means there is no more anchored type.

deferred class FEATURE_I 

inherit
	SHARED_WORKBENCH

	SHARED_SERVER
		export
			{ANY} all
		end

	SHARED_INSTANTIATOR

	SHARED_ERROR_HANDLER

	SHARED_TYPES

	SHARED_EVALUATOR

	SHARED_ARG_TYPES

	SHARED_TABLE

	SHARED_AST_CONTEXT

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end

	SHARED_CODE_FILES

	SHARED_PATTERN_TABLE

	SHARED_USED_TABLE

	SHARED_INST_CONTEXT

	SHARED_ID_TABLES
		export
			{ANY} Body_index_table, Original_body_index_table
		end

	SHARED_ARRAY_BYTE

	SHARED_EXEC_TABLE

	SHARED_OPTIMIZATION_TABLES

	HASHABLE

	PART_COMPARABLE

	COMPILER_EXPORTER
			
feature 

	feature_name: STRING
			-- Final name of the feature

	feature_id: INTEGER
			-- Feature id: first key in the feature call hash table
			-- of a class: tow features of different names have two
			-- different feature ids.

	written_in: CLASS_ID
			-- Class id where the feature is written

	body_index: BODY_INDEX
			-- Index of body id

	pattern_id: PATTERN_ID
			-- Id of the feature pattern

	rout_id_set: ROUT_ID_SET
			-- Routine table to which the feature belongs to.

	export_status: EXPORT_I
			-- Export status of the feature

	is_origin: BOOLEAN
			-- Is the feature an origin ?

	is_frozen: BOOLEAN
			-- Is the feature frozen ?

	is_selected: BOOLEAN
			-- Is the feature selected ?

	is_infix: BOOLEAN
			-- Is the feature an infixed one ?

	is_prefix: BOOLEAN
			-- Is the feature a prefixed one ?

	hash_code: INTEGER is
			-- Hash code
		do
			check
				feature_name_exists: feature_name /= Void
			end
			Result := feature_name.hash_code
		end

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := feature_name < other.feature_name
		end

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'
		do
			feature_id := i
		end

	set_body_index (i: BODY_INDEX) is
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_pattern_id (i: PATTERN_ID) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s
		end

	set_written_in (s: like written_in) is
			-- Assign `s' to `written_in'.
		require
			s_not_void: s /= Void
		do
			written_in := s
		end

	set_is_origin (b: BOOLEAN) is
			-- Assign `b' to `is_origin'.
		do
			is_origin := b
		end

	set_export_status (e: EXPORT_I) is
			-- Assign `e' to `export_status'.
		do
			export_status := e
		end

	set_is_frozen (b: BOOLEAN) is
			-- Assign `b' to `is_frozen'.
		do
			is_frozen := b
		end

	set_is_infix (b: BOOLEAN) is
			-- Assign `b' to `is_infix'. 
		do
			is_infix := b
		end

	set_is_prefix (b: BOOLEAN) is
			-- Assign `b' to `is_prefix'.
		do
			is_prefix := b
		end

	set_is_selected (b: BOOLEAN) is
			-- Assign `b' to `is_selected'.
		do
			is_selected := b
		end

	set_rout_id_set (set: like rout_id_set) is
			-- Assign `set' to `rout_id_set'.
		do
			rout_id_set := set
		end

	to_melt_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature to be melted in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.id.is_equal (written_in)
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature to be generated in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.id.is_equal (written_in)
		end

	generation_class_id: CLASS_ID is
			-- Id of the class where the feature has to be generated in
		do
			Result := written_in
		end

	body_id: BODY_ID is
			-- Body id of the current version of the feature
		require
			consistency: Body_index_table.has (body_index)
		do
			Result := Body_index_table.item (body_index)
		end

	original_body_id: BODY_ID is
			-- Body id of the feature before before the beginning of
			-- a recompilation
		require
			consistency: Original_body_index_table.has (body_index)
		do
			Result := Original_body_index_table.item (body_index)
		end

	duplicate: like Current is
			-- Clone
		do
			Result := clone (Current)
		end

	duplicate_arguments is
			-- Do a clone of the arguments (for replication)
		do
			-- Do nothing
		end

feature -- Incrementality

	equiv (other: FEATURE_I): BOOLEAN is
			-- Incrementality test on instance of FEATURE_I during
			-- second pass.
		require
			good_argument: other /= Void
		do
			Result := written_in.is_equal (other.written_in)
				and then is_selected = other.is_selected
				and then rout_id_set.same_as (other.rout_id_set)
				and then is_origin = other.is_origin
				and then is_frozen = other.is_frozen
				and then is_deferred = other.is_deferred
				and then is_external = other.is_external
				and then export_status.same_as (other.export_status)
				and then same_signature (other)
				and then has_precondition = other.has_precondition
				and then has_postcondition = other.has_postcondition
debug ("ACTIVITY")
	if not Result then
			io.error.putbool (written_in.is_equal (other.written_in)) io.error.new_line;
			io.error.putbool (is_selected = other.is_selected) io.error.new_line;
			io.error.putbool (rout_id_set.same_as (other.rout_id_set)) io.error.new_line;
			io.error.putbool (is_origin = other.is_origin) io.error.new_line;
			io.error.putbool (is_frozen = other.is_frozen) io.error.new_line;
			io.error.putbool (is_deferred = other.is_deferred) io.error.new_line;
			io.error.putbool (is_external = other.is_external) io.error.new_line;
			io.error.putbool (export_status.same_as (other.export_status)) io.error.new_line;
			io.error.putbool (same_signature (other)) io.error.new_line;
			io.error.putbool (has_precondition = other.has_precondition) io.error.new_line;
			io.error.putbool (has_postcondition = other.has_postcondition) io.error.new_line;
	end
end
			if Result then
				if assert_id_set /= Void then
					Result := assert_id_set.same_as (other.assert_id_set)
				else
					Result := (other.assert_id_set = Void)
				end
			end

			if Result and then equal (rout_id_set.first, 
									  System.default_rescue_id) then
				-- This is the default rescue feature.
				-- Test whether emptiness of body has changed.
				Result := (empty_body = other.empty_body)
			end

debug ("ACTIVITY")
	if not Result then
		io.error.putstring ("%T%T")
		io.error.putstring (feature_name)
		io.error.putstring (" is not equiv%N")
	end
end
		end

	select_table_equiv (other: FEATURE_I): BOOLEAN is
			-- Incrementality of the select table
		require
			good_argumnet: other /= Void

		do
			Result :=	written_in.is_equal (other.written_in)
						and then	
						rout_id_set.same_as (other.rout_id_set)
						and then
						is_origin = other.is_origin
						and then
						equal (body_index, other.body_index)
						and then
						type.is_deep_equal (other.type)
		end

	is_valid: BOOLEAN is
			-- Is the feature still valid?
			-- Incrementality: The types of the arguments and/or result
			-- are still defined in the system
		local
			type_a: TYPE_A
		do
			type_a ?= type
			Result := type_a.is_valid
			if Result and then has_arguments then
				Result := arguments.is_valid
			end
		end

	same_class_type (other: FEATURE_I): BOOLEAN is
			-- Has `other' the same resulting type than Current ?
		require
			good_argument: other /= Void
			same_names: other.feature_name.is_equal (feature_name)
		do
			Result := type.same_as (other.type)
		end

	same_interface (other: FEATURE_I): BOOLEAN is
			-- Has `other' the same interface than Current ?
			-- [Semnatic for second pass is `old_feat.same_interface (new)']
		require
			good_argument: other /= Void
			same_names: other.feature_name.is_equal (feature_name)
--			export_statuses_exist: not ( 	export_status = Void
--											or else
--											other.export_status = Void)
		do
			Result := 	type.same_as (other.type)
--						and then
--						export_status.equiv (other.export_status)
debug ("ACTIVITY")
	if not Result then
		io.error.putstring (feature_name)
		io.error.putstring (": NEW RETURN TYPE%N")
		type.trace
		io.error.new_line
		other.type.trace
		io.error.new_line
	end
end
			if Result then
				if argument_count = 0 then
					Result := other.argument_count = 0
				else
					Result := 	argument_count = other.argument_count
								and then
								arguments.same_interface (other.arguments)
				end
			end
			Result := 	Result
						and then
						is_attribute = other.is_attribute
debug ("ACTIVITY")
	if not Result then
		io.error.putstring (feature_name)
		io.error.putstring (": NEW INTERFACE%N")
	end
end
		end

feature -- test for empty body

	empty_body : BOOLEAN        -- Does feature have an empty body?

	set_empty_body (b : BOOLEAN) is
			-- Set `empty_body' to `b'
		do
			empty_body := b
		ensure
			set : empty_body = b
		end

feature -- creation of default rescue clause

	create_default_rescue (def_resc_name : STRING) is
			-- Create default_rescue clause if necessary
		require
			valid_feature_name : def_resc_name /= Void
		local
			my_body : like body
		do
			if not (is_attribute or is_constant or 
									is_external or is_deferred) then
				my_body := body

				if (my_body /= Void) then 
					my_body.create_default_rescue (def_resc_name)
				end
			end
		end

feature -- Type id

	written_type_id (class_type: CL_TYPE_I): INTEGER is
			-- Written type id of the feature in the context of the
			-- type `class_type'.
		do
			Result := written_type (class_type).type_id
		end

	written_type (class_type: CL_TYPE_I): CL_TYPE_I is
			-- Written type of the feature in the context of the
			-- type `class_type'.
		require
			good_argument: class_type /= Void
			conformance: class_type.base_class.conform_to (written_class)
		do
			Result := written_class.meta_type (class_type)
		end

feature -- Conveniences

	assert_id_set: ASSERT_ID_SET is
			-- Assertions to which the procedure belongs to
			-- (To be redefined in PROCEDURE_I).
		do
			-- Do nothing
		end

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end

	obsolete_message: STRING is
			-- Obsolete message
			-- (Void if Current is not obsolete)
		do
			-- Do nothing
		end

	has_arguments: BOOLEAN is
			-- Has the current feature some formal arguments ?
		do
			Result := arguments /= Void
		end

	set_is_code_replicated is
			-- Set current feature to be code replicated.
		require
			valid_feature: is_replicated
		do
			-- Do nothing
		end

	is_code_replicated: BOOLEAN is
			-- Is Current feature code replicated?
			--| This is very important for retrieval
			--| of the body as from the correct	
			--| server (Body_server or Rep_feat_server).
		do
			-- Do nothing
		end

	is_replicated: BOOLEAN is
			-- Is Current feature conceptually replicated?
		do
			-- Do nothig
		end

	is_procedure: BOOLEAN is
			-- Is the current feature a procedure ?
		do
			-- Do nothing
		end

	is_function: BOOLEAN is
			-- Is the cuurent feature a function ?
		do
			-- Do nothing
		end

	is_attribute: BOOLEAN is
			-- Is the current feature an attribute ?
		do
			-- Do nothing
		end

	is_constant: BOOLEAN is
			-- Is the current feature a constant ?
		do
			-- Do nothing
		end

	is_once: BOOLEAN is
			-- Is the current feature a once one ?
		do
			-- Do nothing
		end

	is_do: BOOLEAN is
			-- Is the current feature a do one ?
		do
			-- Do nothing
		end

	is_deferred: BOOLEAN is
			-- Is the current feature a deferred one ?
		do
			-- Do nothing
		end

	is_unique: BOOLEAN is
			-- Is the current feature a unique constant ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN is
			-- Is the current feature an external one ?
		do
			-- Do nothing
		end

	is_require_else: BOOLEAN is
			-- Is the precondition block of the feature a redefined one ?
		do
			Result := True
		end

	has_precondition: BOOLEAN is
			-- Is the feature declaring some preconditions ?
		do
			-- Do nothing
		end

	has_postcondition: BOOLEAN is
			-- Is the feature declaring some postconditions ?
		do
			-- Do nothing
		end

	has_assertion: BOOLEAN is
			-- Is the feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the feature a redefined one ?
		do
			Result := True
		end

	redefinable: BOOLEAN is
			-- Is the feature redefinable ?
		do
			Result := not is_frozen
		end

	undefinable: BOOLEAN is
			-- Is the feature undefinable ?
		do
			Result := redefinable
		end

	is_none_attribute: BOOLEAN is
			-- is the feature an attribute of type NONE ?
		do
			-- Do nothing
		end

	type: TYPE is
			-- Type of the feature
		do
			Result := Void_type
		end

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			-- Do nothing
		end

	arguments: FEAT_ARG is
			-- Argument types
		do
			-- No arguments
		end

	argument_names: EIFFEL_LIST [ID_AS] is
			-- Argument names
		do
			-- No argument names
		end

	set_assert_id_set (set: like assert_id_set) is
			-- Assign `set' to assert_id_set.
		do
			-- Do nothing	
		end

	argument_count: INTEGER is
			-- Number of arguments of the feature
		do
			if arguments /= Void then
				Result := arguments.count
			end
		end

	written_class: CLASS_C is
			-- Class where the feature is written in
		require
			good_written_in: written_in /= Void
		do
			Result := System.class_of_id (written_in)
		end

feature -- Export checking

--	has_special_export: BOOLEAN is
--			-- The export status is special, i.e. the feature
--			-- is not exported to all the other classes.
--			-- A call to this feature must be recorded specially
--			-- in the dependances for incrementality purpose:
--			-- If the hierarchy changes, the call may be invalid.
--		require
--			has_export_status: export_status /= Void
--		do
--			Result := not export_status.is_all
--		end

	is_exported_for (client: CLASS_C): BOOLEAN is
			-- Is the current feature exported to class `client' ?
		require
			good_argument: client /= Void
			has_export_status: export_status /= Void
		do
			Result := export_status.valid_for (client)
		end

	record_suppliers (feat_depend: FEATURE_DEPENDANCE) is
			-- Record the suppliers ids in `feat_depend'
		require
			good_arg: feat_depend /= Void
		local
			type_a: TYPE_A
			a_class: CLASS_C
		do
				-- Create the supplier set for the feature
			type_a ?= type
			if type_a /= Void then
				a_class := type_a.associated_class
				if a_class /= Void then
					feat_depend.add_supplier (a_class)
				end
			end
			if has_arguments then
				from
					arguments.start
				until
					arguments.after
				loop
					type_a ?= arguments.item
					a_class := type_a.associated_class
					if a_class /= Void then
						feat_depend.add_supplier (a_class)
					end
					arguments.forth
				end
			end
		end

	suppliers: TWO_WAY_SORTED_SET [CLASS_ID] is
			-- Class ids of all the suppliers of the feature
		require
			Tmp_depend_server.has (written_in) or else
			Depend_server.has (written_in)
		local
			class_dependance: CLASS_DEPENDANCE
		do
			if Tmp_depend_server.has (written_in) then
				class_dependance := Tmp_depend_server.item (written_in)
			else
				class_dependance := Depend_server.item (written_in)
			end
			Result := class_dependance.item (body_id).suppliers
		end

feature -- Check

-- Note: `require else' can be used even if the feature has no
-- precursor. There is no problem to raise an error in the normal case,
-- the only case  where we cannot do anything is when aliases are used
-- and one name references a feature with a predecessor and not the
-- other one

--	check_assertions is
--			-- Raise an error if "require else" or "ensure then" is used
--			-- but the feature has no ancestor
--		do
--		end

	body: FEATURE_AS is
			-- Body of the feature
		local
			class_ast: CLASS_AS
			bid: BODY_ID
		do
			if body_index /= Void then
				bid := Body_index_table.item (body_index)
				if is_code_replicated then
					Result := Rep_feat_server.item (bid)
				else
					if Tmp_body_server.has (bid) then
						Result := Tmp_body_server.item (bid)
					elseif Body_server.server_has (bid) then
						Result := Body_server.server_item (bid)
					end
				end
			end
			if Result = Void then
				if Tmp_ast_server.has (written_in) then
					-- Means a degree 4 error has occurred so the
					-- best we can do is to search through the
					-- class ast and find the feature as
					class_ast := Tmp_ast_server.item (written_in)
					Result ?= class_ast.feature_with_name (feature_name)
				end
			end
		end

	type_check is
			-- Third pass on current feature
		require
			in_pass3
		do
-- See the note near the declaration of `check_assertions'
--			check_assertions
			record_suppliers (context.supplier_ids)
				-- Take the body in the body server
debug ("SERVER", "TYPE_CHECK")
	io.error.putstring ("feature name: ")
	io.error.putstring (feature_name)
	io.error.new_line
	io.error.putstring ("body id: ")
	body_id.trace
	io.error.new_line
end
				-- make the type check
			body.type_check
		end

	check_local_names is
			-- Check the conflicts between local names and feature names
			-- for an unchanged feature
		do
		end

	in_pass3: BOOLEAN is
			-- Does the current feature support the type check ?
		do
			Result := True
		end

feature -- Byte code computation

	compute_byte_code (has_default_rescue: BOOLEAN) is
			-- Compute byte code for melted feature
		require
			in_pass3: in_pass3
		local
			byte_code: BYTE_CODE
		do
				-- Process byte code
			byte_code := body.byte_node
			byte_code.set_byte_id (body_id)
			byte_code.set_default_rescue (has_default_rescue)

				-- Put it in the temporary byte code server
			if not byte_context.old_expressions.empty then
				byte_code.set_old_expressions (byte_context.old_expressions)
			end
			byte_context.clear_old_expressions

			Tmp_byte_server.put (byte_code)
		end

	melt (dispatch: DISPATCH_UNIT exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
			-- [To be redefined in CONSTANT_I, ATTRIBUTE_I and in EXTERNAL_I].
		require
			good_argument: dispatch /= Void
		local
			byte_code: BYTE_CODE
			melted_feature: MELT_FEATURE
		do
			byte_code := Byte_server.item (body_id)

			byte_context.set_byte_code (byte_code)

			Byte_array.clear
			byte_code.set_real_body_id (dispatch.real_body_id)
			byte_code.make_byte_code (Byte_array)
			byte_context.clear_all

			melted_feature := Byte_array.melted_feature
			melted_feature.set_real_body_id (dispatch.real_body_id)
	
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Dispatch_table.mark_melted (dispatch)
			Execution_table.mark_melted (exec)
		end

	melted: BOOLEAN is
			-- Is the feature melted ?
		local
			bid: BODY_ID
		do
			bid := body_id
			if bid /= Void then
				Result := bid.id > System.frozen_level
			end
		end

	execution_unit (cl_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Execution unit
		do
			if is_code_replicated then
				!REP_EXECUTION_UNIT!Result.make (cl_type, Current)
			else
				!!Result.make (cl_type, Current)
			end
		end

	change_body_id is
			-- Change the body id of the current feature
			--| In case of automatic melting of the Current feature (see
			--| `pass3' in CLASS_C, the body id of the feature must be
			--| cnaged even if not syntactically changed.
		local
			new_body_id, old_body_id: BODY_ID
			changed_body_id_info: CHANGED_BODY_ID_INFO
		do
			old_body_id := body_id
			new_body_id := System.body_id_counter.next_id
				-- Update the server using `old_body_id'
debug ("SERVER")
	io.putstring ("Change body id of feature: ")
	io.putstring (feature_name)
	io.putstring (" of class ")
	io.putstring (written_class.name)
	io.putstring (" old: ")
	io.putstring (old_body_id.dump)
	io.putstring (" new: ")
	io.putstring (new_body_id.dump)
	io.new_line
end
			System.depend_server.change_ids (new_body_id, old_body_id)
			if not is_code_replicated then
				Body_server.change_id (new_body_id, old_body_id)
			else
				Rep_feat_server.change_id (new_body_id, old_body_id)
			end
			Byte_server.change_id (new_body_id, old_body_id)
				-- Update the body index table
			Body_index_table.force (new_body_id, body_index)
			System.onbidt.put (new_body_id, old_body_id)
			!!changed_body_id_info.make (is_code_replicated, body_index, new_body_id)
			System.changed_body_ids.force (changed_body_id_info, old_body_id)
		end
	
feature -- Polymorphism

 	has_entry: BOOLEAN is
 			-- Has the feature an associated polymorphic unit ?
 		do
 			Result := True
 		end
 
 	new_entry (rout_id: ROUTINE_ID): ENTRY is
 			-- New polymorphic unit
 		require
			rout_id_not_void: rout_id /= Void
 		do
 			if not is_attribute or not rout_id.is_attribute then
 				Result := new_rout_entry
 			else
 				Result := new_attr_entry
 			end
 		end
 
 	new_rout_entry: ROUT_ENTRY is
 			-- New routine unit
 		require
 			not_deferred: not is_deferred
 		do
 			!!Result
 			Result.set_body_index (body_index)
 			Result.set_type_a (type.actual_type)
 			Result.set_written_in (written_in)
 			Result.set_pattern_id (pattern_id)
			Result.set_feature_id (feature_id)
 		end
 
 	new_attr_entry: ATTR_ENTRY is
 			-- New attribute unit
 		require
 			is_attribute: is_attribute
		local
			type_a: TYPE_A
 		do
			type_a := type.actual_type
 			!!Result
 			Result.set_type_a (type.actual_type)
 			Result.set_feature_id (feature_id)
 		end
 
 	poly_equiv (other: FEATURE_I): BOOLEAN is
 			-- Is `other' equivalent to Current from the polymorhic table 
			-- implementation point of view ?
 		require
 			good_argument: other /= Void
 		local
 			is_attr: BOOLEAN
 		do
 			is_attr := is_attribute
 			Result := 	other.is_attribute = is_attr
 						and then
 						type.actual_type.same_as (other.type.actual_type)
 			if Result then
 				if is_attr then
 					Result := 	feature_id = other.feature_id
				else
	 				Result :=   written_in.is_equal (other.written_in)
 								and then
 								equal (body_index, other.body_index)
 								and then
 								equal (pattern_id, other.pattern_id)
 				end
 			end
 		end

feature -- Signature instantiation

	instantiate (parent_type: CL_TYPE_A) is
			-- Instantiated the signature in the context of `parent_type'.
		require
			good_argument: parent_type /= Void
			is_solved: type.is_solved
		local
			i, nb: INTEGER
			old_type: TYPE_A
		do
				-- Instantiation of the type
			old_type ?= type
			set_type (old_type.instantiated_in (parent_type))
				-- Instantiation of the arguments
			from
				i := 1
				nb := argument_count
			until
				i > nb
			loop
				old_type ?= arguments.i_th (i)
				arguments.put_i_th (old_type.instantiated_in (parent_type), i)
				i := i + 1
			end
		end

feature -- Signature checking
	
	check_argument_names (feat_table: FEATURE_TABLE) is
			-- Check the argument names
		require
			argument_names_exists: argument_names /= Void
			written_in_class: written_in.is_equal (feat_table.feat_tbl_id)
				-- The feature must be written in the associated class
				-- of `feat_table'.
		local
			arg_names: like argument_names
			arg_id: ID_AS
			vreg: VREG
			vrfa: VRFA
			l_area: SPECIAL [ID_AS]
			i, nb: INTEGER
		do
			from
				arg_names := argument_names
				l_area := arg_names.area
				nb := arg_names.count
			until
				i = nb
			loop
				arg_id := l_area.item (i)
					-- Searching to find after the current item another one
					-- with the same name. 
					-- We do `i + 2' for the start index because we need to go
					-- one step further (+ 1) and also because we are directly
					-- using area (+ 1)
				if arg_names.locate_index_of (arg_id, 1, i + 2) /= 0 then
						-- Two arguments with the same name
					!!vreg
					vreg.set_class (written_class)
					vreg.set_feature (Current)
					vreg.set_entity_name (arg_id)
					Error_handler.insert_error (vreg)
				end
				if feat_table.has (arg_id) then
						-- An argument name is a feature name of the feature
						-- table.
					!!vrfa
					vrfa.set_class (written_class)
					vrfa.set_feature (Current)
					vrfa.set_other_feature (feat_table.found_item)
					Error_handler.insert_error (vrfa)
				end
				i := i + 1
			end
		end

	check_types (feat_table: FEATURE_TABLE) is
			-- Check the type and the arguments types. The objective is
			-- to deal with anchored types and genericity. All the anchored
			-- types are interpreted here and the generic parameter
			-- instantiated if possible.
		require
			type /= Void
		local
			solved_type: TYPE_A
			vffd5: VFFD5
			vffd6: VFFD6
			vffd7: VFFD7
			vtug: VTUG
			vtcg1: VTCG1
			constraint_error_list: LINKED_LIST [CONSTRAINT_INFO]
		do
			if type.has_like and then is_once then
					-- We have an anchored type.
					-- Check if the feature is not a once feature
				!!vffd7
				vffd7.set_class (written_class)
				vffd7.set_feature_name (feature_name)
				Error_handler.insert_error (vffd7)
			end
				-- Process an actual type for the feature interpret
				-- anchored types.
			solved_type := Result_evaluator.evaluated_type
												(type, feat_table, Current)

			check
					-- If an anchored cannot be valuated then an
					-- exection is triggered by the type evaluator.
				solved_type /= Void
			end
debug ("ACTIVITY")
	io.error.putstring ("Check types of ")
	io.error.putstring (feature_name)
	io.error.new_line
	if solved_type = Void then
		io.error.putstring ("VOID solved type!!%N")
	else
		io.error.putstring ("Solved type: ")
		io.error.putstring (solved_type.dump)
		io.error.new_line
	end
end

			if feat_table.associated_class = written_class then
					-- Check valididty of a generic class type
				if not solved_type.good_generics then
					vtug := solved_type.error_generics
					vtug.set_class (written_class)
					vtug.set_feature (Current)
					vtug.set_entity_name ("Result")
					Error_handler.insert_error (vtug)
						-- Cannot go on here ..
					Error_handler.raise_error
				end
					-- Check constrained genericity validity rule
				constraint_error_list := solved_type.check_constraints (written_class)
				if constraint_error_list /= Void then
					!!vtcg1
					vtcg1.set_class (written_class)
					vtcg1.set_feature (Current)
					vtcg1.set_error_list (constraint_error_list)
					Error_handler.insert_error (vtcg1)
				end
			end

			set_type (solved_type)
				-- Instantitate the feature type in the context of the
				-- actual type of the class associated to `feat_table'.

			if is_once and then solved_type.has_formal_generic then
					-- A once funtion cannot have a type with formal generics
				!!vffd7
				vffd7.set_class (written_class)
				vffd7.set_feature_name (feature_name)
				Error_handler.insert_error (vffd7)
			end
			solved_type.check_for_obsolete_class (feat_table.associated_class)

			if 
				is_infix and then 
				((argument_count /= 1) or else (type = Void_type))
			then
					-- Infixed features should have only one argument
					-- and must have a return type.
				!!vffd6
				vffd6.set_class (written_class)
				vffd6.set_feature_name (feature_name)
				Error_handler.insert_error (vffd6)
			end
			if 
				is_prefix and then 
				((argument_count /= 0) or else (type = Void_type))
			then
					-- Prefixed features shouldn't have any argument
					-- and must have a return type.
				!!vffd5
				vffd5.set_class (written_class)
				vffd5.set_feature_name (feature_name)
				Error_handler.insert_error (vffd5)
			end

			if arguments /= Void then
					-- Check types of arguments
				arguments.check_types (feat_table, Current)
			end
		end

	check_expanded (class_c: CLASS_C) is
			-- Check the expanded validity rules
		require
			type /= Void
		local
			solved_type: TYPE_A
			vtec1: VTEC1
			vtec2: VTEC2
		do
debug ("CHECK_EXPANDED")
	io.error.putstring ("Check expanded of ")
	io.error.putstring (feature_name)
	io.error.new_line
end
			if class_c.id.is_equal (written_in) then
					-- Check validity of an expanded result type

					-- `set_type' has been called in `check_types' so
					-- the reverse assignment is valid.
				solved_type ?= type
				if	solved_type.has_expanded then
					if 	solved_type.expanded_deferred then
						!!vtec1
						vtec1.set_class (written_class)	
						vtec1.set_feature (Current)
						vtec1.set_entity_name (feature_name)
						Error_handler.insert_error (vtec1)
					elseif not solved_type.valid_expanded_creation (class_c) then
						!!vtec2
						vtec2.set_class (written_class)	
						vtec2.set_feature (Current)
						vtec2.set_entity_name (feature_name)
						Error_handler.insert_error (vtec2)
					end
				end
				if solved_type.has_generics then
					system.expanded_checker.check_actual_type (solved_type)
				end
				if arguments /= Void then
					arguments.check_expanded (class_c, Current)
				end
			end
		end

	check_signature (old_feature: FEATURE_I) is
			-- Check the signature conformance beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a redefinition.
		require
			good_argument: old_feature /= Void
		local
			old_type, new_type: TYPE_A
			i, arg_count: INTEGER
			new_ext, old_ext: EXTERNAL_I
			new_extension, old_extension: CPP_EXTENSION_I
			old_arguments: like arguments
			current_class: CLASS_C
			vdrd51: VDRD51
			vdrd52: VDRD52
			vdrd53: VDRD53
			vdrd6: VDRD6
			vdrd7: VDRD7
			vdrd71: VDRD71
			ve01: VE01
			ve02: VE02
			ve02a: VE02A
		do
debug ("ACTIVITY")
	io.error.putstring ("Check signature of ")
	io.error.putstring (feature_name)
	io.error.new_line
end
			current_class := System.current_class

				-- Check if an attribute is redefined in an attribute
			if old_feature.is_attribute and then not is_attribute then
				!!vdrd6
				vdrd6.init (old_feature, Current)
				Error_handler.insert_error (vdrd6)
			end

				-- Check if an external (resp. non-external) feature is not
				-- redefined into a non external (resp. external) one
			if old_feature.is_external /= is_external then
				!!ve01
				ve01.set_class (current_class)
				ve01.set_feature (Current)
				ve01.set_old_feature (old_feature)
				Error_handler.insert_error (ve01)
			elseif is_external then
				old_ext ?= old_feature
				new_ext ?= Current
					-- This was the previous implementation:
					-- new_ext.set_encapsulated
					--			  (new_ext.encapsulated or else old_ext.encapsulated)
					-- In the case where a class redefines a routine that 
					-- requires encapsulation (is_special or has_signature is True)
					-- into a `standard' external that doesn't need to be encapsulated
					-- the previous implementation led this `standard' external to
					-- be encapsulated. Bad. -- Fabrice.

					-- C++ redeclaration
				old_extension ?= old_ext.extension
				new_extension ?= new_ext.extension

				if
					(old_extension /= Void) /= (new_extension /= Void)
					or else
					((new_extension /= Void) and then new_extension.type /= old_extension.type)
				then
						-- Error C++ => C or C => C++
					!! vdrd71
					vdrd71.init (old_feature, Current)
					Error_handler.insert_error (vdrd71)
				end
			end

				-- Check if an effective feature is not redefined in a
				-- non-effective feature
			if (not old_feature.is_deferred) and then is_deferred then
				!!vdrd7
				vdrd7.set_class (current_class)
				vdrd7.init (old_feature, Current)
				Error_handler.insert_error (vdrd7)
			end
	
				-- Initialization for like-argument types
			Argument_types.init1 (Current)
		
			old_type ?= old_feature.type	
			old_type := old_type.conformance_type.actual_type
				-- `new_type' is the actual type of the redefinition already
				-- instantiated
			new_type := type.actual_type
debug ("ACTIVITY")
	io.error.putstring ("Types:%N")
	if old_type /= Void then
		io.error.putstring ("old type:%N")
		io.error.putstring (old_type.dump)
		io.error.new_line
	end
	if new_type /= Void then
		io.error.putstring ("new type:%N")
		io.error.putstring (new_type.dump)
		io.error.new_line
	else
		io.error.putstring ("New type: VOID%Ntype:")
		io.error.putstring (type.dump)
		io.error.new_line
		io.error.putstring (type.out)
		io.error.new_line
	end
	io.error.new_line
end
			if not current_class.valid_redeclaration (old_type, new_type) then
				!!vdrd51
				vdrd51.init (old_feature, Current)
				Error_handler.insert_error (vdrd51)
			elseif
				new_type.is_expanded /= old_type.is_expanded
			then
				!!ve02
				ve02.init (old_feature, Current)
--				ve02.set_type (new_type)
--				ve02.set_precursor_type (old_type)
				Error_handler.insert_error (ve02)
			end

				-- Check the argument count
			if argument_count /= old_feature.argument_count then
				!!vdrd52
				vdrd52.init (old_feature, Current)
				Error_handler.insert_error (vdrd52)
			else
					-- Check the argument conformance
				from
					i := 1
					arg_count := argument_count
					old_arguments := old_feature.arguments
				until
					i > arg_count
				loop
					old_type ?= old_arguments.i_th (i)
					old_type := old_type.conformance_type.actual_type
					new_type := arguments.i_th (i).actual_type
debug ("ACTIVITY")
	io.error.putstring ("Types:%N")
	if old_type /= Void then
		io.error.putstring ("old type:%N")
		io.error.putstring (old_type.dump)
		io.error.new_line
	end
	if new_type /= Void then
		io.error.putstring ("new type:%N")
		io.error.putstring (new_type.dump)
		io.error.new_line
	end
	io.error.new_line
end
					if not
						current_class.valid_redeclaration (old_type, new_type)
					then
						!!vdrd53
						vdrd53.init (old_feature, Current)
						Error_handler.insert_error (vdrd53)
					elseif
						new_type.is_expanded /= old_type.is_expanded
					then
						!!ve02a
						ve02a.init (old_feature, Current)
--						ve02a.set_type (new_type)
--						ve02a.set_precursor_type (old_type)
						ve02a.set_argument_number (i)
						Error_handler.insert_error (ve02a)
					end
	
					i := i + 1
				end
			end
		end

	check_same_signature (old_feature: FEATURE_I) is
			-- Check the signature equality beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a join.
		require
			good_argument: old_feature /= Void
			is_deferred
			old_feature.is_deferred
			old_feature_is_solved: old_feature.type.is_solved
		local
			old_type, new_type: TYPE_A
			i, arg_count: INTEGER
			old_arguments: like arguments
			vdjr: VDJR
			vdjr1: VDJR1
			vdjr2: VDJR2
		do
				-- Check the result type conformance
				-- `old_type' is the instantiated inherited type in the
				-- context of the class where the join takes place:
				-- i.e the class relative to `written_in'.
			old_type ?= old_feature.type
				-- `new_type' is the actual type of the join already
				-- instantiated
			new_type ?= type
			if not new_type.is_deep_equal (old_type) then
				!!vdjr1
				vdjr1.init (old_feature, Current)
				vdjr1.set_type (new_type)
				vdjr1.set_old_type (old_type)
				Error_handler.insert_error (vdjr1)
			end

				-- Check the argument count
			if argument_count /= old_feature.argument_count then
				!!vdjr
				vdjr.init (old_feature, Current)
				Error_handler.insert_error (vdjr)
			else
	
					-- Check the argument equality
				from
					i := 1
					arg_count := argument_count
					old_arguments := old_feature.arguments
				until
					i > arg_count
				loop
					old_type ?= old_arguments.i_th (i)
					new_type ?= arguments.i_th (i)
					if not new_type.is_deep_equal (old_type) then
						!!vdjr2
						vdjr2.init (old_feature, Current)
						vdjr2.set_type (new_type)
						vdjr2.set_old_type (old_type)
						vdjr2.set_argument_number (i)
						Error_handler.insert_error (vdjr2)
					end
					i := i + 1
				end
			end
		end

	solve_types (feat_tbl: FEATURE_TABLE) is
			-- Evaluates signature types in the context of `feat_tbl'.
			-- | Take care of possible anchored types
		do
			set_type
				(Result_evaluator.evaluated_type (type, feat_tbl, Current))
			if arguments /= Void then
				arguments.solve_types (feat_tbl, Current)
			end
		end

	same_signature (other: FEATURE_I): BOOLEAN is
			-- Has `other' the same signature than Current ?
		require
			good_argument: other /= Void
			same_feature_names: feature_name.is_equal (other.feature_name)
		local
			i, nb: INTEGER
		do
			Result := type.is_deep_equal (other.type)
			from
				nb := argument_count
				Result := Result and then nb = other.argument_count
				nb := argument_count
				i := 1
			until
				i > nb or else not Result
			loop
				Result := arguments.i_th (i).is_deep_equal (other.arguments.i_th (i))
				i := i + 1
			end
		end

	argument_position (arg_id: ID_AS): INTEGER is
			-- Position of argument `arg_id' in the list of arguments
			-- of the current feature. 0 if none or not found.
		require
			arg_id /= Void
		do
			if arguments /= Void then
				Result := argument_names.locate_index_of (arg_id, 1, 1)
			end
		end

	has_argument_name (arg_id: ID_AS): BOOLEAN is
			-- Has the current feature an argument named `arg_id" ?
		do
			if arguments /= Void then
				argument_names.start
				argument_names.compare_objects
				argument_names.search (arg_id)
				Result := not argument_names.after
			end
		end

feature -- Undefinition

	new_deferred: DEF_PROC_I is
			-- New deferred feature for undefinition
		require
			not is_deferred
			redefinable
		do
			if type /= Void then
				!DEF_FUNC_I!Result
			else
				!!Result
			end
			Result.set_type (type)
			Result.set_arguments (arguments)
			Result.set_written_in (written_in)
			Result.set_rout_id_set (rout_id_set)
			Result.set_assert_id_set (assert_id_set)
			Result.set_is_selected (is_selected)
			Result.set_is_infix (is_infix)
			Result.set_is_prefix (is_prefix)
			Result.set_is_frozen (is_frozen)
			Result.set_feature_name (feature_name)
			Result.set_feature_id (feature_id)
			Result.set_pattern_id (pattern_id)
			Result.set_is_require_else (is_require_else)
			Result.set_is_ensure_then (is_ensure_then)
			Result.set_export_status (export_status)
			Result.set_body_index (body_index)
			Result.set_has_postcondition (has_postcondition)
			Result.set_has_precondition (has_precondition)
		ensure
			Result_exists: Result /= Void
			Result_is_deferred: Result.is_deferred
		end

	new_rout_id: ROUTINE_ID is
			-- New routine id
		do
			Result := Routine_id_counter.next_rout_id
		end

	Routine_id_counter: ROUTINE_COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter
		end

feature -- Replication

	code_id: BODY_ID is
			-- Code id for inheritance analysis
		do
			Result := body_id
		end

	set_code_id (i: BODY_ID) is
			-- Assign `i' to code_id.
		do
			-- Do nothing
		end

	access_in: CLASS_ID is
			-- Id of the class where the current feature can be accessed
			-- through its routine id
			-- Useful for replication
		do
			Result := written_in
		end

	access_class: CLASS_C is
			-- Access class
		do
			Result := System.class_of_id (access_in)
		end

	replicated: FEATURE_I is
			-- Replicated feature
		deferred
		ensure
			Result /= Void
		end

	new_code_id: BODY_ID is
			-- New code id
		do
			Result := System.body_id_counter.next_id
		end

	unselected (in: CLASS_ID): FEATURE_I is
			-- Unselected feature
		require
			in_not_void: in /= Void
		deferred
		ensure
			Result_exists: Result /= Void
		end

	is_unselected: BOOLEAN is
			-- Is the current feature an unselected one ?
		do
			-- Do nothing
		end

	transfer_to (other: FEATURE_I) is
			-- Transfer of datas from Current into `other'.
		require
			other_exists: other /= Void
		do
			other.set_body_index (body_index)
			other.set_export_status (export_status)
			other.set_feature_id (feature_id)
			other.set_feature_name (feature_name)
			other.set_is_frozen (is_frozen)
			other.set_is_infix (is_infix)
			other.set_is_prefix (is_prefix)
			other.set_is_selected (is_selected)
			other.set_pattern_id (pattern_id)
			other.set_rout_id_set (rout_id_set)
			other.set_written_in (written_in)
			other.set_is_origin (is_origin)
		end

feature -- Genericity

	update_instantiator2 (a_class: CLASS_C) is
			-- Look for generic types in the result and arguments in order
			-- to update the instantiator.
		require
			good_argument: a_class /= Void
			good_context: a_class.changed
		local
			gen_type: GEN_TYPE_A
			i, arg_count: INTEGER
		do
			gen_type ?= type.actual_type
			if gen_type /= Void then
					-- Found generic result type
				Instantiator.dispatch (gen_type, a_class)
			end
			from
				i := 1
				arg_count := argument_count
			until
				i > arg_count
			loop	
				gen_type ?= arguments.i_th (i).actual_type
				if gen_type /= Void then
						-- Found generic argument type
					Instantiator.dispatch (gen_type, a_class)
				end
				i := i + 1
			end
		end

feature -- Pattern

	pattern: PATTERN is
			-- Feature pattern
		do
			!!Result.make (type.actual_type.meta_type)
			if argument_count > 0 then
				Result.set_argument_types (arguments.pattern_types)
			end
		end

	process_pattern is
			-- Process pattern of Current feature
		local
			p: PATTERN_TABLE
		do
			p := Pattern_table
			p.insert (generation_class_id, pattern)
			pattern_id := p.last_pattern_id
		end
			
feature -- Dead code removal

	used: BOOLEAN is
			-- Is the feature used ?
		do
					-- In final mode dead code removal process is on.
					-- In workbench mode all the features are considered
					-- used.
			Result := 	byte_context.workbench_mode 
						or else
						System.is_used (Current)
		end

feature -- Byte code access

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			feature_b: FEATURE_B
			feature_bs: FEATURE_BS
			last_constrained_type: TYPE_A
		do
			last_constrained_type := context.last_constrained_type
			if (last_constrained_type /= Void and then last_constrained_type.is_separate) then
				!!feature_bs
				feature_bs.init (Current)
				feature_bs.set_type (access_type)
				Result := feature_bs
			else
				!!feature_b
				feature_b.init (Current)
				feature_b.set_type (access_type)
				Result := feature_b
			end
		ensure
			Result_exists: Result /= Void
		end

feature {NONE} -- log file

	add_in_log (class_type: CLASS_TYPE; encoded_name: STRING) is
		do
			System.used_features_log_file.add (class_type, feature_name, encoded_name)
		end

feature -- C code generation

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generate feature written in `class_type' in `buffer'.
		require
			valid_buffer: buffer /= Void
			written_in_type: class_type.associated_class.id.is_equal (generation_class_id)
			not_deferred: not is_deferred
		local
			byte_code: BYTE_CODE
			tmp_body_id: BODY_ID
		do
			if used then
					-- `generate' from BYTE_CODE will log the feature name
					-- and encoded name in `used_features_log_file' from SYSTEM_I
				generate_header (buffer)

				tmp_body_id := body_id
				if Tmp_opt_byte_server.has (tmp_body_id) then
					byte_code := Tmp_opt_byte_server.disk_item (tmp_body_id)
				else
					byte_code := Byte_server.disk_item (tmp_body_id)
				end

					-- Generation of C code for an Eiffel feature written in
					-- the associated class of the current type.
				byte_context.set_byte_code (byte_code)

				if System.in_final_mode and then System.inlining_on then
					byte_code := byte_code.inlined_byte_code
				end

					-- Generation of the C routine
				byte_code.analyze
				byte_code.set_real_body_id (real_body_id)
				byte_code.generate
				byte_context.clear_all

			else
				System.removed_log_file.add (class_type, feature_name)
			end
		end

	generate_header (buffer: GENERATION_BUFFER) is
			-- Generate a header before the body of the feature
		require
			valid_buffer: buffer /= Void
		do
			buffer.putstring ("/* ")
			buffer.putstring (feature_name)
			buffer.putstring (" */%N%N")
		end

feature -- Debug purpose

	trace is
			-- Debug purpose
		local
			i: INTEGER
		do
			io.error.putstring ("feature name: ")
			io.error.putstring (feature_name)
			io.error.putchar (' ')
			rout_id_set.trace
			io.error.putstring (" {")
			io.error.putstring ("fid = ")
			io.error.putint (feature_id)
			io.error.putstring ("}");
			io.error.putstring (" {")
			io.error.putstring ("body_index = ")
			body_index.trace
			io.error.putstring ("}");
			io.error.putstring (" {")
			io.error.putstring ("written in = ")
			io.error.putstring (written_class.name)
			io.error.putstring ("}");
			io.error.putstring (" {")
			io.error.putstring ("body_id = ")
			if body_index /= Void and then Body_index_table.has (body_index) then
				body_id.trace
			else
				io.error.putint (0)
			end
			io.error.new_line
		end

feature -- Debugging

	is_debuggable: BOOLEAN is
		local
			wc: CLASS_C
		do
			if (not is_external)
				and then (not is_attribute)
				and then (not is_constant)
				and then (not is_deferred)
				and then (not is_unique)
			then
				wc := written_class
				Result := (not wc.is_basic)
					and then (not wc.is_special)
					and then (wc.has_types)
			end
		end

	debuggables: LINKED_LIST [DEBUGGABLE] is
			-- List of byte code arrays and associated
			-- information corresponding to Current
			-- FEATURE_I.
			--| The class in which the feature is
			--| written might be generic, debugable 
			--| information must thus be generated 
			--| for each possible instantiation.
		local
			type_list: TYPE_LIST
			prev_cluster: CLUSTER_I
		do
			if is_debuggable then
				prev_cluster := Inst_context.cluster
				Inst_context.set_cluster (written_class.cluster)
				!!Result.make
				from
					type_list := written_class.types
					type_list.start
				until
					type_list.after
				loop
					Result.extend (debuggable (type_list.item))
					Result.forth
					type_list.forth
				end
				Inst_context.set_cluster (prev_cluster)
			end
		end

	debuggable (class_type: CLASS_TYPE): DEBUGGABLE is
			-- Debuggable byte code, real_body_index and
			-- real_body_id of version of current feature
			-- in `class_type'
		require
			class_type /= Void
			--class_type.associated_class = written_class
		local
			du: DISPATCH_UNIT
			eu: EXECUTION_UNIT
			new_body_id: REAL_BODY_ID
			bc: BYTE_CODE
			fa: FEATURE_AS
		do
			!!Result

			-- Compute the real body index.
			!!du.make (class_type, Current)
			Dispatch_table.put (du)
				-- `put' has a side effect which
				-- `positions' last_unit `du' 
				-- should aready be present in
				-- `Dispatch_table'.
			du := Dispatch_table.last_unit
			Result.set_real_body_index (du.real_body_index)

			-- Set the class type in `Result'.
			Result.set_class_type (class_type)

			-- Compute the real body id.
			eu :=  du.execution_unit
			if eu.real_body_id.id <= System.frozen_level then
				Result.set_was_frozen
			end
			new_body_id := Execution_table.debuggable_body_id (eu.real_body_id)
			Result.set_real_body_id (new_body_id)

			-- Compute the list of breakable AST nodes
			-- (will be used when generating the byte
			-- code array). Specific to debug mode.
			fa := Body_server.disk_item (body_id)
				-- `disk_item' does not keep the object in the cache
				-- => if `find_breakable' has some side effect, it won't
				-- have any effect on the next compilation
			Context.start_lines -- Ast_context
			fa.find_breakable

			-- Compute the debuggable byte code.
			Byte_context.init (class_type)
			--Byte_context.set_class_type (class_type)

			-- Pass the instruction line generated in
			-- trhe AST context to the Byte_context.
			-- Specific to debug mode.
			Byte_context.set_instruction_line (context.instruction_line)

			bc := Byte_server.disk_item (body_id)
				-- See above for the reason why we use `disk_item' and not `item'

			Byte_context.set_debug_mode (True)

			Byte_context.set_byte_code (bc)
			Byte_array.clear
			bc.set_real_body_id (Result.real_body_id)
			bc.make_byte_code (Byte_array)
			Result.set_byte_code (Byte_array.character_array)
			Result.set_breakable_points (Byte_context.breakable_points)
			Byte_context.clear_all
			Context.clear2
		end

	real_body_id: REAL_BODY_ID is
			-- Real body id at compilation time. This id might be
			-- obsolete after supermelting this feature.
			--| In the latter case, the new real body id is kept
			--| in DEBUGGABLE objects.
		require
			valid_body_id: valid_body_id
		local
			du: DISPATCH_UNIT
			class_type: CLASS_TYPE
			old_cluster: CLUSTER_I
		do
			old_cluster := Inst_context.cluster
			Inst_context.set_cluster (written_class.cluster)
			class_type := written_class.types.first
			!! du.make (class_type, Current)
			Dispatch_table.put (du)
				-- `put' has a side effect which `positions' last_unit
				-- `du' should aready be present in `Dispatch_table'.
			du := Dispatch_table.last_unit
			Result := du.real_body_id
			Inst_context.set_cluster (old_cluster)
		end

	valid_body_id: BOOLEAN is
			-- the use of this routine as precondition for real_body_id
			-- allows the enhancement of the external functions
			-- Indeed, if an external has to be encapsulated (macro, signature)
			-- an EXECUTION_UNIT is created instead of an EXT_EXECUTION_UNIT
		do
			Result := (	(not is_external)
						and then (not is_attribute)
						and then (not is_constant)
						and then (not is_deferred)
						and then (not is_unique)
						and then written_class.has_types)
				or else
					(is_constant and is_once)
		end

feature -- Didier stuff

	compatible (other: like Current): BOOLEAN is
		do
			Result := false
			-- body_id are the same
			-- predecessors are the sames
			-- for each matching predecessors,
			-- body id are the same
	--		io.putstring ("implement feature_i.compatible%N")
		end

feature -- Case storage informatio

	store_case_information (f: S_FEATURE_DATA) is
			-- Store relevant information into `f'.
		require
			valid_f: f /= Void
		local
			result_type: S_RESULT_DATA
			type_a: TYPE_A
			classc: CLASS_C
			gen_type_a: GEN_TYPE_A
			s_feat : S_FEATURE_DATA_R40
		do
			type_a := type.actual_type
			classc := written_class
			if not type_a.is_void then
				if type_a.has_generics then
					!! result_type.make (Void, type_a.storage_info_with_name (classc))
				else
					!! result_type.make (Void, type_a.storage_info (classc))
				end
				f.set_result_type (result_type)
			end
			if is_deferred then
				f.set_is_deferred
			elseif assert_id_set /= Void and then
				not assert_id_set.empty 
			then
					-- At the moment flag any routine
					-- with assertions chaining as
					-- effective. Having assert_id_set means
					-- that the feature has redefined or its
					-- precursor is deferred. Later on routine
					-- process_class_inherit_clause in
					-- class CASE_CLUSTER_INFO may tag
					-- the feature as redefined.
				f.set_is_effective	
			end
			if is_attribute then
				f.set_is_attribute
			end
			if arguments /= Void then
				f.set_arguments (arguments.storage_info (classc))
			end
			s_feat ?= f
			-- we know that s_feat/= VOid but ... ?
			if s_feat/= Void then
				fill_body ( s_feat )
			end
		end

	fill_body (s: S_FEATURE_DATA_R40) is
		local
			s_body: S_FEATURE_BODY
			bod1: FEATURE_AS
			bod2: BODY_AS
			bod3: ROUTINE_AS
			bod4: CONSTANT_AS	
			li_st: LINKED_LIST [STRING]	
		do
			!! li_st.make
			bod1 := body
			if bod1/= Void then
				bod2 ?= bod1.body
				if bod2/= Void then
					bod3 ?= bod2.content	
					if bod3/= Void then
						if bod3.locals/= Void and then bod3.locals.count>0 then
							li_st.extend("local")
							deal_with_loc ( bod3.locals, li_st )
						end	
						deal_with_body (bod3.routine_body, li_st)	
						if bod3.rescue_clause/= Void and then bod3.rescue_clause.count>0 then
							deal_with_rescue ( bod3.rescue_clause , li_st )
						end
					else
						bod4?= bod2.content
						if bod4/= Void then
						end		
					end	
				end			
			end
			!! s_body.make(li_st.count)
			s_body.set_text(li_st)
			s.set_body(s_body)		
		end		

	deal_with_rescue (li: EIFFEL_LIST [INSTRUCTION_AS]; li_st: LINKED_LIST [STRING] ) is
		local
			instruc: INSTRUCTION_AS
			format_c: FORMAT_CONTEXT
			ss: STRING
		do
			li_st.extend("rescue")	
			from
				li.start
			until
				li.after
			loop			
				instruc := li.item
				!! format_c.make_for_case
				format_c.set_class_c (written_class)
				instruc.simple_format(format_c)
				!!ss.make ( 20 )
				if format_c.text/= Void then
					from
						format_c.text.start
					until
						format_c.text.after
					loop
						ss.append(format_c.text.item.image)	
						format_c.text.forth
					end	
					li_st.extend(ss)
				end
				li.forth
			end
		end

	deal_with_body (rot_body: ROUT_BODY_AS; li_st: LINKED_LIST [STRING]) is
		local
			intern: INTERNAL_AS
			instruc: INSTRUCTION_AS
			format_c: FORMAT_CONTEXT
			ss: STRING	
			defer: DEFERRED_AS
			exter: EXTERNAL_AS
		do
			intern ?= rot_body
			defer ?= rot_body
			exter ?= rot_body
	
			if defer/= Void then
				-- Deferred
				-- nothing special to add 
			end
			if exter/= Void then
					-- external	
				!! format_c.make_for_case
				format_c.set_class_c (written_class)
				exter.simple_format(format_c)
				!!ss.make ( 20 )
				if format_c.text/= Void then
					from
						format_c.text.start
					until
						format_c.text.after
					loop
						ss.append(format_c.text.item.image)	
						format_c.text.forth
					end	
					li_st.extend(ss)
				end
			end
			if intern/= Void then
					-- Internal
				if intern.is_once then
					li_st.extend("Once") 
				else
					li_st.extend("Do")
				end
				if intern.compound/= Void then
					from
						intern.compound.start
					until
						intern.compound.after
					loop
						instruc := intern.compound.item
						!! format_c.make_for_case
						format_c.set_class_c (written_class)
						instruc.simple_format(format_c)
						!!ss.make ( 20 )
						if format_c.text/= Void then
							from
								format_c.text.start
							until
								format_c.text.after
							loop
								ss.append(format_c.text.item.image)	
								format_c.text.forth
							end	
						end
						li_st.extend(ss)	
						intern.compound.forth
					end
				end		
			end
		end

	deal_with_loc (loc: FIXED_LIST [TYPE_DEC_AS]; li_st: LINKED_LIST [STRING] ) is
		local
			id_list: FIXED_LIST [ ID_AS ]
			line: TYPE_DEC_AS
			st: STRING	
		do
			from
				loc.start
			until
				loc.after
			loop
				line := loc.item
				if line.id_list/= Void then
					from
						line.id_list.start
						!! st.make ( 20 )
					until
						line.id_list.after
					loop
						if st.count>0 then
							st.append(",")
						end	
						st.append(line.id_list.item)
						line.id_list.forth	
					end
					st.append(":")
					st.append(loc.item.type.dump)	
				end	
				loc.forth
				li_st.extend(st)	
			end	
		end

	case_feature_key: S_FEATURE_KEY is
			-- Case feature Key for Current
		local
			temp: STRING
		do
			!! temp.make (0)
			temp.append (feature_name)
			!! Result.make (temp, written_in.id)
		end

feature -- Inlining

	can_be_inlined: BOOLEAN is
			-- Can the feature be inlined? (no expanded, bits, once, constant
			-- or external, rescue)
		local
			type_a: TYPE_A
			byte_code: BYTE_CODE
			loc: ARRAY [TYPE_I]
			type_i: TYPE_I
			i: INTEGER
			args: FEAT_ARG
			wc: CLASS_C
		do
			byte_code := Byte_server.item (body_id)

			type_a ?= type
			Result := (type_a = Void or else not (type_a.is_expanded or else type_a.is_bits))
				and then (byte_code.rescue_clause = Void)

			if Result then
				loc := byte_code.locals
				if loc /= Void then
					from
						i := loc.count
					until
						i = 0 or else not Result
					loop
						type_i := loc.item (i)
						Result := not (type_i.is_expanded or else type_i.is_bit)
						i := i - 1
					end
				end
			end
			if Result then
				args := arguments
				if args /= Void then
					from
						i := args.count
					until
						i = 0 or else not Result
					loop
						type_a ?= args @ i
						Result := not (type_a.is_expanded or else type_a.is_bits)
						i := i - 1
					end
				end
			end
			if Result then
				wc := written_class
				Result := not (wc.is_basic or else (wc.is_special and then feature_name.is_equal ("make_area")))
			end
		end

feature -- Api creation

	api_feature (associated_class_id: CLASS_ID): E_FEATURE is
			-- API representation of Current
		require
			associated_class_id_not_void: associated_class_id /= Void
		local
			bi: BODY_INDEX
		do
			Result := new_api_feature
			Result.set_written_in (written_in)
			Result.set_associated_class_id (associated_class_id)
			bi := body_index
			if bi /= Void then
				Result.set_body_id (Body_index_table.item (bi))
			end
			Result.set_is_origin (is_origin)
			Result.set_export_status (export_status)
			Result.set_is_frozen (is_frozen)
			Result.set_is_infix (is_infix)
			Result.set_is_prefix (is_prefix)
			Result.set_rout_id_set (rout_id_set)
		end		

feature {NONE} -- Implementation

	new_api_feature: E_FEATURE is
			-- API feature creation
		deferred
		ensure
			non_void_result: Result /= Void
		end

feature -- Concurrent Eiffel

	sep_process_pattern: BOOLEAN is
			-- Process pattern of Current feature
		local
			p: PATTERN_TABLE
		do
			p := Pattern_table
			Result := p.sep_insert (generation_class_id, pattern)
			pattern_id := p.last_pattern_id
debug ("SEP_DEBUG")
if Result then
io.putstring ("* Inserted a new pattern whose id is: ")
io.putstring (" it's pattern_id.id: ")
io.putint (pattern_id.id)
io.new_line
end
end
		end

end
