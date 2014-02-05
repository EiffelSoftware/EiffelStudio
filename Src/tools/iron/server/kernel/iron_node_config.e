note
	description: "Summary description for {IRON_NODE_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_CONFIG

create
	make

feature {NONE} -- Initialization

	make (p: PATH)
			-- Create Current from config file `p'.
		do
			path := p

				-- Defaults
			log_level := 1

				-- Load from file.
			load
		end

	path: PATH

feature -- Access

	administrator_email: detachable IMMUTABLE_STRING_8

	log_level: NATURAL_8

feature -- Access

	item (a_name: READABLE_STRING_8): detachable READABLE_STRING_32
		do
			if attached internal_data as d then
				Result := d.item (a_name)
			end
		end

feature {NONE} -- Implementation

	internal_data: detachable IRON_NODE_INFO

	load
		local
			l_cfg: detachable IRON_NODE_INFO
		do
			create l_cfg.make_with_path (path)
			if not l_cfg.is_valid then
				debug ("iron")
					print ("[DEBUG] Error while loading configuration.%N")
				end
				l_cfg := Void
				check has_error: False end
			end
			internal_data := l_cfg
			if l_cfg /= Void then
					-- Administrator email address
				if
					attached l_cfg.adjusted_item ("admin.email.from") as l_email and then
					not l_email.is_empty and then l_email.is_valid_as_string_8
				then
					create administrator_email.make_from_string (l_email.to_string_8)
				end
					-- Log level
				if
					attached l_cfg.item ("log.level") as l_level and then
					l_level.is_natural_8
				then
					log_level := l_level.to_natural_8
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
