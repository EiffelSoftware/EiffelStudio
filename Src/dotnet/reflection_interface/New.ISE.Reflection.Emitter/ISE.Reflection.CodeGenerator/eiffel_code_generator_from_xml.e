indexing
	description: "Generate Eiffel classes from Xml description files."
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_classinterfaceattribute ((create {CLASS_INTERFACE_ATTRIBUTE}).auto_dual) end

class
	EIFFEL_CODE_GENERATOR_FROM_XML

inherit
	CODE_GENERATOR_SUPPORT
		
create
	make,
	make_from_info,
	make_from_info_and_path

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end

	make_from_info (an_assembly_description_filename: like assembly_description_filename) is
		indexing
			description: "[
						Set `assembly_description_filename' with `an_assembly_description_filename'.
						Build `eiffel_assembly' from `assembly_description_filename'.
					  ]"
		require
			non_void_assembly_description_filename: an_assembly_description_filename /= Void
			not_empty_assembly_description_filename: an_assembly_description_filename.count > 0
		local
			support: CODE_GENERATION_SUPPORT
		do
			assembly_description_filename := an_assembly_description_filename
			--create support.make_codegenerationsupport
			create support.make
			eiffel_assembly := support.Eiffel_Assembly_From_Xml ( to_support_string (assembly_description_filename))
			create eiffel_code_generator.make_from_info (eiffel_assembly)
		ensure
			assembly_description_set: assembly_description_filename.is_equal (an_assembly_description_filename)
			non_void_eiffel_assembly: eiffel_assembly /= Void
			non_void_eiffel_code_generator: eiffel_code_generator /= Void
		end
	
	make_from_info_and_path (an_assembly_description_filename: like assembly_description_filename; new_path: STRING) is
		indexing
			description: "[
						Set `assembly_description_filename' with `an_assembly_description_filename'.
						Build `eiffel_assembly' from `assembly_description_filename'.
					  ]"
		require
			non_void_assembly_description_filename: an_assembly_description_filename /= Void
			not_empty_assembly_description_filename: an_assembly_description_filename.count > 0
		local
			support: CODE_GENERATION_SUPPORT
		do
			make_from_info (an_assembly_description_filename)
			update_assembly_description (new_path)
		ensure
			assembly_description_set: assembly_description_filename.is_equal (an_assembly_description_filename)
			non_void_eiffel_assembly: eiffel_assembly /= Void
			non_void_eiffel_code_generator: eiffel_code_generator /= Void
		end	
		
feature -- Access
	
	assembly_description_filename: STRING
		indexing
			description: "Path to `assembly_description.xml'"
		end
	
	eiffel_assembly: EIFFEL_ASSEMBLY
		indexing
			description: "Eiffel assembly corresponding to `assembly_description_filename'"
		end
	
	eiffel_code_generator: EIFFEL_CODE_GENERATOR
		indexing
			description: "Eiffel code generator"
		end
		
feature -- Basic Operations
	
	generate_eiffel_code_from_xml (type_description_filename: STRING) is
			-- | Call `eiffel_class_from_xml' and `generate_eiffel_class' (from `EIFFEL_CODE_GENERATOR') successively.
		indexing
			description: "Generate Eiffel file corresponding to XML file with filename `type_description_filename'."
		require
			non_void_type_description_filename: type_description_filename /= Void
			not_empty_type_description_filename: type_description_filename.count > 0
		do
			eiffel_code_generator.generate_eiffel_class (eiffel_class_from_xml (type_description_filename))
		end	

	generate_eiffel_code_from_xml_and_path (type_description_filename, a_path: STRING) is
			-- | Call `eiffel_class_from_xml' and `generate_eiffel_class' (from `EIFFEL_CODE_GENERATOR') successively.
		indexing
			description: "Generate Eiffel file corresponding to XML file with filename `type_description_filename' in folder corresponding to `a_path'."
		require
			non_void_assembly: eiffel_assembly /= Void
			non_void_type_description_filename: type_description_filename /= Void
			not_empty_type_description_filename: type_description_filename.count > 0
		do
			eiffel_code_generator.generate_eiffel_class_from_path (eiffel_class_from_xml (type_description_filename), a_path)
		end	

feature {NONE} -- Implementation

	eiffel_class_from_xml (type_description_filename: STRING): EIFFEL_CLASS is
		indexing
			description: "Eiffel class corresponding to XML file with filename `type_description_filename'"
		require
			non_void_type_description_filename: type_description_filename /= Void
			not_empty_type_description_filename: type_description_filename.count > 0
		local
			support: CODE_GENERATION_SUPPORT
			eiffel_class: EIFFEL_CLASS
			path: STRING
		do
			--create support.make_codegenerationsupport
			create support.make
			Result := support.Eiffel_Class_From_Xml ( to_support_string (type_description_filename))
		end

	update_assembly_description (new_path: STRING) is
		indexing
			description: "Update `assembly_description.xml' by replacing Eiffel cluster path by `new_path'."
		require
			non_void_new_path: new_path /= Void
			not_empty_new_path: new_path.count > 0
			non_void_eiffel_assembly: eiffel_assembly /= Void
		local
			assembly_cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER
			reflection_support: REFLECTION_SUPPORT
			path: STRING
			eiffel_delivery_path: STRING
			dotnet_library_path: STRING
		do
			--create assembly_cache_handler.make_eiffelassemblycachehandler
			create assembly_cache_handler.make_cache_handler			
			--create reflection_support.make_reflectionsupport
			create reflection_support.make
			path := new_path
			eiffel_delivery_path := from_support_string (reflection_support.Eiffel_delivery_path)
			dotnet_library_path := eiffel_delivery_path
			dotnet_library_path.append (Dotnet_library_relative_path)
			if path.substring_index (dotnet_library_path, 1) > - 1 then
				path.replace_substring_all ( from_support_string (reflection_support.Eiffel_delivery_path), from_support_string (reflection_support.Eiffel_key))
			end
			assembly_cache_handler.update_assembly_description (eiffel_assembly, to_handler_string (path))
		end
	
	Dotnet_library_relative_path: STRING is "\library.net"
		indexing
			description: "Path to `library.net' folder relatively to Eiffel delivery"
		end
		
end -- class EIFFEL_CODE_GENERATOR_FROM_XML
