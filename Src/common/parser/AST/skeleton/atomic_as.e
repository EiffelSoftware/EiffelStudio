indexing

	description: 
		"AST representation of a node: strings, integers, reals etc."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATOMIC_AS

inherit

	AST_EIFFEL

feature -- Properties

	is_unique: BOOLEAN is
			-- Is the terminal a unique constant ?
		do
			-- Do nothing
		end

	is_integer: BOOLEAN is
			-- Is the atomic an integer value ?
		do
			-- Do nothing
		end

	is_character: BOOLEAN is
			-- Is the atomic a character value ?
		do
			-- Do nothing
		end

	is_id: BOOLEAN is
			-- Is the atomic an id value ?
		do
			-- Do nothing
		end

feature -- Output

	string_value: STRING is
		deferred
		end

feature {COMPILER_EXPORTER, INTERVAL_AS} -- Type check and dead code removal

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			-- Do nothing
		end

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		do
			-- Do nothing
		end

	record_dependances is
			-- Record the dependances
		do
		end

end -- class ATOMIC_AS
