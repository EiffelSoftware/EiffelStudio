note

	description:

		"AST Element of Phase 1, represents macros"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_MACRO

inherit

	ANY
		redefine
			out
		end

create

	make,
	make_with_arguments,
	make_with_definition,
	make_with_arguments_and_definition

feature

	make (a_name: STRING)
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
			create definition.make_empty
			create arguments.make
		end


	make_with_definition (a_name: STRING; a_definition: STRING)
		require
			a_name_not_void: a_name /= Void
			a_definition_not_void: a_definition /= Void
		do
			name := a_name
			definition := a_definition
			create arguments.make
		end

	make_with_arguments_and_definition (a_name: STRING; a_arguments: DS_LINKED_LIST[STRING]; a_definition: STRING)
		require
			a_name_not_void: a_name /= Void
			a_definition_not_void: a_definition /= Void
			a_arguments_not_void: a_arguments /= Void
--			a_arguments_has_no_void_item: not a_arguments.has (Void)
		do
			name := a_name
			arguments := a_arguments
			definition := a_definition
		end

	make_with_arguments (a_name: STRING; a_arguments: DS_LINKED_LIST[STRING])
		require
			a_name_not_void: a_name /= Void
			a_arguments_not_void: a_arguments /= Void
--			a_arguments_has_no_void_item: not a_arguments.has (Void)
		do
			name := a_name
			arguments := a_arguments
			create definition.make_empty
		end

feature

	name: STRING
			-- name of macro

	arguments: DS_LINKED_LIST [STRING]
			-- arguments of the macro

	definition: STRING
			-- definition of macro

feature

	out: STRING
		local
			cs: DS_LINKED_LIST_CURSOR [STRING]
		do
			Result := "macro: " + name
			if arguments.count > 0 then
				Result := Result + "("
				from
					cs := arguments.new_cursor
					cs.start
				until
					cs.off
				loop
					Result := Result + cs.item
					if not cs.is_last then
						Result := Result + ", "
					end
					cs.forth
				end
				Result := Result + ")"
			end

			Result := Result + " -> " + definition
		end

invariant

	name_not_void: name /= Void

	definition_not_void: definition /= Void

	arguments_not_void: arguments /= Void

--	arguments_has_no_void_item: not arguments.has (Void)

end
