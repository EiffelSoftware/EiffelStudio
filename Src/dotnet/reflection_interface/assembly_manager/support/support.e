indexing
	description: "ISE Assembly manager support"
	external_name: "ISE.AssemblyManager.Support"

class
	SUPPORT

feature -- Access

	dependancies_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME] is
		indexing
			description: "Dependancies of the assembly corresponding to `a_descriptor'"
			external_name: "DependanciesFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			retried: BOOLEAN
		do
			if not retried then
				create conversion_support.make_conversionsupport
				assembly_name := conversion_support.assemblynamefromdescriptor (a_descriptor)
				an_assembly := an_assembly.load (assembly_name)
				Result := an_assembly.GetReferencedAssemblies
			else
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	dependancies_string (dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]): STRING is
		indexing
			description: "String from `dependancies'"
			external_name: "DependanciesString"
		require
			non_void_dependancies: dependancies /= Void
			not_empty_dependancies: dependancies.count > 0
		local
			dependancies_list: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME		
			added: INTEGER
			a_name: STRING
		do
			create dependancies_list.make
			from
				i := 0
			until
				i = dependancies.count
			loop
				a_dependancy := dependancies.item (i)
				added := dependancies_list.add (a_dependancy.name)
				i := i + 1
			end
			dependancies_list.sort
			
			create Result.make_2 ('%U', 0)
			from
				i := 0
			until
				i = dependancies_list.Count
			loop
				a_name ?= dependancies_list.item (i)
				Result := Result.Concat_String_String (Result, a_name)
				if i < dependancies_list.Count - 1 then
					Result := Result.Concat_String_String (Result, ", ")
				end
				i := i + 1
			end		
		ensure
			string_created: Result /= Void
		end
		
end -- class SUPPORT
