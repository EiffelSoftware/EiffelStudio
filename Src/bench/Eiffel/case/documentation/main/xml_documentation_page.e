indexing
	description: "Documentation Page."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DOCUMENTATION_PAGE

creation
	make

feature -- Initialization

	make(s: STRING) is
			-- Initialization
		require
			not_void: s /= Void
		local
			ind,ind2: INTEGER
			ss: STRING
			err: BOOLEAN
		do
			if not err then
				error := FALSE
				Create list.make
				ss := clone(s)
				ind := 2
				from
				until
					(ind<2)
				loop
					ind := ss.substring_index("<FL_LOOP>",1)
					ind2 := ss.substring_index("</FL_LOOP>",ind)
					if ind >1 and then ind2>ind then
						list.extend(ss.substring(1,ind-1))
						list.extend(ss.substring(ind,ind2+10))
						ss := ss.substring(ind2+11,ss.count)
					else
						list.extend(ss)
					end
				end
			else
				error := TRUE
			end
		rescue
			err := TRUE
			retry
		end

feature -- Access

	error: BOOLEAN

	list: LINKED_LIST[STRING]
	
end -- class XML_DOCUMENTATION_PAGE
