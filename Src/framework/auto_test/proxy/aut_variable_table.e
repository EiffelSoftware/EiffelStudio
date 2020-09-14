note
	description:

		"Maps variables to their type"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_VARIABLE_TABLE

inherit
	AUT_SHARED_RANDOM
		export {NONE} all end

	ITP_VARIABLE_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make (a_system: like system)
			-- Create new handler.
		require
			a_system_not_void: a_system /= Void
		local
			tester: AUT_VARIABLE_EQUALITY_TESTER
		do
			create name_generator.make_with_string_stream (variable_name_prefix)
			create tester.make
			create variable_type_table.make_with_key_tester (10, tester)
			system := a_system
		ensure
			system_set: system = a_system
		end

feature -- Status report

	is_variable_defined (a_variable: ITP_VARIABLE): BOOLEAN
			-- Is variable `a_variable' defined in interpreter?
		require
			a_variable_not_void: a_variable /= Void
		do
			Result := variable_type_table.has (a_variable)
		end

	are_expressions_valid (a_list: DS_LINEAR [ITP_EXPRESSION]): BOOLEAN
			-- Are the expressions in `a_list' valid? I.e. are the variables in `a_list' defined?
		require
			a_list_not_void: a_list /= Void
			a_list_doesnt_have_void: not a_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			v: ITP_VARIABLE
		do
			from
				cs := a_list.new_cursor
				cs.start
				Result := True
			until
				cs.off or not Result
			loop
				v ?= cs.item
				if v /= Void and then not is_variable_defined (v) then
					Result := False
				else
					cs.forth
				end
			end
			cs.go_after
		end

feature -- Access

	system: SYSTEM_I
			-- system

	variable_type (a_variable: ITP_VARIABLE): TYPE_A
			-- Type of `a_variable'
			-- Void of the value of `a_variable' is Void so we don't know the exact type of `a_variable' from the proxy side.
		require
			a_variable_not_void: a_variable /= Void
			variable_defined: is_variable_defined (a_variable)
		do
			Result := variable_type_table.item (a_variable)
		ensure
			result_attached: Result /= Void
		end

	random_variable: ITP_VARIABLE
			-- Random variable from interpreter or `Void' if none
			-- defined
		local
			i: INTEGER
			j: INTEGER
			l_variable_type_table: like variable_type_table
		do
			l_variable_type_table := variable_type_table
			if variable_type_table.count > 0 then
				random.forth
				i := (random.item  \\ variable_type_table.count) + 1
				from
					j := 1
					l_variable_type_table.start
				until
					i = j
				loop
					l_variable_type_table.forth
					j := j + 1
				end
				Result := l_variable_type_table.key_for_iteration
			end
		ensure
			variable_defined: Result /= Void implies is_variable_defined (Result)
		end

	random_conforming_variable (a_context_class: CLASS_C; a_type: TYPE_A): ITP_VARIABLE
			-- Random variable of `conforming_variables (a_type)' or Void if list
			-- is emtpy
		require
			a_context_class_not_Void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_type_not_void: a_type /= Void
		local
			list: like conforming_variables
			cs: DS_LINEAR_CURSOR [ITP_VARIABLE]
			i: INTEGER
			j: INTEGER
		do
			list := conforming_variables (a_context_class, a_type)
			if list.count > 0 then
				random.forth
				i := (random.item  \\ list.count) + 1
				from
					j := 1
					cs := list.new_cursor
					cs.start
				until
					i = j
				loop
					cs.forth
					j := j + 1
				end
				Result := cs.item
				cs.go_after
			end
		ensure
			variable_defined: Result /= Void implies is_variable_defined (Result)
		end

	conforming_variables (a_context_class: CLASS_C; a_type: TYPE_A): DS_LIST [ITP_VARIABLE]
			-- All defeined variables conforming to `a_type'
		require
			a_context_class_not_Void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_type_not_void: a_type /= Void
		local
			l_type: TYPE_A
		do
			create {DS_ARRAYED_LIST [ITP_VARIABLE]} Result.make (variable_type_table.count)
			across variable_type_table as cs loop
				l_type := cs.item.actual_type

					-- On non-Void-Safe
					-- We only allow Void conforms to a non expanded type.
					--
					-- On Void-Safe: Void is discarded
					-- when the type `a_type` is directly attached.
					--
					-- To check if the current system is Void-Safe we just do the following comparison.
					-- system.void_safety_index /= {CONF_TARGET_OPTION}.void_safety_index_none

				if system.void_safety_index /= {CONF_TARGET_OPTION}.void_safety_index_none and then l_type.is_none and then a_type.is_directly_attached then
					-- Avoid void.
				else
					if l_type.is_conformant_to (a_context_class, a_type) and then not (a_type.is_expanded and then l_type.is_none) then
						Result.force_last (cs.key)
					end
				end
			end
		ensure
			variables_not_void: Result /= Void
			variables_doesnt_have_void: not Result.has (Void)
		end

	new_variable: ITP_VARIABLE
			-- Variable not yet defined
		do
			name_generator.generate_new_name
			create Result.make (name_generator.index)
			name_generator.output_string.wipe_out
		ensure
			variable_not_void: Result /= Void
			variable_not_defined: not is_variable_defined (Result)
		end

feature -- Element change

	define_variable (a_variable: ITP_VARIABLE; a_type: TYPE_A)
			-- Define variable `a_variable' to be of type `a_type'.
			-- `a_type' is Void means that the value of `a_variable' is Void so we don't know the exact type of it
			-- from the proxy side.
		require
			a_variable_not_void: a_variable /= Void
			a_type_attached: a_type /= Void
		do
			variable_type_table.force (a_type, a_variable)
		ensure
			variable_defined: is_variable_defined (a_variable)
			variable_has_valid_type: variable_type (a_variable) = a_type
		end

feature -- Removal

	wipe_out
			-- Remove all variable mappings.
		do
			create name_generator.make_with_string_stream (variable_name_prefix)
			variable_type_table.wipe_out
		ensure
			variable_type_table_empty: variable_type_table.is_empty
		end

	name_generator: AUT_UNIQUE_NAME_GENERATOR
			-- Name generator for variable names

	variable_type_table: HASH_TABLE_EX [TYPE_A, ITP_VARIABLE]
			-- Table mapping interprteter variables to their type

invariant

	system_not_void: system /= Void
	name_generator_not_void: name_generator /= Void
	variable_type_table_not_void: variable_type_table /= Void
	all_variables_have_type: not variable_type_table.has (Void)

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
