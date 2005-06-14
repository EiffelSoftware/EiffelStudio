indexing
	description: "Abstract description of a .NET formatting context."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOTNET_FORMAT_CONTEXT

inherit
	FORMAT_CONTEXT
		rename
			make as format_context_make
		end
		
feature {NONE} -- Initialization

	make (a_consumed: CONSUMED_TYPE) is
			-- Initialize Current with 'a_consumed'
		require
			consumed_not_void: a_consumed /= Void
		do
			consumed_t := a_consumed
			set_assembly_name
--			if not cached_xml.has (assembly_name) then
				create assembly_info.make (System.clr_runtime_version)
--				if is_dotnet_installed then
--					assembly_info.initialize (dotnet_framework_path + assembly_name + ".xml")
--					cached_xml.put (assembly_info, assembly_name)
--				end	
--			else
--				assembly_info := cached_xml.item (assembly_name)
--			end
		ensure
			has_dotnet_type: consumed_t /= Void
			assembly_name_not_void: assembly_name /= Void
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
		do
			assembly_name := class_i.assembly.assembly_name
		end

feature {NONE} -- Implementation

	strip_down (a_string: STRING) is
			-- Strip string of all unwanted white space
		require
			a_string_not_void: a_string /= Void
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
