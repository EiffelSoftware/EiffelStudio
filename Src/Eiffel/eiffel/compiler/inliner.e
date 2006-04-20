indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class INLINER

inherit
	SHARED_SERVER
	COMPILER_EXPORTER
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature

	make is
		local
			nb: INTEGER
		do
			inlining_on := System.inlining_on

			nb := System.body_index_counter.count
			create processed_features.make (nb + 1)
			create to_be_inlined.make (nb + 1)

			min_inlining_threshold := System.inlining_size
		end

feature {NONE}

	min_inlining_threshold: INTEGER
			-- Byte code smaller than `min_inlining_threshold' will be inlined
			-- even if they are called several times

	processed_features: PACKED_BOOLEANS
			-- Is item at index `body_index' to be processed?

	to_be_inlined: PACKED_BOOLEANS
			-- Is item at ìndex `body_index' to be processed?

feature -- Current inlined feature

	set_inlined_feature (bc: INLINED_FEAT_B) is
		do
			inlined_feature := bc
		end

	inlined_feature: INLINED_FEAT_B

feature  -- Status

	inlining_on: BOOLEAN;
			-- In inlining on ?

	current_feature_inlined: BOOLEAN;

	set_current_feature_inlined is
		do
			current_feature_inlined := True
		end

	reset is
		do
			current_feature_inlined := False
		end

feature -- Conversion

	bindex_cid_table: HASH_TABLE [INTEGER, INTEGER] is
			-- Table with `body_index' as keys and `class_id' as items.
		once
			Result := Depend_server.bindex_cid_table
		end

feature -- Status

	inline (a_return_type: TYPE_I; body_index: INTEGER): BOOLEAN is
			-- Can we inline `f' ?
		require
			is_inlining_enabled: inlining_on
		do
			if not processed_features.item (body_index) then
				Result := can_be_inlined (a_return_type, body_index)
				processed_features.put (True, body_index)
				if Result then
					to_be_inlined.put (True, body_index)
				end
			else
				Result := to_be_inlined.item (body_index)
			end
		end

feature {NONE} -- Implementation

	can_be_inlined (a_return_type: TYPE_I; body_index: INTEGER): BOOLEAN is
			-- Tell us if we can inline the code corresponding to `body_index'
		local
			byte_code: BYTE_CODE;
			i: INTEGER
			type_i: TYPE_I
			types: ARRAY [TYPE_I]
			wc: CLASS_C
			cid: INTEGER
			result_type: TYPE_I
		do
				-- Make sure we can find the BYTE_CODE
 			if byte_server.server_has (body_index) then
 				byte_code := Byte_server.disk_item (body_index)
 			end

				-- A feature call can be inlined only if it is not a call
				-- to a deferred feature or a once. Previously this computation
				-- was done in FEATURE_I and its descendants. This computation was
				-- not done in the case of the following descendants and was returning
				-- always false:
				--  * EXTERNAL_I
				--  * INVARIANT_FEAT_I
				--  * ONCE_PROC_I
				--  * DEF_PROC_I
				--  * CONSTANT_I
				-- For INVARIANT_FEAT_I, EXTERNAL_I and CONSTANT_I, the current feature
				-- won't be called because their version of `inlined_byte_code' does
				-- not call this computation. Only for ONCE_PROC_I and DEF_PROC_I, we
				-- have to do a special check, and since the information is in BYTE_CODE
				-- we can do it easily in order to avoid the inlining.
			if
				byte_code /= Void and then
				not byte_code.is_deferred and then
				not byte_code.is_once
			then
				result_type := byte_code.result_type
				Result := (a_return_type = Void or else not (a_return_type.is_true_expanded
					or else a_return_type.is_bit or else result_type.is_anchored)) and then
					byte_code.rescue_clause = Void

				if Result then
					types := byte_code.locals
					if types /= Void then
						from
							i := types.count
						until
							i = 0 or else not Result
						loop
							type_i := types.item (i)
							Result := not (type_i.is_true_expanded or else type_i.is_bit or else type_i.is_anchored)
							i := i - 1
						end
					end
				end

				if Result then
					types := byte_code.arguments
					if types /= Void then
						from
							i := types.count
						until
							i = 0 or else not Result
						loop
							type_i := types.item (i)
							Result := not (type_i.is_true_expanded or else type_i.is_bit or else type_i.is_anchored)
							i := i - 1
						end
					end
				end

				if Result then
					cid := bindex_cid_table.item (body_index)
					wc := System.class_of_id (cid)
					Result := not wc.is_basic
				end

				if Result then
					if wc.is_special then
						inspect
							byte_code.feature_name_id
						when
							{PREDEFINED_NAMES}.item_address_name_id,
							{PREDEFINED_NAMES}.base_address_name_id,
							{PREDEFINED_NAMES}.copy_data_name_id,
							{PREDEFINED_NAMES}.move_data_name_id,
							{PREDEFINED_NAMES}.overlapping_move_name_id,
							{PREDEFINED_NAMES}.non_overlapping_move_name_id,
							{PREDEFINED_NAMES}.count_name_id
						then
							-- Even if the routine is big we inline it.
						else
							Result := byte_code.size <= min_inlining_threshold
						end
					else
						Result := byte_code.size <= min_inlining_threshold
					end
				end
			end
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

