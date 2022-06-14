note
	description: "Read content of Eiffel Assembly Cache"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_READER

inherit
	SYSTEM_OBJECT

	CACHE_PATH
		export
			{ANY} all
		end

	CACHE_INFO_FACTORY

	SHARED_CACHE_MUTEX_GUARD
		export
			{NONE} all
		end

create
	default_create

feature -- Access

	assemblies: detachable ARRAYED_LIST [CONSUMED_ASSEMBLY]
			-- Returns all assemblies registered in EAC.
			-- Note: Unconsumed assemblies will be returned also.
		do
			if is_initialized and then attached info as l_cache_info then
				Result := l_cache_info.assemblies.twin
			end
		end

	consumed_assemblies: like assemblies
			-- Returns all completed consumed assemblies
		local
			l_assemblies: like assemblies
			l_cached_assemblies: like assemblies
			l_ca: CONSUMED_ASSEMBLY
		do
			if is_initialized and then attached info as l_cache_info then
				l_cached_assemblies := l_cache_info.assemblies
				create l_assemblies.make (l_cached_assemblies.count)
				from
					l_cached_assemblies.start
				until
					l_cached_assemblies.after
				loop
					l_ca := l_cached_assemblies.item
					if l_ca.is_consumed then
						l_assemblies.extend (l_ca)
					end
					l_cached_assemblies.forth
				end
				Result := l_assemblies
			end
		end

	consumed_assembly_from_path (a_path: PATH): detachable CONSUMED_ASSEMBLY
			-- Find a consumed assembly in cache that matches `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			is_initialized: is_initialized
		local
			l_path: PATH
			l_consumed_assemblies: like assemblies
			l_assembly: CONSUMED_ASSEMBLY
		do
			if attached info as l_info then
				l_consumed_assemblies := l_info.assemblies
				from
					l_consumed_assemblies.start
				until
					l_consumed_assemblies.after or Result /= Void
				loop
					l_assembly := l_consumed_assemblies.item
					if l_path = Void then
						l_path := l_assembly.format_path (a_path).canonical_path
					end
					if l_assembly.has_same_path (l_path) then
						Result := l_assembly
					end
					l_consumed_assemblies.forth
				end
			end
		end

	assembly_types (a_assembly: CONSUMED_ASSEMBLY): detachable CONSUMED_ASSEMBLY_TYPES
			-- Assembly information from EAC
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
		local
			des: EIFFEL_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly).extended (assembly_types_file_name).name, 0)
			Result := {CONSUMED_ASSEMBLY_TYPES} / des.deserialized_object
		end

	consumed_type_from_dotnet_type_name (a_assembly: CONSUMED_ASSEMBLY; a_type: STRING): detachable CONSUMED_TYPE
			-- Type information from type `type' contained in `ca'
		require
			a_assembly_not_void: a_assembly /= Void
			a_assembly_is_in_consumed_cache: is_assembly_in_cache (a_assembly.gac_path, True)
			a_type_not_void: a_type /= Void
			not_a_type_empty: not a_type.is_empty
		local
			l_des: EIFFEL_DESERIALIZER
			l_pos: INTEGER
		do
			l_pos := type_position_from_type_name (a_assembly, a_type)
			if l_pos >= 0 then
				create l_des
				l_des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly).extended (classes_file_name).name, l_pos)
				Result := {CONSUMED_TYPE} / l_des.deserialized_object
			end
		end

	consumed_type_from_consumed_referenced_type (a_assembly: CONSUMED_ASSEMBLY; a_crt: CONSUMED_REFERENCED_TYPE): detachable CONSUMED_TYPE
			-- Type information from consumed referenced type `crt'.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
			non_void_referenced_type: a_crt /= Void
		local
			l_name: STRING
		do
			if attached assembly_mapping_from_consumed_assembly (a_assembly) as l_ca_mapping then
				if a_crt.is_by_ref then
					l_name := a_crt.name.twin
					l_name.keep_head (l_name.count - 1)
				else
					l_name := a_crt.name
				end
				Result := consumed_type_from_dotnet_type_name (l_ca_mapping.assemblies [a_crt.assembly_id], l_name)
			end
		end

	assembly_mapping_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): detachable CONSUMED_ASSEMBLY_MAPPING
			-- Assembly information from EAC for `a_assembly'.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
		local
			des: EIFFEL_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly).extended (Assembly_mapping_file_name).name, 0)
			Result := {CONSUMED_ASSEMBLY_MAPPING} / des.deserialized_object
		end

	consumed_type (a_type: SYSTEM_TYPE): detachable CONSUMED_TYPE
			-- Consumed type corresponding to `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_type_is_in_cache: is_type_in_cache (a_type)
		local
			l_des: EIFFEL_DESERIALIZER
			l_ca: detachable CONSUMED_ASSEMBLY
			l_pos: INTEGER
		do
			l_pos := type_position_from_type (a_type)
			if l_pos >= 0 then
				l_ca := consumed_assembly_from_path (assembly_location (a_type))
				if l_ca /= Void then
					create l_des
					l_des.deserialize (absolute_type_path (l_ca).name, l_pos)
					Result := {CONSUMED_TYPE} / l_des.deserialized_object
				end
			end
		end

	client_assemblies (a_assembly: CONSUMED_ASSEMBLY): detachable ARRAYED_LIST [CONSUMED_ASSEMBLY]
			-- List of assemblies in EAC depending on `a_assembly'.
		require
			non_void_assembly: a_assembly /= Void
		local
			l_referenced_assemblies: like assembly_mapping_from_consumed_assembly
			l_assembly: CONSUMED_ASSEMBLY
		do
			if attached consumed_assemblies as l_assemblies then
				create Result.make (l_assemblies.count)
				from
					l_assemblies.start
				until
					l_assemblies.after
				loop
					l_assembly := l_assemblies.item
					if l_assembly /= Void then
						l_referenced_assemblies := assembly_mapping_from_consumed_assembly (l_assembly)
						if l_referenced_assemblies /= Void and then l_referenced_assemblies.assemblies.has (a_assembly) then
							Result.extend (l_assembly)
						end
					end
					l_assemblies.forth
				end
			end
		end

feature -- Status Report

	is_initialized: BOOLEAN
			-- Is EAC correctly installed?
		do
			Result := (create {RAW_FILE}.make_with_path (Absolute_info_path)).exists
		end

	is_assembly_in_cache (a_path: PATH; a_consumed: BOOLEAN): BOOLEAN
			-- Is `a_path' in cache and if `a_consumed' has it been consumed
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: detachable CONSUMED_ASSEMBLY
		do
			l_ca := consumed_assembly_from_path (a_path)
			Result := l_ca /= Void and then (not a_consumed or l_ca.is_consumed)
		end

	is_type_in_cache (a_type: SYSTEM_TYPE): BOOLEAN
			-- Is `a_type' in EAC?
		require
			non_void_type: a_type /= Void
		local
			l_ca: detachable CONSUMED_ASSEMBLY
			l_type_path: PATH
			l_pos: INTEGER
		do
			l_pos := type_position_from_type (a_type)
			if l_pos >= 0 then
				l_ca := consumed_assembly_from_path (assembly_location (a_type))
				if l_ca /= Void then
					l_type_path := absolute_type_path (l_ca)
					if not l_type_path.is_empty then
						Result := (create {RAW_FILE}.make_with_path (l_type_path)).exists
					end
				end
			end
		end

	is_assembly_stale (a_path: PATH): BOOLEAN
			-- Is assembly `a_path' out of date
			-- Returns false if assembly has not already been consumed.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_consume_path: PATH
			l_file_info: SYSTEM_FILE_INFO
			l_dir_info: DIRECTORY_INFO
			l_so: SYSTEM_OBJECT
			l_reason: STRING
		do
			if attached consumed_assembly_from_path (a_path) as l_ca and then l_ca.is_consumed then
				l_consume_path := absolute_assembly_path_from_consumed_assembly (l_ca)
				create l_dir_info.make (l_consume_path.name)
				create l_file_info.make (l_ca.location.name)
				Result := not l_dir_info.exists or {SYSTEM_DATE_TIME}.compare (l_file_info.last_write_time, l_dir_info.creation_time) > 0
				if not Result then
						-- now check in consumer is newer
					l_so := Current
					if attached l_so.get_type as l_type then
						check l_type_attached: l_type /= Void end
						create l_file_info.make (assembly_location (l_type).name)
						Result := {SYSTEM_DATE_TIME}.compare (l_file_info.last_write_time, l_dir_info.creation_time) > 0
						if Result then
							l_reason := "The consumer is newer than the generated contents."
						end
					end
				else
					l_reason := "The contents of the assembly manifest has changed."
				end
			end
			debug ("assemblies_are_never_stale")
				Result := False
			end
			if Result then
				check
					l_reason_not_void: l_reason /= Void
				end
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Assembly '{0}' is considered stale.", a_path.name.to_cil))
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("%TReason: {0}.", l_reason))
			end
		end

feature {CACHE_WRITER} -- Implementation

	info: detachable CACHE_INFO
			-- Information on EAC content
		require
			non_void_clr_version: clr_version /= Void
		local
			des: EIFFEL_DESERIALIZER
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				if internal_info.item = Void then
					if is_initialized then
						create des
						des.deserialize (Absolute_info_path.name, 0)
						if des.successful then
							if attached {CACHE_INFO} des.deserialized_object as l_ci then
								internal_info.put (l_ci)
							end
						end
					end
					if internal_info.item = Void then
							-- cache info is not initalized or is outdated
						internal_info.put (new_cache_info (absolute_info_path))
					end
				end
			else
				if internal_info.item = Void then
						-- cache info is not initalized or is outdated
					internal_info.put (new_cache_info (absolute_info_path))
				end
			end
			Result := internal_info.item
			guard.unlock
		ensure
			non_void_if_initialized: is_initialized implies Result /= Void
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

feature -- Reset

	reset_info
			-- Causes `info' to be reevaluated.
			-- WARNING: Use this with caution. `reset_info' should not be called
			-- when in the middle of a batch operation.
		do
			internal_info.put (Void)
		ensure
			internal_info_item_not_attached: internal_info.item = Void
		end

feature {NONE} -- Implementation

	internal_info: CELL [detachable CACHE_INFO]
			-- cache `info'
		once
			create Result.put (Void)
		end

	type_position_from_type (a_type: SYSTEM_TYPE): INTEGER
			-- retrieve type position from `a_type' in `a_assembly'.
			-- `-1' if not found.
		require
			a_type_not_void: a_type /= Void
		local
			l_ca: detachable CONSUMED_ASSEMBLY
		do
			l_ca := consumed_assembly_from_path (assembly_location (a_type))
			if l_ca /= Void and then attached a_type.full_name as l_type_name then
				Result := type_position_from_type_name (l_ca, l_type_name)
			else
				Result := -1
			end
		ensure
			valid_result: Result = -1 or Result >= 0
		end

	type_position_from_type_name (a_assembly: CONSUMED_ASSEMBLY; a_type: STRING): INTEGER
			-- retrieve type position from `a_type' in `a_assembly'.
			-- `-1' if not found.
		require
			a_assembly_not_void: a_assembly /= Void
			a_type_not_void: a_type /= Void
			not_a_type_empty: not a_type.is_empty
		local
			l_types: like assembly_types
			i: INTEGER
		do
			l_types := assembly_types (a_assembly)
			Result := -1
			if l_types /= Void then
				from
					i := 1
				until
					i > l_types.count
					or else Result >= 0
					or else l_types.dotnet_names [i] = Void
				loop
					if (l_types.dotnet_names [i]) ~ a_type then
						Result := l_types.positions.item (i)
					else
						i := i + 1
					end
				end
			end
		ensure
			valid_result: Result = -1 or Result >= 0
		end

	assembly_location (a_type: SYSTEM_TYPE): PATH
			-- Get the location of assembly  in which `a_type' belongs.
		require
			a_type_attached: a_type /= Void
		do
			if attached a_type.assembly as a then
				create Result.make_from_string (create {STRING_32}.make_from_cil (a.location))
			else
				check
					from_documentation: False
				then
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
