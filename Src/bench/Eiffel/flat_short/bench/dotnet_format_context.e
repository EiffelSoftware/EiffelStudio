indexing
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_FORMAT_CONTEXT

inherit
	FORMAT_CONTEXT
		rename
			make as format_context_make
		end
		
	IL_ENVIRONMENT
		export
			{NONE} all
		end	
	
feature -- Initialization

	make (a_consumed: CONSUMED_TYPE) is
			-- Initialize Current with 'a_consumed'
		require
			consumed_not_void: a_consumed /= Void
		do
			consumed_t := a_consumed
			set_assembly_name
			if not cached_xml.has (assembly_name) then
				create assembly_info.make (dotnet_framework_path + assembly_name + ".xml")
				cached_xml.put (assembly_info, assembly_name)
			else
				assembly_info := cached_xml.item (assembly_name)
			end
		ensure
			has_dotnet_type: consumed_t /= Void
		end		

feature -- Access

	consumed_t: CONSUMED_TYPE
			-- The .NET consumed type associated with Current.

	class_i: EXTERNAL_CLASS_I
			-- The uncompiled Eiffel class associated with 'consumed_t'.

	assembly_info: ASSEMBLY_INFORMATION
			-- Assembly information for comments retrieval.

	assembly_name: STRING
			-- Assembly name for comments retrieval.

	cached_xml: HASH_TABLE [ASSEMBLY_INFORMATION, STRING] is
			-- Table of cached XML Assembly files.
		once
			create Result.make (5)
		end
		
feature -- Status Setting

	set_assembly_name is
			-- Set the assembly from which the consumed_type was generated.
		local
			l_reader: EIFFEL_XML_DESERIALIZER
			l_file_name: STRING
			l_char_index: INTEGER
			l_c_assembly: CONSUMED_ASSEMBLY_MAPPING
		do
			create l_reader
			create l_file_name.make_from_string (class_i.file_name)
			l_char_index := l_file_name.last_index_of ('\', l_file_name.count)
			l_file_name := l_file_name.substring (1, l_char_index - 1)
			l_char_index := l_file_name.last_index_of ('\', l_file_name.count)
			l_file_name := l_file_name.substring (1, l_char_index - 1)
			l_file_name.append ("\referenced_assemblies.xml")
			l_c_assembly ?= l_reader.new_object_from_file (l_file_name)		
			assembly_name := l_c_assembly.assemblies.item (1).name
		end

feature {NONE} -- Implementation

	strip_down (a_string: STRING ) is
			-- Strip string of all unwanted white space
		local
			l_new_line_count, 
			l_old_line_count: INTEGER
		do
			from
				a_string.prune_all_leading (' ')
				l_new_line_count := a_string.count
			until
				l_new_line_count = l_old_line_count
			loop
				l_old_line_count := l_new_line_count
				a_string.replace_substring_all ("  ", " ")
				l_new_line_count := a_string.count
			end	
		end
		
invariant
	has_dotnet_type: consumed_t /= Void

end -- class DOTNET_FORMAT_CONTEXT
