indexing
	description: "Retrieves children from an instance of `EIFFELCLASS'."
	external_name: "ISE.AssemblyManager.ChildrenFactory"

class
	CHILDREN_FACTORY

create
	make

feature {NONE} -- Initialization

	make (a_list: like types) is
		indexing
			description: "Set `types' with `a_list'."
			external_name: "Make"
		require
			non_void_type_list: a_list /= Void
		do
			types := a_list
		ensure
			types_set: types = a_list
		end

feature -- Access

	types: LINKED_LIST [EIFFEL_CLASS]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Types in current assembly"
			external_name: "Types"
		end

	recursive_children (a_class: EIFFEL_CLASS): LINKED_LIST [EIFFEL_CLASS] is
			-- | Call in loop to `children'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "All children of `a_class'"
			external_name: "RecursiveChildren"
		require
			non_void_eiffel_class: a_class /= Void
		local
			class_children: LINKED_LIST [EIFFEL_CLASS]
			position: INTEGER
			a_child: EIFFEL_CLASS
			added: INTEGER
			type_children: LINKED_LIST [EIFFEL_CLASS]
			j: INTEGER
			a_type_child: EIFFEL_CLASS
		do
			create Result.make
			class_children := children (a_class)
			from
				class_children.start
			until
				class_children.after
			loop
				a_child ?= class_children.item
				if a_child /= Void then
					if not Result.has (a_child) then
						Result.extend (a_child)
					end
					type_children := children (a_child)
					from
						type_children.start
					until
						type_children.after
					loop
						a_type_child ?= type_children.item
						if a_type_child /= Void and then not Result.has (a_type_child) then
							Result.extend (a_type_child)
						end
						type_children.forth
					end
				end
				class_children.forth
			end
			if Result.has (a_class) then
				position := Result.index_of (a_class, 1)
				if position > 0 then
					Result.remove
				end
			end
		ensure
			children_created: Result /= Void
		end
	
feature {NONE} -- Implementation

	children (a_class: EIFFEL_CLASS): LINKED_LIST [EIFFEL_CLASS] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Children of `a_class'"
			external_name: "Children"
		require
			non_void_class: a_class /= Void
		local
			i: INTEGER
			a_type: EIFFEL_CLASS
			a_parent: STRING
			added: INTEGER
			moved: BOOLEAN
			eiffel_class_name: STRING
		do
			create Result.make
			from
				types.start
			until	
				types.after
			loop
				a_type ?= types.item
				if a_type /= Void then
					from
						a_type.parents.start
					until
						a_type.parents.after
					loop
						a_parent ?= a_type.parents.key_for_iteration
						a_parent := a_parent.clone (a_parent)
						a_parent.to_lower
						eiffel_class_name := a_class.eiffel_name.clone (a_class.eiffel_name)
						eiffel_class_name.to_lower
						if a_parent.is_equal (eiffel_class_name) and not Result.has (a_type) then
							Result.extend (a_type)
						end
					end
				end
				types.forth
			end
		ensure
			children_created: Result /= Void
		end

end -- class CHILDREN_FACTORY
