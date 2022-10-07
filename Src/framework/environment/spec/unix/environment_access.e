note
	description: "Access environment variables which takes default values in the registry into account."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENVIRONMENT_ACCESS

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	get_from_application (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL): detachable STRING_32
			-- Get `a_var' as if we were `a_app'.
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
		do
			Result := item (a_var)
		end

	application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: STRING): detachable STRING_32
			-- Variable `a_var' as if we were `a_app' for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void and then not a_version.is_whitespace
		do
			Result := item (a_var)
		end

	installed_product_version_names (env: EIFFEL_ENV): detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
		local
			p: PATH
			d: DIRECTORY
			i: INTEGER
			s: STRING_32
			f: RAW_FILE
		do
			create d.make_with_path (env.versionless_hidden_files_path (False))
			if d.exists then
				create Result.make (0)
				across
					d.entries as ic
				loop
					p := ic.item
					if p.is_current_symbol or p.is_parent_symbol then
							-- Skip
					else
						create f.make_with_path (d.path.extended_path (p))
						if f.is_directory then
							s := p.name
							i := s.index_of ('.', 1)
							if
								i > 1 and then
								s.head (i - 1).is_integer and then
								s.tail (s.count - i).is_integer
							then
									-- Formatted as "MM.mm"
								Result.force (s)
							end
						end
					end
				end
			end
		end

feature -- Environment change

	set_application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: detachable STRING; a_value: detachable READABLE_STRING_GENERAL)
			-- Set value `a_value` in variable `a_var` as if we were `a_app` for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void implies not a_version.is_whitespace
		do
			if a_value /= Void then
				put (a_value, a_var)
			else
				put ("", a_var)
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
