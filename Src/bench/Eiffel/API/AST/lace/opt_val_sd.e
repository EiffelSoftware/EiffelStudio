-- Option_value            : Standard_value
--                         | Class_value
--                         | Name
--                         ;
-- Standard_value          : LEX_YES
--                         | LEX_NO
--                         | LEX_ALL
--                         ;
--
-- Class_value             : LEX_REQUIRE
--                         | LEX_ENSURE
--                         | LEX_INVARIANT
--                         | LEX_LOOP
--                         | LEX_CHECK
--                         ;

-- Heirs are standrad value or a name.

class OPT_VAL_SD

inherit

	AST_LACE

feature -- Attributes

	value: ID_SD;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0)
		end;

feature -- Identification

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

end
