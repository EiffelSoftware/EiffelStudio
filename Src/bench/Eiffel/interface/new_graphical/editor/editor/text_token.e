indexing
	description: "Item of a 2-3-4 tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_TOKEN

inherit
	ANY

create
	make

feature -- Initialization

	make (v: STRING) is
			-- Initialize Current
		do
			value := v
		end

feature -- Access

	value: STRING

	length: INTEGER is
		do
			Result := value.count
		end

	width: INTEGER is
			-- witdh of Current in pixels
			-- Not_implemented.
		do
			check
				Not_implemented: False
			end
		end

feature --

end -- TEXT_TOKEN
