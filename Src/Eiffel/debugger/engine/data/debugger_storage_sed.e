indexing
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_STORAGE_SED

inherit
	DEBUGGER_STORAGE

	EIFFEL_LAYOUT

	SHARED_WORKBENCH

create
	make

feature -- Access

	breakpoints_data_from_storage: BREAK_LIST is
			-- Exceptions handler data from storage
		do
			Result ?= data_from_storage (breakpoints_data_filename)
		end

	exceptions_handler_data_from_storage: DBG_EXCEPTION_HANDLER is
			-- Exceptions handler data from storage
		do
			Result ?= data_from_storage (exceptions_handler_data_filename)
		end

	profiles_data_from_storage: DEBUGGER_PROFILES is
			-- Profiles data from storage
		do
			Result ?= data_from_storage (profiles_data_filename)
		end

feature -- Filename

	breakpoints_data_filename: STRING is
		do
			Result := debugger_data_filename ("dbg-breakpoints")
		end

	exceptions_handler_data_filename: STRING is
		do
			Result := debugger_data_filename ("dbg-exceptions-handler")
		end

	profiles_data_filename: STRING is
		do
			Result := debugger_data_filename ("dbg-profiles")
		end

feature -- Write

	breakpoints_data_to_storage (a_data: like breakpoints_data_from_storage) is
			-- Breakpoints data to storage
		do
			data_to_storage (a_data, breakpoints_data_filename)
		end

	exceptions_handler_data_to_storage (a_data: like exceptions_handler_data_from_storage) is
			-- Exceptions handler data to storage
		do
			data_to_storage (a_data, exceptions_handler_data_filename)
		end

	profiles_data_to_storage (a_data: like profiles_data_from_storage) is
			-- Profiles data to storage
		do
			data_to_storage (a_data, profiles_data_filename)
		end

feature {NONE} -- Implementation

	debugger_data_filename (a_name: STRING): STRING is
		local
			fn: FILE_NAME
		do
			fn := base_debugger_data_filename
			if fn /= Void then
				Result := fn.string

				Result.append_character ('.')
				Result.append_string (a_name)
			end
		end

	base_debugger_data_filename: FILE_NAME is
		local
			fn: FILE_NAME
			l_ver: STRING_8
			l_target: STRING_8
		once
			if is_eiffel_layout_defined then
				create fn.make_from_string (eiffel_layout.user_session_path)
				if workbench.system_defined then
					if {l_uuid: !UUID} (create {USER_OPTIONS_FACTORY}).mapped_uuid (workbench.lace.file_name) then
						l_ver := l_uuid.out
					else
						l_ver := workbench.lace.target.system.uuid.out
					end
					l_ver.replace_substring_all ("-", "")
					l_target := workbench.lace.target.name
				end
				fn.set_file_name (l_ver  + "." + l_target)
				Result := fn
			end
		end

	data_from_storage (a_fn: STRING): ANY is
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
		do
			create l_file.make (a_fn)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read

				create l_sed_rw.make (l_file)
				l_sed_rw.set_for_reading
				Result ?= sed_facilities.retrieved (l_sed_rw, True)

				l_file.close
			end
		end

	data_to_storage (a_data: ANY; a_fn: STRING) is
			--
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
		do
			create l_file.make (a_fn)
			if not l_file.exists or else l_file.is_readable then
				l_file.open_write

				create l_sed_rw.make (l_file)
				l_sed_rw.set_for_writing
				sed_facilities.independent_store (a_data, l_sed_rw, False)

				l_file.close
			end
		end

	Sed_facilities: SED_STORABLE_FACILITIES is
		once
			create Result
		end

;indexing
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
