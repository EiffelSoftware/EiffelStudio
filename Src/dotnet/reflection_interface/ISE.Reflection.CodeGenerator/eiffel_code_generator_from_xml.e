indexing
	description: "Generate Eiffel classes from Xml description files."
	external_name: "ISE.Reflection.EiffelCodeGeneratorFromXml"

class
	EIFFEL_CODE_GENERATOR_FROM_XML
	
inherit
	CODE_GENERATOR
		rename
			generate_code as generate_eiffel_code_from_xml
		end

create
	make,
	make_from_info

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
		end
		
	make_from_info (an_assembly_description_filename: like assembly_description_filename; a_type_description_filename: like type_description_filename) is
			-- Set `assembly_description_filename' with `an_assembly_description_filename'.
			-- Set `type_description_filename' with `a_type_description_filename'.
		indexing
			external_name: "MakeFromInfo"
		require
			non_void_assembly_description_filename: an_assembly_description_filename /= Void
			not_empty_assembly_description_filename: an_assembly_description_filename.Length > 0
			non_void_type_description_filename: a_type_description_filename /= Void
			not_empty_type_description_filename: a_type_description_filename.Length > 0
		do
			assembly_description_filename := an_assembly_description_filename
			type_description_filename := a_type_description_filename
		ensure
			assembly_description_set: assembly_description_filename.Equals_String (an_assembly_description_filename)
			type_description_set: type_description_filename.Equals_String (a_type_description_filename)
		end
	
feature -- Access
	
	assembly_description_filename: STRING
			-- Path to `assembly_description.xml'
		indexing
			external_name: "AssemblyDescriptionFilename"
		end
		
	type_description_filename: STRING
			-- Path to Xml file describing type to generate
		indexing
			external_name: "TypeDescriptionFilename"
		end
		
feature -- Basic Operations
	
	generate_eiffel_code_from_xml is
			-- Generate Eiffel file corresponding to XML file with filename `type_description_filename'.
			-- | Call `eiffel_class_from_xml' and `generate_eiffel_class' (from `EIFFEL_CODE_GENERATOR') successively.
		indexing
			external_name: "GenerateEiffelCodeFromXml"
		local
			support: ISE_REFLECTION_SUPPORT
			eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			eiffel_class: ISE_REFLECTION_EIFFELCLASS
			eiffel_code_generator: EIFFEL_CODE_GENERATOR
			path: STRING
		do
			create support.make_support
			support.make
			eiffel_assembly := support.EiffelAssemblyFromXml (assembly_description_filename)
			eiffel_class := support.EiffelClassFromXml (type_description_filename)
			
			create eiffel_code_generator.make_from_info (eiffel_class, eiffel_assembly)
			eiffel_code_generator.generate_eiffel_class 
		end	
		
end -- class EIFFEL_CODE_GENERATOR_FROM_XML