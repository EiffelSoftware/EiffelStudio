-- Lace controller

class LACE_I

inherit

	EXCEPTIONS;
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_LACE_PARSER

feature

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

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s
		end;

	recompile is
			-- Recompile ACE description
		require
			file_name_exists: file_name /= Void;
		local
			new_date: like date;
			ptr: ANY;
		do
			ptr := file_name.to_c;
			new_date := eif_date ($ptr);
			if new_date /= date then
				do_recompilation;
				date := new_date;
			elseif Universe.cluster_changed then
					-- Class file has been removed or added
				build_universe;
			end;
		end;

	root_ast: ACE_SD;
			-- Root of last parsed ACE

	do_recompilation is
			-- Recompile ACE description
		do
				-- Lace parsing
			root_ast := Void;
			Parser.parse_file (file_name);
			root_ast ?= Parser.ast;
			build_universe;
		rescue
			if exception = Programmer_exception then
					-- Reset `Workbench'
				successfull := False;
			end
		end;

	build_universe is
			-- Build the universe using the AST
		local
			precomp_r: PRECOMP_R;
			old_system: SYSTEM_I;
			precomp_project_name: STRING;
		do
			if root_ast /= Void then
				if not_first_parsing = False then
					precomp_project_name := root_ast.precomp_project_name;
					if precomp_project_name /= Void then
						!!precomp_r;
						precomp_r.retrieve_precompiled (precomp_project_name);
					else
						System.make;
					end;
				end;
				not_first_parsing := True;

				old_universe := Universe.twin;
				old_system := System.twin;

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
			if exception = Programmer_exception then
					-- Reset `Workbench'
				if old_system /= Void then
					Universe.copy (old_universe);
					System.copy (old_system);
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

feature {NONE} -- Externals

	eif_date (s: ANY): INTEGER is
			-- Time stamp primitive
		external
			"C"
		end;

end
