indexing
	description: "Task used for compiling IDL file from Eiffel class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date"
	revision: "$revision"

class
	WIZARD_IDL_COMPILATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

feature -- Access

	title: STRING is
			-- Task title
		do
			if not environment.is_new_component or not environment.marshaller_generated then
				Result := "Compiling IDL:"
			else
				Result := "Compiling IDL and marshaller DLL"
			end
		end

	steps_count: INTEGER is
			-- Number of steps involved in task
		do
			if not environment.is_new_component or not environment.marshaller_generated then
				Result := 1
			else
				Result := 6
			end
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
		do
			compiler.compile_idl
			progress_report.step

			-- Create Proxy/Stub
			if environment.is_new_component and environment.marshaller_generated and not environment.abort then
				compiler.compile_iid
				if not environment.abort then
					progress_report.step
					compiler.compile_data
				end
				if not environment.abort then
					progress_report.step
					compiler.compile_ps
				end
				if not environment.abort then
					progress_report.step
					compiler.link
				end
				if not environment.abort then
					progress_report.step
					compiler.register_ps
				end
				if not environment.abort then
					progress_report.step
				end
			end
		end

	compiler: WIZARD_COMPILER is
			-- IDL/C compiler
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_IDL_COMPILATION_TASK

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
