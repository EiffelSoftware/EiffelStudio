class MT_RELATIONSHIP

inherit

	MT_PROPERTY
		rename id as rid
		redefine is_ok
	end

	MT_STREAMABLE

	MT_RELATIONSHIP_EXTERNAL

	MT_NAME_EXTERNAL

	DB_DATA

	MATISSE_CONST

creation

	make, make_from_id

feature {NONE} -- Initialization

	make(relationship_name : STRING) is
		-- Get relationship from database
	require
		string_not_void : relationship_name /= Void
		string_not_empty : not relationship_name.empty
	local
		relationship_name_to_c : ANY
	do
		relationship_name_to_c := relationship_name.to_c
		rid := c_get_relationship_from_name($relationship_name_to_c)
	end -- make

feature {MT_OBJECT_REL_STREAM,MT_OBJECT_IREL_STREAM,MT_CLASS} -- Initialization

	make_from_id(rel_id : INTEGER) is
		-- Use id retrieved in Matisse to create Eiffel object
		do
			rid := rel_id
		end -- make_from_id

feature -- Status Report

	is_ok(one_object : MT_OBJECT) : BOOLEAN is
		-- Check if relationship is OK
		do
			c_check_relationship(rid,one_object.oid)
		end -- check

	name : STRING is
		-- Relationship name in Matisse
		do
			!!Result.make(0) Result.from_c(c_object_name(rid))
		end -- name

	successors : ARRAY[MT_CLASS] is
		-- Types of objets available via relationship
		local
			one_selection : DB_SELECTION
			query : DB_PROC
			one_container : LINKED_LIST[DB_RESULT]
			i : INTEGER
			one_object : MT_OBJECT
			one_class : MT_CLASS
			one_relationship : MT_RELATIONSHIP
		do
			!!one_selection.make
			!!query.make(Ors)
			!!one_object.make(rid)
			one_selection.set_map_name(one_object,Object_map)
			!!one_relationship.make("Mt Successors")
			one_selection.set_map_name(one_relationship,Relationship_map)
			query.execute(one_selection) 
 			!!one_container.make
			one_selection.set_container(one_container) 
			if one_selection.is_ok then
				one_selection.load_result    
				from
					one_container.start
					!!Result.make(1,one_container.count)
					i:=1
				until
					one_container.off
				loop
					one_object ?= one_container.item.data
					!!one_class.make_from_id(one_object.oid)
					Result.put(one_class,i)
					one_container.forth
					i:=i+1
				end -- loop
			end -- if
		end -- successors

feature {NONE} -- Implementation

	stream : MT_RELATIONSHIP_STREAM

end -- class MT_RELATIONSHIP
