indexing
	description: "Represent a FILE_PROPERTY with the replacements of a CONF_LOCATION"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_LOCATION_PROPERTY

inherit
	FILE_PROPERTY
		redefine
			directory_location_value
		end

create
	make

feature -- Access

	target: CONF_TARGET

feature -- Update

	set_target (a_target: like target) is
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature {NONE} -- Implementation

	directory_location_value: STRING_32 is
			-- Directory location from value with replacements.
		local
			l_loc: CONF_FILE_LOCATION
		do
			check
				target_set: target /= Void
			end
			if value /= Void then
				create l_loc.make (value, target)
				Result := l_loc.evaluated_directory
			else
				create Result.make_empty
			end
		end

end
