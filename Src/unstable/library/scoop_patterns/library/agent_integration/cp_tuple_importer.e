note
	description:
		"[
			Importer for TUPLE objects.
			
			Note: The importer is using reflection. It does not support
			reference objects or user-defined expanded types.
			
			The precondition of `import' will only accept tuples with
			basic expanded types or truly separate references.
			
			Due to a limitation of the runtime, `is_importable' will
			also reject objects which are only declared as separate
			but actually belong to the same processor as the tuple object.
			
			
			The feature `unsafe_import' does not check the validity of
			its argument. It may be used to circumvent the above limitation.
			However, if you pass it a tuple with non-separate objects, you
			will get a traitor!
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_TUPLE_IMPORTER

inherit

	CP_IMPORT_VALIDATOR
		rename
			is_tuple_importable as is_importable
		end

	CP_IMPORTER [TUPLE]
		undefine
			is_importable
		end

feature -- Duplication

	import (tuple: separate TUPLE): TUPLE
			-- Import `tuple' by creating a copy on the local processor.
		do
			Result := do_import (tuple)
		ensure then
			same_count: Result.count = tuple.count
			correct_copy: across 1 |..| Result.count as idx all tuple [idx.item] = Result [idx.item] end
			same_type: Result.generating_type ~ tuple.generating_type
		end

	unsafe_import (tuple: separate TUPLE): TUPLE
			-- Import `tuple' by creating a copy on the local processor.
			-- Note: This function is very dangerous, as it may introduce traitors.
			-- Make sure you only pass TUPLE objects where all references
			-- objects are declared separate.
		do
			Result := do_import (tuple)
		ensure
			same_count: Result.count = tuple.count
			correct_copy: across 1 |..| Result.count as idx all tuple [idx.item] = Result [idx.item] end
			same_type: Result.generating_type ~ tuple.generating_type
		end

feature {NONE} -- Implementation

	do_import (tuple: separate TUPLE): TUPLE
			-- Import `tuple' using some reflection.
		local
			l_tuple_type_id: INTEGER
		do
			l_tuple_type_id := {ISE_RUNTIME}.dynamic_type (tuple)

				-- This tuple creation should always succeed, because the type is exactly the same.
			check attached reflector.new_tuple_from_tuple (l_tuple_type_id, tuple) as l_result then
				Result := l_result
			end
		end

end
