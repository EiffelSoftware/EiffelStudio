note
	description: "[
		Managing data used to get debugger info from eStudio info
		This instance is related to one CLASS_TYPE

		- feature_name_id => List [IL Offset]

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_FROM_CLASS_TYPE

inherit
	SHARED_IL_DEBUG_INFO
		export
			{NONE} il_debug_info
		end

create
	make

feature {NONE} -- Initialization

	make (a_static_type_id: INTEGER)
			-- Initialize `Current'.
		require
			a_static_type_id > 0
		do
			static_type_id := a_static_type_id
			create list_feature_token.make (30)
			create list_once_tokens.make (10)
			create list_breakable_il_offset.make (20)
		end

feature -- reset

	reset (a_class_type: CLASS_TYPE)
			-- Reset data for `static_type_id'.
		require
			class_type_not_void: a_class_type /= Void
		do
			check
				static_type_id = a_class_type.static_type_id
			end
			list_feature_token.wipe_out
			list_once_tokens.wipe_out
			list_breakable_il_offset.wipe_out
			clean_temporary_data
		end

	clean_temporary_data
		do
			last_eiffel_line_number := 0
			last_instruction_position := 0
			last_feature_name_id := 0
		end

feature -- Properties

	static_type_id: INTEGER
			-- Static_type_id related to the CLASS_TYPE

feature -- Queries feature_token

	feature_token (a_feature_i: FEATURE_I): NATURAL_32
			-- `feature_token' associated with `a_feature_i'
		require
			feature_i_not_void: a_feature_i /= Void
		do
			Result := list_feature_token.item (a_feature_i.feature_name_id)
		ensure
			Result /= 0 implies list_feature_token.has (a_feature_i.feature_name_id)
		end

	know_feature_token_from_feature (a_feature: FEATURE_I): BOOLEAN
			-- Know feature_token from `a_feature' ?
		do
			Result := list_feature_token.has (a_feature.feature_name_id)
		end

feature -- Recording Operation feature_token

	record_feature_token (a_feature_token: NATURAL_32; a_feature_i: FEATURE_I)
			-- Record the correspondance
			-- a_feature_i.feature_name_id => a_feature_token.
		require
			token_valid: a_feature_token > 0
			feature_i_not_void: a_feature_i /= Void
		local
			l_feature_name_id: INTEGER
		do
			l_feature_name_id := a_feature_i.feature_name_id
			if not list_feature_token.has (l_feature_name_id) then
				list_feature_token.put (a_feature_token , l_feature_name_id)
			else
				debug ("il_info_trace")
					io.error.put_string (">> CONFLICT record_feature_token <<%N")
					io.error.put_string_32 ({STRING_32} "  - feature_name          =" + a_feature_i.feature_name_32 + "%N")
					io.error.put_string ("  - key : feature_name_id =" + l_feature_name_id.out + "%N")
					io.error.put_string ("  - already               = " + list_feature_token.item (l_feature_name_id).to_hex_string + "%N")
					io.error.put_string ("  - replace             = " + a_feature_token.to_hex_string + "%N")
					io.error.put_string ("%N")
				end
				list_feature_token.force (a_feature_token , l_feature_name_id)
			end
		ensure
			feature_token (a_feature_i) = a_feature_token
		end

feature -- Queries once_tokens

	once_tokens (a_feature_i: FEATURE_I): TUPLE [data_class_tok: NATURAL_32; done_tok: NATURAL_32; result_tok: NATURAL_32; exception_tok: NATURAL_32]
			-- data class token,  `_done' and `_result' tokens associated with `a_feature_i'
		require
			feature_i_not_void: a_feature_i /= Void
		do
			Result := list_once_tokens.item (a_feature_i.feature_name_id)
		ensure
			Result /= Void implies list_once_tokens.has (a_feature_i.feature_name_id)
		end

	know_once_tokens_from_feature (a_feature: FEATURE_I): BOOLEAN
			-- Know once tokens from `a_feature' ?
		do
			Result := list_once_tokens.has (a_feature.feature_name_id)
		end

feature -- Recording Operation once_tokens

	record_once_tokens (a_data_class_token,
					a_once_done_token, a_once_result_token, a_once_exception_token: NATURAL_32;
					a_feature_i: FEATURE_I)
			-- Record the correspondance
			-- a_feature_i.feature_name_id =>
			--			a_data_class_token,
			--			a_once_done_token
			--			a_once_result_token
		require
			feature_i_not_void: a_feature_i /= Void
		local
			l_feature_name_id: INTEGER
			l_entry: like once_tokens
		do
			l_feature_name_id := a_feature_i.feature_name_id
			if not list_once_tokens.has (l_feature_name_id) then
				l_entry := [a_data_class_token, a_once_done_token, a_once_result_token, a_once_exception_token]
				list_once_tokens.put (l_entry , l_feature_name_id)
			else
				l_entry := list_once_tokens.item (l_feature_name_id)
				if a_data_class_token /= 0 then
					l_entry.data_class_tok := a_data_class_token
				end
				if a_once_done_token /= 0 then
					l_entry.done_tok := a_once_done_token
				end
				if a_once_result_token /= 0 then
					l_entry.result_tok := a_once_result_token
				end
				if a_once_exception_token /= 0 then
					l_entry.exception_tok := a_once_exception_token
				end
			end
		ensure
			once_tokens (a_feature_i) /= Void
		end

feature -- Queries IL Offsets

	breakable_il_offsets (a_feature_i: FEATURE_I): ARRAYED_LIST [TUPLE [e_line: INTEGER; il_offsets: IL_OFFSET_SET]]
			-- breakable_il_offsets associated with `a_feature_i'
		require
			feature_i_not_void: a_feature_i /= Void
		do
			Result := list_breakable_il_offset.item (a_feature_i.feature_name_id)
		ensure
			Result /= Void implies list_breakable_il_offset.has (a_feature_i.feature_name_id)
		end

	know_il_offset_from_feature (a_feature: FEATURE_I): BOOLEAN
			-- Know il offsets from feature `a_feature' ?
		do
			Result := list_breakable_il_offset.has (a_feature.feature_name_id)
		end

feature -- Recording Operation

	line_info_for_eiffel_line (a_eiffel_line: INTEGER; a_data: ARRAYED_LIST [TUPLE [i: INTEGER; set: IL_OFFSET_SET]]): TUPLE [e_line: INTEGER; il_offset: IL_OFFSET_SET]
			-- Breakable line info for `eiffel_line' inside `a_data'
		do
			from
				a_data.finish
			until
				a_data.before or Result /= Void
			loop
				if a_data.item.i = a_eiffel_line then
					Result := a_data.item
				else
					a_data.back
				end
			end
		end

	last_eiffel_line_number: INTEGER
	last_instruction_position: INTEGER
	last_feature_name_id: INTEGER

	record_add_line_info (a_feature: FEATURE_I; a_il_offset: INTEGER; a_eiffel_line: INTEGER)
			-- Record IL Information regarding breakable Lines
		require
			a_feature /= Void
			a_il_offset >= 0
			a_eiffel_line >= 0
		local
			l_il_offset_list: ARRAYED_LIST [TUPLE [i: INTEGER; set: IL_OFFSET_SET]]
			l_line_info: TUPLE [i: INTEGER; set: IL_OFFSET_SET]
			l_offsets_info: IL_OFFSET_SET
				-- bp index => [eiffel line number, [IL offsets, ...]]
			l_feature_name_id: INTEGER
		do
			l_feature_name_id := a_feature.feature_name_id

			if
				l_feature_name_id = last_feature_name_id
				and a_eiffel_line = last_eiffel_line_number
			then
				last_instruction_position := last_instruction_position + 1
			else
				last_feature_name_id := l_feature_name_id
				last_eiffel_line_number := a_eiffel_line
				last_instruction_position := 0
			end

			l_il_offset_list := list_breakable_il_offset.item (l_feature_name_id)
			if l_il_offset_list = Void then
				create l_il_offset_list.make (20)
				list_breakable_il_offset.put (l_il_offset_list, l_feature_name_id)
			end
			if last_instruction_position > 0 then
					--| if the instruction is on the same line as an other ...
					--| this is a new breakable point
				l_line_info := Void
			else
				l_line_info := line_info_for_eiffel_line (a_eiffel_line, l_il_offset_list)
			end
			if l_line_info = Void then
				create {IL_OFFSET_SET} l_offsets_info.make
				l_line_info := [a_eiffel_line, l_offsets_info]
				l_il_offset_list.extend (l_line_info)
			else
				l_offsets_info := l_line_info.set
			end
			l_offsets_info.extend (a_il_offset)
			debug ("debugger_il_info_trace")
				io.error.put_string (" -> " + l_il_offset_list.count.out + "@" + l_line_info.i.out  + "["+last_instruction_position.out+"]" +  ": " + l_il_offset_list.count.out + "%N")
			end
		end

feature -- Cleaning operation

	clean_feature_token (a_feature: FEATURE_I)
			-- Removed information related to `a_feature'
			-- regarding feature_token.
		require
			know_feature_token_from_feature: know_feature_token_from_feature (a_feature)
		do
			list_feature_token.remove (a_feature.feature_name_id)
			check
				entry_removed: list_feature_token.removed
			end
		ensure
			removed: not know_feature_token_from_feature (a_feature)
		end

	clean_once_tokens (a_feature: FEATURE_I)
			-- Removed information related to `a_feature'
			-- regarding once_tokens.
		require
			know_once_tokens_from_feature: know_once_tokens_from_feature (a_feature)
		do
			list_once_tokens.remove (a_feature.feature_name_id)
			check
				entry_removed: list_once_tokens.removed
			end
		ensure
			removed: not know_once_tokens_from_feature (a_feature)
		end

	clean_breakable_il_offset (a_feature: FEATURE_I)
			-- Removed information related to `a_feature'
			-- regarding breakable il offsets.
		require
			know_il_offset_from_feature: know_il_offset_from_feature (a_feature)
		do
			list_breakable_il_offset.remove (a_feature.feature_name_id)
			check
				entry_removed: list_breakable_il_offset.removed
			end
		ensure
			removed: not know_il_offset_from_feature (a_feature)
		end

feature {NONE} -- Storage Implementation

	list_feature_token: HASH_TABLE [NATURAL_32, INTEGER]
			-- {feature_token} <= {feature_name_id}

	list_once_tokens: HASH_TABLE [TUPLE [data_class_tok: NATURAL_32; done_tok: NATURAL_32; result_tok: NATURAL_32; exception_tok: NATURAL_32], INTEGER]
			-- feature_tokens[_data_class|_done|_result|_exception] <= [feature_name_id]

	list_breakable_il_offset: HASH_TABLE [ARRAYED_LIST [TUPLE [e_line: INTEGER; il_offsets: IL_OFFSET_SET]], INTEGER]
			-- [bp index => [eiffel line, List [Offset IL]] ] <= [feature_name_id]

invariant

	static_type_id_valid: static_type_id /= 0

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end
