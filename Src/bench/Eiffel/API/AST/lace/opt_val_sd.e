indexing

	description: 
		"Heirs are standrad value or a name.";
	date: "$Date$";
	revision: "$Revision$"

class OPT_VAL_SD

inherit

	AST_LACE

feature {LACE_AST_FACTORY} -- Initialization

	initialize (v: like value) is
			-- Create a new OPT_VAL AST node.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0)
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_value (v: like value) is
			-- Assign `v' to `value'.
		do
			value := v
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

end -- class OPT_VAL_SD
