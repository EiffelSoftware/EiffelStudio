note
	description: "Remove null and false object members."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_NULL_AND_FALSE_MEMBER_REMOVER

inherit
	JSON_ITERATOR
		redefine
			visit_json_object
		end

feature -- Visit

	visit_json_object (a_json_object: JSON_OBJECT)
			-- <Precursor>
		local
			lst: ARRAYED_LIST [JSON_STRING]
		do
			across
				a_json_object as c
			loop
				if
					attached {JSON_NULL} c.item
					or else attached {JSON_BOOLEAN} c.item as jb and then not jb.item
				then
					if lst = Void then
						create lst.make (1)
					end
					lst.force (c.key)
				else
					c.item.accept (Current)
				end
			end
			if lst /= Void then
				across
					lst as c
				loop
					a_json_object.remove (c.item)
				end
				lst.wipe_out
			end
		end

end
