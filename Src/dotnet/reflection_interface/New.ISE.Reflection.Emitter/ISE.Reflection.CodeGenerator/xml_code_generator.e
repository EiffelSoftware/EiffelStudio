indexing
	description: "Generate XML files describing types from emitter information"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_classinterfaceattribute ((create {CLASS_INTERFACE_ATTRIBUTE}).auto_dual) end

class 
	XML_CODE_GENERATOR
	
inherit	
	CODE_GENERATOR_SUPPORT
	XML_ELEMENTS
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
		do
			--create cache_handler.make_eiffelassemblycachehandler
			create cache_handler.make_cache_handler
		ensure
			non_void_cache_handler: cache_handler /= Void
		end
			
feature -- Basic Operations
	
	start_assembly_generation (an_eiffel_assembly: EIFFEL_ASSEMBLY) is
			-- | Call `StoreAssembly' on `cache_handler'.
		indexing
			description: "Start assembly generation: create folder and assembly description file and set write lock."
		require
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
			non_void_eiffel_assembly_name: an_eiffel_assembly.assembly_descriptor /= Void
		do
			type_storer := cache_handler.Store_Assembly (an_eiffel_assembly)
		ensure
			non_void_type_storer: type_storer /= Void
		end

	generate_type (an_eiffel_class: EIFFEL_CLASS) is
		indexing
			description: "Generate XML file from `eiffel_class'."
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.eiffel_name /= Void
			not_empty_eiffel_class_name: an_eiffel_class.eiffel_name.count > 0	
			non_void_assembly_descriptor: an_eiffel_class.assembly_descriptor /= Void
			non_void_full_external_name: an_eiffel_class.full_external_name /= Void
			not_empty_full_external_name: an_eiffel_class.full_external_name.count > 0
			non_void_external_name: an_eiffel_class.external_name /= Void
			not_empty_external_name: an_eiffel_class.external_name.count > 0
		do
			check
				non_void_type_storer: type_storer /= Void
				not_committed: not type_storer.committed
			end
			type_storer.add_type (an_eiffel_class, False)
		end

	end_assembly_generation is
			-- | Call `commit' on `type_storer' and set `type_storer' with `Void'.
		indexing
			description: "End assembly generation."
		do
			check
				non_void_type_storer: type_storer /= Void
				not_commmitted: not type_storer.committed
			end
			type_storer.Commit
			type_storer := Void
			cache_handler.Commit
		ensure
			void_type_storer: type_storer = Void
		end

	replace_type (an_eiffel_class: EIFFEL_CLASS) is
		indexing
			description: "Replace type corresponding to `an_eiffel_class' in assembly corresponding to `an_assembly_descriptor'."
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.eiffel_name /= Void
			not_empty_eiffel_class_name: an_eiffel_class.eiffel_name.count > 0	
			non_void_assembly_descriptor: an_eiffel_class.assembly_descriptor /= Void
			non_void_full_external_name: an_eiffel_class.full_external_name /= Void
			not_empty_full_external_name: an_eiffel_class.full_external_name.count > 0
			non_void_external_name: an_eiffel_class.external_name /= Void
			not_empty_external_name: an_eiffel_class.external_name.count  > 0		
		do
			type_storer := cache_handler.type_storer_from_class (an_eiffel_class)
			type_storer.add_type (an_eiffel_class, True)
			type_storer.commit
			type_storer := Void
		ensure
			void_type_storer: type_storer = Void
		end
		
feature {NONE} -- Implementation

	cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER
		indexing
			description: "Eiffel assembly cache handler"
		end

	type_storer: TYPE_STORER 
		indexing
			description: "Type storer"
		end
		
end -- class XML_CODE_GENERATOR
