indexing
	description: "[
		Visitor that looks for libraries with a given UUID.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FIND_UUID_VISITOR

inherit
	CONF_FIND_VISITOR [!CONF_LIBRARY]
		rename
			found_groups as found_libraries
		end

create
	make

feature -- Access

	uuid: UUID
			-- UUID used to find libraries

feature -- Status setting

	set_uuid (a_uuid: like uuid)
			-- Set `uuid' to `a_uuid'.
		do
			uuid := a_uuid
		ensure
			uuid_set: uuid = a_uuid
		end

feature {NONE} -- Query

	is_matching (a_library: !CONF_LIBRARY): BOOLEAN is
			-- <Precursor>
		do
			Result := a_library.library_target.system.uuid.is_equal (uuid)
		end

end
