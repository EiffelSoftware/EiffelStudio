note
	description: "Class that provides interface to Eiffel a COM-based .NET assembly consumer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER

inherit
	CONSUMER
		rename
			is_available as exists,
			release as unload
		end

create
	make

feature {NONE} -- Initialization

	make (a_cache_path: PATH; a_runtime_version: READABLE_STRING_GENERAL)
			-- Create new instance of IL_EMITTER
		require
			attached a_cache_path
			not a_cache_path.is_empty
			attached a_runtime_version
			not a_runtime_version.is_empty
		do
			if attached (create {EMITTER_FACTORY}).new_emitter (a_runtime_version) as i then
				i.initialize_with_path (create {UNI_STRING}.make (a_cache_path.name))
				implementation := i
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- <Precursor>
		do
			Result := attached implementation
		end

	is_initialized: BOOLEAN
			-- <Precursor>
		do
			if attached implementation then
				Result := implementation.is_initialized
			end
		end

	last_com_code: INTEGER
			-- Last value of the COM error if any.
		do
			if attached implementation then
				Result := implementation.last_call_success
			end
		end

	last_error_message: detachable READABLE_STRING_32
			-- <Precursor>
		local
			c: like last_com_code
		do
			c := last_com_code
			if c /= 0 then
				Result := {STRING_32} "COM error 0x" + c.to_hex_string
			end
		end

feature -- Clean up

	unload
			-- <Precursor>
		do
			if attached implementation then
				implementation.unload
			end
		end

feature -- XML generation

	consume_assembly_from_path (a_assemblies_path: ITERABLE [READABLE_STRING_32]; a_info_only: BOOLEAN; a_references: detachable ITERABLE [READABLE_STRING_32])
			-- <Precursor>
		local
			l_refs: detachable UNI_STRING
			paths: STRING_32
			refs: STRING_32
		do
			create paths.make_empty
			across
				a_assemblies_path as p
			loop
				paths.append (p)
				paths.append_character (';')
			end
			if not paths.is_empty then
				paths.remove_tail (1)
			end
			if a_references /= Void then
				create refs.make_empty
				across
					a_references as p
				loop
					refs.append_character (';')
					refs.append (p)
				end
				create l_refs.make (refs)
			end
			check attached implementation then
				implementation.consume_assembly_from_path (
					create {UNI_STRING}.make (paths),
					a_info_only,
					l_refs)
			end
		end

	consume_assembly (a_name, a_version, a_culture, a_key: READABLE_STRING_GENERAL; a_info_only: BOOLEAN)
			-- <Precursor>
		do
			check attached implementation then
				implementation.consume_assembly (
					create {UNI_STRING}.make (a_name),
					create {UNI_STRING}.make (a_version),
					create {UNI_STRING}.make (a_culture),
					create {UNI_STRING}.make (a_key),
					a_info_only)
			end
		end

feature {NONE} -- Implementation

	implementation: detachable COM_CACHE_MANAGER note option: stable attribute end
			-- Com object to get information about assemblies and emitting them.

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
