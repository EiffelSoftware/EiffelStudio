indexing
	description: "Include all the information needed to generate xml assembly description file"
	external_name: "ISE.Reflection.EiffelAssembly"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class 
	EIFFEL_ASSEMBLY

inherit
	SUPPORT
		
create
	make

feature {NONE} -- Initialization

	make (a_descriptor: like assembly_descriptor; a_path: like eiffel_cluster_path; a_number: like emitter_version_number) is
		indexing
			description: "[Set `assembly_descriptor' with `a_descriptor'.%
						%Set `eiffel_cluster_path' with `a_path'.%
						%Set `emitter_version_number' with `a_number'.]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_path: a_path /= Void
			not_empty_path: a_path.get_length > 0
			non_void_emitter_version_number: a_number /= Void
			not_empty_emitter_version_number: a_number.get_length > 0
		do
			assembly_descriptor := a_descriptor
			eiffel_cluster_path := a_path
			emitter_version_number := a_number
			create xml_elements
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
			eiffel_cluster_path_set: eiffel_cluster_path.equals_string (a_path)
			emitter_version_number_set: emitter_version_number.equals_string (a_number)
		end

feature -- Access

	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		indexing
			description: "Assembly descriptor"
			external_name: "AssemblyDescriptor"
		end
		
	eiffel_cluster_path: STRING
		indexing
			description: "Path to cluster where Eiffel classes will be generated"
			external_name: "EiffelClusterPath"
		end
		
	emitter_version_number: STRING
		indexing
			description: "Emitter version number"
			external_name: "EmitterVersionNumber"
		end

	Types_retrieval_failed: STRING is "Types retrieval failed."	
		indexing
			description: "Error name: types retrieval has failed"
			external_name: "TypesRetrievalFailed"
		end
	
	Types_retrieval_failed_message: STRING is "Types retrieval has failed. There may be a sharing violation or XML files may be corrupted."	
		indexing
			description: "Error message when types retrieval has failed"
			external_name: "TypesRetrievalFailedMessage"
		end	
		
	types: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Assembly types"
			external_name: "Types"
		local
			reflection_support: REFLECTION_SUPPORT
			a_filename: STRING
			assembly_description: SYSTEM_XML_XMLTEXTREADER
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
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
		do
			if not retried then
				create Result.make
				create reflection_support.make
				a_filename := reflection_support.xml_assembly_filename (assembly_descriptor)
				a_filename := a_filename.replace (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
				
				create assembly_description.make_xmltextreader_10 (a_filename)	
				assembly_description.set_Whitespace_Handling (white_space_handling.none)
				
				assembly_description.read_start_element_string (xml_elements.Assembly_element)

				if assembly_description.get_Name.equals_string (xml_elements.Assembly_name_element) then
					assembly_name := assembly_description.read_element_string_string (xml_elements.Assembly_name_element)
				end
				if assembly_description.get_Name.equals_string (xml_elements.Assembly_version_element) then
					assembly_version := assembly_description.read_element_string_string (xml_elements.Assembly_version_element)
				end
				if assembly_description.get_Name.equals_string (xml_elements.Assembly_culture_element) then
					assembly_culture := assembly_description.read_element_string_string (xml_elements.Assembly_culture_element)
				end
				if assembly_description.get_Name.equals_string (xml_elements.Assembly_public_key_element) then
					assembly_public_key := assembly_description.read_element_string_string (xml_elements.Assembly_public_key_element)
				end
				if assembly_description.get_Name.equals_string (xml_elements.Eiffel_cluster_path_element) then
					eiffel_path := assembly_description.read_element_string_string (xml_elements.Eiffel_cluster_path_element)
				end
				if assembly_description.get_Name.equals_string (xml_elements.Emitter_version_number_element) then
					version_number := assembly_description.read_element_string_string (xml_elements.Emitter_version_number_element)
				end
				
					-- Read `types'.
				if assembly_description.get_Name.equals_string (xml_elements.Assembly_types_element) then
					create generation_support.make
					assembly_description.read_start_element_string (xml_elements.Assembly_types_element)
					from
					until
						not assembly_description.get_Name.equals_string (xml_elements.Assembly_type_filename_element)
					loop
						type_filename := assembly_description.read_element_string_string (xml_elements.Assembly_type_filename_element)
						type_filename := type_filename.replace (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
						added := Result.add (generation_support.eiffel_class_from_xml (type_filename))
					end
					assembly_description.read_end_element
				end
				assembly_description.read_end_element
				assembly_description.Close
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
			external_name: "XmlElements"
		end
		
invariant
	non_void_assembly_descriptor: assembly_descriptor /= Void
	non_void_eiffel_cluster_path: eiffel_cluster_path /= Void
	not_empty_eiffel_cluster_path: eiffel_cluster_path.get_length > 0
	non_void_emitter_version_number: emitter_version_number /= Void
	not_empty_emitter_version_number: emitter_version_number.get_length > 0
	
end -- class EIFFEL_ASSEMBLY
