note
	description: "Summary description for {CIL_ASSEMBLY_INFO}."
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


	revision: NATURAL_16 assign set_revision
			-- `revision'

	build: NATURAL_16 assign set_build
			-- `build'

	minor: NATURAL_16 assign set_minor
			-- `minor'

	major: NATURAL_16 assign set_major
			-- `major'


feature -- Element change

	set_revision (a_revision: like revision)
			-- Assign `revision' with `a_revision'.
		do
			revision := a_revision
		ensure
			revision_assigned: revision = a_revision
		end

	set_build (a_build: like build)
			-- Assign `build' with `a_build'.
		do
			build := a_build
		ensure
			build_assigned: build = a_build
		end

	set_minor (a_minor: like minor)
			-- Assign `minor' with `a_minor'.
		do
			minor := a_minor
		ensure
			minor_assigned: minor = a_minor
		end

	set_major (a_major: like major)
			-- Assign `major' with `a_major'.
		do
			major := a_major
		ensure
			major_assigned: major = a_major
		end

end
