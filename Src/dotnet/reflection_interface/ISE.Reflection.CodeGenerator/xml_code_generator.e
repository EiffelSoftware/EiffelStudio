indexing
	description: "Generate XML files describing types from emitter information"
	external_name: "ISE.Reflection.XmlCodeGenerator"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class 
	XML_CODE_GENERATOR
	
inherit		
	ISE_REFLECTION_XMLELEMENTS
		export
			{NONE} all
		end
		
create 
	make_xml_code_generator

feature {NONE} -- Initialization

	make_xml_code_generator is
			-- Creation routine
			-- | Initialize `cache_handler'.
		indexing
			external_name: "MakeXmlCodeGenerator"
		do
			create cache_handler.make_eiffelassemblycachehandler
			cache_handler.makecachehandler
		ensure
			non_void_cache_handler: cache_handler /= Void
		end
			
feature -- Basic Operations
	
	start_assembly_generation (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY) is
			-- Start assembly generation: create folder and assembly description file and set write lock.
			-- | Call `StoreAssembly' on `cache_handler'.
		indexing
			external_name: "StartAssemblyGeneration"
		require
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
			non_void_eiffel_assembly_name: an_eiffel_assembly.AssemblyName /= Void
			not_empty_eiffel_assembly_name: an_eiffel_assembly.AssemblyName.Length > 0
		do
			type_storer := cache_handler.StoreAssembly (an_eiffel_assembly)
		ensure
			non_void_type_storer: type_storer /= Void
		end

	generate_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
			-- Generate XML file from `eiffel_class'. 
		indexing
			external_name: "GenerateType"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.EiffelName /= Void
			not_empty_eiffel_class_name: an_eiffel_class.EiffelName.Length > 0
		do
			check
				non_void_type_storer: type_storer /= Void
			end
			type_storer.AddType (an_eiffel_class, False)
		end

	end_assembly_generation is
			-- End assembly generation.
			-- | Call `commit' on `type_storer' and set `type_storer' with `Void'.
		indexing
			external_name: "EndAssemblyGeneration"
		do
			check
				non_void_type_storer: type_storer /= Void
			end
			type_storer.Commit
			type_storer := Void
			cache_handler.Commit
		ensure
			void_type_storer: type_storer = Void
		end

	replace_type (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
			-- Replace type corresponding to `an_eiffel_class' in assembly corresponding to `an_assembly_descriptor'.
		indexing
			external_name: "ReplaceType"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			type_storer := cache_handler.replacetype (an_assembly_descriptor, an_eiffel_class)
			type_storer.addtype (an_eiffel_class, True)
			type_storer.commit
			type_storer := Void
		ensure
			void_type_storer: type_storer = Void
		end
		
feature {NONE} -- Implementation

	cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
			-- Eiffel/.NET assembly cache handler
		indexing
			external_name: "CacheHandler"
		end

	type_storer: ISE_REFLECTION_TYPESTORER 
			-- Type storer
		indexing
			external_name: "TypeStorer"
		end
		
end -- class XML_CODE_GENERATOR