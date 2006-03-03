indexing
	description: "Objects that represent an external."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_EXTERNAL

inherit
	CONF_CONDITIONED

create
	make

feature {NONE} -- Initialization

	make (a_location: CONF_LOCATION) is
			-- Create with `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			location := a_location
		ensure
			location_set: location = a_location
		end


feature -- Access, stored in configuration file

	location: CONF_LOCATION
			-- The file location.

	description: STRING
			-- A description about the external.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_location (a_location: like location) is
			-- Set `location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

invariant
	location_not_void: location /= Void

end
