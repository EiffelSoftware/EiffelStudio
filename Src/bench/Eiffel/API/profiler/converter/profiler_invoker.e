indexing

	description:
		"Invokes the profiler for the steps between the %
		% system's run and the real convertion of the %
		% output file.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILER_INVOKER

inherit
	SHARED_EIFFEL_PROJECT;
	SHARED_EXEC_ENVIRONMENT;
	PROJECT_CONTEXT

create
	make

feature -- Initialization

	make (p: STRING; a: STRING; f: STRING; m: STRING) is
			-- The used profiler is `p'.
			-- The application must be invoked with 'a'.
			-- The output should be written into `f'.
			-- Application was compiled in mode `m'.
		require
			m_is_valid: m.is_equal ("workbench") or else m.is_equal ("final")
		do
			profiler_type := p;
			profiler_type.to_lower;
			arguments := a;
			output_file := f;
			compile_type := m;
		end;

feature -- Status report

	must_invoke_profiler: BOOLEAN is
			-- Must the profiler be invoked in order to convert its
			-- output?
		do
			if profiler_type.is_equal ("gprof") or else
			   profiler_type.is_equal ("win32_ms") then
				Result := true;
			end;
		end;

feature -- Execution

	invoke_profiler is
			-- Invoke the profiler, depends on which profiler is
			-- used.
		require
			must_invoke_profiler: must_invoke_profiler
		do
			if profiler_type.is_equal ("gprof") then
				invoke_gprof;
			elseif profiler_type.is_equal ("win32_ms") then
				invoke_win32_ms;
			end;
		end;

feature {NONE} -- Attributes

	profiler_type: STRING
		-- The profiler used.

	arguments: STRING
		-- The arguments for the application.

	output_file: STRING
		-- Filename of the file where the profiler's output should
		-- be written into.

	compile_type: STRING
		-- Type of compilation used to generate the application.
		-- Can be `workbench' or `final'.

feature {NONE} -- Implementation

	invoke_gprof is
			-- Invokes gprof in order to generate the text file.
		local
			exec_string: STRING;
			old_dir: STRING;
			cm_bool: BOOLEAN;
			app_name: STRING
		do
			if compile_type.is_equal ("workbench") then
				cm_bool := true;
			end;
			exec_string := "gprof -b ";
			app_name := Eiffel_system.application_name (cm_bool);
			if app_name /= Void then
				exec_string.append (Eiffel_system.application_name (cm_bool));
				exec_string.append (" > ");
				exec_string.append (output_file);
				old_dir := Execution_environment.current_working_directory;
				if cm_bool then
					Execution_environment.change_working_directory (Workbench_generation_path);
				else
					Execution_environment.change_working_directory (Final_generation_path);
				end;
				Execution_environment.system (exec_string);
				Execution_environment.change_working_directory (old_dir)
			end;
		end;

	invoke_win32_ms is
			-- Invokes the profiler from Microsoft in order to
			-- generate the text file.
		local
			exec_string: STRING;
			old_dir: STRING;
			cm_bool: BOOLEAN;
			app_name: STRING
		do
			if compile_type.is_equal ("workbench") then
				cm_bool := true;
			end;
			old_dir := Execution_environment.current_working_directory;
			if cm_bool then
				Execution_environment.change_working_directory (Workbench_generation_path);
			else
				Execution_environment.change_working_directory (Final_generation_path);
			end;
			app_name := Eiffel_system.application_name (cm_bool);
			if app_name /= Void then
				exec_string := "prep /nologo /om /ft ";
				exec_string.append (app_name);
				Execution_environment.system (exec_string);
				exec_string := "profile /nologo ";
				exec_string.append (app_name);
				exec_string.extend (' ');
				exec_string.append (arguments);
				Execution_environment.system (exec_string);
				exec_string := "prep /nologo /m ";
				exec_string.append (app_name);
				Execution_environment.system (exec_string);
				exec_string := "plist /nologo ";
				exec_string.append (app_name);
				exec_string.append (" > ");
				exec_string.append (output_file);
				Execution_environment.system (exec_string);
				Execution_environment.change_working_directory (old_dir);
			end;
		end;

end -- class PROFILER_INVOKER
