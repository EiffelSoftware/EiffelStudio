indexing
	description: "Generate Eiffel classes from Xml description files."
	external_name: "ISE.Reflection.EiffelCodeGeneratorFromXml"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	EIFFEL_CODE_GENERATOR_FROM_XML
		
create
	make,
	make_from_info,
	make_from_info_and_path

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do
		end

	make_from_info (an_assembly_description_filename: like assembly_description_filename) is
		indexing
			description: "[Set `assembly_description_filename' with `an_assembly_description_filename'.%
					%Build `eiffel_assembly' from `assembly_description_filename'.]"
			external_name: "MakeFromInfo"
		require
			non_void_assembly_description_filename: an_assembly_description_filename /= Void
			not_empty_assembly_description_filename: an_assembly_description_filename.Length > 0
		local
			support: ISE_REFLECTION_CODEGENERATIONSUPPORT
		do
			assembly_description_filename := an_assembly_description_filename
			create support.make_codegenerationsupport
			support.make
			eiffel_assembly := support.EiffelAssemblyFromXml (assembly_description_filename)
			create eiffel_code_generator.make_from_info (eiffel_assembly)
		ensure
			assembly_description_set: assembly_description_filename.Equals_String (an_assembly_description_filename)
			non_void_eiffel_assembly: eiffel_assembly /= Void
			non_void_eiffel_code_generator: eiffel_code_generator /= Void
		end
	
	make_from_info_and_path (an_assembly_description_filename: like assembly_description_filename; new_path: STRING) is
		indexing
			description: "[Set `assembly_description_filename' with `an_assembly_description_filename'.%
					%Build `eiffel_assembly' from `assembly_description_filename'.]"
			external_name: "MakeFromInfoAndPath"
		require
			non_void_assembly_description_filename: an_assembly_description_filename /= Void
			not_empty_assembly_description_filename: an_assembly_description_filename.Length > 0
		local
			support: ISE_REFLECTION_CODEGENERATIONSUPPORT
		do
			make_from_info (an_assembly_description_filename)
			update_assembly_description (new_path)
		ensure
			assembly_description_set: assembly_description_filename.Equals_String (an_assembly_description_filename)
			non_void_eiffel_assembly: eiffel_assembly /= Void
			non_void_eiffel_code_generator: eiffel_code_generator /= Void
		end	
		
feature -- Access
	
	assembly_description_filename: STRING
		indexing
			description: "Path to `assembly_description.xml'"
			external_name: "AssemblyDescriptionFilename"
		end
	
	eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
		indexing
			description: "Eiffel assembly corresponding to `assembly_description_filename'"
			external_name: "EiffelAssembly"
		end
	
	eiffel_code_generator: EIFFEL_CODE_GENERATOR
		indexing
			description: "Eiffel code generator"
			external_name: "EiffelCodeGenerator"
		end
		
feature -- Basic Operations
	
	generate_eiffel_code_from_xml (type_description_filename: STRING) is
			-- | Call `eiffel_class_from_xml' and `generate_eiffel_class' (from `EIFFEL_CODE_GENERATOR') successively.
		indexing
			description: "Generate Eiffel file corresponding to XML file with filename `type_description_filename'."
			external_name: "GenerateEiffelCodeFromXml"
		require
			non_void_type_description_filename: type_description_filename /= Void
			not_empty_type_description_filename: type_description_filename.Length > 0
		do
			eiffel_code_generator.generate_eiffel_class (eiffel_class_from_xml (type_description_filename))
		end	

	generate_eiffel_code_from_xml_and_path (type_description_filename, a_path: STRING) is
			-- | Call `eiffel_class_from_xml' and `generate_eiffel_class' (from `EIFFEL_CODE_GENERATOR') successively.
		indexing
			description: "Generate Eiffel file corresponding to XML file with filename `type_description_filename' in folder corresponding to `a_path'."
			external_name: "GenerateEiffelCodeFromXmlAndPath"
		require
			non_void_assembly: eiffel_assembly /= Void
			non_void_type_description_filename: type_description_filename /= Void
			not_empty_type_description_filename: type_description_filename.Length > 0
		do
			eiffel_code_generator.generate_eiffel_class_from_path (eiffel_class_from_xml (type_description_filename), a_path)
		end	

feature {NONE} -- Implementation

	eiffel_class_from_xml (type_description_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		indexing
			description: "Eiffel class corresponding to XML file with filename `type_description_filename'"
			external_name: "EiffelClassFromXml"
		require
			non_void_type_description_filename: type_description_filename /= Void
			not_empty_type_description_filename: type_description_filename.Length > 0
		local
			support: ISE_REFLECTION_CODEGENERATIONSUPPORT
			eiffel_class: ISE_REFLECTION_EIFFELCLASS
			path: STRING
		do
			create support.make_codegenerationsupport
			support.make
			Result := support.EiffelClassFromXml (type_description_filename)
		end

	update_assembly_description (new_path: STRING) is
		indexing
			description: "Update `assembly_description.xml' by replacing Eiffel cluster path by `new_path'."
			external_name: "UpdateAssemblyDescription"
		require
			non_void_new_path: new_path /= Void
			not_empty_new_path: new_path.length > 0
			non_void_eiffel_assembly: eiffel_assembly /= Void
		local
			assembly_cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			path: STRING
			eiffel_delivery_path: STRING
			dotnet_library_path: STRING
		do
			create assembly_cache_handler.make_eiffelassemblycachehandler
			assembly_cache_handler.makecachehandler			
			create reflection_support.make_reflectionsupport
			reflection_support.make
			path := new_path
			eiffel_delivery_path := reflection_support.Eiffeldeliverypath
			dotnet_library_path := eiffel_delivery_path.concat_string_string (eiffel_delivery_path, Dotnet_library_relative_path)
			if path.indexof (dotnet_library_path) > - 1 then
				path := path.replace (reflection_support.Eiffeldeliverypath, reflection_support.Eiffelkey)
			end
			assembly_cache_handler.updateassemblydescription (eiffel_assembly, path)
		end
	
	Dotnet_library_relative_path: STRING is "\library.net"
		indexing
			description: "Path to `library.net' folder relatively to Eiffel delivery"
			external_name: "DotnetLibraryRelativePath"
		end
		
end -- class EIFFEL_CODE_GENERATOR_FROM_XML