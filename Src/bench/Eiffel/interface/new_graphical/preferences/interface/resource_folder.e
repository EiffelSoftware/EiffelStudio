indexing
	description: "Class which encapsulates the information relative to a resource category."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_FOLDER

create
	make

feature -- Initialization

	make (imp: RESOURCE_FOLDER_I) is
		do
			implementation := imp
		end

feature -- Access

	name: STRING is
			-- Id of Current, it is unique.
		do
			Result := implementation.name
		end

	description: STRING is
			-- Description of Current.
		do
			Result := implementation.description
		end

	resource_list: LINKED_LIST [RESOURCE] is
			-- List of resources.
		do
			Result := implementation.resource_list
		end

	child_list: LINKED_LIST [RESOURCE_FOLDER] is
			-- List of Categories.
		local
			child_list_i: LINKED_LIST [RESOURCE_FOLDER_I]
		do
			child_list_i := implementation.child_list
			create Result.make
			from
				child_list_i.start
			until
				child_list_i.after
			loop
				Result.extend (child_list_i.item.interface)
				child_list_i.forth
			end
		end

feature {NONE} -- Implementation

	implementation: RESOURCE_FOLDER_I

end -- class RESOURCE_FOLDER
