indexing
	description: "Output the same class with the an added process routine."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ADD_PROCESS_VISITOR

inherit
	AST_ROUNDTRIP_PRINTER_VISITOR
		redefine
			process_class_as,
			process_parent_as,
			context
		end

create
	make_with_default_context

feature -- Main Process

	add_process_routine (a_opts: APPLICATION_OPTIONS; a_new_line: STRING) is
			-- Process `parsed_class' and add a `process' routine.
		require
			a_opts_not_void: a_opts /= Void
			a_new_line_not_void: a_new_line /= Void
		do
			options := a_opts
			new_line := a_new_line
			process_ast_node (parsed_class)
			options := Void
			new_line := Void
		end

feature -- AST visiting

	process_class_as (l_as: CLASS_AS) is
		local
			s: STRING_AS
		do
			safe_process (l_as.internal_top_indexes)
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.deferred_keyword)
			safe_process (l_as.expanded_keyword)
			safe_process (l_as.separate_keyword)
			safe_process (l_as.external_keyword)
			safe_process (l_as.class_keyword)
			safe_process (l_as.class_name)
			safe_process (l_as.internal_generics)
			safe_process (l_as.alias_keyword)
			s ?= l_as.external_class_name
			safe_process (s)
			safe_process (l_as.obsolete_keyword)
			safe_process (l_as.obsolete_message)
			safe_process (l_as.internal_conforming_parents)
			safe_process (l_as.internal_non_conforming_parents)
			safe_process (l_as.creators)
			safe_process (l_as.convertors)
			safe_process (l_as.features)
			generate_process_routine
			safe_process (l_as.internal_invariant)
			safe_process (l_as.internal_bottom_indexes)
			safe_process (l_as.end_keyword)
		end

	process_parent_as (l_as: PARENT_AS) is
		local
			l_has_redefine: BOOLEAN
		do
			safe_process (l_as.type)
			safe_process (l_as.internal_renaming)
			safe_process (l_as.internal_exports)
			safe_process (l_as.internal_undefining)
				-- If parent is one of the class for which we are adding a `process' routine, then
				-- it means that we need to redefine it.
			if l_as.type /= Void and then options.universe.has_class (l_as.type.class_name.name.as_lower) then
				if l_as.internal_redefining = Void then
					context.add_string (new_line)
					context.add_string ("%T%Tredefine")
					context.add_string (new_line)
					context.add_string ("%T%T%Tprocess")
					context.add_string (new_line)
					l_has_redefine := True
				end
			else
				safe_process (l_as.internal_redefining)
			end
			safe_process (l_as.internal_selecting)
			if l_has_redefine and then l_as.end_keyword = Void then
				context.add_string ("%T%Tend")
				remove_following_white_spaces
				context.add_string (new_line)
				context.add_string (new_line)
			else
				safe_process (l_as.end_keyword)
			end
		end

feature {NONE} -- Implementation

	options: APPLICATION_OPTIONS
			-- Various processing options.

	new_line: STRING
			-- Type of new line character in Current parsed class.

	context: ROUNDTRIP_STRING_LIST_CONTEXT

	generate_process_routine is
		do
			remove_following_white_spaces
			context.add_string (new_line)
			context.add_string (new_line)
			context.add_string ("feature -- Visitor")
			context.add_string (new_line)
			context.add_string (new_line)
			context.add_string ("%Tprocess (a_visitor: ")
			context.add_string (options.interface_class_name)
			if options.use_user_data then
				context.add_string (" [")
				context.add_string (options.user_data_class_name)
				context.add_string ("]; a_data: ")
				context.add_string (options.user_data_class_name)
			end
			context.add_string (") is")
			context.add_string (new_line)
			context.add_string ("%T%Tdo")
			context.add_string (new_line)
			context.add_string ("%T%T%Ta_visitor.process_")
			context.add_string (parsed_class.class_name.name.as_lower)
			context.add_string (" (Current")
			if options.use_user_data then
				context.add_string (", a_data")
			end
			context.add_string (")")
			context.add_string (new_line)
			context.add_string ("%T%Tend")
			context.add_string (new_line)
			context.add_string (new_line)
		end

	remove_following_white_spaces is
			-- Remove all white spaces..
		local
			l_break_as: BREAK_AS
			l_index: INTEGER
			l_string: STRING
			l_done: BOOLEAN
		do
			l_index := last_index + 1
			if match_list.valid_index (l_index) then
				l_break_as ?= match_list.i_th (last_index + 1)
				if l_break_as /= Void then
					l_string := l_break_as.literal_text (match_list)
					if l_string /= Void then
						l_string := l_string.twin
						from
						until
							l_done
						loop
							if not l_string.is_empty then
								inspect
									l_string.item (1)
								when ' ', '%T', '%N', '%R' then l_string.remove (1)
								else
									l_done := True
								end
							else
								l_done := True
							end
						end
						context.add_string (l_string)
						last_index := l_index
					end
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
