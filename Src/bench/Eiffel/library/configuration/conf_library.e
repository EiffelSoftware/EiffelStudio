indexing
	description: "A library."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LIBRARY

inherit
	CONF_GROUP
		redefine
			process,
			is_library
		end

	REFACTORING_HELPER
		undefine
			is_equal
		end

create
	make

feature -- Status

	is_library: BOOLEAN is
			-- Is this a library?
		once
			Result := True
		end

feature -- Access, in compiled only, not stored to configuration file

	library_target: CONF_TARGET
			-- The library target.

feature -- Access queries

	uuid: UUID
			-- uuid of the used library.

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_uuid (an_uuid: UUID) is
			-- Set the uuid of the library.
		require
			an_uuid_not_void: an_uuid /= Void
		do
			uuid := an_uuid
		ensure
			uuid_set: uuid = an_uuid
		end


	set_library_target (a_target: CONF_TARGET) is
			-- Set `library_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			library_target := a_target
			library_target.add_library_usage (Current)
		ensure
			library_target_set: library_target = a_target
		end


feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_library (Current)
		end
end
