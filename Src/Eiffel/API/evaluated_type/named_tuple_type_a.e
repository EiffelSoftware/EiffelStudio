indexing
	description: "Tuples whose actual generic parameters are named."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NAMED_TUPLE_TYPE_A

inherit
	TUPLE_TYPE_A
		rename
			make as old_make
		redefine
			check_labels, is_named_tuple, process
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class_id: INTEGER; g: like generics; n: like names) is
			-- Create new instance of NAMED_TUPLE_TYPE_A.
		require
			a_class_id_positive: a_class_id > 0
			g_not_void: g /= Void
			n_not_void: n /= Void
			same_count: g.count = n.count
		do
			old_make (a_class_id, g)
			names := n
		ensure
			class_id_set: class_id = a_class_id
			generics_set: generics = g
			names_set: names = n
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_named_tuple_type_a (Current)
		end

feature -- Status report

	is_named_tuple: BOOLEAN is True
			-- Current is a labelled TUPLE.

	label_position_by_id (a_id: INTEGER): INTEGER is
			-- If present, position of `a_id' in Current, otherwise `0'.
		do
			if a_id > 0 then
				Result := names.index_of (a_id, 0) + 1
			end
		ensure
			label_position_non_negative: Result >= 0
		end

	label_position (a_name: STRING): INTEGER is
			-- If present, position of `a_name' in Current, otherwise `0'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		local
			l_name_id: INTEGER
		do
			l_name_id := names_heap.id_of (a_name)
			if l_name_id > 0 then
				Result := names.index_of (l_name_id, 0) + 1
			end
		ensure
			label_position_non_negative: Result >= 0
		end

	label_name (i: INTEGER): STRING is
			-- Name of `i-th' label of Current.
		require
			valid_index: generics.valid_index (i)
		do
			Result := names_heap.item (names.item (i - 1))
		ensure
			label_name_not_void: Result /= Void
		end

feature -- Checking

	check_labels (a_context_class: CLASS_C; a_node: TYPE_AS) is
			-- Check validity of `labels' of current in `a_context_class'.
		local
			l_named_tuple_node: NAMED_TUPLE_TYPE_AS
			l_vreg: VREG
			l_vrft: VRFT
			i, nb, l_name_id: INTEGER
			l_names: like names
			l_is_tuple_class_available: BOOLEAN
			l_feat_tbl: FEATURE_TABLE
			l_pos: INTEGER
		do
			l_named_tuple_node ?= a_node
			l_is_tuple_class_available := system.tuple_class.is_compiled and then
				(not system.tuple_class.compiled_class.degree_4_needed or else system.tuple_class.compiled_class.degree_4_processed)
			if l_is_tuple_class_available then
				l_feat_tbl := system.tuple_class.compiled_class.feature_table
			end
			from
				i := 0
				l_names := names
				nb := l_names.count
			until
				i = nb
			loop
				l_name_id := l_names.item (i)
					-- Check if we have unique names.
				if i < nb then
					l_pos := l_names.index_of (l_name_id, i + 1)
					if l_pos >= 0 then
						create l_vreg
						l_vreg.set_class (a_context_class)
						if context.current_feature /= Void then
							l_vreg.set_feature (context.current_feature)
						end
						if l_named_tuple_node /= Void then
							l_vreg.set_location (l_named_tuple_node.i_th_type_declaration (l_pos + 1).start_location)
						elseif a_node /= Void then
							l_vreg.set_location (a_node.start_location)
						end
						l_vreg.set_entity_name (names_heap.item (l_name_id))
						error_handler.insert_error (l_vreg)
					end
				end
					-- Check that we do not conflict with a feature of the TUPLE class.
				if l_is_tuple_class_available then
					l_feat_tbl.search_id (l_name_id)
					if l_feat_tbl.found then
						create l_vrft
						l_vrft.set_class (a_context_class)
						if context.current_feature /= Void then
							l_vrft.set_feature (context.current_feature)
						end
						if l_named_tuple_node /= Void then
							l_vrft.set_location (l_named_tuple_node.i_th_type_declaration (i + 1).start_location)
						elseif a_node /= Void then
							l_vrft.set_location (a_node.start_location)
						end
						l_vrft.set_other_feature (l_feat_tbl.found_item)
						error_handler.insert_error (l_vrft)
					end
				else
					add_future_checking (a_context_class, agent check_tuple_feature_clash (a_context_class, context.current_feature, l_name_id, a_node, i + 1))
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation: access

	names: SPECIAL [INTEGER]
			-- List of all names appearing in tuple type for specifying arguments.

feature {NONE} -- Checking

	check_tuple_feature_clash (a_context_class: CLASS_C; a_context_feature: FEATURE_I; a_name_id: INTEGER; a_node: TYPE_AS; a_pos: INTEGER) is
			-- Check that `a_name_id' is not the same as a feature of TUPLE.
		require
			a_context_class_not_void: a_context_class /= Void
			a_name_id_positive: a_name_id > 0
			a_pos_positive: a_pos > 0
			a_pos_valid: a_pos <= generics.count
			has_tuple_class: system.tuple_class /= Void
			has_tuple_class_compiled: system.tuple_class.is_compiled
			has_tuple_class_features: not system.tuple_class.compiled_class.degree_4_needed or else system.tuple_class.compiled_class.degree_4_processed
		local
			l_feat_tbl: FEATURE_TABLE
			l_vrft: VRFT
		do
			l_feat_tbl := system.tuple_class.compiled_class.feature_table
			l_feat_tbl.search_id (a_name_id)
			if l_feat_tbl.found then
				create l_vrft
				l_vrft.set_class (a_context_class)
				if a_context_feature /= Void then
					l_vrft.set_feature (a_context_feature)
				end
				if a_node /= Void then
					if {l_tuple_node: NAMED_TUPLE_TYPE_AS} a_node then
						l_vrft.set_location (l_tuple_node.i_th_type_declaration (a_pos).start_location)
					else
						l_vrft.set_location (a_node.start_location)
					end
				end
				l_vrft.set_other_feature (l_feat_tbl.found_item)
				error_handler.insert_error (l_vrft)
			end
		end

invariant
	generics_not_void: generics /= Void
	generics_not_empty: generics.count > 0
	names_not_void: names /= Void
	names_not_empty: names.count > 0

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
