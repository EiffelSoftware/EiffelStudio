indexing
	description: "Heirs are standrad value or a name.";
	date: "$Date$";
	revision: "$Revision$"

deferred class OPT_VAL_SD

inherit
	AST_LACE

feature {OPT_VAL_SD, LACE_AST_FACTORY} -- Initialization

	initialize (v: like value) is
			-- Create a new OPT_VAL AST node.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Properties

	value: ID_SD;

	is_yes: BOOLEAN is
			-- Is the option value `yes' ?
		do
			-- Do nothing
		end;

	is_no: BOOLEAN is
			-- Is the option value `no' ?
		do
			-- Do nothing
		end;

	is_all: BOOLEAN is
			-- Is the option value `all' ?
		do
			-- Do nothing
		end;

	is_require: BOOLEAN is
			-- Is the option value `require' ?
		do
			-- do nothing
		end;

	is_ensure: BOOLEAN is
			-- Is the option value `ensure' ?
		do
			-- Do nothing
		end;

	is_invariant: BOOLEAN is
			-- Is the option value `invariant' ?
		do
			-- Do nothing
		end;

	is_loop: BOOLEAN is
			-- Is the option value `loop' ?
		do
			-- Do nothing
		end;

	is_check: BOOLEAN is
			-- Is the option value `check' ?
		do
			-- Do nothing
		end;

	is_name: BOOLEAN is
			-- is the option value a name value ?
		do
			-- Do nothing
		end;

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			Result := clone (Current)
			Result.initialize (value.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then value.same_as (other.value)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Append current in `st'.
		do
			st.putstring ("(")
			value.save (st)
			st.putstring (")")
		end

end -- class OPT_VAL_SD
