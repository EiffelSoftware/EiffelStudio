indexing
	description: "Provide support for reflection."
	external_name: "ISE.Reflection.ReflectionSupport"

class
	REFLECTION_SUPPORT
	
inherit
	SUPPORT
		
create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
			create error_messages
			create dictionary
		ensure
			error_messages_created: error_messages /= Void
			dictionary_created: dictionary /= Void
		end

feature -- Access				
		
	Assemblies_folder_path: STRING is
			-- Path to `$EIFFEL\dotnet\assemblies' directory
		indexing
			external_name: "AssembliesFolderPath"
		once
			check
				non_void_eiffel_delivery_path: Eiffel_delivery_path /= Void
				not_emtpy_eiffel_delivery_path: Eiffel_delivery_path.Length > 0
			end
			Result := Eiffel_delivery_path.Concat_String_String (Eiffel_delivery_path, Assemblies_folder_relative_path)
		ensure
			path_created: Result /= Void 
			not_empty_path: Result.Length > 0
		end

	assembly_folder_path_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
			-- Assembly folder name corresponding to `a_descriptor'.
			-- | Code string built from `a_version', `a_culture' and `a_public_key' by using the MD5 hash algorithm.
		indexing
			external_name: "AssemblyFolderPathFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			name: STRING	
			version: STRING
			culture: STRING
			public_key: STRING
			string_to_code: STRING
			folder_name: STRING
		do
			name := a_descriptor.Name
			version := a_descriptor.Version
			culture := a_descriptor.Culture
			public_key := a_descriptor.PublicKey
			string_to_code := name.Concat_String_String_String_String (name, dictionary.Dash, version, dictionary.Dash)
			string_to_code := string_to_code.Concat_String_String_String_String (string_to_code, culture, dictionary.Dash, public_key)
			--folder_name := hash_value (string_to_code)
			Result := Assemblies_folder_path
			--Result := Result.Concat_String_String (Result, folder_name)
			Result := Result.Concat_String_String (Result, string_to_code)
		ensure
			assembly_folder_name_generated: Result /= Void
			valid_folder_name: Result.Length > 0
		end			

--	xml_assembly_filename (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY): STRING is
--			-- Xml filename corresponding to `an_eiffel_assembly' 
--		indexing
--			external_name: "XmlAssemblyFilename"
--		require
--			non_void_eiffel_assembly: an_eiffel_assembly /= Void
--			non_void_assembly_version: an_eiffel_assembly.AssemblyVersion /= Void
--			non_void_assembly_culture: an_eiffel_assembly.AssemblyCulture /= Void
--			non_void_assembly_public_key: an_eiffel_assembly.AssemblyPublicKey /= Void
--		local
--			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
--		do
--			create a_descriptor.make1
--			a_descriptor.Make (an_eiffel_assembly.AssemblyName, an_eiffel_assembly.AssemblyVersion, an_eiffel_assembly.AssemblyCulture, an_eiffel_assembly.AssemblyPublicKey)
--			Result := xml_assembly_filename_from_info (a_descriptor)
--		ensure
--			non_void_filename: Result /= Void
--		end

	xml_assembly_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
			-- Xml filename corresponding to `an_assembly_descriptor' 
		indexing
			external_name: "XmlAssemblyFilename"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_version: an_assembly_descriptor.version /= Void
			non_void_assembly_culture: an_assembly_descriptor.culture /= Void
			non_void_assembly_public_key: an_assembly_descriptor.publickey /= Void
		local
			assembly_folder_path: STRING
			retried: BOOLEAN
		do
			if not retried then
				assembly_folder_path := assembly_folder_path_from_info (an_assembly_descriptor)
				Result := assembly_folder_path.Concat_String_String_String_String (assembly_folder_path, "\", Assembly_description_filename, dictionary.Xml_extension)
			else
				Result := Assembly_description_filename
				Result := Result.concat_string_string (Result, dictionary.Xml_extension)
			end
		ensure
			non_void_filename: Result /= Void
		rescue
			retried := True
			create_error (error_messages.No_assembly_description, error_messages.No_assembly_description_message)
			retry
		end
	
	Default_xml_type_filename: STRING is "type.xml"
			-- Default xml type filename
		indexing
			external_name: "DefaultXmlTypeFilename"
		end
		
--	xml_type_filename (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): STRING is
--			-- Xml filename corresponding to `an_eiffel_class'
--		indexing
--			external_name: "XmlTypeFilename"
--		require
--			non_void_eiffel_class: an_eiffel_class /= Void
--			non_void_external_full_name: an_eiffel_class.FullExternalName /= Void
--			not_empty_external_full_name: an_eiffel_class.FullExternalName.length > 0
--			non_void_assembly_descriptor: an_eiffel_class.AssemblyDescriptor /= Void
--		local
--			formatter: FORMATTER
--			assembly_folder_path: STRING
--			retried: BOOLEAN
--		do
--			xml_type_filename_from_info (an_eiffel_class.AssemblyDescriptor, an_eiffel_class.FullExternalName)
--		ensure
--			non_void_filename: Result /= Void
--		end

	xml_type_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; type_full_external_name: STRING): STRING is
			-- Xml filename corresponding to `type_full_external_name' in assembly corresponding to `an_assembly_descriptor'
		indexing
			external_name: "XmlTypeFilename"
		require
			non_void_full_external_name: type_full_external_name /= Void
			not_empty_full_external_name: type_full_external_name.length > 0
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			formatter: FORMATTER
			assembly_folder_path: STRING
			retried: BOOLEAN
		do
			if not retried then
				create formatter.make_formatter
				assembly_folder_path := assembly_folder_path_from_info (an_assembly_descriptor)
				Result := assembly_folder_path.Concat_String_String_String_String (assembly_folder_path, "\", formatter.FormatTypeName (type_full_external_name).ToLower, dictionary.Xml_extension)
			else
				Result := Default_xml_type_filename
			end
		ensure
			non_void_filename: Result /= Void
		rescue
			retried := True
			create_error (error_messages.No_type_description, error_messages.No_type_description_message)
			retry
		end
		
feature {NONE} -- Implementation

	error_messages: REFLECTION_SUPPORT_ERROR_MESSAGES
			-- Error messages
		indexing
			external_name: "ErrorMessages"
		end
		
	dictionary: DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	Eiffel_key: STRING is "ISE_EIFFEL"
			-- Name of environment variable containing path to Eiffel delivery
		indexing
			external_name: "EiffelKey"
		end

	Eiffel_delivery_path: STRING is 
			-- Path to Eiffel delivery
		indexing
			external_name: "EiffelDeliveryPath"
		local
			env: SYSTEM_ENVIRONMENT
		once
			Result := env.GetEnvironmentVariable (Eiffel_key)
		ensure
			non_void_eiffel_delivery_path: Result /= Void
			not_emtpy_eiffel_delivery_path: Result.Length > 0
		end

	Assemblies_folder_relative_path: STRING is "\dotnet\assemblies\"
			-- Relative path to `assemblies' directory (in $EIFFEL\)
		indexing
			external_name: "AssembliesFolderRelativePath"
		end
		
--	hash_value (a_string: STRING): STRING is
--			-- Hash value of `a_string' (using MD5 algorithm)
--		indexing
--			external_name: "HashValue"
--		require
--			non_void_string: a_string /= Void
--			not_empty_string: a_string.Length > 0
--		local
--			encoding: SYSTEM_TEXT_ASCIIENCODING
--			data: ARRAY [INTEGER_8]
--			crypto_service_provider: SYSTEM_SECURITY_CRYPTOGRAPHY_MD5CRYPTOSERVICEPROVIDER
--			hash: ARRAY [INTEGER_8]	
--			i: INTEGER
--			convert: SYSTEM_CONVERT
--			an_hash_value: INTEGER_8
--			an_integer: INTEGER
--			valid_string: STRING
--			retried: BOOLEAN
--		do
--			if not retried then
--				create Result.make_2 ('%U', 0)
--				create encoding.make_asciiencoding
--				data := encoding.GetBytes (a_string)
--				create crypto_service_provider.make_md5cryptoserviceprovider
--				hash := crypto_service_provider.ComputeHash (data)
--				from
--				until
--					i = hash.count
--				loop
--					an_hash_value := hash.item (i)
--					an_integer := convert.ToInt32_Byte (an_hash_value)
--					valid_string := valid_characters.item (an_integer)	
--					Result := Result.Concat_String_String (Result, valid_string)
--					i := i + 1
--				end
--			else
--				Result := dictionary.Empty_string
--			end
--		ensure
--			hash_value_compiled: Result /= Void
--		rescue
--			retried := True
--			create_error (error_messages.Hash_value_computation_failed, error_messages.Hash_value_computation_failed_message)
--			retry
--		end
		
	Assembly_description_filename: STRING is "assembly_description"
			-- Filename of XML file describing the assembly
		indexing
			external_name: "AssemblyDescriptionFilename"
		end

--	valid_characters: ARRAY [STRING] is 
--			-- Valid characters for files and directories
--		indexing
--			external_name: "ValidCharacters"
--		once
--			create Result.make (256)
--			Result.put (0, "a") 
--			Result.put (1, "b") 
--			Result.put (2, "c") 
--			Result.put (3, "d") 
--			Result.put (4, "e") 
--			Result.put (5, "f") 
--			Result.put (6, "g") 
--			Result.put (7, "h") 
--			Result.put (8, "i") 
--			Result.put (9, "j") 
--			Result.put (10, "k") 
--			Result.put (11, "l") 
--			Result.put (12, "m") 
--			Result.put (13, "n") 
--			Result.put (14, "o") 
--			Result.put (15, "p") 
--			Result.put (16, "q") 
--			Result.put (17, "r") 
--			Result.put (18, "s") 
--			Result.put (19, "t")
--			Result.put (20, "u") 
--			Result.put (21, "v") 
--			Result.put (22, "w") 
--			Result.put (23, "x") 
--			Result.put (24, "y") 
--			Result.put (25, "z") 
--			Result.put (26, "0") 
--			Result.put (27, "1") 
--			Result.put (28, "2") 
--			Result.put (29, "3") 
--			Result.put (30, "4") 
--			Result.put (31, "5") 
--			Result.put (32, "6") 
--			Result.put (33, "7") 
--			Result.put (34, "8") 
--			Result.put (35, "9") 
--			Result.put (36, "%%") 
--			Result.put (37, "'") 
--			Result.put (38, "`") 
--			Result.put (39, "-") 
--			Result.put (40, "{") 
--			Result.put (41, "}") 
--			Result.put (42, "!") 
--			Result.put (43, "#") 
--			Result.put (44, "(") 
--			Result.put (45, ")") 
--			Result.put (46, "&") 
--			Result.put (47, "^") 
--			Result.put (48, "@a") 
--			Result.put (49, "@b") 
--			Result.put (50, "@c") 
--			Result.put (51, "@d") 
--			Result.put (52, "@e") 
--			Result.put (53, "@f") 
--			Result.put (54, "@g") 
--			Result.put (55, "@h") 
--			Result.put (56, "@i") 
--			Result.put (57, "@j") 
--			Result.put (58, "@k") 
--			Result.put (59, "@l") 
--			Result.put (60, "@m") 
--			Result.put (61, "@n") 
--			Result.put (62, "@o") 
--			Result.put (63, "@p") 
--			Result.put (64, "@q") 
--			Result.put (65, "@r") 
--			Result.put (66, "@s") 
--			Result.put (67, "@t") 
--			Result.put (68, "@u") 
--			Result.put (69, "@v") 
--			Result.put (70, "@w") 
--			Result.put (71, "@x") 
--			Result.put (72, "@y") 
--			Result.put (73, "@z") 
--			Result.put (74, "@0") 
--			Result.put (75, "@1") 
--			Result.put (76, "@2") 
--			Result.put (77, "@3") 
--			Result.put (78, "@4") 
--			Result.put (79, "@5") 
--			Result.put (80, "@6") 
--			Result.put (81, "@7") 
--			Result.put (82, "@8") 
--			Result.put (83, "@9") 
--			Result.put (84, "@$") 
--			Result.put (85, "@%%")
--			Result.put (86, "@'") 
--			Result.put (87, "@`") 
--			Result.put (88, "@-") 
--			Result.put (89, "@@") 
--			Result.put (90, "@{") 
--			Result.put (91, "@}") 
--			Result.put (92, "@~") 
--			Result.put (93, "@!") 
--			Result.put (94, "@#") 
--			Result.put (95, "@(") 
--			Result.put (96, "@)") 
--			Result.put (97, "@&") 
--			Result.put (98, "@_") 
--			Result.put (99, "@^") 
--			Result.put (100, "_a") 
--			Result.put (101, "_b") 
--			Result.put (102, "_c") 
--			Result.put (103, "_d") 
--			Result.put (104, "_e") 
--			Result.put (105, "_f") 
--			Result.put (106, "_g") 
--			Result.put (107, "_h") 
--			Result.put (108, "_i") 
--			Result.put (109, "_j") 
--			Result.put (110, "_k") 
--			Result.put (111, "_l") 
--			Result.put (112, "_m") 
--			Result.put (113, "_n") 
--			Result.put (114, "_o") 
--			Result.put (115, "_p") 
--			Result.put (116, "_q") 
--			Result.put (117, "_r") 
--			Result.put (118, "_s") 
--			Result.put (119, "_t") 
--			Result.put (120, "_u") 
--			Result.put (121, "_v") 
--			Result.put (122, "_w") 
--			Result.put (123, "_x") 
--			Result.put (124, "_y") 
--			Result.put (125, "_z") 
--			Result.put (126, "_0") 
--			Result.put (127, "_1") 
--			Result.put (128, "_2") 
--			Result.put (129, "_3") 
--			Result.put (130, "_4") 
--			Result.put (131, "_5") 
--			Result.put (132, "_6") 
--			Result.put (133, "_7") 
--			Result.put (134, "_8") 
--			Result.put (135, "_9") 
--			Result.put (136, "_$") 
--			Result.put (137, "_%%") 
--			Result.put (138, "_'") 
--			Result.put (139, "_`") 
--			Result.put (140, "_-") 
--			Result.put (141, "_@") 
--			Result.put (142, "_{") 
--			Result.put (143, "_}") 
--			Result.put (144, "_~") 
--			Result.put (145, "_!") 
--			Result.put (146, "_#") 
--			Result.put (147, "_(") 
--			Result.put (148, "_)") 
--			Result.put (149, "_&") 
--			Result.put (150, "__") 
--			Result.put (151, "_^") 
--			Result.put (152, "~a") 
--			Result.put (153, "~b") 
--			Result.put (154, "~c") 
--			Result.put (155, "~d") 
--			Result.put (156, "~e") 
--			Result.put (157, "~f") 
--			Result.put (158, "~g") 
--			Result.put (159, "~h") 
--			Result.put (160, "~i") 
--			Result.put (161, "~j") 
--			Result.put (162, "~k") 
--			Result.put (163, "~l") 
--			Result.put (164, "~m") 
--			Result.put (165, "~n") 
--			Result.put (166, "~o") 
--			Result.put (167, "~p") 
--			Result.put (168, "~q") 
--			Result.put (169, "~r") 
--			Result.put (170, "~s") 
--			Result.put (171, "~t") 
--			Result.put (172, "~u") 
--			Result.put (173, "~v") 
--			Result.put (174, "~w") 
--			Result.put (175, "~x") 
--			Result.put (176, "~y") 
--			Result.put (177, "~z") 
--			Result.put (178, "~0") 
--			Result.put (179, "~1") 
--			Result.put (180, "~2") 
--			Result.put (181, "~3") 
--			Result.put (182, "~4") 
--			Result.put (183, "~5") 
--			Result.put (184, "~6") 
--			Result.put (185, "~7") 
--			Result.put (186, "~8") 
--			Result.put (187, "~9") 
--			Result.put (188, "~$") 
--			Result.put (189, "~%%") 
--			Result.put (190, "~'") 
--			Result.put (191, "~`") 
--			Result.put (192, "~-") 
--			Result.put (193, "~@") 
--			Result.put (194, "~{") 
--			Result.put (195, "~}") 
--			Result.put (196, "~~") 
--			Result.put (197, "~!") 
--			Result.put (198, "~#") 
--			Result.put (199, "~(") 
--			Result.put (200, "~)") 
--			Result.put (201, "~&") 
--			Result.put (202, "~_") 
--			Result.put (203, "~^") 
--			Result.put (204, "$a") 
--			Result.put (205, "$b") 
--			Result.put (206, "$c") 
--			Result.put (207, "$d") 
--			Result.put (208, "$e") 
--			Result.put (209, "$f") 
--			Result.put (210, "$g") 
--			Result.put (211, "$h") 
--			Result.put (212, "$i") 
--			Result.put (213, "$j") 
--			Result.put (214, "$k") 
--			Result.put (215, "$l") 
--			Result.put (216, "$m") 
--			Result.put (217, "$n") 
--			Result.put (218, "$o") 
--			Result.put (219, "$p") 
--			Result.put (220, "$q") 
--			Result.put (221, "$r") 
--			Result.put (222, "$s") 
--			Result.put (223, "$t") 
--			Result.put (224, "$u") 
--			Result.put (225, "$v") 
--			Result.put (226, "$w") 
--			Result.put (227, "$x") 
--			Result.put (228, "$y") 
--			Result.put (229, "$z") 
--			Result.put (230, "$0") 
--			Result.put (231, "$1") 
--			Result.put (232, "$2") 
--			Result.put (233, "$3") 
--			Result.put (234, "$4") 
--			Result.put (235, "$5") 
--			Result.put (236, "$6") 
--			Result.put (237, "$7") 
--			Result.put (238, "$8") 
--			Result.put (239, "$9") 
--			Result.put (240, "$$") 
--			Result.put (241, "$%%") 
--			Result.put (242, "$'") 
--			Result.put (243, "$`") 
--			Result.put (244, "$-") 
--			Result.put (245, "$@") 
--			Result.put (246, "${") 
--			Result.put (247, "$}") 
--			Result.put (248, "$~") 
--			Result.put (249, "$!") 
--			Result.put (250, "$#") 
--			Result.put (251, "$(") 
--			Result.put (252, "$)") 
--			Result.put (253, "$&") 
--			Result.put (254, "$_") 
--			Result.put (255, "$^")
--		ensure
--			table_created: Result /= Void
--			valid_table: Result.count = 256
--		end
		
end -- class REFLECTION_SUPPPORT
