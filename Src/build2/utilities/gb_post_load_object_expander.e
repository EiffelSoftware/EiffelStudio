indexing
	description: "Objects that permit expansion of layout items on objects after loading."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_POST_LOAD_OBJECT_EXPANDER

feature -- Status setting

	register_object_as_expanded (an_object: GB_OBJECT) is
			-- Add `an_object' to `expanded_objects'.
		require
			an_object_not_void: an_object /= Void
			not_already_marked: not Expanded_objects.has (an_object)
		do
			expanded_objects.extend (an_object)
		ensure
			registered: expanded_objects.has (an_object)
		end
		
feature -- Basic operations

	expand_all_registered_objects is
			-- Expand all relevent representations of all objects in
			-- `expanded_objects', and leave `expanded_objects' empty.
		do
			from
				expanded_objects.start
			until
				expanded_objects.off
			loop
			--	if expanded_objects.item.layout_item.is_expandable then
					expanded_objects.item.layout_item.expand	
					expanded_objects.remove
			--	end
			end
		ensure
			expanded_objects_empty: expanded_objects.is_empty
		end
		
feature {NONE} -- Implementation

	expanded_objects: ARRAYED_LIST [GB_OBJECT] is
			-- `Result' is all objects marked as expanded.
		once
			create Result.make (0)
		end

invariant
	expanded_objects_not_void: expanded_objects /= Void

end -- class GB_POST_LOAD_OBJECT_EXPANDER
