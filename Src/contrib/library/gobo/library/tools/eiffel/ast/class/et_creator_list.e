note

	description:

		"Eiffel lists of creation clauses"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_CREATOR_LIST

inherit

	ET_AST_NODE

	ET_HEAD_LIST [ET_CREATOR]

create

	make, make_with_capacity

feature -- Initialization

	reset
			-- Reset creators as they were when they were last parsed.
		local
			i, nb: INTEGER
		do
			nb := count - 1
			from i := 0 until i > nb loop
				storage.item (i).reset
				i := i + 1
			end
		end

feature -- Status report

	is_exported_to (a_name: ET_FEATURE_NAME; a_client: ET_CLASS): BOOLEAN
			-- Is feature name listed in current creation clauses
			-- and is it exported to `a_client'?
			-- (Note: Use `current_system.ancestor_builder' on the classes whose ancestors
			-- need to be built in order to check for descendants.)
		require
			a_name_not_void: a_name /= Void
			a_client_not_void: a_client /= Void
		local
			i, nb: INTEGER
		do
			nb := count - 1
			from i := 0 until i > nb loop
				if storage.item (i).is_exported_to (a_name, a_client) then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

	is_directly_exported_to (a_name: ET_FEATURE_NAME; a_client: ET_CLASS): BOOLEAN
			-- Is feature name listed in current creation clauses
			-- and is it directly_exported to `a_client'?
			-- This is different from `is_exported_to' where `a_client' can
			-- be a descendant of a class appearing in the list of clients.
			-- Note: The use of 'direct' in the name of this feature has not
			-- the same meaning as 'direct and indirect client' in ETL2 p.91.
		require
			a_name_not_void: a_name /= Void
			a_client_not_void: a_client /= Void
		local
			i, nb: INTEGER
		do
			nb := count - 1
			from i := 0 until i > nb loop
				if storage.item (i).is_directly_exported_to (a_name, a_client) then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

feature -- Access

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			if is_empty then
				Result := tokens.null_position
			else
				Result := first.position
			end
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			if not is_empty then
				Result := first.first_leaf
			end
		end

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			if not is_empty then
				Result := last.last_leaf
			end
		end

	break: ET_BREAK
			-- Break which appears just after current node
		do
			if not is_empty then
				Result := last.break
			end
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_creator_list (Current)
		end

feature {NONE} -- Implementation

	fixed_array: KL_SPECIAL_ROUTINES [ET_CREATOR]
			-- Fixed array routines
		once
			create Result
		end

end
