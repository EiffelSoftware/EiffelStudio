indexing
	description: "Generate a table between local names and LOCAL_INFO instance for a routine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_LOCALS_INFO

inherit
	AST_NULL_VISITOR
		redefine
			process_feature_as,
			process_body_as,
			process_routine_as
		end

	SHARED_EVALUATOR
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

feature -- Access

	local_table (a_class: CLASS_C; a_feature: FEATURE_I; a_node: FEATURE_AS): HASH_TABLE [LOCAL_INFO, STRING] is
			-- Local table.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
			a_node_not_void: a_node /= Void
		do
			current_class := a_class
			current_feature := a_feature
			is_for_format := False
			a_node.process (Current)
			Result := last_locals
			reset
		end

feature {NONE} -- Implementation: access

	is_for_format: BOOLEAN
			-- Are locals computed for format purposes?

	current_class: CLASS_C
			-- Associated class where locals of `current_feature' if any will be computed.

	current_feature: FEATURE_I
			-- Associated feature if any to compute locals

	last_locals: HASH_TABLE [LOCAL_INFO, STRING]
			-- Last computed table

feature {NONE} -- Settings

	reset is
			-- Reset current.
		do
			current_class := Void
			current_feature := Void
			last_locals := Void
		end

feature {NONE} -- Implementation

	process_feature_as (l_as: FEATURE_AS) is
		do
			l_as.body.process (Current)
		end

	process_body_as (l_as: BODY_AS) is
		do
			safe_process (l_as.content)
		end

	process_routine_as (l_as: ROUTINE_AS) is
		local
			l_feat_tbl: FEATURE_TABLE
			l_id_list: ARRAYED_LIST [INTEGER]
			l_solved_type: TYPE_A
			l_local_info: LOCAL_INFO
			i: INTEGER
			l_locals: EIFFEL_LIST [TYPE_DEC_AS]
		do
			l_locals := l_as.locals
			if l_locals /= Void and not l_locals.is_empty then
				from
					create last_locals.make (2 * l_locals.count)
					l_feat_tbl := current_feature.written_class.feature_table
					type_a_checker.init_for_checking (current_feature, l_feat_tbl.associated_class, Void, Void)
					l_locals.start
				until
					l_locals.after
				loop
					from
						l_id_list := l_locals.item.id_list
						l_solved_type := type_a_generator.evaluate_type (l_locals.item.type, current_class)
						l_solved_type := type_a_checker.solved (l_solved_type, l_locals.item.type)
						l_id_list.start
					until
						l_id_list.after
					loop
						create l_local_info
						i := i + 1
						l_local_info.set_position (i)
						l_local_info.set_type (l_solved_type)
						last_locals.put (l_local_info, Names_heap.item (l_id_list.item))
						l_id_list.forth
					end
					l_locals.forth
				end
			else
				last_locals := empty_local_table
			end
		end

	empty_local_table: HASH_TABLE [LOCAL_INFO, STRING] is
			-- Empty local table
		once
			create Result.make (0)
		end
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
