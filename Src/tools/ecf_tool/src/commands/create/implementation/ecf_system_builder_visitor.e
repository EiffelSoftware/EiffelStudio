note
	description: "Summary description for {ECF_SYSTEM_BUILDER_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_SYSTEM_BUILDER_VISITOR

inherit
	ECF_VISITOR

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make
		do
			create factory
		end

	factory: CONF_PARSE_FACTORY

	new_conf_system (ecf: ECF; a_ecf_location: PATH): CONF_SYSTEM
		do
			Result := factory.new_system_with_file_name (a_ecf_location.name, ecf.name, create {UUID}.make_from_string (ecf.uuid))
		end

	current_conf_target: detachable CONF_TARGET

feature -- Access

	system: detachable CONF_SYSTEM

feature -- Operation

	reset
		do
			system := Void
			current_conf_target := Void
		end

feature -- Visitor

	process_ecf (v: ECF)
		do
			v.process (Current)
		end

	process_ecf_common (v: ECF)
		local
			l_target: CONF_TARGET
			l_file_rule: CONF_FILE_RULE
			l_system: like system
		do
			l_system := new_conf_system (v, (create {PATH}.make_from_string (v.name)).appended_with_extension ("ecf"))
			system := l_system

			l_target := factory.new_target (v.name, l_system)
			current_conf_target := l_target

			create l_file_rule.make
			l_file_rule.add_exclude ("/EIFGENs")
			l_file_rule.add_exclude ("/.git")
			l_file_rule.add_exclude ("/.svn")
			l_target.file_rule.extend (l_file_rule)
			l_target.options.set_full_class_checking (True)

			if v.is_voidsafe then
				l_target.options.void_safety.put_index (l_target.options.void_safety_index_all)
				l_target.options.set_is_attached_by_default (True)
			else
				l_target.options.void_safety.put_index (l_target.options.void_safety_index_none)
				l_target.options.set_is_attached_by_default (False)
			end
			if v.syntax.is_case_insensitive_equal_general ("standard") then
				l_target.options.syntax.put_index (l_target.options.syntax_index_standard)
			else
				l_target.options.syntax.put (v.syntax)
			end

			l_system.add_target (l_target)

			process_libraries_from (v)
			process_clusters_from (v)
			process_tests_clusters_from (v)
		end


	process_testing_ecf (v: TESTING_ECF)
		do
			process_application_ecf (v)
		end

	process_application_ecf (v: APPLICATION_ECF)
		do
			process_ecf_common (v)
			if
				attached current_conf_target as l_target
			then
				l_target.set_root (create {CONF_ROOT}.make (to_string_32 (v.root_cluster), v.root_class, v.root_feature, False))

				if v.is_console_application then
					l_target.add_setting ({CONF_CONSTANTS}.s_console_application, "true")
				else
					check v.generating_type /= {LIBRARY_ECF} end
					l_target.add_setting ({CONF_CONSTANTS}.s_console_application, "false")
				end

				if attached v.executable_name as s then
					check v.generating_type /= {LIBRARY_ECF} end
					l_target.add_setting ({CONF_CONSTANTS}.S_executable_name, s)
				end

				if attached v.concurrency as s then
					if s.is_case_insensitive_equal_general ("thread") then
						l_target.setting_concurrency.put_index (l_target.setting_concurrency_index_thread)
					elseif s.is_case_insensitive_equal_general ("scoop") then
						l_target.setting_concurrency.put_index (l_target.setting_concurrency_index_scoop)
					elseif s.is_case_insensitive_equal_general ("none") then
						l_target.setting_concurrency.put_index (l_target.setting_concurrency_index_none)
					else
						l_target.setting_concurrency.put (s)
					end
				end
			end
		end

	process_library_ecf (v: LIBRARY_ECF)
		do
			process_ecf_common (v)
			if
				attached system as l_system and then
				attached current_conf_target as l_target
			then
				l_system.set_library_target (l_target)
				l_target.set_root (create {CONF_ROOT}.make (Void, Void, Void, True))
			end
		end

feature {NONE} -- Implementation

	process_libraries_from (v: ECF)
		local
			lib: CONF_LIBRARY
		do
			if attached current_conf_target as l_target then
				across
					v.libraries as ic
				loop
					if attached library_info (ic.item) as lib_info then
						if v.is_voidsafe then
							lib := factory.new_library (lib_info.name, lib_info.ecf_path_without_extension + "-safe.ecf", l_target)
						else
							lib := factory.new_library (lib_info.name, lib_info.ecf_path_without_extension + ".ecf", l_target)
						end
						l_target.add_library (lib)
					end
				end
			end
		end

	process_clusters_from (v: ECF)
		local
			clu: CONF_CLUSTER
		do
			if attached current_conf_target as l_target then
				across
					v.clusters as ic
				loop
					if attached ic.item as l_cluster then
						if l_cluster.same_string (".") then
							clu := factory.new_cluster ("src", create {CONF_DIRECTORY_LOCATION}.make (".", l_target), l_target)
						else
							clu := factory.new_cluster (l_cluster, create {CONF_DIRECTORY_LOCATION}.make (l_cluster, l_target), l_target)
						end
						clu.set_recursive (True)
						l_target.add_cluster (clu)
					end
				end
			end
		end

	process_tests_clusters_from (v: ECF)
		local
			clu: CONF_CLUSTER
		do
			if attached current_conf_target as l_target then
				across
					v.tests_clusters as ic
				loop
					if attached ic.item as l_cluster then
						if l_cluster.same_string (".") then
							clu := factory.new_test_cluster ("src", create {CONF_DIRECTORY_LOCATION}.make (".", l_target), l_target)
						else
							clu := factory.new_test_cluster (l_cluster, create {CONF_DIRECTORY_LOCATION}.make (l_cluster, l_target), l_target)
						end
						clu.set_recursive (True)
						l_target.add_cluster (clu)
					end
				end
			end
		end

	library_info (s: STRING): detachable TUPLE [name: STRING; ecf_path_without_extension: STRING]
		local
			lib: STRING
			p: INTEGER
		do
			if s.has ('/') or s.has ('\') then
				p := s.last_index_of ('/', s.count).max (s.last_index_of ('\', s.count))
				if s.substring (s.count - 3, s.count).is_case_insensitive_equal (".ecf") then
					Result := [s.substring (p + 1, s.count - 4).as_lower, s.substring (1, s.count - 4)]
				else
					Result := [s.substring (p + 1, s.count).as_lower, s]
				end
			else
				lib := s.as_lower
				Result := [lib, "$ISE_LIBRARY/library/" + s + "/" + s]
			end
		end

feature -- Helpers

	to_string_32 (s: detachable READABLE_STRING_GENERAL): detachable STRING_32
		do
			if s /= Void then
				create Result.make_from_string_general (s)
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
