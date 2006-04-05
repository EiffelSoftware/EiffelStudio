indexing
	description: "Simplistic interface for client assemblies"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_MANAGER

inherit
	EMITTER
		rename
			make as make_emitter,
			error_category as error_category_emitter,
			error_message_table as error_message_table_emitter
		export
			{NONE} all
			{CACHE_MANAGER} clr_version
			{ANY} compact_and_clean_cache, cache_reader, cache_writer
		undefine
			start
		end

	SAFE_ASSEMBLY_LOADER
		export
			{NONE} all
			{ANY} release_cached_assemblies
		end

	CACHE_MANAGER_ERRORS
		export
			{NONE} all
		select
			error_category,
			error_message_table
		end

create
	make,
	make_with_path

feature {NONE}-- Initialization

	make is
			-- create an instance of CACHE_MANAGER
		do
			is_successful := True
			last_error_message := ""
			create cache_writer.make
			create cache_reader
		end

	make_with_path (a_path: STRING) is
			-- create instance of CACHE_MANAGER with ISE_EIFFEL path set to `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {DIRECTORY}.make (a_path)).exists
		do
			set_internal_eiffel_cache_path (a_path.twin)
			make
		end

feature -- Access

	is_successful: BOOLEAN

	last_error_message: STRING
		-- last error message

feature -- Basic Oprtations

	consume_assembly (a_name, a_version, a_culture, a_key: STRING) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_assembly: ASSEMBLY
			l_resolver: AR_RESOLVER
		do
			is_successful := True
			last_error_message := ""

			add_to_eac := True
			l_assembly := load_assembly_from_full_name (fully_quantified_name (a_name, a_version, a_culture, a_key))
			if l_assembly /= Void then
				create l_resolver.make
				l_resolver.add_resolve_path_from_file_name (l_assembly.location)
				resolve_subscriber.subscribe ({APP_DOMAIN}.current_domain, l_resolver)
				add_assembly_to_eac (l_assembly.location)
				resolve_subscriber.unsubscribe ({APP_DOMAIN}.current_domain, l_resolver)
			end
		ensure
			successful: is_successful
		end

	consume_assembly_from_path (a_path: STRING) is
			-- Consume assembly located `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_paths: LIST [STRING]
			l_resolver: CONSUMER_AGUMENTED_RESOLVER
		do
			is_successful := True
			last_error_message := ""

			add_to_eac := True

			l_paths := a_path.split (';')
			create l_resolver.make (l_paths)
			resolve_subscriber.subscribe ({APP_DOMAIN}.current_domain, l_resolver)

			from
				l_paths.start
			until
				l_paths.after
			loop
				l_resolver.add_resolve_path_from_file_name (l_paths.item)
				add_assembly_to_eac (l_paths.item)
				l_resolver.remove_resolve_path_from_file_name (l_paths.item)
				l_paths.forth
			end
			resolve_subscriber.unsubscribe ({APP_DOMAIN}.current_domain, l_resolver)
		ensure
			successful: is_successful
		end

	relative_folder_name (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
		do
			l_ca := assembly_info (a_name, a_version, a_culture, a_key)
			if l_ca /= Void then
				Result := relative_assembly_path_from_consumed_assembly (l_ca)
				Result.prune_all_trailing ('\')
			end
		end

	relative_folder_name_from_path (a_path: STRING): STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
			l_assembly: ASSEMBLY
		do
			l_assembly := load_assembly_from_path (a_path)
			if l_assembly /= Void then
				l_ca := cache_writer.consumed_assembly_from_path (l_assembly.location)
			end
			if l_ca = Void then
					-- Try load assembly from GAC
				l_assembly := load_from_gac_or_path (a_path)
				if l_assembly /= Void then
					l_ca := cache_writer.consumed_assembly_from_path (l_assembly.location)
				end
			end
			if l_ca /= Void then
				Result := relative_assembly_path_from_consumed_assembly (l_ca)
				Result.prune_all_trailing ('\')
			end
		end

	assembly_info_from_path (a_path: STRING): CONSUMED_ASSEMBLY is
			-- retrieve a local assembly's information.
			-- If assembly has already been consumed then function will
			-- return found matching CONSUMED_ASSEMBLY.
			-- If you need to use resulting CONSUMED_ASSEMBLY.folder_name
			-- then you need to query CONSUMED_ASSEMBLY.is_consumed = True to
			-- know that that name exists.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			Result := cache_writer.consumed_assembly_from_path (a_path)
		end

	assembly_info (a_name: STRING; a_version: STRING; a_culture: STRING; a_key: STRING): CONSUMED_ASSEMBLY is
			-- retrieve a assembly's information.
			-- If assembly has already been consumed then function will
			-- return found matching CONSUMED_ASSEMBLY.
			-- If you need to use resulting CONSUMED_ASSEMBLY.folder_name
			-- then you need to query CONSUMED_ASSEMBLY.is_consumed = True to
			-- know that that name exists.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_assembly: ASSEMBLY
		do
			l_assembly := load_assembly_from_full_name (fully_quantified_name (a_name, a_version, a_culture, a_key))
			if l_assembly /= Void then
				Result := cache_writer.consumed_assembly_from_path (l_assembly.location)
			end
		end

feature {NONE} -- Basic Operations

	fully_quantified_name (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- returns "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			Result := a_name.twin
			if a_version /= Void and not a_version.is_empty then
				Result.append (", Version=" + a_version)
				if a_culture /= Void and not a_culture.is_empty then
					Result.append (", Culture=" + a_culture)
					if a_key /= Void and not a_key.is_empty then
						Result.append (", PublicKeyToken=" + a_key)
					end
				end
			end
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

feature {NONE} -- Internal Agents

	start is
			-- dummy routine
		do
			--| no code!
		end

invariant
	cache_writer_not_void: cache_writer /= Void
	cache_reader_not_void: cache_reader /= Void

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


end -- class CACHE_MANAGER
