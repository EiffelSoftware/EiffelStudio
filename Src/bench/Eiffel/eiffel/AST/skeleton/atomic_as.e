indexing
	description:"Atomic node: strings, integers, reals etc. %
				%Version for Bench version."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATOMIC_AS

inherit
	EXPR_AS

	SHARED_TYPES

feature -- Properties

	is_unique: BOOLEAN is
			-- Is the terminal a unique constant ?
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

feature {COMPILER_EXPORTER} -- Multi-branch instruction processing

	is_valid_inspect_value (value_type: TYPE_A): BOOLEAN is
			-- Is the atomic a good bound for multi-branch of the given `value_type'?
		require
			value_type_not_void: value_type /= Void
		do
			-- Do nothing
		end

	inspect_value (value_type: TYPE_A): INTERVAL_VAL_B is
			-- Inspect value of the given `value_type'
		require
			value_type_not_void: value_type /= Void
			is_valid_inspect_value: is_valid_inspect_value (value_type)
		do
			-- Do nothing
		ensure
			result_not_void: Result /= Void
		end

	unique_constant: CONSTANT_I is
			-- Associated unique constant (if any)
		do
			-- Do nothing
		ensure
			result_is_unique: Result /= Void implies Result.is_unique
		end

feature -- Output

	string_value: STRING is
		deferred
		end;

feature {COMPILER_EXPORTER, INTERVAL_AS} -- Dead code removal

	record_dependances is
			-- Record the dependances
		do
		end

end -- class ATOMIC_AS
