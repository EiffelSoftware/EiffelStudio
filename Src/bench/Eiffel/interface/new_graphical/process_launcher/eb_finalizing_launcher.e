indexing
	description: "Object which is response for launching c compiler in finalization mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FINALIZING_LAUNCHER

inherit
	EB_C_COMPILER_LAUNCHER
		redefine
			on_start, generation_path
		end

create
	make

feature{NONE} -- Actions

	on_start is
			-- Handler called before c compiler starts
		do
			Precursor
			idle_printing_manager.add_printer ({EB_IDLE_PRINTING_MANAGER}.finalizing_printer)
		end

feature{NONE} -- Data storage

	data_storage: EB_PROCESS_IO_STORAGE is
		do
			Result := finalizing_storage
		end

feature{NONE} -- Generation path

	generation_path: STRING is
			-- Path on which c compiler will be launched.
			-- Used when we need to open a console there.
		do
			Result := final_generation_path
		end

feature -- Message

	c_compilation_launched_msg: STRING is
			-- Message to indicate c compilation launched successfully
		do
			Result := interface_names.e_finalizing_launched
		end

	c_compilation_launch_failed_msg: STRING is
			-- Message to indicate c compilation launch failed
		do
			Result := interface_names.e_finalizing_launch_failed
		end

	c_compilation_succeeded_msg: STRING is
			-- Message to indicate c compilation exited successfully
		do
			Result := interface_names.e_finalizing_succeeded
		end

	c_compilation_failed_msg: STRING is
			-- Message to indicate c compilation failed
		do
			Result := interface_names.e_finalizing_failed
		end

	c_compilation_terminated_msg: STRING is
			-- Message to indicate c compilation has been terminated
		do
			Result := interface_names.e_finalizing_terminated
		end

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
