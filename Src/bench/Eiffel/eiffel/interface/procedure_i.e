deferred class PROCEDURE_I 

inherit
	FEATURE_I
		redefine
			transfer_to, duplicate,
			has_postcondition, has_precondition, is_ensure_then,
			is_require_else, is_procedure, argument_names, arguments,
			obsolete_message, assert_id_set, set_assert_id_set,
			check_local_names, duplicate_arguments
		end
	
feature 

	arguments: FEAT_ARG;
			-- Arguments type

	is_require_else: BOOLEAN;
			-- Is the preconditon block of the procedure preceeded by
			-- `require else' ?

	is_ensure_then: BOOLEAN;
			-- Is the postcondition block of the feature preceeded by
			-- `ensure then' ?

	has_precondition: BOOLEAN;
			-- Is the procedure declaring some precondition ?
	
	has_postcondition: BOOLEAN;
			-- Is the procedure declaring some postcondition ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	assert_id_set: ASSERT_ID_SET;
			-- Assertions to which the procedure belongs to 

	set_assert_id_set (set: like assert_id_set) is
			-- Assign `set' to assert_id_set.
		do
			assert_id_set := set
		end;

	set_arguments (args: like arguments) is
			-- Assign `args' to `arguments'.
		do
			arguments := args;
		end;

	set_is_require_else (b: BOOLEAN) is
			-- Assign `b' to `is_require_else'.
		do
			is_require_else := b;
		end;

	set_is_ensure_then (b: BOOLEAN) is
			-- Assign `b' to `is_ensure_then'.
		do
			is_ensure_then := b;
		end;

	set_has_precondition (b: BOOLEAN) is
			-- Assign `b' to `has_precondition'.
		do
			has_precondition := b;
		end;

	set_has_postcondition (b: BOOLEAN) is
			-- Assign `b' to `has_postcondition'.
		do
			has_postcondition := b;
		end;

	set_obsolete_message (s: STRING) is
			-- Assign `s' to `obsolete_message'
		do
			obsolete_message := s;
		end;

	argument_names: EIFFEL_LIST [ID_AS] is
			-- Argument names
		do
			Result := arguments.argument_names;
		end;

	duplicate_arguments is
			-- Do a clone of the arguments (for replication)
		do
			if arguments /= Void then
				arguments := clone (arguments)
			end;
		end;

	init_assertion_flags (content: ROUTINE_AS) is
			-- Initialize assertion flags with `content'.
		require
			good_argument: content /= Void;
		do
			is_require_else := content.is_require_else;
			is_ensure_then := content.is_ensure_then;
			has_precondition := content.has_precondition;
			has_postcondition := content.has_postcondition;
		end;

	duplicate: like Current is
			-- Duplicate feature
		do
			Result := clone (Current);
			if arguments /= Void then
				Result.set_arguments (clone (arguments));
			end;
			if type /= Void then
				Result.set_type (clone (type));
			end;
		end;

	init_arg (argument_as: EIFFEL_LIST [TYPE_DEC_AS]) is
			-- Initialization of arguments.
		require
			good_argument: argument_as /= Void;
		local
			i, j, count, dec_count, nb_arg: INTEGER;
			arg_type: TYPE;
			arg_dec: TYPE_DEC_AS;
			id_list: EIFFEL_LIST [ID_AS];
		do
				-- Calculate the number of arguments.
			from
				i := 1;
				count := argument_as.count;
			until
				i > count
			loop
				nb_arg := nb_arg + argument_as.i_th (i).id_list.count;
				i := i + 1;
			end;
				-- Creation of data structures
			!!arguments.make (nb_arg);
				-- Fill the data structures
			nb_arg := 1;
			from
				i := 1;
			until
				i > count
			loop
				arg_dec := argument_as.i_th (i);
				from
					j := 1;
					id_list := arg_dec.id_list;
					arg_type := arg_dec.type;
					dec_count := id_list.count;
				until
					j > dec_count
				loop
					arguments.put_name (id_list.i_th (j), nb_arg);
					arguments.put_i_th (arg_type, nb_arg);
					nb_arg := nb_arg + 1;
					j := j + 1;
				end;
				i := i + 1
			end;
		end;

	is_procedure: BOOLEAN is True;

	transfer_to (other: PROCEDURE_I) is
			-- Transfer datas form `other' into Current.
		do
			{FEATURE_I} Precursor (other);
			other.set_arguments (arguments);
			other.set_is_require_else (is_require_else);
			other.set_is_ensure_then (is_ensure_then);
			other.set_obsolete_message (obsolete_message);
			other.set_has_precondition (has_precondition);
			other.set_has_postcondition (has_postcondition);
			other.set_assert_id_set (assert_id_set);
		end;

	check_local_names is
			-- Check the conflicts between local names and feature names
			-- for an unchanged feature
		do
			if not is_replicated then	
				Body_server.item (body_index).check_local_names;
			end;
		end;

-- Note: `require else' can be used even if the feature has no
-- precursor. There is no problem to raise an error in the normal case,
-- the only case  where we cannot do anything is when aliases are used
-- and one name references a feature with a predecessor and not the
-- other one

--	check_assertions is
--		local
--			fas: FEATURE_AS;
--			body: BODY_AS;
--			ras: ROUTINE_AS;
--			precondition: REQUIRE_AS;
--			postcondition: ENSURE_AS;
--			ve05: VE05;
--		do
--			if is_origin then
--				fas := Body_server.item (body_index);
--				body := fas.body;
--				ras ?= body.content;
--				if ras /= Void then
--					precondition := ras.precondition;
--					postcondition := ras.postcondition;
--					if
--						(precondition /= Void and then precondition.is_else)
--					or else
--						(postcondition /= Void and then postcondition.is_then)
--					then
--io.error.putstring ("Error VE05: require else or ensure then%NClass: ");
--io.error.putstring (System.current_class.name);
--io.error.putstring ("%NFeature: ");
--io.error.putstring (feature_name);
--io.error.new_line;
--						!!ve05;
--						ve05.set_class (System.current_class);
--						ve05.set_feature (Current);
--						Error_handler.insert_error (ve05);
--						Error_handler.checksum;
--					end;
--				end;
--			end;
--		end;

feature {NONE} -- Implementation

    new_api_feature: E_ROUTINE is
            -- API feature creation
        do
			!E_PROCEDURE! Result.make (feature_name, feature_id);
			update_api (Result)
        end;

	update_api (f: E_ROUTINE) is
			-- Update the attributes of api feature `f'.
		local
			args: like arguments;
		do
			args := arguments;
			if args /= Void then
				f.set_arguments (args.api_args);
			end;	
			f.set_has_precondition (has_precondition);
			f.set_has_postcondition (has_postcondition);
			f.set_obsolete_message (obsolete_message);
		end;

end
