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

	eiffel_feature: ISE_REFLECTION_EIFFELFEATURE
		indexing
			description: "Eiffel feature (Result of `has_feature')"
			external_name: "EiffelFeature"
		end
		
feature -- Status Report

	exists (a_class: ISE_REFLECTION_EIFFELCLASS; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does a feature with `a_feature_name' exist in `eiffel_class'?"
			external_name: "Exists"
		require
			non_void_class: a_class /= Void
			non_void_feature_name: a_feature_name /= Void
		do
			Result := has_feature (a_class.initializationfeatures, a_feature_name)
					or has_feature (a_class.accessfeatures, a_feature_name)
					or has_feature (a_class.elementchangefeatures, a_feature_name)
					or has_feature (a_class.basicoperations, a_feature_name)
					or has_feature (a_class.unaryoperatorsfeatures, a_feature_name)
					or has_feature (a_class.binaryoperatorsfeatures, a_feature_name)
					or has_feature (a_class.specialfeatures, a_feature_name)
					or has_feature (a_class.implementationfeatures, a_feature_name)
		end

feature {NONE} -- Implementation

	has_feature (a_list: SYSTEM_COLLECTIONS_ARRAYLIST; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does `a_list' contain feature with name `a_feature_name'?"
			external_name: "HasFeature"
		require
			non_void_list: a_list /= Void
			non_void_feature_name: a_feature_name /= Void
		local
			i: INTEGER
			a_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			from
			until
				i = a_list.count or Result
			loop
				a_feature ?= a_list.item (i)
				if a_feature /= Void and then a_feature.eiffelname.tolower.equals_string (a_feature_name.tolower) then
					eiffel_feature := a_feature
					Result := True
				end
				i := i + 1
			end
		end

end -- class SUPPORT
