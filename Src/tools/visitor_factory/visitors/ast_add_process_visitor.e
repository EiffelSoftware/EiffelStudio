note
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

	add_process_routine (a_opts: APPLICATION_OPTIONS; a_new_line: STRING)
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

	process_class_as (l_as: CLASS_AS)
		local
			s: STRING_AS
		do
			safe_process (l_as.internal_top_indexes)
			safe_process (l_as.frozen_keyword (match_list))
			safe_process (l_as.deferred_keyword (match_list))
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.external_keyword (match_list))
			safe_process (l_as.class_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.internal_generics)
			safe_process (l_as.alias_keyword (match_list))
			s ?= l_as.external_class_name
			safe_process (s)
			safe_process (l_as.obsolete_keyword (match_list))
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

	process_parent_as (l_as: PARENT_AS)
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
				else
					safe_process (l_as.internal_redefining)
					context.add_string (",")
					context.add_string (new_line)
					context.add_string ("%T%T%Tprocess")
				end
			else
				safe_process (l_as.internal_redefining)
			end
			safe_process (l_as.internal_selecting)
			if l_has_redefine and then l_as.end_keyword (match_list) = Void then
				context.add_string ("%T%Tend")
				process_following_breaks
			else
				safe_process (l_as.end_keyword (match_list))
			end
		end

feature {NONE} -- Implementation

	options: APPLICATION_OPTIONS
			-- Various processing options.

	new_line: STRING
			-- Type of new line character in Current parsed class.

	context: ROUNDTRIP_STRING_LIST_CONTEXT

	generate_process_routine
		do
			process_following_breaks
			add_new_line_if_necessary
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

	process_following_breaks
			-- Process all breaks until a non-break is encountered.
		local
			i: INTEGER
			stop: BOOLEAN
			l_break: BREAK_AS
			l_symbol: SYMBOL_STUB_AS
		do
			from
				i := last_index + 1
			until
				stop
			loop
				if match_list.valid_index (i) then
					l_break ?= match_list.i_th (i)
					if l_break /= Void then
						l_break.process (Current)
						i := i + 1
					else
						l_symbol ?= match_list.i_th (i)
						if l_symbol /= Void then
							l_symbol.process (Current)
							i := i + 1
						else
							stop := True
						end
					end
				else
					stop := True
				end
			end
			last_index := i - 1
		end

	add_new_line_if_necessary
			-- Add a newline if previous is not an empty break line or if is not a break.
		local
			l_break_as: BREAK_AS
			l_index, i: INTEGER
			l_text: STRING
			l_has_new_line: BOOLEAN
		do
			l_index := last_index
			if match_list.valid_index (l_index) then
				l_break_as ?= match_list.i_th (l_index)
				if l_break_as = Void then
					context.add_string (new_line)
				else
					l_text := l_break_as.literal_text (match_list)
					from
						i := l_text.count
					until
						i = 0
					loop
						inspect l_text.item (i)
						when '%N' then
							l_has_new_line := True
							i := 0
						when ' ', '%T', '%R' then
								-- We can ignore those characters.
							i := i - 1
						else
								-- We hit some text, we should stop the loop here.
							i := 0
						end
					end
					if not l_has_new_line then
							--
						context.add_string (new_line)
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
