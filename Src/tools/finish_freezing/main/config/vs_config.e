indexing
	description: "Specialized configiration for versions of Microsoft's Visual Studio."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	VS_CONFIG

inherit
	MSCL_CONFIG

create
	make

feature {NONE} -- Access

	batch_file_name: STRING is
			-- Absolute path to an environment configuration batch script
		do
			create Result.make (256)
			Result.append (install_path)
			if use_32bit then
				Result.append ("bin\vcvars32.bat")
			else
				Result.append ("bin\amd64\vcvarsamd64.bat")
			end
		end

	full_product_reg_path: STRING is
			-- Absolute product registry location
		do
			create Result.make (256)
			Result.append ("HKEY_LOCAL_MACHINE\SOFTWARE\")
			if {PLATFORM_CONSTANTS}.is_64_bits then
				Result.append ("Wow6432Node\")
			end
			Result.append (product_reg_path)
		end

	install_path_value_name: STRING = "ProductDir"
			-- Key value name for install location

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
