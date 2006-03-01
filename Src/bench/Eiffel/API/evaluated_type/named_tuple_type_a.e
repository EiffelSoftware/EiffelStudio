indexing
	description: "Tuples whose actual generic parameters are named."
	date: "$Date$"
	revision: "$Revision$"

class
	NAMED_TUPLE_TYPE_A

inherit
	TUPLE_TYPE_A
		rename
			make as old_make
		redefine
			check_labels, is_named_tuple
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

feature -- Status report

	is_named_tuple: BOOLEAN is True
			-- Current is a labelled TUPLE.

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
			l_processed: SEARCH_TABLE [INTEGER]
			l_pos: INTEGER
		do
				-- If `a_node' is of type NAMED_TUPLE_TYPE_AS then we should
				-- check the validity of labels, if not, it means that we were
				-- checking a type whose actual type is NAMED_TUPLE_TYPE_A but
				-- is not declared as NAMED_TUPLE_TYPE_AS declaration, and in this
				-- case we assume that wherever the NAMED_TUPLE_TYPE_AS was, it
				-- was checked.
			l_named_tuple_node ?= a_node
			if l_named_tuple_node /= Void then
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
							context.init_error (l_vreg)
							l_vreg.set_location (l_named_tuple_node.generics.i_th (l_pos + 1).start_location)
							l_vreg.set_entity_name (names_heap.item (l_name_id))
							error_handler.insert_error (l_vreg)
						end
					end
						-- Check that we do not conflict with a feature of the TUPLE class.
					if l_is_tuple_class_available then
						if l_feat_tbl.has_id (l_name_id) then
							create l_vrft
							context.init_error (l_vrft)
							l_vrft.set_location (l_named_tuple_node.generics.i_th (i + 1).start_location)
							l_vrft.set_other_feature (l_feat_tbl.found_item)
							error_handler.insert_error (l_vrft)
						end
					else
						remaining_validity_checking_list.extend (create {FUTURE_CHECKING_INFO}.make (
							a_context_class,
							agent check_tuple_feature_clash (a_context_class, context.current_feature, l_name_id, l_named_tuple_node, i + 1)))
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation: access

	names: SPECIAL [INTEGER]
			-- List of all names appearing in tuple type for specifying arguments.

feature {NONE} -- Checking

	check_tuple_feature_clash (a_context_class: CLASS_C; a_context_feature: FEATURE_I; a_name_id: INTEGER; a_tuple_node: NAMED_TUPLE_TYPE_AS; a_pos: INTEGER) is
			-- Check that `a_name_id' is not the same as a feature of TUPLE.
		require
			a_context_class_not_void: a_context_class /= Void
			a_name_id_positive: a_name_id > 0
			a_tuple_node_not_void: a_tuple_node /= Void
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
			if l_feat_tbl.has_id (a_name_id) then
				create l_vrft
				l_vrft.set_class (a_context_class)
				if a_context_feature /= Void then
					l_vrft.set_feature (a_context_feature)
				end
				l_vrft.set_location (a_tuple_node.generics.i_th (a_pos).start_location)
				l_vrft.set_other_feature (l_feat_tbl.found_item)
				error_handler.insert_error (l_vrft)
			end
		end

invariant
	generics_not_void: generics /= Void
	generics_not_empty: generics.count > 0
	names_not_void: names /= Void
	names_not_empty: names.count > 0

end
