indexing
	description: "Serialize Codedom passed as argument to be reused in tests"
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

	ECDS_SHARED_SETTINGS
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

feature {NONE} -- Implementation

	serialize (a_graph: SYSTEM_OBJECT) is
			-- Serialize object graph `a_graph'.
		require
			non_void_graph: a_graph /= Void
		local
			l_formatter: BINARY_FORMATTER
			l_stream: FILE_STREAM
		do
			create l_stream.make (serialized_tree_location, {FILE_MODE}.Create_)
			create l_formatter.make
			l_formatter.serialize (l_stream, a_graph)
			l_stream.close
		end

end -- class ECDS_CODE_COMPILER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
