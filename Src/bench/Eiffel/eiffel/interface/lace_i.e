-- Lace controller

class LACE_I

inherit

	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	SHARED_LACE_PARSER;
	COMPILER_EXPORTER;
	SHARED_EIFFEL_PROJECT

feature -- Access

	file_name: STRING;
			-- Path to the universe/system description

	date: INTEGER;
			-- Time stamp of file named `file_name'

	successfull: BOOLEAN;
			-- Is the last compilation successfull ?

	not_first_parsing: BOOLEAN;

	old_universe: UNIVERSE_I;
			-- Universe of the previous compilation
			-- usefull for checking  the removed clusters

    date_has_changed: BOOLEAN is
        local
            str: ANY;
            new_date: INTEGER
        do
            str := file_name.to_c;
            new_date := eif_date ($str);
            Result := new_date /= date;
        end;

feature -- Status setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
debug
	if s = Void then
		io.error.putstring ("LACE.file_name: void%N");
	else
		io.error.putstring ("LACE.file_name: ");
		io.error.putstring (s);
		io.error.new_line;
	end
end;
			file_name := s
		end;

	recompile is
			-- Recompile ACE description
		require
			file_name_exists: file_name /= Void;
		local
			new_date: like date;
			ptr: ANY;
			file: PLAIN_TEXT_FILE;
			vd22: VD22
		do
			ptr := file_name.to_c;
			!!file.make (file_name);
			if not file.exists then
				successfull := False;
				!!vd22;
				vd22.set_file_name (file_name);
				Error_handler.insert_error (vd22);
				Error_handler.raise_error
			end
			new_date := eif_date ($ptr);
			if root_ast = Void or else new_date /= date then
				do_recompilation;
				date := new_date;
			else
				build_universe;
			end;
		end;

	root_ast: ACE_SD;
			-- Root of last parsed ACE

	ace_options: ACE_OPTIONS;
			-- Options explicitly set in the ace file

	do_recompilation is
			-- Recompile ACE description
		do
				-- Lace parsing
			root_ast := Void;
			Parser.parse_file (file_name);
			root_ast ?= Parser.ast;
			build_universe;
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				successfull := False;
			end
		end;

	build_universe is
			-- Build the universe using the AST
		local
			precomp_r: PRECOMP_R;
			extendible_r: EXTENDIBLE_R;
			old_system: SYSTEM_I;
			precompiled_options: HASH_TABLE [D_PRECOMPILED_SD, STRING];
			extendible_project_name: STRING;
			sys: SYSTEM_I
		do
			if root_ast /= Void then
					-- Options explicitely set in the ace file
					--| Processing is done in `build_universe' in ACE_SD
				!! ace_options

				if not_first_parsing = False then
					precompiled_options := root_ast.precompiled_options;
					extendible_project_name := root_ast.extendible_project_name;
					if extendible_project_name /= Void then
							-- DLE: retrieve the dynamically extendible project.
						!!extendible_r;
						extendible_r.retrieve_extendible (extendible_project_name)
					elseif not precompiled_options.empty then
						!!precomp_r;
						precomp_r.retrieve_precompiled (precompiled_options);
					else
						!! sys;
						Workbench.set_system (sys)
						Eiffel_project.init_system;
						sys.make;
					end
				else
						-- This is just for validity check wrt DLE.
					extendible_project_name := root_ast.extendible_project_name
				end;
				System.set_extendible (Compilation_modes.is_extendible)
				not_first_parsing := True;

					-- When finalizing a DC-set, the DR-set must
					-- have been finalized as well.
				System.check_dle_finalize;

				old_universe := clone (Universe);
				old_system := clone (System);

				Universe.clusters.wipe_out;

					-- Recompilation
				root_ast.build_universe;

					-- Check presence of basic classes in the universe
				Universe.check_universe;

					-- Check sum error
				Error_handler.checksum;

				old_universe := Void;

				successfull := True;
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				if old_system /= Void then
					Universe.copy (old_universe);
					if System.is_dynamic then
						Universe.reset_dle_clusters
					else
						Universe.reset_clusters
					end;
					System.copy (old_system)
				end;
				old_universe := Void;
				successfull := False;
			end
		end;

	parsed: BOOLEAN is
			-- Was last parsing successful?
		do
			Result := root_ast /= Void
		end

	compile_all_classes: BOOLEAN is
			-- Is the root class NONE, i.e. all the classes must be compiled
		require
			parsed: parsed
		do
			Result := root_ast.compile_all_classes
		end;

feature -- Access

	has_assertions: BOOLEAN is
		do
			Result := ace_options.has_assertion
		end

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Time stamp primitive
		external
			"C"
		end;

end
