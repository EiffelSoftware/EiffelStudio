indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NM_REFERENCED_ASSEMBLIES_MANAGER

inherit
	CODE_SHARED_REFERENCED_ASSEMBLIES

	NM_REGISTRY_KEYS
		export
			{NONE} all
		end

feature -- Access

	Startup_assemblies: LIST [STRING] is
			-- Assemblies to be in list by default
		once
			create {ARRAYED_LIST [STRING]} Result.make (20)
			Result.extend ("mscorlib.dll")
			Result.extend ("system.dll")
			Result.extend ("system.xml.dll")
			Result.extend ("system.web.dll")
			Result.extend ("system.windows.forms.dll")
			Result.extend ("system.enterpriseservices.dll")
			Result.extend ("system.data.dll")
			Result.extend ("system.drawing.dll")
			Result.extend ("system.web.services.dll")
			Result.extend ("microsoft.visualc.dll")
			Result.extend ("system.directoryservices.dll")
			Result.extend ("system.runtime.remoting.dll")
			Result.extend ("system.web.regularexpressions.dll")
			Result.extend ("system.design.dll")
			Result.extend ("system.runtime.serialization.formatters.soap.dll")
			Result.extend ("cscompmgd.dll")
			Result.extend ("accessibility.dll")
			Result.extend ("system.enterpriseservices.dll")
			if not {RUNTIME_ENVIRONMENT}.get_system_version.is_equal ("v1.0.3705") then
				Result.extend ("system.web.mobile.dll")
			end
			Result.compare_objects
		ensure
			lowercase: Result.for_all (agent is_lower)
		end

	is_lower (a_string: STRING): BOOLEAN is
			-- Is `a_string' lower case?
		do
			Result := a_string.as_lower.is_equal (a_string)
		end
		
feature -- Status Report

	is_startup_assembly (a_path: STRING): BOOLEAN is
			-- Is assembly with location `a_path' in `Startup_assemblies' list?
		local
			l_framework_path: STRING
		do
			l_framework_path := {RUNTIME_ENVIRONMENT}.get_runtime_directory
			l_framework_path.to_lower
			from
				Startup_assemblies.start
			until
				Startup_assemblies.after or Result
			loop
				Result := a_path.substring_index (l_framework_path, 1).is_equal (1)
				if Result then
					Result := Startup_assemblies.has (a_path.substring (l_framework_path.count + 1, a_path.count))
				end
				Startup_assemblies.forth
			end
		end

feature -- Basic Operations

	load_assemblies is
			-- Retrieve referenced assemblies list persisted with `save_assemblie'.
		local
			l_key: REGISTRY_KEY
			l_value: SYSTEM_STRING
			l_assemblies: NATIVE_ARRAY [SYSTEM_STRING]
			i, l_count: INTEGER
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_key := {REGISTRY}.Current_user.open_sub_key (Saved_settings_key)
				if l_key /= Void then
					l_value ?= l_key.get_value (Assemblies_key_name)
					l_key.close
					if l_value /= Void then
						l_assemblies := l_value.split (<<Separator>>)
						from
							l_count := l_assemblies.count
						until
							i = l_count
						loop
							if not Referenced_assemblies.has_file (l_assemblies.item (i)) then
								Referenced_assemblies.extend_file (l_assemblies.item (i))
							end
							i := i + 1
						end
					else
						load_default_assemblies
					end
				else
					load_default_assemblies
				end
			end
		rescue
			l_retried := True
			retry
		end
		
	save_assemblies is
			-- Persist referenced assemblies list.
		local
			l_assemblies: STRING
			l_key: REGISTRY_KEY
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_assemblies.make (4096)
				from
					Referenced_assemblies.start
					if not Referenced_assemblies.after then
						l_assemblies.append (Referenced_assemblies.item.assembly.location)
						Referenced_assemblies.forth
					end
				until
					Referenced_assemblies.after
				loop
					l_assemblies.append_character (Separator)
					l_assemblies.append (Referenced_assemblies.item.assembly.location)
					Referenced_assemblies.forth
				end
				l_key := {REGISTRY}.Current_user.open_sub_key (Saved_settings_key, True)
				if l_key = Void then
					l_key := {REGISTRY}.Current_user.create_sub_key (Saved_settings_key)
				end
				l_key.set_value (Assemblies_key_name.to_cil, l_assemblies.to_cil)
				l_key.close
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	load_default_assemblies is
			-- Load assemblies in `Startup_assemblies' list.
		do
			from
				Startup_assemblies.start
			until
				Startup_assemblies.after
			loop
				Referenced_assemblies.extend_file (Startup_assemblies.item)
				Startup_assemblies.forth
			end
		end

feature {NONE} -- Private Access

	Separator: CHARACTER is ';'
			-- Separator between two paths in saved information

end -- class NM_REFERENCED_ASSEMBLIES_MANAGER

--+--------------------------------------------------------------------
--| Name Mapper
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------