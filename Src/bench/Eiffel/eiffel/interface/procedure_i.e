deferred class PROCEDURE_I 

inherit
		
	FEATURE_I
		rename
			transfer_to as basic_transfer_to
		redefine
			duplicate,
			has_postcondition, has_precondition, is_ensure_then,
			is_require_else, is_procedure, argument_names, arguments,
			obsolete_message, assert_id_set, set_assert_id_set,
			check_local_names
		end;
	FEATURE_I
		redefine
			transfer_to, duplicate,
			has_postcondition, has_precondition, is_ensure_then,
			is_require_else, is_procedure, argument_names, arguments,
			obsolete_message, assert_id_set, set_assert_id_set,
			check_local_names
		select
			transfer_to
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
			Result := twin;
			if arguments /= Void then
				Result.set_arguments (arguments.twin);
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
			basic_transfer_to (other);
			other.set_arguments (arguments);
			other.set_is_require_else (is_require_else);
			other.set_is_ensure_then (is_ensure_then);
			other.set_obsolete_message (obsolete_message);
			other.set_has_precondition (has_precondition);
			other.set_has_postcondition (has_postcondition);
		end;

	check_local_names is
			-- Check the conflicts between local names and feature names
			-- for an unchanged feature
		local
			body: FEATURE_AS;
		do
			body := Body_server.item (body_id);
			body.check_local_names;
		end;

end
