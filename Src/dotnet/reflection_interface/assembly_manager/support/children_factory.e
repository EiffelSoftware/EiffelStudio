indexing
	description: "Retrieves children from an instance of `ISE_REFLECTION_EIFFELCLASS'."
	external_name: "ISE.AssemblyManager.ChildrenFactory"

class
	CHILDREN_FACTORY

create
	make

feature {NONE} -- Initialization

	make (a_list: like types) is
			-- Set `types' with `a_list'.
		indexing
			external_name: "Make"
		require
			non_void_type_list: a_list /= Void
		do
			types := a_list
		ensure
			types_set: types = a_list
		end

feature -- Access

	types: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Types in current assembly
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "Types"
		end

	recursive_children (a_class: ISE_REFLECTION_EIFFELCLASS): SYSTEM_COLLECTIONS_ARRAYLIST is
			-- All children of `a_class'
			-- | Call in loop to `children'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "RecursiveChildren"
		require
			non_void_eiffel_class: a_class /= Void
		local
			class_children: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			added: INTEGER
			type_children: SYSTEM_COLLECTIONS_ARRAYLIST
			j: INTEGER
			a_type_child: ISE_REFLECTION_EIFFELCLASS
		do
			create Result.make
			class_children := children (a_class)
			from
				i := 0
			until
				i = class_children.count
			loop
				a_child ?= class_children.item (i)
				if a_child /= Void then
					if not Result.contains (a_child) then
						added := Result.add (a_child)
					end
					type_children := children (a_child)
					from
						j := 0
					until
						j = type_children.count
					loop
						a_type_child ?= type_children.item (j)
						if a_type_child /= Void and then not Result.contains (a_type_child) then
							added := Result.add (a_type_child)
						end
						j := j + 1
					end
				end
				i := i + 1
			end
		ensure
			children_created: Result /= Void
		end
	
feature {NONE} -- Implementation

	children (a_class: ISE_REFLECTION_EIFFELCLASS): SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Children of `a_class' 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "Children"
		require
			non_void_class: a_class /= Void
		local
			i: INTEGER
			a_type: ISE_REFLECTION_EIFFELCLASS
			parents_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_parent: STRING
			added: INTEGER
			moved: BOOLEAN
		do
			create Result.make
			from
				i := 0
			until	
				i = types.count
			loop
				a_type ?= types.item (i)
				if a_type /= Void then
					parents_enumerator := a_type.parents.keys.getenumerator
					from
					until
						not parents_enumerator.movenext
					loop
						a_parent ?= parents_enumerator.current_
						if a_parent.tolower.equals_string (a_class.eiffelname.tolower) and not Result.contains (a_type) then
							added := Result.add (a_type)
						end
						--moved := parents_enumerator.movenext
					end
				end
				i := i + 1
			end
		ensure
			children_created: Result /= Void
		end

end -- class CHILDREN_FACTORY
