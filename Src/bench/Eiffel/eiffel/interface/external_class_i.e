indexing
	description: "[
		Representation of a class that has been generated
		in a different compilation or language in .NET context.
		Used to consume external types in Eiffel.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_CLASS_I

inherit
	CLASS_I
		rename
			make as old_make
		redefine
			external_name, file_name, is_external_class, cluster
		end

create
	make

feature {NONE} -- Initialization

	make (a_name, an_external_name: STRING; a_file_location: like file_name) is
			-- Create new instance of Current.
		require
			a_name_not_void: a_name /= Void
			an_external_name_not_void: an_external_name /= Void
			a_file_location_not_void: a_file_location /= Void
		do
			name := a_name
			external_name := an_external_name
			file_name := a_file_location
		ensure
			name_set: name = a_name
			external_name_set: external_name = an_external_name
			file_name_set: file_name = a_file_location
		end

feature -- Access

	external_name: STRING
			-- Name of class as known in .NET
			
	file_name: FILE_NAME
			-- File where XML data of current class is stored.

	cluster: ASSEMBLY_I
			-- Cluster is an assembly.

feature -- Status Report

	is_external_class: BOOLEAN is True
			-- Class is defined outside current system.
			
	is_eiffel_class: BOOLEAN
			-- Is Current class originally written in Eiffel.

invariant
	name_not_void: name /= Void
	external_name_not_void: external_name /= Void
	file_name_not_void: file_name /= Void
	
end -- class EXTERNAL_CLASS_I
