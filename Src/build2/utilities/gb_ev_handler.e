indexing
	description: "Objects that provide access to all the currently supported%
		%Vision2 types for Build2."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_HANDLER

inherit
	GB_CONSTANTS
	
	OPERATING_ENVIRONMENT
	
feature -- Access
	
	supported_types: ARRAYED_LIST [STRING] is
			-- All vision2 types available for the system.
		local
			directory: DIRECTORY
			entries: ARRAYED_LIST [STRING]
		do
			create Result.make (0)
			create directory.make (gb_ev_directory)
			entries := directory.linear_representation
			from
				entries.start
			until
				entries.off
			loop
				if not entries.item.is_equal (".") and not entries.item.is_equal ("..") then
					if entries.item.has ('.') then
						Result.extend (entries.item.substring (1, entries.item.index_of ('.', 1) - 1))
					elseif not (entries.item.is_equal ("CVS")) then
						get_files_in_sub_directories (directory.name + directory_separator.out + entries.item, Result)		
					end	
				end
				entries.forth
			end
		end
		
feature {NONE} -- Implementation
		
	get_files_in_sub_directories (a_directory: STRING; files: ARRAYED_LIST[STRING]) is
			-- `Result' is all filenames recursively in `a_directory'.
		local
			directory: DIRECTORY
			entries: ARRAYED_LIST [STRING]
		do
			create directory.make (a_directory)
			entries := directory.linear_representation
			from
				entries.start
			until
				entries.off
			loop
				if not entries.item.is_equal (".") and not entries.item.is_equal ("..") then
					if entries.item.has ('.') then
						files.extend (entries.item.substring (1, entries.item.index_of ('.', 1) - 1))
					elseif not (entries.item.is_equal ("CVS")) then
						get_files_in_sub_directories (directory.name + directory_separator.out +  entries.item, files)		
					end	
				end
				entries.forth
			end
		end
		
end -- class GB_EV_HANDLER
