note
	description: "Arguments of a FEATURE_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEAT_ARG

-- FIXME: redefine is_equivalent

inherit
	ARRAYED_LIST [TYPE_A]
		rename
			make as old_make
		export
			{ANY} area
		redefine
			copy
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_EVALUATOR
		undefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		undefine
			copy, is_equal
		end

	SHARED_ERROR_HANDLER
		undefine
			copy, is_equal
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_ENCODING_CONVERTER
		undefine
			copy, is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			copy, is_equal
		end

create
	make

create {FEAT_ARG}
	old_make, make_filled

feature {NONE} -- Implementation

	make (n: INTEGER)
			-- Arrays creation
		do
			old_make (n)
			create argument_names.make_filled (0, n)
		end

feature -- Access

	argument_names: SPECIAL [INTEGER]
			-- Argument names. Index in `Names_heap' table.

	item_id (i: INTEGER): INTEGER
			-- Name of argument at position `i'.
		require
			index_positive: i >= 1
			index_small_enough: i <= count
		do
			Result := argument_names.item (i - 1)
		ensure
			valid_result: Result > 0
		end

	item_name (i: INTEGER): STRING
			-- Name of argument at position `i'.
		require
			index_positive: i >= 1
			index_small_enough: i <= count
		do
			Result := Names_heap.item (argument_names.item (i - 1))
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

	argument_position_id (arg_id: INTEGER; a_start_position: INTEGER): INTEGER
		require
			arg_id_not_void: arg_id >= 0
			valid_start_position: a_start_position >= 1
		do
			if a_start_position <= count then
				Result := 1 + argument_names.index_of (arg_id, a_start_position - 1)
			end
		ensure
			not_found_or_found: Result = 0 or else (Result >= 1 and then Result <= count)
		end

	pattern_types: ARRAY [TYPE_A]
			-- Pattern types of arguments
		local
			l_area: SPECIAL [TYPE_A]
			r_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
				create Result.make (1, nb)
				r_area := Result.area
			until
				i = nb
			loop
				r_area.put (l_area.item (i).meta_type, i)
				i := i + 1
			end
		end

feature -- Duplication

	copy (other: like Current)
			-- Clone
		do
			if other /= Current then
				Precursor {ARRAYED_LIST} (other)
				argument_names := other.argument_names.twin
			end
		end

feature -- Element change

	extend_with_name (a_type: TYPE_A; id: INTEGER)
			-- Record argument name `s'.
		require
			id_valid: id >= 0
		do
			extend (a_type)
			argument_names.put (id, count - 1)
		end

feature -- Checking

	check_types (feat_table: FEATURE_TABLE; f: FEATURE_I)
			-- Check like types in arguments and instantiate arguments
		require
			good_argument: not (feat_table = Void or f = Void)
		local
			solved_type: TYPE_A
			associated_class: CLASS_C
			i, nb: INTEGER
			l_area: SPECIAL [TYPE_A]
			a_area: like argument_names
			l_names_heap: like Names_heap
		do
			from
				a_area := argument_names
				l_area := area
				l_names_heap := Names_heap
				nb := count
				associated_class := feat_table.associated_class
				type_a_checker.init_with_feature_table (f, feat_table, error_handler)
			until
				i = nb
			loop
					-- Process anchored type for argument types
				solved_type := type_a_checker.check_and_solved (l_area.item (i), Void)
				if solved_type /= Void then
					l_area.put (solved_type, i)
				end
				i := i + 1
			end
		end

	check_type_validity (a_context_class: CLASS_C; a_feature: FEATURE_I; a_checker: TYPE_A_CHECKER; a_check_for_obsolete: BOOLEAN)
			-- Check like types in arguments and instantiate arguments
		require
			a_context_class_not_void: a_context_class /= Void
			a_feature_not_void: a_feature /= Void
			a_checker_not_void: a_checker /= Void
			written_in: a_context_class.class_id = a_feature.written_in
		local
			i, nb: INTEGER
			l_area: SPECIAL [TYPE_A]
			l_type: TYPE_A
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_type := l_area.item (i)
					-- Process anchored type for argument types
					-- Check validity of a generic type
				a_checker.check_type_validity (l_type, Void)
				if a_check_for_obsolete then
					l_type.check_for_obsolete_class (a_context_class, a_feature)
				end
				i := i + 1
			end
		end

	check_expanded (associated_class: CLASS_C f: FEATURE_I)
			-- Check expanded validity rules
		require
			good_argument: not (associated_class = Void or f = Void)
		local
			solved_type: TYPE_A
			argument_name: STRING
			vtec: VTEC
			a_area: like argument_names
			l_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
			arg_eval: ARG_EVALUATOR
			l_names_heap: like Names_heap
		do
			from
				arg_eval := Arg_evaluator
				a_area := argument_names
				l_names_heap := Names_heap
				l_area := area
				nb := count
			until
				i = nb
			loop
					-- Process anchored type for argument types
				argument_name := l_names_heap.item (a_area.item (i))
				arg_eval.set_argument_name (argument_name)
				if associated_class = f.written_class then
					solved_type ?= l_area.item (i)
						-- Check validity of an expanded type
					if 	solved_type.has_expanded then
						if 	solved_type.expanded_deferred then
							create {VTEC1} vtec
						elseif not solved_type.valid_expanded_creation (associated_class) then
							create {VTEC2} vtec
						elseif system.il_generation and then not solved_type.is_ancestor_valid then
								-- Expanded type cannot be based on a class with external ancestor.
							create {VTEC3} vtec
						end
						if vtec /= Void then
								-- Report error.
							vtec.set_class (associated_class)
							vtec.set_feature (f)
							vtec.set_entity_name (argument_name)
							Error_handler.insert_error (vtec)
							vtec := Void
						end
					end
					if solved_type.has_generics then
						System.expanded_checker.check_actual_type (solved_type)
					end
				end
				i := i + 1
			end
		end

	solve_types (feat_tbl: FEATURE_TABLE f: FEATURE_I)
			-- Evaluates argument types in the context of `feat_tbl'.
			-- | Take care of possible anchored types.
		local
			l_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
			arg_eval: ARG_EVALUATOR
			l_solved_type: TYPE_A
		do
			from
				arg_eval := Arg_evaluator
				l_area := area
				nb := count
			until
				i = nb
			loop
				l_solved_type := arg_eval.evaluated_type (l_area.item (i), feat_tbl, f)
				check l_solved_type_not_void: l_solved_type /= Void end
				l_area.put (l_solved_type, i)
				i := i + 1
			end
		end

feature -- Status report

	is_valid: BOOLEAN
			-- All the types are still in the system
		local
			type_a: TYPE_A
			l_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
		do
			from
				Result := True
				l_area := area
				nb := count
			until
				i = nb or else not Result
			loop
				type_a ?= l_area.item (i)
				Result := type_a.is_valid
				i := i + 1
			end
		end

	same_interface (other: FEAT_ARG): BOOLEAN
			-- Has the other argument list the same interface than the
			-- current one ?
		require
			good_argument: other /= Void
			good_count: count = other.count
		local
			l_area, o_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
		do
			from
				l_area := area
				o_area := other.area
				nb := count
				Result := True
			until
				i = nb or else not Result
			loop
				Result := l_area.item (i).same_as (o_area.item (i))
				i := i + 1
			end
		end

feature -- Debugging

	trace
		local
			l_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
		do
			io.put_string ("feature argument types%N")
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				io.put_string (l_area.item (i).dump)
				io.put_new_line
				i := i + 1
			end
		end

feature {FEATURE_I}

	api_args: E_FEATURE_ARGUMENTS
		local
			i, c: INTEGER
			args: ARRAYED_LIST [STRING]
		do
			c := count
			create Result.make_filled (c)
			create args.make_filled (c)
			from
				i := 1
			until
				i > c
			loop
				Result.put_i_th (i_th (i), i)
				args.put_i_th (item_name (i), i)
				i := i + 1
			end
			Result.set_argument_names (args)
		end

invariant
	argument_names_not_void: argument_names /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- end of class FEAT_ARG
