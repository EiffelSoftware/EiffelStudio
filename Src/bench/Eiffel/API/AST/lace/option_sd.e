-- Description for option supported by Eiffel compiler 3

class OPTION_SD

inherit

	AST_LACE

feature

	set is
			-- Yacc initialization
		do
		end

feature -- Identfication

	is_debug: BOOLEAN is
			-- Is the option a debug one ?
		do
			-- Do nothing
		end;

	is_assertion: BOOLEAN is
			-- Is the option a assertion one ?
		do
			-- Do nothing
		end;

	is_optimize: BOOLEAN is
			-- Is the option an optimize one ?
		do
			-- Do nothing
		end;

	is_trace: BOOLEAN is
			-- Is the option a trace one ?
		do
			-- Do nothing
		end

end
