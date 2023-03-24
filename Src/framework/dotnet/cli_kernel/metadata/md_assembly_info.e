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
		end

feature -- Access

	major_version: NATURAL_16 assign set_major_version
			-- Major version

	minor_version: NATURAL_16 assign set_minor_version
			-- Minor version

	revision_number: NATURAL_16 assign set_revision_number
			-- Revision number

	build_number: NATURAL_16 assign set_build_number
			-- Build number	

	major: like major_version
		obsolete "Use major_version"
		do
			Result := major_version
		end

	minor: like minor_version
		obsolete "Use minor_version"
		do
			Result := minor_version
		end

	revision: like revision_number
		obsolete "Use revision_number"
		do
			Result := revision_number
		end

	build: like build_number
		obsolete "Use build_number"
		do
			Result := build_number
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

	set_major (m: like major)
		obsolete "Use set_major_version"
		do
			set_major_version (m)
		end

	set_minor (m: like minor)
		obsolete "Use set_minor_version"
		do
			set_minor_version (m)
		end

	set_revision (r: like revision)
		obsolete "Use set_revision_number"
		do
			set_revision_number (r)
		end

	set_build (b: like build_number)
		obsolete "Use set_build_number"
		do
			set_build_number (b)
		end

end
