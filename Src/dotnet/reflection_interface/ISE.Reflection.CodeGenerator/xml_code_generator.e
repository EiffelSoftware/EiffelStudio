indexing
	description: "Generate XML files describing types from emitter information"
	external_name: "ISE.Reflection.XmlCodeGenerator"

class 
	XML_CODE_GENERATOR
	
inherit		
	ISE_REFLECTION_XMLELEMENTS
		export
			{NONE} all
		end
		
create 
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
			-- | Initialize `cache_handler'.
		indexing
			external_name: "Make"
		do
			create cache_handler.make_eiffelassemblycachehandler
			cache_handler.Make
		ensure
			non_void_cache_handler: cache_handler /= Void
		end
			
feature -- Basic Operations
	
	start_assembly_generation (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
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
			type_storer.AddType (an_eiffel_class)
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