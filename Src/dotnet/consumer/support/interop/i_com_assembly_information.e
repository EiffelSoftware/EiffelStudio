indexing
	description: "COM visible class representing an assemblies information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE100-6EB3-46C8-94CE-208A7B1C79C3") end

deferred class
	I_COM_ASSEMBLY_INFORMATION
		
feature -- Access

	name: SYSTEM_STRING is
			-- assembly name
		deferred
		ensure
			non_void_result: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	version: SYSTEM_STRING is
			-- assembly version
		deferred
		ensure
			non_void_result: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	culture: SYSTEM_STRING is
			-- assembly culture
		deferred
		ensure
			non_void_result: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	public_key_token: SYSTEM_STRING is
			-- assembly public key token
		deferred
		ensure
			non_void_result: Result /= Void
		end
		
	is_in_gac: BOOLEAN is
			-- Is assembly currently is GAC
		deferred
		end
		
	is_consumed: BOOLEAN is
			-- has assembly been consumed?
		deferred
		end
		
	consumed_folder_name: SYSTEM_STRING is
			-- name of folder where assembly was consumed to
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	code_base: SYSTEM_STRING is
			-- Assembly code base location
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: Result.length > 0
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


end -- class I_COM_ASSEMBLY_INFORMATION
