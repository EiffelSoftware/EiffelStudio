indexing
	description: "Parse file given in make and extract informations"

class
	ASSEMBLY_INFORMATION
	
inherit
	EXPAT_ERROR_CODES
	
creation
	make

feature -- Initialization

	make (an_xml_file_path: STRING) is
		do
			xml_file_path := an_xml_file_path
			
			initialize
		end
		
	initialize is
			--
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create type_parser.make

				create f.make_open_read (xml_file_path)
				f.read_stream (f.count)
				if f.last_string /= Void then
					type_parser.parse_string (f.last_string)
					type_parser.set_end_of_file
					if not type_parser.is_correct then
						-- print (type_parser.last_error_extended_description)
					else
						-- print ("%NNo errors detected%N")
					end
				else
					-- print ("File has no content%N")
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	type_parser: TYPE_XML_PARSER
			-- Type parser.		

	xml_file_path: STRING
			-- Path to xml document.

feature -- Basic Operations

	find_type (a_full_dotnet_type: STRING): MEMBER_INFORMATION is
			-- Find comments relative to `a_full_dotnet_type'.
		require
			non_void_a_full_dotnet_type: a_full_dotnet_type /= Void
			not_empty_a_full_dotnet_type: not a_full_dotnet_type.is_empty
		do
			Result := find_member (a_full_dotnet_type, a_full_dotnet_type)
		end

	find_feature (a_feature_signature: STRING): MEMBER_INFORMATION is
			-- Find comments of feature of `a_full_dotnet_type' corresponding to `a_feature_signature'.
		require
			non_void_a_feature_signature: a_feature_signature /= Void
			not_empty_a_feature_signature: not a_feature_signature.is_empty
		local
			l_type: STRING
			l_index: INTEGER
		do
			l_type := clone (a_feature_signature)
			l_index := l_type.index_of ('(', 1)
			if l_index > 0 then
				l_type.keep_head (l_index)
			end
			l_index := l_type.last_index_of ('.', l_type.count)
			l_type.keep_head (l_index)
			
			Result := find_member (l_type, a_feature_signature)
		end


feature --{NONE} -- Implementation

	find_member (a_full_dotnet_type: STRING; a_member_signature: STRING): MEMBER_INFORMATION is
			-- Find comments of feature of `a_full_dotnet_type' corresponding to `a_member_signature'.
		require
			non_void_a_full_dotnet_type: a_full_dotnet_type /= Void
			not_empty_a_full_dotnet_type: not a_full_dotnet_type.is_empty
			non_void_a_member_signature: a_member_signature /= Void
			not_empty_a_member_signature: not a_member_signature.is_empty
		local
			l_feature_parser: FEATURE_XML_PARSER
			f: RAW_FILE
			l_last_str: STRING
		do
			if type_parser.Xml_types.has (a_full_dotnet_type) then
				create f.make_open_read (xml_file_path)
				
				f.go (type_parser.Xml_types.item (a_full_dotnet_type).pos_in_file)
				f.read_stream (type_parser.Xml_types.item (a_full_dotnet_type).number_of_char)
				if f.last_string /= Void	then
					l_last_str := f.last_string
					l_last_str.prepend ("<type>")
					l_last_str.append ("</type>")

					create l_feature_parser.make
					l_feature_parser.parse_string (l_last_str)
					l_feature_parser.set_end_of_file
					if not l_feature_parser.is_correct then
						--print (l_feature_parser.last_error_extended_description)
					else
						--print ("%NNo errors detected%N")
												
						if l_feature_parser.Members_information.has (a_member_signature) then
							--print ("%N%N************** Member found!!! **************%N%N")
							Result := l_feature_parser.Members_information.item (a_member_signature)
						else
							--print ("%N%N************** Member not found!!! **************%N%N")
						end
					end
				else
					print ("File has no content%N")
				end
			end
		end

end -- class ASSEMBLY_INFORMATION
