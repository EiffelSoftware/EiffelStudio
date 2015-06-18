note
	description: "Defines if objects shall be copied across processor boundaries."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_IMPORT_STRATEGY [G]

feature -- Status report

	is_importable (object: separate G): BOOLEAN
			-- Is `object' importable?
		do
			Result := True
		end

feature -- Duplication

	import (object: separate G): separate G
			-- Import `object' based on the strategy defined in `Current'.
		require
			importable: is_importable (object)
		deferred
		end

end
