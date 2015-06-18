note
	description: " Objects that can be imported from a separate object.%
				 % Descendants should declare `make_from_separate' as a creation procedure."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_IMPORTABLE

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate like Current)
			-- Initialize `Current' with the same values as `other'.
		deferred
		end

end
