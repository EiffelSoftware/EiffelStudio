note
	description:
	"[
		Import an object by creating an uninitialized object
		of the same type using reflection, and then calling
		{CP_IMPORTABLE}.make_from_separate on it.
		
		Note: The use of reflection guarantees that the dynamic 
		type of the imported object will be the same as the original
		object, but it also introduces some problems. To make
		this import strategy safe, all descendants of G must satisfy 
		the following two rules:
		
		1) They cannot have invariants.
		
		2) Feature `make_from_separate' must be a creation
		   procedure in every non-deferred descendant of G.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_DYNAMIC_TYPE_IMPORTER[G -> CP_IMPORTABLE]

inherit
	CP_IMPORTER [G]

	REFLECTOR
		export {NONE}
			all
		end

feature

	import (a_object: separate G): G
			-- <Precursor>
		local
			l_type_id: INTEGER
			l_clone: detachable ANY
		do
				-- Get the type id.
			l_type_id := {ISE_RUNTIME}.dynamic_type (a_object)

				-- Create an uninitialized clone on the current processor.
			l_clone := new_instance_of (l_type_id)

				-- Downcast the new object.
			check attached {G} l_clone as l_result then
				Result := l_result
			end

				-- Initialize the result.
			Result.make_from_separate (a_object)
		end

end
