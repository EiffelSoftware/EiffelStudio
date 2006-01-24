indexing
	description: "Objects that is used to find local entities form a feature as."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LOCAL_ENTITIES_FINDER_FROM_AST

inherit
	EB_LOCAL_ENTITIES_FINDER

	SHARED_NAMES_HEAP
		export
			{NONE} All
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- initialize `Current'.
		do
			create found_entities.make (2)
			create found_locals_list.make (2)
			create found_arguments_list.make (2)
		end

feature -- Basic Operations

	build_entities_list (a_feature_as: FEATURE_AS) is
			-- Build list of locals and argument types (`found_entities') corresponding to a position
			-- in a text defined by `line' and `token'.
		require
			a_feature_as: a_feature_as /= Void
		do
			reset
			feature_as := a_feature_as
			build_lists
			found_entities := found_locals_list
			found_entities.append (found_arguments_list)
		end

	reset is
			-- Wipe lists out .
		do
			has_return_type := False
			found_entities.wipe_out
			found_locals_list.wipe_out
			found_arguments_list.wipe_out
		ensure then
			found_entities_empty: found_entities.is_empty
			found_locals_list_empty: found_locals_list.is_empty
			found_arguments_list_empty: found_arguments_list.is_empty
		end

feature -- Access

	found_names: LINKED_LIST [STRING] is
			-- List of found entity names.
		local
			id_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make
			if found_entities /= Void and not found_entities.is_empty then
				from
					found_entities.start
				until
					found_entities.after
				loop
					from
						id_list := found_entities.item.id_list
						id_list.start
					until
						id_list.after
					loop
						Result.extend (Names_heap.item (id_list.item))
						id_list.forth
					end
					found_entities.forth
				end
			end
		end

	found_locals_list: EIFFEL_LIST [TYPE_DEC_AS]
			-- List of found locals for current routine

	has_return_type: BOOLEAN
			-- Does feature have a return type?

feature {NONE} -- Implementation

	build_lists is
			-- Build list of local types.
			-- Resulting local nodes will be put in `found_locals_list'.
			-- Build list of argument types.
			-- Resulting argument nodes will be put in `found_arguments_list'.
			-- Attempts to locate a return type
		require
			found_locals_list_empty: found_locals_list.is_empty
		local
			l_routine_as: ROUTINE_AS
			l_body: BODY_AS
		do
			if feature_as /= Void then
				l_body := feature_as.body
				if l_body /= Void then
					l_routine_as ?= l_body.content
					if l_routine_as /= Void and then l_routine_as.locals /= Void then
						found_locals_list := l_routine_as.locals.twin
					end
					if l_body.arguments /= Void then
						found_arguments_list := l_body.arguments.twin
					end
					has_return_type := (l_body.type /= Void)
				end
			end
		end

feature {NONE} -- Implementation: Access	

	found_entities: EIFFEL_LIST [TYPE_DEC_AS]

	found_arguments_list: EIFFEL_LIST [TYPE_DEC_AS]

	feature_as: FEATURE_AS

invariant
	found_locals_list_not_void: found_locals_list /= Void
	found_entities_not_void: found_entities /= Void
	found_arguments_list_not_void: found_arguments_list /= Void

end -- class EB_LOCAL_ANALYZER

