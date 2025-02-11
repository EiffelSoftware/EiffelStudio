﻿note
	description: "Provide reflection mechanisms to inspect EAC"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CACHE_REFLECTION

inherit
	CACHE_READER
		redefine
			consumed_type,
			assembly_types
		end

create
	default_create

feature -- Redefined

	consumed_type (t: SYSTEM_TYPE): detachable CONSUMED_TYPE
			-- Consumed type corresponding to `t'.
		local
			l_cache: like types_cache
		do
			l_cache := types_cache
			if attached t.full_name as n then
				l_cache.search (n)
				if l_cache.found then
					Result := l_cache.found_item
				else
					Result := Precursor (t)
					if attached Result then
						l_cache.put (Result, n)
					end
				end
			end
		end

	assembly_types (a_assembly: CONSUMED_ASSEMBLY): detachable CONSUMED_ASSEMBLY_TYPES
			-- Assembly information from EAC
		local
			l_cache: like assembly_types_cache
		do
			l_cache := assembly_types_cache
			l_cache.search (a_assembly.gac_path)
			if l_cache.found then
				Result := l_cache.found_item
			else
				Result := Precursor {CACHE_READER} (a_assembly)
				if Result /= Void then
					l_cache.put (Result, a_assembly.gac_path)
				end
			end
		end

feature -- Initialization

	initialize_cache (a_path: PATH)
			-- initialize cache with a binary file containing
			-- specifics consumed types.
		require
			non_void_path: a_path /= Void
			not_empty_path: not a_path.is_empty
		local
			l_raw_file: RAW_FILE
			l_consumed_types: LINKED_LIST [CONSUMED_TYPE]
			l_cache: like types_cache
		do
			if {SYSTEM_FILE}.exists (a_path.name.to_cil) then
				create l_raw_file.make_with_path (a_path)
				l_raw_file.open_read
				l_consumed_types ?= l_raw_file.retrieved
				l_cache := types_cache
				if l_consumed_types /= Void then
					from
						l_consumed_types.start
					until
						l_consumed_types.after
					loop
						l_cache.search (l_consumed_types.item.dotnet_name)
						if not l_cache.found then
							l_cache.put (l_consumed_types.item, l_consumed_types.item.dotnet_name)
						end
						l_consumed_types.forth
					end
				end
			end
		end

feature -- Access

	type_name (t: SYSTEM_TYPE): detachable STRING
			-- Eiffel name of .NET type `t'.
		local
			ct: detachable CONSUMED_TYPE
		do
			if is_type_in_cache (t) then
				ct := consumed_type (t)
				if ct /= Void then
					Result := ct.eiffel_name.twin
				end
			end
		end

	feature_name (t: SYSTEM_TYPE; dotnet_name: STRING; args: NATIVE_ARRAY [SYSTEM_TYPE]): detachable STRING
			-- Eiffel name of .NET function `dotnet_name' from type `t' with arguments `args'.
		require
			non_void_type: t /= Void
			non_void_name: dotnet_name /= Void
			valid_name: not dotnet_name.is_empty
			valid_args: args /= Void implies args.count >= 0
		local
			ct: detachable CONSUMED_TYPE
			crt: CONSUMED_REFERENCED_TYPE
			fields: detachable ARRAYED_LIST [CONSUMED_FIELD]
			procedures: detachable ARRAYED_LIST [CONSUMED_PROCEDURE]
			functions: detachable ARRAYED_LIST [CONSUMED_FUNCTION]
			constructors: detachable ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
			found: BOOLEAN
			i, j, count: INTEGER
			ca: detachable CONSUMED_ASSEMBLY
			cargs: ARRAY [CONSUMED_ARGUMENT]
			am: detachable ARRAYED_LIST [CONSUMED_ASSEMBLY]
		do
			if is_type_in_cache (t) then
				ct := consumed_type (t)
			end
			if attached t.assembly as l_assembly and then attached l_assembly.location as l_ass_location then
				ca := consumed_assembly_from_path (create {PATH}.make_from_string (create {IMMUTABLE_STRING_32}.make_from_cil (l_ass_location)))
			end
			if ca /= Void then
				am := assembly_mapping_array (ca)
			end
			if ct /= Void and am /= Void then
				if dotnet_name.is_equal (Constructor_name) then
					constructors := ct.constructors
					if constructors /= Void then
						from
							i := 1
							count := constructors.count
						until
							i > count or found
						loop
							cargs := constructors.i_th (i).arguments
							if cargs.count = args.count then
								from
									j := 1
									found := True
								until
									j > cargs.count or not found
								loop
									crt := cargs.item (j).type
									found := crt.name.to_cil.equals (args.item (j - 1).full_name) and then
										attached args.item (j - 1).assembly as l_assembly and then
										attached l_assembly.location as l_ass_location and then
										am.i_th (crt.assembly_id) ~ consumed_assembly_from_path (create {PATH}.make_from_string (create {IMMUTABLE_STRING_32}.make_from_cil (l_ass_location)))
									j := j + 1
								end
							end
							if found then
								Result := constructors.i_th (i).eiffel_name
							end
							i := i + 1
						end
					end
				elseif args /= Void then
					functions := ct.functions
					if functions /= Void then
						from
							i := 1
						until
							i > functions.count or found
						loop
							if functions.i_th (i).dotnet_name.is_equal (dotnet_name) then
								cargs := functions.i_th (i).arguments
								if cargs.count = args.count then
									from
										j := 1
										found := True
									until
										j > cargs.count or not found
									loop
										crt := cargs.item (j).type
										found := crt.name.to_cil.equals (args.item (j - 1).full_name) and then
											attached args.item (j - 1).assembly as l_assembly and then
											attached l_assembly.location as l_ass_location and then
											am.i_th (crt.assembly_id) ~ consumed_assembly_from_path (create {PATH}.make_from_string (create {IMMUTABLE_STRING_32}.make_from_cil (l_ass_location)))
										j := j + 1
									end
								end
							end
							if found then
								Result := functions.i_th (i).eiffel_name
							end
							i := i + 1
						end
					end
					if not found then
						procedures := ct.procedures
						if procedures /= Void then
							from
								i := 1
							until
								i > procedures.count or found
							loop
								if procedures.i_th (i).dotnet_name.is_equal (dotnet_name) then
									cargs := procedures.i_th (i).arguments
									if cargs.count = args.count then
										from
											j := 1
											found := True
										until
											j > cargs.count or not found
										loop
											crt := cargs.item (j).type
											found := crt.name.to_cil.equals (args.item (j - 1).full_name) and then
												attached args.item (j - 1).assembly as l_assembly and then
												attached l_assembly.location as l_ass_location and then
												am.i_th (crt.assembly_id) ~ consumed_assembly_from_path (create {PATH}.make_from_string (create {IMMUTABLE_STRING_32}.make_from_cil (l_ass_location)))
											j := j + 1
										end
									end
								end
								if found then
									Result := procedures.i_th (i).eiffel_name
								end
								i := i + 1
							end
						end
					end
				else
					-- No arguments, search fields first
					fields := ct.fields
					if fields /= Void then
						from
							i := 1
						until
							i > fields.count or found
						loop
							found := fields.i_th (i).dotnet_name.is_equal (dotnet_name)
							if found then
								Result := fields.i_th (i).eiffel_name
							end
							i := i + 1
						end
					end
					if not found then
						functions := ct.functions
						if functions /= Void then
							from
								i := 1
							until
								i > functions.count or found
							loop
								found := functions.i_th (i).dotnet_name.is_equal (dotnet_name)
								if found then
									Result := functions.i_th (i).eiffel_name
								end
								i := i + 1
							end
						end
					end
					if not found then
						procedures := ct.procedures
						if procedures /= Void then
							from
								i := 1
							until
								i > procedures.count or found
							loop
								found := procedures.i_th (i).dotnet_name.is_equal (dotnet_name)
								if found then
									Result := procedures.i_th (i).eiffel_name
								end
								i := i + 1
							end
						end
					end
				end
			end
		end

 	assembly_mapping_array (a_assembly: CONSUMED_ASSEMBLY): ARRAYED_LIST [CONSUMED_ASSEMBLY]
 			-- Assembly mapping for assembly `a_assembly'.
 		require
 			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
		local
			l_cache: like assemblies_mappings_cache
 		do
 			l_cache := assemblies_mappings_cache
			l_cache.search (a_assembly.gac_path)
			if l_cache.found and then attached l_cache.found_item as l_result then
				Result := l_result
			elseif attached assembly_mapping_from_consumed_assembly (a_assembly) as l_mapping then
				Result := l_mapping.assemblies
				l_cache.put (Result, a_assembly.gac_path)
			else
				create Result.make (0)
			end
  		end

	entity (entities_list: LIST [CONSUMED_ENTITY]; args: NATIVE_ARRAY [SYSTEM_TYPE]): detachable CONSUMED_ENTITY
			-- return `consumed_entity' corresponding to parameters.
			-- `entities_list' is given by `entities'.
		require
			valid_entities: entities_list /= Void
			valid_args: args /= Void implies args.count >= 0
		local
			cargs: detachable ARRAY [CONSUMED_ARGUMENT]
			crt: CONSUMED_REFERENCED_TYPE
			found: BOOLEAN
			i: INTEGER
		do
			from
				entities_list.start
			until
				entities_list.after or Result /= Void
			loop
				cargs := entities_list.item.arguments
				if (cargs = Void or else cargs.count = 0) and args = Void then
					Result := entities_list.item
				elseif cargs /= Void and then args /= Void and then cargs.count = args.count then
					-- compare arguments
					from
						i := 1
						found := True
					until
						i > cargs.count or not found
					loop
						crt := cargs.item (i).type
						found := crt.name.to_cil.equals (args.item (i - 1).full_name)
						i := i + 1
					end
					if found then
						Result := entities_list.item
					end
				end

				entities_list.forth
			end
		end

	entities (t: SYSTEM_TYPE; dotnet_feature_name: STRING): LIST [CONSUMED_ENTITY]
			-- Return list of Eiffel Eiffel entities associated to `dotnet_feature_name'.
		require
			non_void_t: t /= Void
			non_void_dotnet_feature_name: dotnet_feature_name /= Void
			not_empty_dotnet_feature_name: not dotnet_feature_name.is_empty
		local
			ct: CONSUMED_TYPE
			fields: ARRAYED_LIST [CONSUMED_FIELD]
			procedures: ARRAYED_LIST [CONSUMED_PROCEDURE]
			functions: ARRAYED_LIST [CONSUMED_FUNCTION]
			constructors: ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
			i: INTEGER
			l_cache: like types_cache
		do
			create {ARRAYED_LIST [CONSUMED_ENTITY]} Result.make (24)

			l_cache := types_cache
			if attached t.full_name as n then
				l_cache.search (n)
				if l_cache.found then
					ct := l_cache.found_item
				else
					ct := consumed_type (t)
					if attached ct then
						l_cache.put (ct, n)
					end
				end
			end
			if ct /= Void then
				if dotnet_feature_name.is_equal (Constructor_name) then
					constructors := ct.constructors
					if constructors /= Void then
						from
							i := 1
						until
							i > constructors.count
						loop
							Result.extend (constructors.i_th (i))
							i := i + 1
						end
					end
				else
					functions := ct.functions
					if functions /= Void then
						from
							i := 1
						until
							i > functions.count
						loop
							if functions.i_th (i).dotnet_name.is_equal (dotnet_feature_name) then
								Result.extend (functions.i_th (i))
							end
							i := i + 1
						end
					end

					procedures := ct.procedures
					if procedures /= Void then
						from
							i := 1
						until
							i > procedures.count
						loop
							if procedures.i_th (i).dotnet_name.is_equal (dotnet_feature_name) then
								Result.extend (procedures.i_th (i))
							end
							i := i + 1
						end
					end

					fields := ct.fields
					if fields /= Void then
						from
							i := 1
						until
							i > fields.count
						loop
							if fields.i_th (i).dotnet_name.is_equal (dotnet_feature_name) then
								Result.extend (fields.i_th (i))
							end
							i := i + 1
						end
					end
				end
			end
		ensure
			non_void_feature_names: Result /= Void
		end

feature -- Implementation

	types_cache: CACHE [CONSUMED_TYPE, STRING]
			-- Cache for loaded types
		once
			create Result.make (Max_cache_items)
		end

	assembly_types_cache: CACHE [CONSUMED_ASSEMBLY_TYPES, PATH]
			-- Cache of assembly types
		once
			create Result.make (15)
		end

feature {NONE} -- Implementation

	constructor_name: STRING = ".ctor"

	assemblies_mappings_cache: CACHE [ARRAYED_LIST [CONSUMED_ASSEMBLY], PATH]
			-- Cache for assemblies ids mappings
		once
			create Result.make (max_cache_items)
		end

	max_cache_items: INTEGER = 40
			-- Maximum number of types stored in local cache

;note
	copyright:	"Copyright (c) 1984-20186, Eiffel Software"
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


end -- class CACHE_REFLECTION
