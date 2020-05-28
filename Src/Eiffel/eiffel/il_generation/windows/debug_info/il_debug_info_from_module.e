note
	description: "[
		Managing data used to interpret debugger info
		we are dealing for a module identified by `module_filename' :

		- class_token => CLASS_TYPE.static_type_id 
			which allow use to retrieve the CLASS_TYPE

		- feature_token => 	 [CLASS_TYPE.associated_class.class_id , ]
			                 [FEATURE_I.feature_name_id              ]
			which allow use to retrieve the FEATURE_I
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_FROM_MODULE

inherit
	SHARED_IL_DEBUG_INFO
		export
			{NONE} il_debug_info
		end

create
	make

feature {NONE} -- Initialization

	make (a_module_filename: like module_filename; a_syst_name: STRING)
			-- Initialize `Current'.
		require
			mod_name_valid: a_module_filename /= Void and then not a_module_filename.is_empty
		do
			module_filename := a_module_filename
			system_name := a_syst_name
			create list_class_type_id.make (10)
			create list_feature_info.make (100)
		end

feature -- reset

	reset (a_module_filename: like module_filename)
			-- Reset data for `module_filename'.
		do
			check
				module_filename.is_equal (a_module_filename)
			end
			list_class_type_id.wipe_out
			list_feature_info.wipe_out
		end

	set_module_name (a_mod_name: like module_name)
			-- Set module name (should not change anymore)
		require
			module_name_valid: a_mod_name /= Void and then not a_mod_name.is_empty
		do
			module_name := a_mod_name
			module_name.to_lower
			if module_name.substring_index (".dll", 1) = 0 then
				module_name.append_string (".dll")
			end
		ensure
			module_name_is_lower_case: module_name.as_lower.is_equal (module_name)
		end

feature {IL_DEBUG_INFO_RECORDER} -- Update Module Name

	update_module_filename (a_mod_filename: like module_filename)
			-- Update Current module filename with `a_mod_filename'.
		require
			a_mod_name_not_empty: a_mod_filename /= Void and then not a_mod_filename.is_empty
		do
			module_filename := a_mod_filename
		end

	merge (other: like Current)
			-- Merge information from other into Current.
		do
			list_class_type_id.merge (other.list_class_type_id)
			list_feature_info.merge (other.list_feature_info)
		end

	set_system_name (s: STRING)
			-- Set system name related to Current module
		do
			system_name := s
		end

feature -- Properties

	module_filename: STRING_32
			-- formatted Module filename

	module_name: STRING
			-- Final module file name without the directory path
--| Uncomment next 2 lines, when Eiffel will allow assertion on attribute ...
--		ensure
--			module_name_is_lower_case: module_name /= Void and then module_name.as_lower.is_equal (module_name)

	system_name: STRING
			-- In case this module is a precompiled lib

feature -- Queries Class

	class_type_for_token (a_class_token: NATURAL_32): detachable CLASS_TYPE
			-- CLASS_TYPE associated with `a_class_token'
		require
			class_token_valid: a_class_token /= 0
		local
			l_class_type_id: INTEGER
		do
			l_class_type_id := list_class_type_id.item (a_class_token)
			if l_class_type_id /= 0 then
				Result := Il_debug_info.class_types @ l_class_type_id
			end
		ensure
			Result /= Void implies list_class_type_id.has (a_class_token)
		end

	know_class_from_token (a_class_token: NATURAL_32): BOOLEAN
			-- Know class from token `a_class_token' ?
		do
			Result := list_class_type_id.has (a_class_token)
		end

feature -- Reverse Queries Class

	class_token_for_class_type (a_class_type: CLASS_TYPE): NATURAL_32
		require
			class_type_not_void: a_class_type /= Void
		local
			l_id: INTEGER
			l_cursor: CURSOR
		do
			debug ("il_info_trace")
				io.error.put_string ("Reverse Search ..%N")
			end
			l_id := a_class_type.static_type_id
			l_cursor := list_class_type_id.cursor
			from
				list_class_type_id.start
			until
				list_class_type_id.after or Result > 0
			loop
				if list_class_type_id.item_for_iteration = l_id then
					Result := list_class_type_id.key_for_iteration
				end
				list_class_type_id.forth
			end
			list_class_type_id.go_to (l_cursor)
		ensure
			result_positive: Result > 0
		end

feature -- Queries Feature

	feature_i_for_token (a_feature_token: NATURAL_32): FEATURE_I
			-- FEATURE_I associated with `a_feature_token'
		require
			feature_token_valid: a_feature_token /= 0
		local
			l_class_id: INTEGER
			l_name_id: INTEGER
			l_infos: TUPLE [class_id: INTEGER; name_id: INTEGER]
			l_class_c: CLASS_C
		do
			l_infos := list_feature_info.item (a_feature_token)
			if l_infos /= Void then
				l_class_id := l_infos.class_id
				l_name_id  := l_infos.name_id
				l_class_c := Il_debug_info.class_of_id (l_class_id)
				Result := l_class_c.feature_table.item_id (l_name_id)
				if Result = Void and then l_class_c.is_eiffel_class_c then
					Result := l_class_c.eiffel_class_c.inline_agent_of_name_id (l_name_id)
				end
--| NOTA JFIAT: 2004/05/28 : fix invariant cursor in call stack
--| When we'll decide to fix the cursor in call stack on invariant
--| this may be a start ..
--				if Result = Void then
--					Result := l_class_c.invariant_feature
--					if Result.feature_name_id /= l_name_id then
--						Result := Void
--					end
--				end
			end
		ensure
			Result /= Void implies list_feature_info.has (a_feature_token)
		end

	know_feature_from_token (a_feature_token: NATURAL_32): BOOLEAN
			-- Know feature from token `a_feature_token' ?
		do
			Result := list_feature_info.has (a_feature_token)
		end

feature -- Recording Operation

	record_class_type (a_class_type: CLASS_TYPE; a_class_token: NATURAL_32)
		require
			class_type_not_void: a_class_type /= Void
		local
			l_class_static_type_id: INTEGER
		do
			l_class_static_type_id := a_class_type.static_type_id
			if not list_class_type_id.has (a_class_token) then
				list_class_type_id.put (l_class_static_type_id , a_class_token)
			else
				debug ("il_info_trace")
					io.error.put_string (">> CONFLICT record_class_token : "+a_class_type.associated_class.name_in_upper+" <<%N")
					io.error.put_string ("  - key : class_token =" + a_class_token.to_hex_string + "%N")
					io.error.put_string ("  - already           = " + list_class_type_id.item (a_class_token).out + "%N")
					io.error.put_string ("  - replace           = " + l_class_static_type_id.out + "%N")
					io.error.put_string ("%N")
				end
				list_class_type_id.force (l_class_static_type_id , a_class_token)
			end
			--| This can be forced any time
		end

	record_feature_i (a_class_type: CLASS_TYPE; a_feature_i: FEATURE_I; a_feature_token: NATURAL_32)
		require
			class_type_not_void: a_class_type /= Void
			feature_i_not_void: a_feature_i /= Void
			feature_token_valid: a_feature_token > 0
		local
			l_entry: TUPLE [INTEGER, INTEGER]
		do
			l_entry := [a_class_type.associated_class.class_id, a_feature_i.feature_name_id]

			if not list_feature_info.has (a_feature_token) then
				list_feature_info.put (l_entry , a_feature_token)
			else
				debug ("il_info_trace")
					io.error.put_string_32 ({STRING_32} ">> CONFLICT record_feature_i : "+a_class_type.associated_class.name_in_upper
							+"."+a_feature_i.feature_name_32
							+" <<%N")
					io.error.put_string ("  - key : feature_token =" + a_feature_token.to_hex_string + "%N")
					io.error.put_string ("  - already             = " + list_feature_info.item (a_feature_token).out + "%N")
					io.error.put_string ("  - replace             = " + l_entry.out + "%N")
					io.error.put_string ("%N")
				end
				list_feature_info.force (l_entry , a_feature_token)
			end
		end

feature -- Cleaning operation

	clean_feature_token (a_feature_token: NATURAL_32)
		require
			know_feature_from_token: know_feature_from_token (a_feature_token)
		do
			list_feature_info.remove (a_feature_token)
			check
				entry_removed: list_feature_info.removed
			end
		ensure
			removed: not know_feature_from_token (a_feature_token)
		end

feature {IL_DEBUG_INFO_FROM_MODULE} -- Storage Implementation

	list_class_type_id: HASH_TABLE [INTEGER, NATURAL_32]
			-- {static_type_id} <= {ClassToken}

	list_feature_info: HASH_TABLE [TUPLE [INTEGER, INTEGER], NATURAL_32]
			-- {class_id, name_id} <= {feature_token}

feature

	debug_display
			--
		do
			io.put_string ("************************************************************%N")
			io.put_string ("* Module=" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (module_filename) + "%N")
			io.put_string ("************************************************************%N")
			io.put_string ("%N Class Token  => static_class_type %N%N")

			across
				list_class_type_id as c
			loop
				io.put_string (" - 0x" + c.key.to_hex_string)
				io.put_string (" => " +	c.item.out)
				io.put_string (" :: " + (Il_debug_info.class_types @ c.item).associated_class.name_in_upper)
				io.put_new_line
			end
		end

invariant

	module_filename_not_void: module_filename /= Void

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
