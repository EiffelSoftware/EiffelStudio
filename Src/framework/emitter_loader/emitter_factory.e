indexing
	description: "Create COM_CACHE_MANAGER instances"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER_FACTORY

inherit
	CLI_COM
	
	CLR_HOST_FACTORY
		export
			{NONE} all
		end

feature -- Initialization

	new_emitter (runtime_version: STRING): COM_CACHE_MANAGER is
			-- Create a new instance of COM_CACHE_MANAGER.
		local
			p: POINTER
			l_host: CLR_HOST
		do
			initialize_com
			l_host := runtime_host (runtime_version)
			check
				l_host_not_void: l_host /= Void
			end
			p := c_new_cache_manager
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

feature {NONE} -- Externals

	c_new_cache_manager: POINTER is
			-- Creates new instance of EiffelSoftware_MetadataConsumer_ComCacheManager.
		external
			"C use %"cli_writer.h%""
		alias
			"new_cache_manager"
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

end -- class EMITTER_FACTORY
