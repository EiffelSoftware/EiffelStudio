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
				date := new_date;
				do_recompilation;
			elseif Universe.cluster_changed then
					-- Class file has been removed or added
				do_recompilation;
			end;
		end;

	root_ast: ACE_SD;
			-- Root of last parsed ACE

	do_recompilation is
			-- Recompile ACE description
		local
			old_universe, new_universe: UNIVERSE_I;
			old_system, new_system: SYSTEM_I;
		do
			old_universe := Universe.twin;
			old_system := System.twin;

				-- Lace parsing
			root_ast := Void;
			Parser.parse_file (file_name);
			root_ast ?= Parser.ast;

			if root_ast /= Void then

					-- Recompilation
				root_ast.build_universe;

					-- Check presence of basic classes in the universe
				Universe.check_universe;

					-- Check sum error
				Error_handler.checksum;

				successfull := True;
			end
		rescue
			if exception = Programmer_exception then
					-- Reset `Workbench'
				Universe.copy (old_universe);
				System.copy (old_system);
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
