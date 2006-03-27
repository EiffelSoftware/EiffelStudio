indexing
	description:
		"Internal representation of a class built of partial classes. Instance of CLASS_I represent%
		%non-compiled classes, but instance of CLASS_C already compiled%
		%classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	PARTIAL_EIFFEL_CLASS_I

inherit
	EIFFEL_CLASS_I
		undefine
			is_read_only,
			full_file_name,
			set_date
		redefine
			cluster,
			file_name,
			class_type
		end

	CONF_CLASS_PARTIAL
		rename
			check_changed as set_date,
			file_name as base_name,
			name as original_name,
			renamed_name as name,
			group as cluster
		undefine
			is_compiled
		redefine
			cluster,
			class_type
		end

create
	make_from_partial

feature -- Access

	cluster: CLUSTER_I
			-- Cluster to which the class belongs to.

	file_name: FILE_NAME is
			-- Full file name of the class.
		do
			create Result.make_from_string (base_location.build_path (path, ""))
			Result.set_file_name (base_name)
		end

feature {NONE} -- Type anchor

	class_type: PARTIAL_EIFFEL_CLASS_I

end
