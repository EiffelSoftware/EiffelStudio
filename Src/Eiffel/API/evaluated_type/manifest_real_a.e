note
	description: "[
		Actual type for manifest real constant types. By default they are considered as REAL_64,
		but will conform to REAL_32 until we are able to check if a manifest real will only fit in
		either a REAL_32 or REAL_64.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MANIFEST_REAL_A

inherit
	REAL_A
		redefine
			default_create, convert_to, intrinsic_type, process
		end

	SHARED_TYPES
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
				-- By default we always create a manifest real constant as if it was a 64-bit value.
			make (64)
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_manifest_real_a (Current)
		end

feature -- Property

	intrinsic_type: REAL_A
			-- Real type of current manifest real.
			-- It is always a REAL_64.
		do
			Result := real_64_type
		end

feature {COMPILER_EXPORTER} -- Implementation

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
			-- <Precursor>
		local
			l_info: CONVERSION_INFO
			l_feat: FEATURE_I
		do
			if attached {REAL_A} a_target_type as l_real and then l_real.size = 32 then
				l_feat := associated_class.feature_table.item_id ({PREDEFINED_NAMES}.truncated_to_real_name_id)
					-- We protect ourself in case the `truncated_to_real' routine
					-- would have been removed from the REAL_64 class.
				if l_feat /= Void then
					create {FEATURE_CONVERSION_INFO} l_info.make_to (Current, l_real, associated_class, l_feat)
					Result := True
				end
				context.set_last_conversion_info (l_info)
			else
				Result := Precursor {REAL_A} (a_context_class, a_target_type)
			end
		end

invariant
	correct_size: size = 64

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

end
