indexing
	description: "Shared resources used by the compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONFIGURE_RESOURCES

feature -- Resources

	Configure_resources: RESOURCE_TABLE is
			-- Resources specified by the user
			-- (Calls `init_resources'. To include your own
			-- resource files redefine `init_resources'.)
		once
			create Result.make (0)
		end

feature -- Resource names

	r_AutomaticBackup: STRING is "automatic_backup"
	r_Fail_on_rescue: STRING is "fail_on_rescue"
	r_Cache_size: STRING is "cache_size"
	r_Graphics_disabled: STRING is "graphics_disabled"
	r_Windows_timer_delay: STRING is "windows_timer_delay"
	r_Metamorphosis_disabled: STRING is	"metamorphosis_disabled"

feature {NONE} -- Convenient access

	Fail_on_rescue: BOOLEAN is
			-- Fail on rescue?
		once
			Result := Configure_resources.get_boolean (r_Fail_on_rescue, False)
		end

	Metamorphosis_disabled: BOOLEAN is
			-- Is extra metamorphosis disabled?
		once
			Result := Configure_resources.get_boolean (r_Metamorphosis_disabled, False)
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

end -- class SHARED_CONFIGURE_RESOURCES
