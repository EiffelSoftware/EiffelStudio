note
	description: "[
		Description of a generic derivation of class TYPE. It contains
		type of the current generic derivation. All generic derivations are stored
		in TYPE_LIST of CLASS_C
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CLASS_TYPE

inherit
	CLASS_TYPE
		redefine
			generate_feature,
			generate_il_feature
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature -- C code generation

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generate feature `feat' in `buffer'.
		do
			inspect feat.feature_name_id
			when {PREDEFINED_NAMES}.default_name_id then
				generate_default (feat, buffer)
			else
				Precursor (feat, buffer)
			end
		end

feature -- IL code generation

	generate_il_feature (feat: FEATURE_I)
			-- Generate feature `feat' in `buffer'.
		do
			inspect feat.feature_name_id
			when {PREDEFINED_NAMES}.default_name_id then
				generate_il_default (feat)
			else
				Precursor (feat)
			end
		end

feature {NONE} -- Implementation

	generate_default (feat: FEATURE_I; buffer: GENERATION_BUFFER)
		require
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.default_name_id
			buffer_not_void: buffer /= Void
		local
			l_byte_context: like byte_context
			l_byte_code: BYTE_CODE
		do
				-- The code below is mostly taken from `{FEATURE_I}.generate' and should be updated
				-- accordingly.
			l_byte_code := byte_server.disk_item (feat.body_index)
			feat.generate_header (Current, buffer)
			l_byte_context := byte_context
			l_byte_context.set_byte_code (l_byte_code)
			l_byte_context.set_current_feature (feat)
				-- The only thing that differs from the code written in $ISE_EIFFEL/studio/built_ins/neutral/TYPE.e
				-- is the removal of the `check' which is only used to make the compiler happy but is detrimental
				-- to the case where we have a detachable actual argument to TYPE.
			if l_byte_code.compound /= Void and then not l_byte_code.compound.is_empty then
				l_byte_code.compound.start
				l_byte_code.compound.remove
			end
			l_byte_code.analyze
			l_byte_code.set_real_body_id (feat.real_body_id (Current))
			l_byte_code.generate
			l_byte_context.clear_feature_data
		end

	generate_il_default (feat: FEATURE_I)
		require
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.default_name_id
		local
			l_byte_context: like byte_context
			l_byte_code: BYTE_CODE
		do
				-- The code below is mostly taken from `{FEATURE_I}.generate_il' and should be updated
				-- accordingly.
			l_byte_code := byte_server.disk_item (feat.body_index)
			l_byte_context := byte_context
			l_byte_context.set_byte_code (l_byte_code)
			l_byte_context.set_current_feature (feat)
				-- The only thing that differs from the code written in $ISE_EIFFEL/studio/built_ins/neutral/TYPE.e
				-- is the removal of the `check' which is only used to make the compiler happy but is detrimental
				-- to the case where we have a detachable actual argument to TYPE.
			if l_byte_code.compound /= Void and then not l_byte_code.compound.is_empty then
				l_byte_code.compound.start
				l_byte_code.compound.remove
			end
			l_byte_code.generate_il
			l_byte_context.clear_feature_data
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
