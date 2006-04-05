indexing
	description: "Serialize Codedom passed as argument to be reused in tests"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_CODE_COMPILER

inherit
	SYSTEM_DLL_ICODE_COMPILER

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	ECDS_DOTNET_SERIALIZER
		export
			{NONE} all
		end

create
	default_create
		
feature -- Interface

	compile_assembly_from_dom (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT): SYSTEM_DLL_COMPILER_RESULTS is
			-- Serialize `a_compile_unit'.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromDom"])
			if a_compile_unit = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["CompileAssemblyFromDom"])
			else
				serialize (a_compile_unit)
			end
			create Result.make (a_options.temp_files)
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromDom"])
		end
	
	compile_assembly_from_dom_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compile_units: NATIVE_ARRAY [SYSTEM_DLL_CODE_COMPILE_UNIT]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Serialize `a_compile_units'.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromDomBatch"])
			if a_compile_units = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["CompileAssemblyFromDomBatch"])
			else
				serialize (a_compile_units)
			end
			create Result.make (a_options.temp_files)
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromDomBatch"])
		end

	compile_assembly_from_file (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_name: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
			-- Do nothing.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromFile"])
			create Result.make (a_options.temp_files)
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromFile"])
		end

	compile_assembly_from_file_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_names: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Do nothing.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromFileBatch"])
			create Result.make (a_options.temp_files)
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromFileBatch"])
		end		

	compile_assembly_from_source (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_source: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
			-- Do nothing.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromSource"])
			create Result.make (a_options.temp_files)
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromSource"])
		end

	compile_assembly_from_source_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_sources: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Do nothing.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromSourceBatch"])
			create Result.make (a_options.temp_files)
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromSourceBatch"])
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
end -- class ECDS_CODE_COMPILER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
