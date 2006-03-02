indexing
	description: "Class for an staticed type on a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_FEATURE

inherit
	LIKE_TYPE_A
		redefine
			update_dependance
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I) is
			-- Creation
		require
			valid_argument: f /= Void
		do
			feature_id := f.feature_id
			routine_id := f.rout_id_set.first
			feature_name_id := f.feature_name_id
			class_id := System.current_class.class_id
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_like_feature (Current)
		end

feature -- Properties

	feature_name_id: INTEGER
			-- Feature name ID of anchor

	routine_id: INTEGER
			-- Routine ID of anchor in context of `class_id'.

	feature_name: STRING is
			-- Final name of anchor.
		require
			feature_name_id_set: feature_name_id >= 1
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature {COMPILER_EXPORTER}

	feature_id: INTEGER
			-- Feature ID of the anchor

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_feat: LIKE_FEATURE
		do
			other_like_feat ?= other
			Result := 	other_like_feat /= Void
					and then other_like_feat.routine_id = routine_id
					and then other_like_feat.feature_id = feature_id
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE) is
			-- Update dependency for Dead Code Removal
		local
			a_class: CLASS_C
			depend_unit: DEPEND_UNIT
			feature_i: FEATURE_I
		do
				-- we must had a dependance to the anchor feature
			a_class := System.class_of_id (class_id)
			feature_i := a_class.feature_table.item_id (feature_name_id)
			create depend_unit.make (class_id, feature_i)
			feat_depend.extend (depend_unit)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			s: STRING
		do
			s := actual_type.dump
			create Result.make (18 + s.count)
			Result.append ("[like " + feature_name +"] ")
			Result.append (s)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			ec: CLASS_C
			l_feat: E_FEATURE
		do
			ec := Eiffel_system.class_of_id (class_id)
			st.add (ti_l_bracket)
			st.add (ti_like_keyword)
			st.add_space
			if ec.has_feature_table then
				l_feat := ec.feature_with_name (feature_name)
			end
			if l_feat /= Void then
				st.add_feature (l_feat, feature_name)
			else
				st.add_feature_name (feature_name, ec)
			end
			st.add (ti_r_bracket)
			st.add_space
			actual_type.ext_append_to (st, f)
		end

feature -- Primitives

	raise_veen (f: FEATURE_I) is
		local
			veen: VEEN
		do
			create veen
			veen.set_class (System.current_class)
			veen.set_feature (f)
			veen.set_identifier (feature_name)
			Error_handler.insert_error (veen)
			Error_handler.raise_error
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_FEATURE is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table
		local
			origin_table: HASH_TABLE [FEATURE_I, INTEGER]
			anchor_feature, orig_feat: FEATURE_I
			anchor_type: TYPE_AS
			l_controler_state: BOOLEAN
		do
			if not (System.current_class.class_id = class_id) then
				debug
					io.error.put_string ("LIKE_FEATURE solved_type origin_table%N")
				end

				origin_table := feat_table.origin_table
				orig_feat := System.class_of_id (class_id).feature_table.item_id (feature_name_id)
				if orig_feat = Void then
					raise_veen (f)
				end
				routine_id := orig_feat.rout_id_set.first
				anchor_feature := origin_table.item (routine_id)

				debug
					if anchor_feature = Void then
						io.error.put_string ("Void feature%N")
						feat_table.trace
						orig_feat.trace
						f.trace
					end
				end
			else
				debug
					io.error.put_string ("LIKE_FEATURE solved_type origin_table%N")
				end

				anchor_feature := feat_table.item_id (feature_name_id)
				if anchor_feature = Void then
					raise_veen (f)
				end
				routine_id := anchor_feature.rout_id_set.first
				debug
					if anchor_feature = Void then
						io.error.put_string ("Void feature%N")
					end
				end
			end
			anchor_type := anchor_feature.type
			l_controler_state := like_control.is_on
			if
				anchor_type.is_void or
				(l_controler_state and like_control.has_routine_id (routine_id))
			then
				like_control.raise_error
			else
				if not l_controler_state then
						-- Enable like controler only if not already enabled.
					like_control.turn_on
				end
					-- Update anchored type controler
				like_control.put_routine_id (routine_id)
					-- Re-processing of the anchored type
				Result := twin
				Result.set_actual_type
					(anchor_type.solved_type (feat_table, anchor_feature).actual_type)
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end
				if not l_controler_state then
						-- Disable like controler only if it was not enabled before
						-- entering current routine.
					like_control.turn_off
				end
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_FEATURE is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := twin
			Result.set_actual_type
							(actual_type.instantiation_in (type, written_id))
		end

	create_info: CREATE_FEAT is
			-- Byte code information for entity type creation
		local
			updated_feature_id: INTEGER
			feat_tbl: FEATURE_TABLE
			feat_i: FEATURE_I
			l_class: CLASS_C
		do
				--| FIXME: `feature_id' refers to the feature_id in class that declares
				--| `feature_name'. However most of times, we need to perform call on
				--| `feature_name' (or its renamed version) in different contexts (eg a
				--| descendant class). To do that, we need to search in current class
				--| being processed by compiler the feature_id of feature of routine id
				--| `routine_id'.
				--| If feature_table does not exist, it means that we are in current
				--| class and it is enough to take stored `feature_id'.
			if System.in_pass3 then
				l_class := context.current_class
				feat_tbl := l_class.feature_table
			else
				l_class := System.current_class
				if System.feat_tbl_server.has (l_class.class_id) then
					feat_tbl := l_class.feature_table
				end
			end
			if feat_tbl /= Void then
				feat_i := feat_tbl.feature_of_rout_id (routine_id)
				if feat_i /= Void then
					updated_feature_id := feat_i.feature_id
				else
					updated_feature_id := feature_id
				end
			else
				updated_feature_id := feature_id
			end

			create Result.make (updated_feature_id, routine_id, l_class)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := routine_id = other.routine_id and then
				class_id = other.class_id and then
				feature_id = other.feature_id and then
				equivalent (actual_type, other.actual_type) and then
				feature_name_id = other.feature_name_id
		end

feature {LIKE_FEATURE} -- Implementation

	class_id: INTEGER;
			-- Class ID of the class where the anchor is referenced

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
