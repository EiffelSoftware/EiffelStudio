indexing

	description: 
		"Description for option supported by Eiffel compiler 4";
	date: "$Date$";
	revision: "$Revision $"

deferred class OPTION_SD

inherit
	AST_LACE
		rename
			adapt as ast_adapt
		end;

feature {NONE} -- Initialization 

	set is
			-- Yacc initialization
		do
		end

feature -- Properties

	option_name: STRING is
			-- Name of the option
		deferred
		end;

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
		end;

	is_profile: BOOLEAN is
			-- Is the option a profile one ?
		do
			-- Do nothing
		end;

	is_free_option: BOOLEAN is
		do
			-- Do nothing
		end;

feature -- Free options properties

	is_valid: BOOLEAN is
		do
			Result := True;
		end;

	is_system_level: BOOLEAN is
		do
			-- Do nothing
		end;

	is_precompiled: BOOLEAN is
		do
			-- Do nothing
		end;

feature {COMPILER_EXPORTER} -- Update

	process_system_level_options (value: OPT_VAL_SD) is
		do
		end;

	adapt (	value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		deferred
		end;

	error (option_value: OPT_VAL_SD) is
		local
			vd15: VD15
		do
			!!vd15;
			vd15.set_option_name (option_name);
			if option_value /= Void then
				vd15.set_option_value (option_value.value);
			end;
			Error_handler.insert_error (vd15);
		end;

end -- class OPTION_SD
