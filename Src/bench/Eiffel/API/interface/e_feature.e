indexing

	description: 
		"Representation of an Eiffel feature.";
	date: "$Date$";
	revision: "$Revision $"

class E_FEATURE

inherit

	COMPARABLE;
	SHARED_EIFFEL_PROJECT
		undefine
			is_equal
		end;
	HASHABLE
		undefine
			is_equal
		end;
	SHARED_SERVER
		undefine
			is_equal
		end;
	COMPILER_EXPORTER
		undefine
			is_equal
		end

feature -- Initialization

	make (n: like name; i: INTEGER) is
			-- Initialize feature with name `n' with
			-- identification `i'.
		require
			valid_n: n /= Void;
			positive_i: i >= 0
		do
			name := n;
			id := i;
		ensure
			set: name = n and then id = i
		end;

feature -- Properties

	name: STRING;
			-- Final name of the feature

	id: INTEGER;
			-- Unique identification for a feature

	written_in: CLASS_ID
			-- Class id where feature is written in

	body_id: BODY_ID;
			-- Identification of the body
			-- (Two features can have the same body_id if
			-- they are shared through replication)

	rout_id_set: ROUT_ID_SET;
			-- Routine table to which the feature belongs to.

	export_status: EXPORT_I;
			-- Export status of the feature

	is_origin: BOOLEAN;
			-- Is the feature an origin ?

	is_frozen: BOOLEAN;
			-- Is the feature frozen ?

	is_infix: BOOLEAN;
			-- Is the feature an infixed one ?

	is_prefix: BOOLEAN;
			-- Is the feature a prefixed one ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_normal: BOOLEAN is
			-- Is a normal feature?
		do
			Result := not (is_infix or else is_prefix)
		ensure
			Result = not (is_infix or else is_prefix)
		end;

	is_procedure: BOOLEAN is
			-- Is the current feature a procedure ?
		do
			-- Do nothing
		end;

	is_function: BOOLEAN is
			-- Is the cuurent feature a function ?
		do
			-- Do nothing
		end;

	is_attribute: BOOLEAN is
			-- Is the current feature an attribute ?
		do
			-- Do nothing
		end;

	is_constant: BOOLEAN is
			-- Is the current feature a constant ?
		do
			-- Do nothing
		end;

	is_once: BOOLEAN is
			-- Is the current feature a once one ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is the current feature a deferred one ?
		do
			-- Do nothing
		end;

	is_unique: BOOLEAN is
			-- Is the current feature a unique constant ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is the current feature an external one ?
		do
			-- Do nothing
		end;

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end;

	has_precondition: BOOLEAN is
			-- Is the feature declaring some preconditions ?
		do
			-- Do nothing
		end;

	has_postcondition: BOOLEAN is
			-- Is the feature declaring some postconditions ?
		do
			-- Do nothing
		end;

	has_assertion: BOOLEAN is
			-- Is the feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end;

	arguments: E_FEATURE_ARGUMENTS is
			-- Argument types
		do
		end;

	argument_names: FIXED_LIST [STRING] is
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
				!! Result.make (nb);
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
			-- Is the feature debuggable?
		do
			Result := (body_id /= Void) and then
				(not is_external) and then
				(not is_attribute) and then
				(not is_constant) and then
				(not is_deferred) and then
				(not is_unique) and then
				written_class.is_debuggable
		ensure
			debuggable_if: Result implies
				(body_id /= Void) and then 
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
				!! Result.make;
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
								(start_position + 1, end_position);
					Result.add_feature (Current, class_text)
				end;
				Result.add_new_line;
			end
		end;

	associated_class: CLASS_C is
			-- Class where the feature was evaluated in
		do
			check
				valid_class: associated_class_id /= Void
			end;
			Result := Eiffel_system.class_of_id (associated_class_id);
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		require
			good_written_in: written_in /= Void;
		do
			Result := Eiffel_system.class_of_id (written_in);
		end;

	is_compiled: BOOLEAN is
			-- Has the feature been compiled?
			-- (Has been compiled if passed degree 4)
		do
			Result := body_id /= Void
		end;

	is_exported_to (client: CLASS_C): BOOLEAN is
			-- Is the current feature exported to class `client' ?
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
			bid: BODY_ID
		do
			bid := body_id;
			if bid /= Void then
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
			end;
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := name.hash_code
		end;

	callers (cl_class: CLASS_C): SORTED_TWO_WAY_LIST [STRING] is
			-- Callers for feature from `associated_class'
			-- to client class `cl_class'
		require
			valid_cl_class: associated_class.clients.has (cl_class)
		local
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			cfeat: STRING;
			current_d: DEPEND_UNIT;
		do
			!! Result.make;
			dep := Depend_server.item (cl_class.id);
			!! current_d.make (associated_class.id, id);
			from
				-- Loop through the features of each client
				-- of current_class.
				dep.start
			until
				dep.after
			loop
				fdep := dep.item_for_iteration;
				if fdep.has (current_d) then
					cfeat := dep.key_for_iteration;
					Result.put_front (cfeat);
				end;
				dep.forth;
			end;
			if Result.empty then
				Result := Void
			else
				Result.sort
			end;
		ensure
			valid_result: Result /= Void implies not Result.empty
					and then Result.sorted
		end;

	updated_version: E_FEATURE is
			-- Updated version of feature after a compilation
			-- (First it checks if the `associated_class' is valid and
			-- retrieves the feature using `name' from the
			-- `associated_class' feature table)
		do
			if associated_class.is_valid then
				Result := associated_class.feature_with_name (name)
			end
		end;

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
		local
			args: like arguments
		do
			args := arguments;
			append_name (st);
			if args /= Void then
				st.add_string (" (");
				from
					args.start
				until
					args.after
				loop
					st.add_string (args.argument_names.i_th 
									(args.index));
					st.add_string (": ");
					args.item.append_to (st);
					args.forth;
					if not args.after then
						st.add_string ("; ")
					end
				end;
				st.add_char (')')
			end;
			if type /= Void then
				st.add_string (": ");
				type.append_to (st);
			end;
		end;

	append_name (st: STRUCTURED_TEXT) is
			-- Append the name of the feature in `st'
		require
			valid_st: st /= Void
		do
			st.add_feature (Current, name) 
		end;

	feature_signature: STRING is
			-- Signature of Current feature
		local
			args: like arguments
		do
			!!Result.make (50);
			Result.append (name);
			args := arguments;
			if args /= Void then
				Result.append (" (");
				from
					args.start
				until
					args.after
				loop
					Result.append (args.argument_names.i_th (args.index));
					Result.append (": ");
					Result.append (args.item.dump);
					args.forth;
					if not args.after then
						Result.append ("; ")
					end
				end;
				Result.append (")")
			end;
		end;

	valid_body_id: BOOLEAN is
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

    number_of_stop_points: INTEGER is
            -- Number of stop points for eiffel feature
		require
			is_debuggable: is_debuggable
		local
			feature_as: like ast
        do
			feature_as := ast;
			if feature_as /= Void then
				Result := feature_as.number_of_stop_points
			end 
        end

feature {DEBUG_INFO} -- Implementation

	real_body_id: REAL_BODY_ID is
			-- Real body id at compilation time. This id might be
			-- obsolete after supermelting this feature.
			--| In the latter case, the new real body id is kept
			--| in DEBUGGABLE objects.
		require
			valid_body_id: valid_body_id
		local
			f: FEATURE_I
		do
			f := associated_feature_i;
			check
				feature_upto_date: f /= Void
			end;
			Result := f.real_body_id;
		end;

	debuggables: LINKED_LIST [DEBUGGABLE] is
			-- List of byte code arrays and associated
			-- information corresponding to Current
			-- E_FEATURE defined in `from_c'.
			--| The class in which the feature is
			--| written might be generic, debugable
			--| information must thus be generated
			--| for each possible instantiation.
		local
			f: FEATURE_I
		do
			f := associated_feature_i;
			check
				feature_upto_date: f /= Void
			end;
			Result := f.debuggables;
		end

feature {NONE} -- Implementation

	associated_class_id: CLASS_ID
            -- Class id where the feature was evaluated in

feature {COMPILER_EXPORTER} -- Implementation

	associated_feature_i: FEATURE_I is
			-- Assocated feature_i
		do
			Result := associated_class.feature_named (name)
		end;

feature {FEATURE_I} -- Setting

	set_written_in (i: CLASS_ID) is
			-- Set `written_in' to `i'.
		do
			written_in := i;
		end;

	set_associated_class_id (i: CLASS_ID) is
			-- Set `associated_class_id' to `i'.
		do
			associated_class_id := i
		end;

	set_body_id (i: BODY_ID) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
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
