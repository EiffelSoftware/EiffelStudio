note
	description: "Class that provides interface to Eiffel `consumer'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_CONSUMER

inherit
	CONSUMER
		rename
			is_available as exists,
			release as unload
		end

create
	make

feature {NONE} -- Initialization

	make (a_path: PATH; a_runtime_version: READABLE_STRING_GENERAL)
			-- Create new instance of COM_CONSUMER
		require
			attached a_path
			not a_path.is_empty
			attached a_runtime_version
			not a_runtime_version.is_empty
		do
			check
				False
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	is_initialized: BOOLEAN
			-- <Precursor>
		do
			check
				False
			end
		end


	last_com_code: INTEGER
			-- Last value of the COM error if any.
		require
			exists: exists
		do
			check
				False
			end
		end

	last_error_message: detachable READABLE_STRING_32
			-- <Precursor>
		do
			check
				False
			end
		end

feature -- Clean up

	unload
			-- <Precursor>
		do
			check
				False
			end
		end

feature -- XML generation

	consume_assembly_from_path (a_assembly_paths: ITERABLE [READABLE_STRING_32]; a_info_only: BOOLEAN; a_references: detachable ITERABLE [READABLE_STRING_32])
			-- <Precursor>
		do
			check
				False
			end
		end

	consume_assembly (a_name, a_version, a_culture, a_key: READABLE_STRING_GENERAL; a_info_only: BOOLEAN)
			-- <Precursor>
		do
			check
				False
			end
		end

note
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
