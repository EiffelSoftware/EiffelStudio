class SHARED_CODE_FILES

inherit

	PROJECT_CONTEXT
	
feature {NONE}

	size_file (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the type sizes are generated
			--! This is not a once function since
			--! we want different postfix for the
			--! file name
		local
			file_name: STRING;
		do
			if final_mode then
				file_name := build_path (Final_generation_path, Esize);
				file_name.append (Dot_x);
			else
				file_name := build_path (Workbench_generation_path, Esize);
				file_name.append (Dot_c);
			end;
			!!Result.make (file_name);
		end;

	History_file: INDENT_FILE is
			-- File containing history tables
		once
			!!Result.make (final_file_name (Ehisto));
		end;

	Reference_file: INDENT_FILE is
			-- File where the table of number of redeferences is generated
		once
			!!Result.make (final_file_name (Eref));
		end;

	Skeleton_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the skeletons correponding to the
			-- Eiffel class types are generated
		do
			!!Result.make (gen_file_name (final_mode, Eskelet));
		end;

	Cecil_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the datas for visible classes are generated
		do
			!!Result.make (gen_file_name (final_mode, Evisib));
		end;

	Conformance_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the conformance tables are generated.
		do
			!!Result.make (gen_file_name (final_mode, Econform));
		end;

	Plug_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File miscellenaeous datas are generated for the run-time
		do
			!!Result.make (gen_file_name (final_mode, Eplug));
		end;

	Pattern_file: INDENT_FILE is
			-- File where all the pattern for the workbench mode
			-- are generated
		once
			!!Result.make (workbench_file_name (Epattern));
		end;

	Option_file: INDENT_FILE is
			-- File where the compilation option are generated
		once
			!!Result.make (workbench_file_name (Eoption));
		end;

	Rout_info_file: INDENT_FILE is
			-- File where the compilation option are generated
		once
			!!Result.make (workbench_file_name (Ecall));
		end;

	Init_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the C routine `c_main' is generated
		do
			!!Result.make (gen_file_name (final_mode, Einit));
		end;

	Main_f (final_mode: BOOLEAN): INDENT_FILE is
			-- File where the C routine `c_main' is generated
		do
			!!Result.make (gen_file_name (final_mode, Emain));
		end;

	Dispatch_file: INDENT_FILE is
			-- File where the dispatch table `dispatch' is generated
		once
			!!Result.make (workbench_file_name (Edispatch));
		end;

	Frozen_file: INDENT_FILE is
			-- File where the frozen routines array `frozen' is generated
		once
			!!Result.make (workbench_file_name (Efrozen));
		end;

	Make_f (final_mode: BOOLEAN): INDENT_FILE is
			-- Makefile for C compilation
		local
			p: STRING
		do
			if final_mode then
				p := Final_generation_path
			else
				p := Workbench_generation_path
			end;
			!!Result.make (build_path (p, Makefile_SH));
		end;

	Update_file: RAW_FILE is
			-- File containing all the byte code to update
		once
			!!Result.make (build_path (Workbench_generation_path, Updt));
		end

feature {NONE}

	final_file_name (base_name: STRING): STRING is
		do
			Result := build_path (Final_generation_path, base_name);
			Result.append (Dot_c);
		end;

	workbench_file_name (base_name: STRING): STRING is
		do
			Result := build_path (Workbench_generation_path, base_name);
			Result.append (Dot_c);
		end;

	gen_file_name (final_mode: BOOLEAN; base_name: STRING): STRING is
		do
			if final_mode then
				Result := final_file_name (base_name)
			else
				Result := workbench_file_name (base_name)
			end;
		end;

end
