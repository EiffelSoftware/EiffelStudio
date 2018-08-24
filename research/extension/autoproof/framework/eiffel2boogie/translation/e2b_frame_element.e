note
	description: "An entry in a frame description; denotes a set of objects restricted to some fields."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_FRAME_ELEMENT

create
	make

feature {NONE} -- Initialization

	make (a_objects: LIST [IV_EXPRESSION]; a_fields: LIST [IV_ENTITY]; a_type: TYPE_A; a_origin: CLASS_C)
			-- Create an entry in a frame description that denotes a set of objects `a_objects' of type `a_type' restricted to fields `a_fields',
			-- where the frame clause is written in `a_origin'.
		require
			objects_exists: attached a_objects
			fields_exists: attached a_fields
			type_exists: attached a_type
			origin_exists: attached a_origin
		do
			objects := a_objects
			fields := a_fields
			type := a_type
			origin := a_origin
		ensure
			objects_set: objects = a_objects
			fields_set: fields = a_fields
			type_set: type = a_type
			origin_set: origin = a_origin
		end

feature -- Access

	objects: LIST [IV_EXPRESSION]
			-- Object descriptions.

	fields: LIST [IV_ENTITY]
			-- Fields to which the objects are restricted.

	type: TYPE_A
			-- Eiffel type of each of the `objects'.

	origin: CLASS_C
			-- Class where the frame clause was written in.

invariant
	objects_exists: attached objects
	fields_exists: attached fields
	type_exists: attached type
	origin_exists: attached origin

end
