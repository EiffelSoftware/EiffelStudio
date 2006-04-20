indexing
	description: "Misc features to aid use with Eiffel ENViSioN!"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_COMPILER_SUPPORT

inherit
	IL_CASING_CONVERSION
		export
			{NONE} all
		end
	
	IEIFFEL_SUPPORT_IMPL_STUB
		redefine
			expand_path,
			eiffel_class_name_to_dotnet_name,
			get_process_id
		end
		
create
	default_create

feature -- Access

	get_process_id (pid: INTEGER_REF) is
			-- Get Current Process Handle
		do
			pid.set_item (cwin_get_current_process_id)
		end
		
feature -- Basic Operations

	expand_path (a_path: STRING): STRING is
			-- Epxand all env vars in 'a_path'
		require else
			non_void_path: a_path /= Void
		local
			var: STRING
			formatted_var: STRING
			dollar_pos: INTEGER
			slash_pos: INTEGER
			parth_pos: INTEGER
			next_dollar_pos: INTEGER
			env_var: STRING
			env: EXECUTION_ENVIRONMENT
		do
			create env
			Result := clone(a_path)
			
			if not Result.is_empty then
				Result.replace_substring_all ("/", "\")
				
				dollar_pos := Result.index_of ('$', 1)
				if dollar_pos > 0 then
					from 
					until
						dollar_pos = 0
					loop
						-- look for '\'
						slash_pos := Result.index_of ('\', dollar_pos + 1)
						
						-- now look for ) and return the first
						-- allows for $(ENV)Ext\...
						parth_pos := Result.index_of (')', dollar_pos + 1)
						
						-- look or $ as path could be $var1$var2
						next_dollar_pos := Result.index_of ('$', dollar_pos + 1)
	
						if slash_pos > 0 then
							if parth_pos > 0 then
								slash_pos := slash_pos.min (parth_pos + 1)
							end
							if next_dollar_pos > 0 then
								slash_pos := slash_pos.min (next_dollar_pos)
							end
						elseif parth_pos > 0 then
							if next_dollar_pos > 0 then
								slash_pos := parth_pos.min (next_dollar_pos)
							else
								slash_pos := parth_pos + 1
							end
						else
							if next_dollar_pos > 0 then
								slash_pos := next_dollar_pos
							else
								slash_pos := Result.count + 1
							end
						end
						
						var := Result.substring (dollar_pos, slash_pos - 1)
						
						-- remove the () and $
						formatted_var := clone(var);
						formatted_var.prune_all('(')
						formatted_var.prune_all(')')
						formatted_var.prune_all_leading('$')
						
						env_var := env.get (formatted_var)
						if env_var /= Void and then env_var.count > 0 then
							Result.replace_substring_all (var, env_var)
						end
						if dollar_pos + 1 <= Result.count then
							dollar_pos := Result.index_of ('$', dollar_pos + 1)
						else
							dollar_pos := 0
						end
					end
				end
			end
		end
		
	eiffel_class_name_to_dotnet_name (a_class_name: STRING): STRING is
			-- Takes an Eiffel class name and converts it to .NET convention.
			-- `a_class_name' [in].  
		require else
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
		do
			Result := pascal_casing (True, a_class_name.as_lower, feature {IL_CASING_CONVERSION}.upper_case)
		end

feature {NONE} -- External

	cwin_get_current_process_id: INTEGER is
			-- Platform SDK GetCurrentProcess
		external
			"C [macro %"windows.h%"]: EIF_INTEGER"
		alias
			"GetCurrentProcessId()"
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
end -- class COM_COMPILER_SUPPORT
