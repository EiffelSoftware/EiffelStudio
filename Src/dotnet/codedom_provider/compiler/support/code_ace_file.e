indexing
	description: "Ace file to be written on disk"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ACE_FILE

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create {ARRAYED_LIST [CODE_ACE_CLUSTER]} clusters.make (10)
			create {ARRAYED_LIST [CODE_ACE_ASSEMBLY]} assemblies.make (10)
		end

feature -- Access

	content: STRING is
			-- Ace file content
		do
			create Result.make (4096)
			Result.append ("system%N%T%"")
			Result.append (system_name)
			Result.append ("%"%N%Nroot%N%T")
			Result.append (root_class_name)
			if root_creation_routine_name /= Void then
				Result.append (": ")
				Result.append (root_creation_routine_name)
			end
			Result.append ("%N%Ndefault%N%Tmsil_generation (yes)%N%Tuse_cluster_name_as_namespace (no)%N%T")
			Result.append ("use_all_cluster_name_as_namespace (yes)%N%Tdotnet_naming_convention (yes)%N%T")
			Result.append ("console_application (")
			if is_console_application then
				Result.append ("yes")
			else
				Result.append ("no")
			end
			Result.append (")%N%Tmsil_generation_type (%"")
			if is_console_application then
				Result.append ("exe")
			else
				Result.append ("dll")
			end
			Result.append ("%")%N%T")
			Result.append ("msil_clr_version (%"")
			Result.append (target_clr_version)
			Result.append ("%")%N%T")
			if metadata_cache_path /= Void then
				Result.append ("metadata_cache_path (%"")
				Result.append (metadata_cache_path)
				Result.append ("%")%N%T")
			end
			Result.append ("line_generation (")
			if generate_debug_info then
				Result.append ("yes")
			else
				Result.append ("no")
			end
			if precompile /= Void then
				Result.append (")%N%Tprecompiled (%"")
				Result.append (precompile)
				Result.append ("%")%N%Tmsil_use_optimized_precompile (yes")
			end
			Result.append (")%N%Ncluster%N%T")
			from
				clusters.start
				if not clusters.after then
					Result.append (clusters.item.code)
					clusters.forth
				end
			until
				clusters.after
			loop
				Result.append ("%N%N%T")
				Result.append (clusters.item.code)
				clusters.forth
			end
			Result.append ("%N%Nassembly%N%T")
			from
				assemblies.start
				if not assemblies.after then
					Result.append (assemblies.item.code)
					assemblies.forth
				end
			until
				assemblies.after
			loop
				Result.append ("%N%N%T")
				Result.append (assemblies.item.code)
				assemblies.forth
			end
			Result.append ("%N%Nend")
		end
	
	system_name: STRING
			-- System name

	root_class_name: STRING
			-- Root class name

	root_creation_routine_name: STRING
			-- Root creation routine name

	is_console_application: BOOLEAN
			-- Is system a console application?
			-- If not then it is a class library

	target_clr_version: STRING
			-- Target CLR version

	metadata_cache_path: STRING
			-- Path to metadata cache path

	clusters: LIST [CODE_ACE_CLUSTER]
			-- Clusters
	
	assemblies: LIST [CODE_ACE_ASSEMBLY]
			-- Assemblies

	generate_debug_info: BOOLEAN
			-- Should debug information be generated for system?

	precompile: STRING
			-- Path to precompiled library if any

feature -- Status Report

	is_ready: BOOLEAN is
			-- 	Is ace file ready to be generated?
		do
			Result := system_name /= Void and root_class_name /= Void and target_clr_version /= Void
		end

feature -- Element Settings

	set_system_name (a_name: like system_name) is
			-- Set `system_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			system_name := a_name
		ensure
			system_name_set: system_name = a_name
		end
	
	set_root_class_name (a_name: like root_class_name) is
			-- Set `root_class_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			root_class_name := a_name
		ensure
			root_class_name_set: root_class_name = a_name
		end
	
	set_root_creation_routine_name (a_name: like root_creation_routine_name) is
			-- Set `root_creation_routine_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			root_creation_routine_name := a_name
		ensure
			root_creation_routine_name_set: root_creation_routine_name = a_name
		end
	
	set_console_application (a_bool: BOOLEAN) is
			-- Set `is_console_application_set' with `a_bool'.
		do
			is_console_application := a_bool
		ensure
			is_console_application_set: is_console_application = a_bool
		end
		
	set_target_clr_version (a_target: like target_clr_version) is
			-- Set `target_clr_version' with `a_target'.
		require
			non_void_target: a_target /= Void
		do
			target_clr_version := a_target
		ensure
			target_clr_version_set: target_clr_version = a_target
		end
	
	set_metadata_cache_path (a_path: like metadata_cache_path) is
			-- Set `metadata_cache_path' with `a_path'.
		require
			non_void_path: a_path /= Void
		do
			metadata_cache_path := a_path
		ensure
			metadata_cache_path_set: metadata_cache_path = a_path
		end
	
	add_cluster (a_cluster: CODE_ACE_CLUSTER) is
			-- Add `a_cluster' to `clusters'.
		require
			non_void_cluster: a_cluster /= Void
		do
			clusters.extend (a_cluster)
		ensure
			added: clusters.has (a_cluster)
		end
	
	add_assembly (a_assembly: CODE_ACE_ASSEMBLY) is
			-- Add `a_assembly' to `assemblies'.
		require
			non_void_assembly: a_assembly /= Void
		do
			assemblies.extend (a_assembly)
		ensure
			added: assemblies.has (a_assembly)
		end
	
	set_generate_debug_info (a_bool: BOOLEAN) is
			-- Set `generate_debug_info' with `a_bool'.
		do
			generate_debug_info := a_bool
		ensure
			generate_debug_info_set: generate_debug_info = a_bool
		end
	
	set_precompile (a_precompile: STRING) is
			-- Set `precompile' with `a_precompile'.
		do
			precompile := a_precompile
		ensure
			precompile_set: precompile = a_precompile
		end

feature -- Basic Operations

	write (a_file_name: STRING) is
			-- Write ace file to `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
		local
			l_retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
		do
			if not l_retried then
				create l_file.make_open_write (a_file_name)
				l_file.put_string (content)
				l_file.close
			end
		rescue
			l_retried := True
			Event_manager.process_exception
			retry
		end

feature {NONE} -- Implementation

	Directory_separator: CHARACTER is
			-- Directory separator
		once
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
		
invariant
	non_void_clusters: clusters /= Void
	non_void_assemblies: assemblies /= Void
	is_ready_definition: is_ready = (system_name /= Void and root_class_name /= Void and target_clr_version /= Void)

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


end -- class CODE_ACE_FILE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------