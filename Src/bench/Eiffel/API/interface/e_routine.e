indexing

	description: 
		"Representation of an eiffel routine.";
	date: "$Date$";
	revision: "$Revision $"

class E_ROUTINE

inherit

	E_FEATURE
		redefine
			has_postcondition, has_precondition,
			argument_names, arguments, is_once,
			is_deferred, locals, obsolete_message,
			is_external
		end

feature -- Properties

	arguments: E_FEATURE_ARGUMENTS;
			-- Arguments type

	has_precondition: BOOLEAN;
			-- Is the routine declaring some precondition ?
	
	has_postcondition: BOOLEAN;
			-- Is the routine declaring some postcondition ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_deferred: BOOLEAN;
			-- Is the routine deferred?

	is_once: BOOLEAN;
			-- Is the routine declared as a once?

	is_external: BOOLEAN;
			-- Is the routine declared as a once?

feature -- Access

	argument_names: LIST [STRING] is
			-- Argument names
		do
			Result := arguments.argument_names;
		end;

	locals: EIFFEL_LIST [TYPE_DEC_AS] is
		local
			routine_as: ROUTINE_AS
		do
			routine_as ?= Body_server.item (body_index).body.content;
			if routine_as /= Void then
				Result := routine_as.locals
			end;
		end;

feature {FEATURE_I} -- Setting

	set_deferred (b: like is_deferred) is
			-- Set `is_deferred' to `b'.
		do
			is_deferred := b;
		end;

	set_once (b: like is_once) is
			-- Set `is_once' to `b'.
		do
			is_once := b;
		end;

	set_external (b: like is_external) is
			-- Set `is_external' to `b'.
		do
			is_external := b
		end;

	set_arguments (args: like arguments) is
			-- Assign `args' to `arguments'.
		do
			arguments := args;
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

end -- class E_ROUTINE
