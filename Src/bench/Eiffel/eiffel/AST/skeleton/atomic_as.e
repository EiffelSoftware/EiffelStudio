indexing
	description:"Atomic node: strings, integers, reals etc. %
				%Version for Bench version."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATOMIC_AS

inherit
	AST_EIFFEL
		redefine
			byte_node
		end

	SHARED_TYPES

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
feature -- Type check and dead code removal

	byte_node: EXPR_B is
		do
			-- Do nothing
		end

	value_i: VALUE_I is
		do
			-- Do nothing
		end

feature {COMPILER_EXPORTER} -- Type check and dead code removal

	make_integer: INT_VAL_B is
			-- Integer value.
		require
			good_integer
		do
			-- Do nothing
		end

	make_character: CHAR_VAL_B is
			-- Character value.
		require
			good_character
		do
			-- Do nothing
		end

feature -- Output

	string_value: STRING is
		deferred
		end;

feature -- Type check

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

feature {COMPILER_EXPORTER, INTERVAL_AS} -- Dead code removal

	record_dependances is
			-- Record the dependances
		do
		end

end -- class ATOMIC_AS
