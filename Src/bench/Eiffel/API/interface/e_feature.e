indexing
	description	: "Representation of an Eiffel feature.";
	date		: "$Date$";
	revision	: "$Revision $"

class E_FEATURE

inherit
	COMPARABLE

	SHARED_EIFFEL_PROJECT
		undefine
			is_equal
		end

	HASHABLE
		undefine
			is_equal
		end

	SHARED_SERVER
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			is_equal
		end

	PREFIX_INFIX_NAMES
		undefine
			is_equal
		end

feature -- Initialization

	make (n: like name; a: like alias_name; i: INTEGER) is
			-- Initialize feature with name `n' with
			-- identification `i'.
		require
			valid_n: n /= Void
			positive_i: i >= 0
		do
			name := n
			alias_name := a
			feature_id := i
		ensure
			name_set: name = n 
			alias_name_set: alias_name = a
			feature_id_set: feature_id = i
		end

feature -- Properties

	name: STRING;
			-- Final name of the feature

	alias_name: STRING
			-- Alias name of the feature (if any)

	feature_id: INTEGER;
			-- Unique identification for a feature

	written_in: INTEGER
			-- Class id where feature is written in

	body_index: INTEGER;
			-- Identification of the body
			-- (Two features can have the same body_index if
			-- they are shared through replication)

	rout_id_set: ROUT_ID_SET;
			-- Routine table to which the feature belongs to.

	export_status: EXPORT_I;
			-- Export status of the feature

	is_origin: BOOLEAN;
			-- Is feature an origin ?

	is_frozen: BOOLEAN;
			-- Is feature frozen ?
			-- Notes from Arnaud: it has nothing to do with
			-- melted/frozen feature but refers to the keyword
			-- frozen you can add before a feature name

	is_infix: BOOLEAN;
			-- Is feature an infixed one ?

	is_prefix: BOOLEAN;
			-- Is feature a prefixed one ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_procedure: BOOLEAN is
			-- Is current feature a procedure ?
		do
			-- Do nothing
		end;

	is_function: BOOLEAN is
			-- Is current feature a function ?
		do
			-- Do nothing
		end;

	is_attribute: BOOLEAN is
			-- Is current feature an attribute ?
		do
			-- Do nothing
		end;

	is_constant: BOOLEAN is
			-- Is current feature a constant ?
		do
			-- Do nothing
		end;

	is_once: BOOLEAN is
			-- Is current feature a once one ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is current feature a deferred one ?
		do
			-- Do nothing
		end;

	is_unique: BOOLEAN is
			-- Is current feature a unique constant ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is current feature an external one ?
		do
			-- Do nothing
		end;
		
	is_il_external: BOOLEAN is
			-- Is current feature an IL external one?
		do
			-- Do nothing
		end
		

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end;

	has_precondition: BOOLEAN is
			-- Is feature declaring some preconditions ?
		do
			-- Do nothing
		end;

	has_postcondition: BOOLEAN is
			-- Is feature declaring some postconditions ?
		do
			-- Do nothing
		end;

	has_assertion: BOOLEAN is
			-- Is feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end;

	has_arguments: BOOLEAN is
 			-- Has current feature some formal arguments ?
		do
			Result := arguments /= Void
		end

	arguments: E_FEATURE_ARGUMENTS is
			-- Argument types
		do
		end;

	argument_names: LIST [STRING] is
			-- Argument names
		do
		end;

	locals: EIFFEL_LIST [TYPE_DEC_AS] is
			-- Locals for current feature
		do
		end;

	argument_count: INTEGER is
			-- Number of arguments of the feature
		do
			if arguments /= Void then
				Result := arguments.count;
			end;
		end;

	type: TYPE_A is
			-- Feature type
		do
		end;

feature -- Access

	ancestor_version (an_ancestor: CLASS_C): E_FEATURE is
			-- Feature in `an_ancestor' of which `Current' is derived.
			-- `Void' if not present in that class.
		require
			an_ancestor_not_void: an_ancestor /= Void
		local
			n, nb: INTEGER
			ris: ROUT_ID_SET
			rout_id: INTEGER
		do
			ris := rout_id_set
			from
				n := ris.lower
				nb := ris.count
			until
				n > nb or else Result /= Void
			loop
				rout_id := ris.item (n)
				if
					rout_id /= 0 and then an_ancestor.is_valid
					and then an_ancestor.has_feature_table
				then
					Result := an_ancestor.feature_with_rout_id (rout_id)
				end
				n := n + 1
			end
		end

	precursors: ARRAYED_LIST [CLASS_C] is
			-- Precursor definition of written in classes
			-- of current feature defined in `from_c'
		local
			f: FEATURE_I;
			inh_info: INH_ASSERT_INFO;
			i, nb: INTEGER;
			assert_id_set: ASSERT_ID_SET;
			e_class: CLASS_C
		do
			f := associated_feature_i;
			check
				feature_upto_date: f /= Void
			end;
			assert_id_set := f.assert_id_set;
			if assert_id_set /= Void then
				nb := assert_id_set.count;
				create Result.make (nb);
				from
					i := 1
				until
					i > nb
				loop
					inh_info := assert_id_set.item (i);
					e_class := Eiffel_system.class_of_id (inh_info.written_in);
					if e_class /= Void then
						--| On the off chance that this information
						--| is not upto date hence the check with void
						Result.extend (e_class)
					end;
					i := i + 1
				end
			end
		end;

	is_debuggable: BOOLEAN is
			-- Is feature debuggable?
		do
			Result := (body_index /= 0) and then
				(not is_external) and then
				(not is_attribute) and then
				(not is_constant) and then
				(not is_deferred) and then
				(not is_unique) and then
				written_class.is_debuggable
		ensure
			debuggable_if: Result implies
				(body_index /= 0) and then 
				(not is_external) and then
				(not is_attribute) and then
				(not is_constant) and then
				(not is_deferred) and then
				(not is_unique) and then
				written_class.is_debuggable
		end;

	text: STRUCTURED_TEXT is
			-- Text of the feature.
			-- Void if unreadable file
		local
			class_text: STRING;
			start_position, end_position: INTEGER;
			body_as: FEATURE_AS;
			c: like written_class;	
		do
			c := written_class;
			class_text := c.text;
			if class_text /= Void then
				body_as := ast;
				start_position := body_as.start_position;
				end_position := body_as.end_position;
				create Result.make;
				Result.add_string ("-- Version from class: ");
				Result.add_classi (c.lace_class, c.name_in_upper);
				Result.add_new_line;
				Result.add_new_line;
				Result.add_indent;
				if
					class_text.count >= end_position and
					start_position < end_position
				then
					class_text := class_text.substring 
								(start_position, end_position);
					Result.add_feature (Current, class_text)
				end;
				Result.add_new_line;
			end
		end;

	associated_class: CLASS_C is
			-- Class where the feature was evaluated in
		do
			check
				valid_class: associated_class_id /= 0
			end;
			Result := Eiffel_system.class_of_id (associated_class_id);
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		require
			good_written_in: written_in /= 0;
		do
			Result := Eiffel_system.class_of_id (written_in);
		end;

	is_compiled: BOOLEAN is
			-- Has the feature been compiled?
			-- (Has been compiled if passed degree 4)
		do
			Result := body_index /= 0 or else written_class.is_true_external
		end;

	is_exported_to (client: CLASS_C): BOOLEAN is
			-- Is current feature exported to class `client' ?
		require
			good_argument: client /= Void;
			has_export_status: export_status /= Void;
		do
			Result := export_status.is_exported_to (client);
		end;

	ast: FEATURE_AS is
			-- Associated AST structure for feature
		local
			class_ast: CLASS_AS;
			bid: INTEGER
		do
			bid := body_index;
			if bid /= 0 then
					-- Server in the temporary server first to get the latest version of the AST.
				if Tmp_ast_server.has (written_in) then
					class_ast := Tmp_ast_server.item (written_in)
					Result := class_ast.feature_with_name (name)
				elseif Body_server.has (bid) then
					Result := Body_server.item (bid)
				end
			elseif Tmp_ast_server.has (written_in) then
				class_ast := Tmp_ast_server.item (written_in)
				Result := class_ast.feature_with_name (name)
			else
					-- In this case we must certainly be handling a dotnet feature and we need
					-- to create an empty AST otherwise we cannot pick and drop it.
				create Result.initialize (Void, Void, Void, 0)
			end			
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := name.hash_code
		end;

	callers (cl_class: CLASS_C; a_flag: INTEGER_8): SORTED_TWO_WAY_LIST [STRING] is
			-- Callers for feature from `associated_class'
			-- to client class `cl_class'
		require
			valid_cl_class: associated_class.clients.has (cl_class)
			valid_flags: a_flag = 0 or
				a_flag = {DEPEND_UNIT}.is_in_assignment_flag or
				a_flag = {DEPEND_UNIT}.is_in_check_flag or
				a_flag = {DEPEND_UNIT}.is_in_creation_flag or
				a_flag = {DEPEND_UNIT}.is_in_ensure_flag or
				a_flag = {DEPEND_UNIT}.is_in_invariant_flag or
				a_flag = {DEPEND_UNIT}.is_in_require_flag
		local
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			current_d, l_depend_unit: DEPEND_UNIT;
			l_found: BOOLEAN
		do
			create Result.make
			dep := Depend_server.item (cl_class.class_id)
				-- No need to set the `flags' here since we do an explicit comparison.
			create current_d.make (associated_class.class_id,associated_feature_i)
			from
				-- Loop through the features of each client
				-- of current_class.
				dep.start
			until
				dep.after
			loop
				fdep := dep.item_for_iteration
				from
					l_found := False
					fdep.start
				until
					l_found or fdep.after
				loop
					l_depend_unit := fdep.item
					l_found := l_depend_unit.same_as (current_d) and then
						l_depend_unit.internal_flags & a_flag = a_flag
					fdep.forth
				end
				if l_found then
					Result.put_front (fdep.feature_name)
				end
				dep.forth
			end
			if Result.is_empty then
				Result := Void
			else
				Result.sort
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
					and then Result.sorted
		end

	updated_version: E_FEATURE is
			-- Updated version of feature after a compilation
			-- (First it checks if the `associated_class' is valid and
			-- retrieves the feature using `name' from the
			-- `associated_class' feature table)
		local
			class_c: CLASS_C
		do
				--| We try first to get the class on which the feature was previously
				--| defined. In the case, where the class has been removed from the
				--| system, there is no `associated_class' and we should no go any
				--| further.
			class_c := associated_class
			if
				class_c /= Void and then class_c.is_valid
				and then class_c.has_feature_table
			then
				Result := class_c.feature_with_name (name)
			end
		end

	number_of_breakpoint_slots: INTEGER is
			-- Number of breakpoint slots in the feature (:::)
			-- It includes the pre/postcondition (inner & herited)
			-- and the rescue clause.
		local
			f: FEATURE_I
		do
			f := associated_feature_i
			check
				feature_upto_date: f /= Void
			end
			Result := f.number_of_breakpoint_slots
		end
		
	number_of_all_precondition_slots: INTEGER is
			-- Number of preconditions
			-- (including inherited assertions)
		local
			f: FEATURE_I
		do
			f := associated_feature_i
			check
				feature_upto_date: f /= Void
			end
			Result := f.number_of_all_precondition_slots
		end		

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := name < other.name
		end;

feature -- Output

	append_signature (st: STRUCTURED_TEXT) is
			-- Append the signature of current feature in `st'
		require
			non_void_st: st /= Void
		do
			append_full_name (st)
			append_just_signature (st)
		end
		
	append_just_signature (st: STRUCTURED_TEXT) is
			-- Append just signature of feature in `st'.
		require
			st_not_void: st /= Void
		local
			args: like arguments
			orig_type, cur_type: TYPE_A
			same: BOOLEAN
		do
			args := arguments
			if args /= Void then
				st.add_space
				st.add (Ti_l_parenthesis)
				from
					args.start
				until
					args.after
				loop
					orig_type := args.item
					st.add_local (args.argument_names.i_th (args.index))
					same := True
					from args.forth until not same or else args.after loop
						cur_type := args.item
						if cur_type.same_type (orig_type) and then cur_type.is_equivalent (orig_type) then
							st.add (Ti_comma)
							st.add_space
							st.add_local (args.argument_names.i_th (args.index))
							args.forth
						else
							same := False
						end
					end
					st.add (Ti_colon)
					st.add_space
					orig_type.ext_append_to (st, Current)
					if not args.after then
						st.add (Ti_semi_colon)
						st.add_space
					end
				end
				st.add (Ti_r_parenthesis)
			end
			if not is_procedure then
				st.add (Ti_colon)
				st.add_space
				type.ext_append_to (st, Current)
			end			
		end
		

	append_name (st: STRUCTURED_TEXT) is
			-- Append the name of the feature in `st'
		require
			valid_st: st /= Void
		local
			l_name: STRING
		do
			l_name := name.as_lower
			if is_once or else is_constant then
				l_name.put ((l_name @ 1).upper, 1)
			end
			st.add_feature (Current, l_name)
		end

	append_full_name (st: STRUCTURED_TEXT) is
			-- Append name of the feature in `st' in its complete form
			-- (with infix and prefix keywords and alias names if any).
		require
			valid_st: st /= Void
		local
			ot: OPERATOR_TEXT
			a: like alias_name
		do
			if is_infix then
				st.add (Ti_infix_keyword)
				create ot.make (Current, extract_symbol_from_infix (name))
			elseif is_prefix then
				st.add (Ti_prefix_keyword)
				create ot.make (Current, extract_symbol_from_prefix (name))
			else
				append_name (st)
				a := alias_name
				if a /= Void then
					st.add_space
					st.add (Ti_alias_keyword)
					st.add_space
					create ot.make (Current, extract_alias_name (a))
				end
			end
			if ot /= Void then
				st.add_space
				st.add (Ti_double_quote)
				st.add (ot)
				st.add (Ti_double_quote)
			end
		end

feature -- Output

	feature_signature: STRING is
			-- Signature of Current feature
		do
			create Result.make (50)
			Result.append (name)
			append_arguments_to (Result)
		end

	append_arguments_to (s: STRING) is
			-- Append arguments to `s'.
		require
			s_not_void: s /= Void
		local
			args: like arguments
		do
			args := arguments
			if args /= Void then
				s.append (" (")
				from
					args.start
				until
					args.after
				loop
					s.append (args.argument_names.i_th (args.index))
					s.append (": ")
					s.append (args.item.dump)
					args.forth
					if not args.after then
						s.append ("; ")
					end
				end
				s.append (")")
			end
		end

	valid_body_index: BOOLEAN is
			-- The use of this routine as precondition for real_body_id
			-- allows the enhancement of the external functions
			-- Indeed, if an external has to be encapsulated (macro, signature)
			-- an EXECUTION_UNIT is created instead of an EXT_EXECUTION_UNIT
		do
			Result := ( (not is_external)
						and then (not is_attribute)
						and then (not is_constant)
						and then (not is_deferred)
						and then (not is_unique)
						and then written_class.has_types)
				or else
					(is_constant and is_once);
		end;

feature -- Implementation

	real_body_id: INTEGER is
			-- Real body id at compilation time.
		require
			valid_body_index: valid_body_index
		local
			f: FEATURE_I
		do
			f := associated_feature_i;
			check
				feature_upto_date: f /= Void
			end;
			Result := f.real_body_id;
		end;

feature {NONE} -- Implementation

	associated_class_id: INTEGER
            -- Class id where the feature was evaluated in

feature {COMPILER_EXPORTER} -- Implementation

	associated_feature_i: FEATURE_I is
			-- Assocated feature_i
		do
			Result := associated_class.feature_named (name)
		end;

feature {FEATURE_I} -- Setting

	set_written_in (i: INTEGER) is
			-- Set `written_in' to `i'.
		do
			written_in := i;
		end;

	set_associated_class_id (i: INTEGER) is
			-- Set `associated_class_id' to `i'.
		do
			associated_class_id := i
		end;

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_is_origin (b: BOOLEAN) is
			-- Assign `b' to `is_origin'.
		do
			is_origin := b;
		end;

	set_export_status (e: EXPORT_I) is
			-- Assign `e' to `export_status'.
		do
			export_status := e;
		end;

	set_is_frozen (b: BOOLEAN) is
			-- Assign `b' to `is_frozen'.
		do
			is_frozen := b;
		end;

	set_is_infix (b: BOOLEAN) is
			-- Assign `b' to `is_infix'.
		do
			is_infix := b;
		end;

	set_is_prefix (b: BOOLEAN) is
			-- Assign `b' to `is_prefix'.
		do
			is_prefix := b;
		end;

	set_rout_id_set (set: like rout_id_set) is
			-- Assign `set' to `rout_id_set'.
		do
			rout_id_set := set;
		end;

end -- class E_FEATURE
