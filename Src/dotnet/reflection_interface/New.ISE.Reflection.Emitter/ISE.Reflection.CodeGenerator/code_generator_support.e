indexing
	description: "Support to allow convertions between dependant assemblies"

class
	CODE_GENERATOR_SUPPORT
	
feature -- convertion

	from_system_string (string: SYSTEM_STRING ) : STRING is
		indexing
			description: "Converts a SYSTEM_STRING to a STRING"
		require
			string_not_void : string /= void
		do
			Result := create {STRING}.make_from_cil ( string )
		ensure
			new_string_created : Result /= void
		end

	to_support_string (string: STRING ) : STRING is
		indexing
			description: "Converts a STRING to a ISE_REFLECTION_SUPPORT_STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		end
		
	from_support_string (string: STRING ) : STRING is
		indexing
			description: "Converts a ISE_REFLECTION_SUPPORT_STRING to a STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
		
		
	to_component_string (string: STRING ) : STRING is
		indexing
			description: "Converts a STRING to a ISE_REFLECTION_EIFFEL_COMPONENTS_STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
		
	from_component_string (string: STRING ) : STRING is
		indexing
			description: "Converts a ISE_REFLECTION_EIFFEL_COMPONENTS_STRING to a STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
		
		
	to_notifier_string (string: STRING ) : STRING is
		indexing
			description: "Converts a STRING to a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
		
	from_notifier_string (string: STRING ) : STRING is
		indexing
			description: "Converts a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING to a STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
		
		
	to_handler_string (string: STRING ) : STRING is
		indexing
			description: "Converts a STRING to a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
		
	from_handler_string (string: STRING ) : STRING is
		indexing
			description: "Converts a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING to a STRING"
		require
			string_not_void : string /= void
		do
			Result := string
		ensure
			new_string_created : Result /= void
		end
--
--
--	to_support_string (string: STRING ) : ISE_REFLECTION_SUPPORT_STRING is
--		indexing
--			description: "Converts a STRING to a ISE_REFLECTION_SUPPORT_STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_STRING}.make_from_cil ( string.to_cil )
--		end
--		
--	from_support_string (string: ISE_REFLECTION_SUPPORT_STRING ) : STRING is
--		indexing
--			description: "Converts a ISE_REFLECTION_SUPPORT_STRING to a STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
--		
--		
--	to_component_string (string: STRING ) : ISE_REFLECTION_EIFFEL_COMPONENTS_STRING is
--		indexing
--			description: "Converts a STRING to a ISE_REFLECTION_EIFFEL_COMPONENTS_STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {ISE_REFLECTION_EIFFEL_COMPONENTS_IMPLEMENTATION_STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
--		
--	from_component_string (string: ISE_REFLECTION_EIFFEL_COMPONENTS_STRING ) : STRING is
--		indexing
--			description: "Converts a ISE_REFLECTION_EIFFEL_COMPONENTS_STRING to a STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
--		
--		
--	to_notifier_string (string: STRING ) : ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING is
--		indexing
--			description: "Converts a STRING to a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_IMPLEMENTATION_STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
--		
--	from_notifier_string (string: ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING ) : STRING is
--		indexing
--			description: "Converts a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING to a STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
--		
--		
--	to_handler_string (string: STRING ) : ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING is
--		indexing
--			description: "Converts a STRING to a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_IMPLEMENTATION_STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
--		
--	from_handler_string (string: ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING ) : STRING is
--		indexing
--			description: "Converts a ISE_REFLECTION_EIFFEL_ASSEMBLY_CACHE_NOTIFIER_STRING to a STRING"
--		require
--			string_not_void : string /= void
--		do
--			Result := create {STRING}.make_from_cil ( string.to_cil )
--		ensure
--			new_string_created : Result /= void
--		end
		
end -- CODE_GENERATOR_SUPPORT
