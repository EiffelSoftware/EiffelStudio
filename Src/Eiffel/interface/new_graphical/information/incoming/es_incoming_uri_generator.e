note
	description: "URI Generator for EIS incoming mechanism"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INCOMING_URI_GENERATOR

feature -- Generator

	generate_uri_for_stone (a_stone: ANY): detachable STRING_32
			-- Generate URI for `a_stone'.
		local
			l_feature_name, l_class_name, l_group_name: detachable STRING_32
			l_target_name, l_system_name, l_system_uuid: detachable STRING_32
			l_group: CONF_GROUP
			l_target: CONF_TARGET
		do
			if attached {FEATURE_STONE} a_stone as l_feature_stone then
				l_feature_name := l_feature_stone.e_feature.name_32
				if attached l_feature_stone.class_name as l_n then
					l_class_name := l_n
				end
				l_group := l_feature_stone.class_i.group
				l_group_name := l_group.name
				l_target_name := l_group.target.name
				l_system_name := l_group.target.system.name
				l_system_uuid := l_group.target.system.uuid.out
			elseif attached {CLASSI_STONE} a_stone as l_class_stone then
				if attached l_class_stone.class_name as l_n then
					l_class_name := l_n
				end
				l_group := l_class_stone.class_i.group
				l_group_name := l_group.name
				l_target_name := l_group.target.name
				l_system_name := l_group.target.system.name
				l_system_uuid := l_group.target.system.uuid.out
			elseif attached {CLUSTER_STONE} a_stone as l_cluster_stone then
				l_group := l_cluster_stone.group
				l_group_name := l_group.name
				l_target_name := l_group.target.name
				l_system_name := l_group.target.system.name
				l_system_uuid := l_group.target.system.uuid.out
			elseif attached {TARGET_STONE} a_stone as l_target_stone then
				l_target := l_target_stone.target
				l_target_name := l_target.name
				l_system_name := l_target.system.name
				l_system_uuid := l_target.system.uuid.out
			end

			if l_system_name /= Void and then l_system_uuid /= Void then
				create Result.make_from_string (eiffel_prefix)
					-- System name
				Result.append (system_name)
				Result.append (l_system_name)
				Result.append_character (dot)
					-- System uuid
				Result.append (l_system_uuid)

				if l_target_name /= Void then
					Result.append_character (separator)
						-- Target name
					Result.append (target_name)
					Result.append (l_target_name)

					if l_group_name /= Void then
							-- Group name
						Result.append_character (separator)
						Result.append (group_name)
						Result.append (l_group_name)

						if l_class_name /= Void then
								-- Class name
							Result.append_character (separator)
							Result.append (class_name)
							Result.append (l_class_name)

							if l_feature_name /= Void then
									-- Feature name
								Result.append_character (separator)
								Result.append (feature_name)
								Result.append (l_feature_name)
							end
						end
					end
				end
			end
		end

feature {NONE} -- Constants

	eiffel_prefix: STRING_32 = "eiffel:?"

	system_name: STRING_32 = "system="

	target_name: STRING_32 = "target="

	group_name: STRING_32 = "cluster="

	class_name: STRING_32 = "class="

	feature_name: STRING_32 = "feature="

	dot: CHARACTER_32 = '.'

	separator: CHARACTER_32 = '&'

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
