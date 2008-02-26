indexing
	description: "Abstract representation of a routine"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class PROCEDURE_I

inherit
	FEATURE_I
		redefine
			transfer_to, duplicate,
			is_routine, arguments,
			obsolete_message, assert_id_set, set_assert_id_set,
			check_local_names, duplicate_arguments
		end

feature -- Access

	arguments: FEAT_ARG
			-- Arguments type

	obsolete_message: STRING
			-- Obsolete message
			-- (Void if Current is not obsolete)
		do
			Result := names_heap.item (obsolete_message_id)
		end

	obsolete_message_id: INTEGER
			-- Id of `obsolete_message' in `names_heap' table.

	assert_id_set: ASSERT_ID_SET
			-- Assertions to which the procedure belongs to

feature -- Status report

	is_routine: BOOLEAN is True
			-- Current is a procedure.

feature -- Settings

	set_assert_id_set (set: like assert_id_set) is
			-- Assign `set' to assert_id_set.
		do
			assert_id_set := set
		end

	set_arguments (args: like arguments) is
			-- Assign `args' to `arguments'.
		do
			arguments := args
		ensure
			arguments_set: arguments = args
		end

	frozen set_has_precondition (b: BOOLEAN) is
			-- Assign `b' to `has_precondition'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_precondition_mask)
		ensure
			has_precondition_set: has_precondition = b
		end

	frozen set_has_postcondition (b: BOOLEAN) is
			-- Assign `b' to `has_postcondition'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_postcondition_mask)
		ensure
			has_postcondition_set: has_postcondition = b
		end

	set_obsolete_message (s: STRING) is
			-- Assign `s' to `obsolete_message'
		require
			s_not_void: s /= Void
		local
			l_names_heap: like names_heap
		do
			l_names_heap := names_heap
			l_names_heap.put (s)
			obsolete_message_id := l_names_heap.found_item
		ensure
			obsolete_message_set: equal (obsolete_message, s)
		end

	set_obsolete_message_id (v: like obsolete_message_id) is
			-- Assign `v' to `obsolete_message_id'
		do
			obsolete_message_id := v
		ensure
			obsolete_message_id_set: obsolete_message_id = v
		end

feature -- Initialization

	duplicate_arguments is
			-- Do a clone of the arguments (for replication)
		do
			if arguments /= Void then
				arguments := arguments.twin
			end
		end

	init_assertion_flags (content: ROUTINE_AS) is
			-- Initialize assertion flags with `content'.
		require
			content_not_void: content /= Void
		do
			set_is_require_else (content.is_require_else)
			set_is_ensure_then (content.is_ensure_then)
			set_has_precondition (content.has_precondition)
			set_has_postcondition (content.has_postcondition)
		end

	duplicate: like Current is
			-- Duplicate feature
		do
			Result := Precursor {FEATURE_I}
			if arguments /= Void then
				Result.set_arguments (arguments.twin)
			end
			if type /= Void then
				Result.set_type (type.twin, assigner_name_id)
			end
		end

	init_arg (argument_as: EIFFEL_LIST [TYPE_DEC_AS]; a_context_class: CLASS_C) is
			-- Initialization of arguments.
		require
			argument_as_not_void: argument_as /= Void
			a_context_class_not_void: a_context_class /= Void
		local
			i, j, l_count, dec_count, nb_arg: INTEGER
			arg_type: TYPE_A
			arg_dec: TYPE_DEC_AS
			id_list: IDENTIFIER_LIST
		do
				-- Calculate the number of arguments.
			from
				i := 1
				l_count := argument_as.count
			until
				i > l_count
			loop
				nb_arg := nb_arg + argument_as.i_th (i).id_list.count
				i := i + 1
			end
				-- Creation of data structures
			create arguments.make (nb_arg)
				-- Fill the data structures
			nb_arg := 1
			from
				i := 1
			until
				i > l_count
			loop
				arg_dec := argument_as.i_th (i)
				from
					j := 1
					id_list := arg_dec.id_list
					arg_type := type_a_generator.evaluate_type (arg_dec.type, a_context_class)
					dec_count := id_list.count
				until
					j > dec_count
				loop
					arguments.put_name (id_list.i_th (j), nb_arg)
					arguments.put_i_th (arg_type, nb_arg)
					nb_arg := nb_arg + 1
					j := j + 1
				end
				i := i + 1
			end
		end

	transfer_to (other: PROCEDURE_I) is
			-- Transfer datas form `other' into Current.
		do
			Precursor {FEATURE_I} (other)
			other.set_arguments (arguments)
			other.set_is_require_else (is_require_else)
			other.set_is_ensure_then (is_ensure_then)
			other.set_obsolete_message_id (obsolete_message_id)
			other.set_has_precondition (has_precondition)
			other.set_has_postcondition (has_postcondition)
			other.set_assert_id_set (assert_id_set)
			other.set_has_rescue_clause (has_rescue_clause)
		end

	check_local_names (a_body: BODY_AS) is
			-- Check the conflicts between local names and feature names
			-- for an unchanged feature
		do
			if not is_replicated then
				feature_checker.check_local_names (Current, a_body)
			end
		end

-- Note: `require else' can be used even if the feature has no
-- precursor. There is no problem to raise an error in the normal case,
-- the only case  where we cannot do anything is when aliases are used
-- and one name references a feature with a predecessor and not the
-- other one

--	check_assertions is
--		local
--			fas: FEATURE_AS
--			body: BODY_AS
--			ras: ROUTINE_AS
--			precondition: REQUIRE_AS
--			postcondition: ENSURE_AS
--			ve05: VE05
--		do
--			if is_origin then
--				fas := Body_server.item (body_index)
--				body := fas.body
--				ras ?= body.content
--				if ras /= Void then
--					precondition := ras.precondition
--					postcondition := ras.postcondition
--					if
--						(precondition /= Void and then precondition.is_else)
--					or else
--						(postcondition /= Void and then postcondition.is_then)
--					then
--io.error.put_string ("Error VE05: require else or ensure then%NClass: ")
--io.error.put_string (System.current_class.name)
--io.error.put_string ("%NFeature: ")
--io.error.put_string (feature_name)
--io.error.put_new_line
--						!!ve05
--						ve05.set_class (System.current_class)
--						ve05.set_feature (Current)
--						Error_handler.insert_error (ve05)
--						Error_handler.checksum
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

    new_api_feature: E_ROUTINE is
            -- API feature creation
        do
			create {E_PROCEDURE} Result.make (feature_name_id, alias_name, has_convert_mark, feature_id)
			update_api (Result)
        end

	update_api (f: E_ROUTINE) is
			-- Update the attributes of api feature `f'.
		require
			f_not_void: f /= Void
		local
			args: like arguments
		do
			args := arguments
			if args /= Void then
				f.set_arguments (args.api_args)
			end
			f.set_has_precondition (has_precondition)
			f.set_has_postcondition (has_postcondition)
			f.set_obsolete_message (obsolete_message)
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
