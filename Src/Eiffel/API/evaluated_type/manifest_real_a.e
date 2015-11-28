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
			convert_to, intrinsic_type, process
		end

	SHARED_TYPES

create
	make

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_manifest_real_a (Current)
		end

feature -- Property

	intrinsic_type: REAL_A
			-- Real type of current manifest real.
		do
			if size = 32 then
				Result := real_32_type
			else
				Result := real_64_type
			end
		end

feature {COMPILER_EXPORTER} -- Implementation

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN
			-- <Precursor>
		do
				-- Currently as long as we do not validate the value of the manifest real constant,
				-- we allow assignment of manifest reals to either 32 or 64-bit value.
				-- Typed real are useful to find out the type of the real constant to build manifest
				-- tuples for example.
			if attached {REAL_A} a_target_type as l_real then
				Result := True
				context.set_last_conversion_info (create {NULL_CONVERSION_INFO}.make (l_real))
			else
				Result := Precursor {REAL_A} (a_context_class, a_target_type)
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
