note

	description:
		"Invokes the profiler for the steps between the %
		% system's run and the real convertion of the %
		% output file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILER_INVOKER

inherit
	SHARED_EIFFEL_PROJECT;
	SHARED_EXECUTION_ENVIRONMENT;
	PROJECT_CONTEXT

create
	make

feature -- Initialization

	make (p: like profiler_type; a: like arguments; f: like output_file; m: like compile_type)
			-- The used profiler is `p'.
			-- The application must be invoked with 'a'.
			-- The output should be written into `f'.
			-- Application was compiled in mode `m'.
		require
			m_is_valid: m.same_string_general ("workbench") or else m.same_string_general ("final")
		do
			profiler_type := p;
			profiler_type.to_lower;
			arguments := a;
			output_file := f;
			compile_type := m;
		end;

feature -- Status report

	must_invoke_profiler: BOOLEAN
			-- Must the profiler be invoked in order to convert its
			-- output?
		do
			if profiler_type.same_string_general ("gprof") or else
			   profiler_type.same_string_general ("win32_ms") then
				Result := true;
			end;
		end;

feature -- Execution

	invoke_profiler
			-- Invoke the profiler, depends on which profiler is
			-- used.
		require
			must_invoke_profiler: must_invoke_profiler
		do
			if profiler_type.same_string_general ("gprof") then
				invoke_gprof;
			elseif profiler_type.same_string_general ("win32_ms") then
				invoke_win32_ms;
			end;
		end;

feature {NONE} -- Attributes

	profiler_type: STRING_32
		-- The profiler used.

	arguments: STRING_32
		-- The arguments for the application.

	output_file: STRING_32
		-- Filename of the file where the profiler's output should
		-- be written into.

	compile_type: STRING_32
		-- Type of compilation used to generate the application.
		-- Can be `workbench' or `final'.

feature {NONE} -- Implementation

	invoke_gprof
			-- Invokes gprof in order to generate the text file.
		local
			exec_string: STRING_32
			l_old_path, l_path: PATH
			cm_bool: BOOLEAN
		do
			cm_bool := compile_type.same_string_general ("workbench")
			exec_string := {STRING_32} "gprof -b "
			if attached Eiffel_system.application_name (cm_bool) as app_name then
				exec_string.append_string_general (app_name.name)
				exec_string.append ({STRING_32} " > ")
				exec_string.append (output_file)
				l_old_path := Execution_environment.current_working_path
				if cm_bool then
					l_path := project_location.workbench_path
				else
					l_path := project_location.final_path
				end
				Execution_environment.change_working_path (l_path)
				Execution_environment.system (exec_string)
				Execution_environment.change_working_path (l_old_path)
			end
		end

	invoke_win32_ms
			-- Invokes the profiler from Microsoft in order to
			-- generate the text file.
		local
			exec_string: STRING_32
			l_old_path, l_path: PATH
			cm_bool: BOOLEAN
		do
			cm_bool := compile_type.same_string_general ("workbench")
			if attached Eiffel_system.application_name (cm_bool) as app_name then
				l_old_path := Execution_environment.current_working_path
				if cm_bool then
					l_path := project_location.workbench_path
				else
					l_path := project_location.final_path
				end
				Execution_environment.change_working_path (l_path)
				exec_string := {STRING_32} "prep /nologo /om /ft "
				exec_string.append_string_general (app_name.name)
				Execution_environment.system (exec_string)
				exec_string := {STRING_32} "profile /nologo "
				exec_string.append_string_general (app_name.name)
				exec_string.extend (' ')
				exec_string.append (arguments)
				Execution_environment.system (exec_string)
				exec_string := {STRING_32} "prep /nologo /m "
				exec_string.append_string_general (app_name.name)
				Execution_environment.system (exec_string)
				exec_string := {STRING_32} "plist /nologo "
				exec_string.append_string_general (app_name.name)
				exec_string.append ({STRING_32} " > ")
				exec_string.append (output_file)
				Execution_environment.system (exec_string)
				Execution_environment.change_working_path (l_old_path)
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class PROFILER_INVOKER
