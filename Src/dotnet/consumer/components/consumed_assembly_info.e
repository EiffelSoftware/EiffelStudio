indexing
	description: "Information associated to a consumed assembly"

class
	CONSUMED_ASSEMBLY_INFO

create
	make

feature {NONE} -- Initialization

	make (ass: CONSUMED_ASSEMBLY; assembly_location, assembly_directory: STRING; f: INTEGER)is
			-- Initialization
		require
			non_void_ass: ass /= Void
			non_void_assembly_location: assembly_location /= Void
			not_empty_assembly_location: not assembly_location.is_empty
			non_void_assembly_directory: assembly_directory /= Void
			not_empty_assembly_directory: not assembly_directory.is_empty
			positive_flag: f >= 0
		do
			assembly := ass
			location := assembly_location
			directory := assembly_directory
			flags := f
		ensure
			assembly_set: assembly = ass
			location_set: location = assembly_location
			directory_set: directory = assembly_directory
			flags_set: flags = f
		end

feature -- Access

	assembly: CONSUMED_ASSEMBLY
			-- Consumed assembly

	location: STRING
			-- Location of assembly.

	directory: STRING
			-- Directory where is stored `assembly'

	flags: INTEGER
			-- Provides information about an Assembly reference.

invariant
	non_void_assembly: assembly /= Void
	non_void_location: location /= Void
	not_empty_location: not location.is_empty
	non_void_directory: directory /= Void
	not_empty_directory: not directory.is_empty

end -- class CONSUMED_ASSEMBLY_INFO
