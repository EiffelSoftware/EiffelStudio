note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INSTALLATION_ENVIRONMENT

create
	make

feature {NONE} -- Creation

	make (env: EIFFEL_ENV)
		do
			eiffel_env := env
		end

	eiffel_env: EIFFEL_ENV

feature -- Access

	application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: detachable STRING): detachable STRING_32
			-- Variable `a_var' as if we were `a_app' for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void implies not a_version.is_whitespace
		local
			l_lowered_var: READABLE_STRING_GENERAL
			p: PATH
			f: PLAIN_TEXT_FILE
			s: STRING
			utf: UTF_CONVERTER
		do
			l_lowered_var := a_var.as_lower

			if a_version /= Void then
				p := eiffel_env.hidden_files_path_for_version (a_version, False)
			else
				p := eiffel_env.hidden_files_path
			end

			p := p.extended ("installation")
			if a_app /= Void then
				p := p.extended (a_app)
			end
			p := p.extended (l_lowered_var)

			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				create s.make (f.count)
				from
					f.open_read
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (1_024)
					s.append (f.last_string)
				end
				f.close
				s.right_adjust
				Result := utf.utf_8_string_8_to_string_32 (s)
			end
		end

feature -- Element change

	set_application_item (a_var: READABLE_STRING_GENERAL; a_app: detachable READABLE_STRING_GENERAL; a_version: detachable STRING; a_value: READABLE_STRING_GENERAL)
			-- Set value `a_value` in variable `a_var` as if we were `a_app` for version `a_version` (formatted as MM.mm).
		require
			a_var_ok: a_var /= Void and then not a_var.has ('%U')
			a_app_ok: a_app = Void or else not a_app.has ('%U')
			a_version_ok: a_version /= Void implies not a_version.is_whitespace
		local
			l_lowered_var: READABLE_STRING_GENERAL
			p: PATH
			f: PLAIN_TEXT_FILE
			utf: UTF_CONVERTER
			d: DIRECTORY
		do
			l_lowered_var := a_var.as_lower

			if a_version /= Void then
				p := eiffel_env.hidden_files_path_for_version (a_version, True)
			else
				p := eiffel_env.hidden_files_path
			end
			p := p.extended ("installation")
			if a_app /= Void then
				p := p.extended (a_app)
			end
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			p := p.extended (l_lowered_var)

			create f.make_with_path (p)
			if a_value /= Void then
				if not f.exists or else f.is_access_writable then
					f.create_read_write
					f.put_string (utf.utf_32_string_to_utf_8_string_8 (a_value))
					f.close
				end
			else
				if f.exists and then f.is_access_writable then
					f.delete
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
