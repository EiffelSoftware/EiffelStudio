indexing
	description: "Include all the information needed to generate xml assembly description file"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class 
	EIFFEL_ASSEMBLY

inherit
	SUPPORT_SUPPORT
	SUPPORT
		
create
	make, make_from_implementation

feature {NONE} -- Initialization

	make (a_descriptor: like assembly_descriptor; a_path: like eiffel_cluster_path; a_number: like emitter_version_number) is
		indexing
			description: "[
						Set `assembly_descriptor' with `a_descriptor'.
						Set `eiffel_cluster_path' with `a_path'.
						Set `emitter_version_number' with `a_number'.
					  ]"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_path: a_path /= Void
			not_empty_path: a_path.count > 0
			non_void_emitter_version_number: a_number /= Void
			not_empty_emitter_version_number: a_number.count > 0
		do
			assembly_descriptor := a_descriptor
			eiffel_cluster_path := a_path
			emitter_version_number := a_number
			create xml_elements
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
			eiffel_cluster_path_set: eiffel_cluster_path.is_equal (a_path)
			emitter_version_number_set: emitter_version_number.is_equal (a_number)
			non_void_xml_elements: xml_elements /= Void
		end
		
	make_from_implementation (a_implementation: like implementation; a_descriptor: like assembly_descriptor; a_path: like eiffel_cluster_path; a_number: like emitter_version_number) is
		indexing
			description: "[
						Set 'implementation' with 'a_implementation'
						Set `assembly_descriptor' with `a_descriptor'.
						Set `eiffel_cluster_path' with `a_path'.
						Set `emitter_version_number' with `a_number'.
					  ]"
		do
			implementation := a_implementation
			make (a_descriptor, a_path, a_number)
		end
		
	implementation: EIFFEL_ASSEMBLY_IMP
	
feature {EIFFEL_ASSEMBLY_IMP} -- Status Setting

	set_implementation (a_implementation: EIFFEL_ASSEMBLY_IMP) is
		do
			implementation := a_implementation
		end

feature -- Access

	assembly_descriptor: ASSEMBLY_DESCRIPTOR
		indexing
			description: "Assembly descriptor"
		end
		
	eiffel_cluster_path: STRING
		indexing
			description: "Path to cluster where Eiffel classes will be generated"
		end
		
	emitter_version_number: STRING
		indexing
			description: "Emitter version number"
		end

	Types_retrieval_failed: STRING is "Types retrieval failed."	
		indexing
			description: "Error name: types retrieval has failed"
		end
	
	Types_retrieval_failed_message: STRING is "Types retrieval has failed. There may be a sharing violation or XML files may be corrupted."	
		indexing
			description: "Error message when types retrieval has failed"
		end	
		
	types: LINKED_LIST [EIFFEL_CLASS] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Assembly types"
		local
			reflection_support: REFLECTION_SUPPORT
			a_filename: STRING
			assembly_description: SYSTEM_XML_XML_TEXT_READER
			generation_support: CODE_GENERATION_SUPPORT
			type_filename: STRING
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			eiffel_path: STRING
			version_number: STRING			
			retried: BOOLEAN
			added: INTEGER
			white_space_handling: SYSTEM_XML_WHITESPACE_HANDLING
			file: PLAIN_TEXT_FILE
		do
			if not retried then
				create reflection_support.make
				a_filename := reflection_support.xml_assembly_filename (assembly_descriptor)
				a_filename.replace_substring_all (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)

				create file.make(a_filename)
				
				if file.exists then
					create Result.make
					create assembly_description.make_system_xml_xml_text_reader_10 (a_filename.to_cil)	
					assembly_description.set_Whitespace_Handling (white_space_handling.none)

					assembly_description.read_start_element_string (xml_elements.Assembly_element.to_cil)

					if assembly_description.get_Name.Equals (xml_elements.Assembly_name_element.to_cil) then
						assembly_name := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_name_element.to_cil))
					end
					if assembly_description.get_Name.Equals (xml_elements.Assembly_version_element.to_cil) then
						assembly_version := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_version_element.to_cil))
					end
					if assembly_description.get_Name.Equals (xml_elements.Assembly_culture_element.to_cil) then
						assembly_culture := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_culture_element.to_cil))
					end
					if assembly_description.get_Name.Equals (xml_elements.Assembly_public_key_element.to_cil) then
						assembly_public_key := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_public_key_element.to_cil))
					end
					if assembly_description.get_Name.Equals (xml_elements.Eiffel_cluster_path_element.to_cil) then
						eiffel_path := from_system_string (assembly_description.read_element_string_string (xml_elements.Eiffel_cluster_path_element.to_cil))
					end
					if assembly_description.get_Name.Equals (xml_elements.Emitter_version_number_element.to_cil) then
						version_number := from_system_string (assembly_description.read_element_string_string (xml_elements.Emitter_version_number_element.to_cil))
					end

						-- Read `types'.
					if assembly_description.get_Name.Equals (xml_elements.Assembly_types_element.to_cil) then
						create generation_support.make
						assembly_description.read_start_element_string (xml_elements.Assembly_types_element.to_cil)
						from
						until
							not assembly_description.get_Name.Equals (xml_elements.Assembly_type_filename_element.to_cil)
						loop
							type_filename := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_type_filename_element.to_cil))
							type_filename.replace_substring_all (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
							
							create file.make (type_filename)
							if file.exists then
								Result.extend (generation_support.eiffel_class_from_xml (type_filename))
							end
						end
						assembly_description.read_end_element
					end
					assembly_description.read_end_element
					assembly_description.Close
				else
					Result := Void
				end
			else
				Result := Void
			end
		rescue
			retried := True
			create_error (Types_retrieval_failed, Types_retrieval_failed_message)
			retry
		end

feature {NONE} -- Implementation

	xml_elements: XML_ELEMENTS
		indexing
			description: "XML elements"
		end
		
invariant
	non_void_assembly_descriptor: assembly_descriptor /= Void
	non_void_eiffel_cluster_path: eiffel_cluster_path /= Void
	not_empty_eiffel_cluster_path: eiffel_cluster_path.count > 0
	non_void_emitter_version_number: emitter_version_number /= Void
	not_empty_emitter_version_number: emitter_version_number.count > 0
	
end -- class EIFFEL_ASSEMBLY
