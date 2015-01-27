note
	description: "Summary description for {ES_IRON_INSTALL_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_IRON_INSTALL_TASK

inherit
	IRON_INSTALL_TASK
		redefine
			install_ecf_dependencies
		end

create
	make

feature -- Operation: ecf dependency	

	install_ecf_dependencies (a_ecf: PATH; a_target_name: detachable READABLE_STRING_GENERAL; a_iron: IRON)
			-- Install IRON package needed by `a_ecf'.
			-- This applies for current platform
		local
			cfg: CONF_LOAD
			cfg_factory: CONF_PARSE_FACTORY
			tgt: detachable CONF_TARGET
			lib: CONF_LIBRARY
			l_ref: detachable READABLE_STRING_GENERAL
			l_package_name: detachable STRING_32
			ut: FILE_UTILITIES
			l_targets: ARRAYED_LIST [CONF_TARGET]
		do
			if ut.file_path_exists (a_ecf) then
				create cfg_factory
				create cfg.make (cfg_factory)

				cfg.retrieve_configuration (a_ecf.name)
				if attached cfg.last_system as sys then
					create l_targets.make (0)
					if a_target_name = Void then
						tgt := sys.library_target
						if tgt /= Void then
							l_targets.force (tgt)
						else
							across
								sys.targets as ic
							loop
								l_targets.force (ic.item)
							end
						end
					else
						across
							sys.targets as ic
						until
							tgt /= Void
						loop
							if a_target_name.is_case_insensitive_equal (ic.item.name) then
								l_targets.force (ic.item)
							end
						end
					end
					from
						l_targets.start
					until
						l_targets.after
					loop
						tgt := l_targets.item
						if is_verbose then
							print ("Analyze ")
							if tgt = sys.library_target then
								print (" library ")
							else
								print (" project ")
							end
							if not sys.name.same_string (tgt.name) then
								print (sys.name)
								print (".")
							end
							print (tgt.name)
							print (" from ")
							print (a_ecf.name)
							print ("%N")
						end
						across
							tgt.libraries as ic
						loop
							lib := ic.item
							l_ref := lib.location.original_path
							if l_ref.starts_with ("iron:") then
								add_to_completed_pool (l_ref)
								l_package_name := package_name_from_iron_uri (l_ref)
								if not l_package_name.is_empty then
									l_package_name.to_lower
									process_package_by_name (l_package_name, a_iron)
								end
							else --| not a iron:package:path.ecf
								l_ref := lib.location.evaluated_path.name
								if not is_completed (l_ref) then
									add_to_pending_ecf_pool (l_ref)
								end
							end
						end

						if attached pending_ecf_pool as ppool then
							across
								ppool as ic
							loop
								l_ref := ic.item
								if not is_completed (l_ref) then
									add_to_completed_pool (l_ref)
									install_ecf_dependencies (create {PATH}.make_from_string (l_ref), Void, a_iron)
								end
							end
						end
						l_targets.forth
					end
				else
					if is_verbose then
						print ("Process ")
						print (a_ecf.name)
						print (" -> Error while loading!")
						io.put_new_line
					end
				end
			else
				if is_verbose then
					print ("Process ")
					print (a_ecf.name)
					print (" -> File Not Found!")
					io.put_new_line
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
