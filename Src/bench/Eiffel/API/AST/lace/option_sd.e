indexing
	description: "Description for option supported by Eiffel compiler 4";
	date: "$Date$";
	revision: "$Revision$"

deferred class OPTION_SD

inherit
	AST_LACE
		rename
			adapt as ast_adapt,
			adapt_defaults as ast_adatp_defaults
		end;

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

	is_namespace: BOOLEAN is
			-- Is option a namespace one?
		do
			-- False by default.
		end
		
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

	is_system_level_only: BOOLEAN is
			-- Is Current option to be used
		do
			Result := is_system_level
		end;

	is_precompiled: BOOLEAN is
		do
			-- Do nothing
		end;

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
				-- Nothing to be duplicated, so we do a basic clone.
			Result := twin
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then option_name.is_equal (other.option_name)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			st.putstring (option_name)
		end

feature {COMPILER_EXPORTER} -- Update

	process_system_level_options (value: OPT_VAL_SD) is
		do
		end;

	adapt (value: OPT_VAL_SD;
			classes: HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD])
		is
			-- If `list' is Void, adapt Current option to `classes'.
			-- Otherwise, only adapt Current option to classes whose name
			-- is in `list'.
		deferred
		end;

	adapt_defaults (value: OPT_VAL_SD;
			classes: HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD])
		is
			-- If `list' is Void, adapt Ace default Current option to `classes'.
			-- Otherwise, only adapt Current option to classes whose name
			-- is in `list'.
		do
			adapt (value, classes, list)
		end

	error (option_value: OPT_VAL_SD) is
		local
			vd15: VD15
		do
			create vd15;
			vd15.set_option_name (option_name);
			if option_value /= Void then
				vd15.set_option_value (option_value.value);
			end;
			Error_handler.insert_error (vd15);
		end;

end -- class OPTION_SD
