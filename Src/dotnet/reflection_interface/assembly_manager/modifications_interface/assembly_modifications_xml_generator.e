indexing
	description: "Generate XML file containing assembly modifications."
	external_name: "ISE.AssemblyManager.AssemblyModificationsXmlGenerator"

class
	ASSEMBLY_MODIFICATIONS_XML_GENERATOR

inherit
	ASSEMBLY_MODIFICATIONS_XML_ELEMENTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is 
			-- Creation routine
		indexing
			external_name: "Make"
		do
		end

feature -- Access

	Assembly_modifications_xml_filename: STRING is "assembly_modifications"
			-- Name of XML file with assembly modifications
		indexing
			external_name: "AssemblyModificationsXmlFilename"
		end
	
	Xml_extension: STRING is ".xml"
			-- XML file extension
		indexing
			external_name: "XmlExtension"
		end
	
	Dtd_extension: STRING is ".dtd"
			-- DTD file extension
		indexing
			external_name: "DtdExtension"
		end
	
	True_string: STRING is "True"
			-- True as a string
		indexing
			external_name: "TrueString"
		end
		
feature -- Basic Operations

	generate_xml (a_modification_descriptor: ASSEMBLY_MODIFICATIONS) is
			-- Generate XML files with modifications corresponding to `a_modification_descriptor'.
		indexing
			external_name: "GenerateXml"
		require
			non_void_modification_descriptor: a_modification_descriptor /= Void
			not_empty_types_modifications: a_modification_descriptor.types_modifications.count > 0
		local
			retried: BOOLEAN
			public_string: STRING
			subset: STRING
			DTD_path: STRING
		do
			if not retried then
				modification_descriptor := a_modification_descriptor
				create text_writer.make_xmltextwriter_1 (xml_filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

					-- Set generation options
					-- `1' for `Formatting.Indented'
				text_writer.set_Formatting (1)
				text_writer.set_Indentation (1)
				text_writer.set_IndentChar ('%T')
				text_writer.set_Namespaces (False)
				text_writer.set_QuoteChar ('%"')

					-- XML generation

					-- Write `<?xml version="1.0">
				DTD_path := "..\"
				text_writer.WriteDocType (Assembly_modifications_xml_filename, public_string, DTD_path.concat_string_string_string (DTD_path, Assembly_modifications_xml_filename, Dtd_extension), subset)

					-- <modified_assembly>
				text_writer.writestartelement (Modified_assembly_element)

					-- <assembly_descriptor>
				generate_assembly_descriptor_element
				
					-- <modifications>
				generate_modifications_element
				
					-- </modified_assembly>
				text_writer.writeendelement
				
				text_writer.close
				modification_descriptor := Void
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	text_writer: SYSTEM_XML_XMLTEXTWRITER
			-- XML text writer
		indexing
			external_name: "TextWriter"
		end
		
	modification_descriptor: ASSEMBLY_MODIFICATIONS
			-- Assembly modifications descriptor
		indexing
			external_name: "ModificationDescriptor"
		end
		
	xml_filename: STRING is
			-- XML filename from `modification_descriptor'
		indexing
			external_name: "XmlFilename"
		local
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
		do
			if not retried then
				check
					non_void_modification_descriptor: modification_descriptor /= Void
				end
				an_assembly_descriptor := modification_descriptor.assembly_descriptor
				create reflection_support.make_reflectionsupport
				reflection_support.makereflectionsupport
				Result := reflection_support.assemblyfolderpathfrominfo (an_assembly_descriptor)
				Result := Result.concat_string_string_string_string (Result, "\", Assembly_modifications_xml_filename, Xml_extension)
			else
				Result := Assembly_modifications_xml_filename
				Result := Result.concat_string_string (Result, Xml_extension)
			end
		ensure
			xml_filename_created: Result /= Void
			not_empty_filename: Result.length > 0
		rescue
			retried := True
			retry
		end

	generate_assembly_descriptor_element is
			-- Generate `Assembly_descriptor_element'.
		indexing
			external_name: "GenerateAssemblyDescriptorElement"
		do
			check
				non_void_modification_descriptor: modification_descriptor /= Void
			end
				-- <assembly_descriptor>
			text_writer.writestartelement (Assembly_descriptor_element)	

				-- <assembly_name>
			text_writer.writeelementstring (Assembly_name_element, modification_descriptor.assembly_descriptor.name)
				-- <assembly_version>
			text_writer.writeelementstring (Assembly_version_element, modification_descriptor.assembly_descriptor.version)
				-- <assembly_culture>
			text_writer.writeelementstring (Assembly_culture_element, modification_descriptor.assembly_descriptor.culture)
				-- <assembly_public_key>
			text_writer.writeelementstring (Assembly_public_key_element, modification_descriptor.assembly_descriptor.publickey)

				-- </assembly_descriptor>
			text_writer.writeendelement 
		end
		
	generate_modifications_element is
			-- Generate `Modifications_element'.
		indexing
			external_name: "GenerateModificationsElement"
		local
			types_modifications: SYSTEM_COLLECTIONS_HASHTABLE
			types_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_type_full_name: STRING
			a_type_modification: TYPE_MODIFICATIONS_DESCRIPTOR
			moved: BOOLEAN
			features_modifications: SYSTEM_COLLECTIONS_HASHTABLE
			features_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_member_info: SYTEM_REFLECTION_MEMBERINFO
			new_feature_name: STRING
		do
			check
				non_void_modification_descriptor: modification_descriptor /= Void
			end
			
			text_writer.writestartelement (Modifications_element)	
			types_modifications := modification_descriptor.types_modifications
			types_enumerator := types_modifications.keys.get_enumerator
			from
			until
				not types_enumerator.movenext
			loop
				a_type_full_name ?= types_modifications_enumerator.current_
				if a_type_full_name /= Void then
					a_type_modification ?= types_modifications.item (a_type_full_name)
					if a_type_modification /= Void then
							-- <type>
						text_writer.writestartelement (Type_element)

							-- <class_name>
						text_writer.writestartelement (Class_name_element)

							-- <dot_net_full_name>
						text_writer.writeelementstring (Dot_net_full_name_element, a_type_full_name)					
							-- <new_class_name>
						text_writer.writeelementstring (New_class_name_element, a_type_modification.new_class_name)
					
							-- </class_name>
						text_writer.writeendelement

						features_modifications := a_type_modification.features_modifications
						if features_modifications /= Void and then features_modifications.count > 0 then
								-- <features>
							text_writer.writestartelement (Features_element)
							
							features_enumerator := features_modifications.keys.getenumerator
							from
							until
								not features_enumerator.movenext
							loop
								a_member_info ?= features_enumerator.current_
								if a_member_info /= Void then
									new_feature_name ?= features_modifications.item (a_memeber_info)
									if new_feature_name /= Void then					
											-- <feature>
										text_writer.writestartelement (Feature_element)
											-- <new_feature_name>
										text_writer.writeelementstring (New_feature_name_element, new_feature_name)
											-- <feature_external_name>
										text_writer.writeelementstring (Feature_external_name_element, a_member_info.name)
										
										a_field_info ?= features_enumerator.current_
										if a_field_info /= Void then
												-- <is_field>
											text_writer.writeelementstring (Is_field_element, True_string)
										else
											a_method_info ?= features_enumerator.current_
											if a_method_info /= Void and then a_method_info.getparameters.count > 0 then
													-- <arguments>
												text_writer.writestartelement (Arguments_element)

												parameters := a_method_info.getparameters
												from
													i := 0
												until
													i = parameters.count
												loop
													a_parameter := parameters.item (i)
														-- <argument_type_external_name>
													text_writer.writeelementstring (Argument_type_external_name_element, a_parameter.parametertype.fullname)
													i := i + 1
												end
													-- </arguments>
												text_writer.writeendelement 
										end
										
											-- </feature>
										text_writer.writeendelement
									end
								end
								moved := features_enumerator.movenext
							end
							
								-- </features>
							text_writer.writeendelement
							
							-- </type>
						text_writer.writeendelement
					end
				end
				moved := types_modifications_enumerator.movenext
			end		
				-- </modifications>
			text_writer.writeendelement
		end
					
end -- class ASSEMBLY_MODIFICATIONS_XML_GENERATOR
