indexing
	description: "MIDL component (coclass, interface)"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_COMPONENT

inherit
	EI_APP_CONSTANTS

feature {NONE} -- Initialization

	make (c_name: STRING) is
			-- Initialize object.  Set 'name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			name := clone (c_name)
			create guid.make
			guid.generate

			version := 1.0
			create description.make (0)
		end

feature -- Access

	name: STRING
			-- Name

	guid: ECOM_GUID
			-- Guid

	description: STRING
			-- Description

	version: REAL
			-- Version

feature -- Element change

	set_name (c_name: STRING) is
			-- Set 'name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			name := clone (c_name)
		ensure
			name_set: name.is_equal (c_name)
		end

	set_guid (l_guid: ECOM_GUID) is
			-- Set 'guid' to 'l_guid'.
		require
			non_void_guid: l_guid /= Void
			valid_guid: l_guid.exists
		do
			guid := clone (l_guid)
		ensure
			guid_set: guid.is_equal (l_guid)
		end

	set_description ( desc: STRING) is
			-- Set 'description' to 'desc'.
		require
			non_void_description: desc /= Void
			valid_description: not desc.is_empty
		do
			description := clone (desc)
		ensure
			description_set: description.is_equal (desc)
		end

	set_version (ver: REAL) is
			-- Set 'version' to 'ver'.
		require
			valid_version: ver > 0.0
		do
			version := ver
		ensure
			version_set: version = ver
		end

invariant
	valid_name: name /= Void and then not name.is_empty
	valid_guid: guid /= Void and then guid.exists
	valid_version: version > 0.0

end -- class EI_MIDL_COMPONENT
