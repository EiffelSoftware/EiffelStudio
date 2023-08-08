note
	description: "Summary description for {MD_ASSEMBLY_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_INFO

create
	make

feature {NONE} -- Initialization

	make
		do
			major_version := 1 -- Default version is: 1.0.0.0
		end

feature -- Access

	major_version: NATURAL_16 assign set_major_version
			-- Major version

	minor_version: NATURAL_16 assign set_minor_version
			-- Minor version

	build_number: NATURAL_16 assign set_build_number
			-- Build number	

	revision_number: NATURAL_16 assign set_revision_number
			-- Revision number

feature -- Conversion

	string: STRING_8
		do
			create Result.make (10)
			Result.append (major_version.out)
			Result.append_character ('.')
			Result.append (minor_version.out)
			Result.append_character ('.')
			Result.append (build_number.out)
			Result.append_character ('.')
			Result.append (revision_number.out)
		end

feature -- Element change

	set_major_version (m: like major_version)
			-- Set `major_version` to `m`.
		do
			major_version := m
		ensure
			major_version_set: major_version = m
		end

	set_minor_version (m: like minor_version)
			-- Set `minor_version` to `m`.	
		do
			minor_version := m
		ensure
			minor_version_set: minor_version = m
		end

	set_revision_number (r: like revision_number)
			-- Set `revision_number` to `r`.	
		do
			revision_number := r
		ensure
			revision_number_set: revision_number = r
		end

	set_build_number (b: like build_number)
			-- Set `build_number` to `b`.
		do
			build_number := b
		ensure
			build_number_set: build_number = b
		end

end
