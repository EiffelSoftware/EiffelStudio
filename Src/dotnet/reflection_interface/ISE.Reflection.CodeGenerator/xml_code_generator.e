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
			-- | Initialize `cache_handler'.
		indexing
			description: "Creation routine"
			external_name: "MakeXmlCodeGenerator"
		do
			create cache_handler.make_eiffelassemblycachehandler
			cache_handler.make_cache_handler
		ensure
			non_void_cache_handler: cache_handler /= Void
		end
			
feature -- Basic Operations
	
	start_assembly_generation (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is--FACTORY) is
			-- | Call `StoreAssembly' on `cache_handler'.
		indexing
			description: "Start assembly generation: create folder and assembly description file and set write lock."
			external_name: "StartAssemblyGeneration"
		require
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
			non_void_eiffel_assembly_name: an_eiffel_assembly.get_assembly_descriptor.get_name /= Void
			not_empty_eiffel_assembly_name: an_eiffel_assembly.get_assembly_descriptor.get_name.get_Length > 0
		do
			type_storer := cache_handler.Store_Assembly (an_eiffel_assembly)
		ensure
			non_void_type_storer: type_storer /= Void
		end

	generate_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		indexing
			description: "Generate XML file from `eiffel_class'."
			external_name: "GenerateType"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.get_Eiffel_Name /= Void
			not_empty_eiffel_class_name: an_eiffel_class.get_Eiffel_Name.get_Length > 0
		do
			check
				non_void_type_storer: type_storer /= Void
			end
			type_storer.Add_Type (an_eiffel_class, False)
		end

	end_assembly_generation is
			-- | Call `commit' on `type_storer' and set `type_storer' with `Void'.
		indexing
			description: "End assembly generation."
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
		indexing
			description: "Replace type corresponding to `an_eiffel_class' in assembly corresponding to `an_assembly_descriptor'."
			external_name: "ReplaceType"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			type_storer := cache_handler.replace_type (an_assembly_descriptor, an_eiffel_class)
			type_storer.add_type (an_eiffel_class, True)
			type_storer.commit
			type_storer := Void
		ensure
			void_type_storer: type_storer = Void
		end
		
feature {NONE} -- Implementation

	cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
		indexing
			description: "Eiffel assembly cache handler"
			external_name: "CacheHandler"
		end

	type_storer: ISE_REFLECTION_TYPESTORER 
		indexing
			description: "Type storer"
			external_name: "TypeStorer"
		end
		
end -- class XML_CODE_GENERATOR
