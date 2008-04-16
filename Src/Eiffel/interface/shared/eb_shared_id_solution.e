indexing
	description: "Identifier solution for group, folder, class and feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_ID_SOLUTION

inherit
	SHARED_WORKBENCH

feature -- Access names

	last_target_uuid: STRING
	last_target_name: STRING
	last_group_name: STRING
	last_folder_path: STRING
	last_class_name: STRING
	last_feature_name: STRING
			-- Last names extracted from ids when retrieving XXX_of_id
			-- It is possible not valid in the system if XXX_of_id returns void.

	last_folder_name: STRING is
			-- The outer most folder name in `last_folder_path' if possible
			-- Void if no folder name can be retrieved from `last_folder_path'.
		local
			l_last_folder_path: STRING
			l_cnt: INTEGER
			l_index: INTEGER
		do
			l_last_folder_path := last_folder_path
			if l_last_folder_path /= Void then
				l_cnt := l_last_folder_path.count
				l_index := l_last_folder_path.last_index_of ('/', l_cnt)
				if l_index > 0 and then l_index < l_cnt then
					Result := l_last_folder_path.substring (l_index + 1, l_cnt)
				end
			end
		end

feature -- Access (Target)

	id_of_target (a_target: CONF_TARGET): STRING is
			-- UUID of `a_target'
		require
			a_target_not_void: a_target /= Void
		do
			create Result.make (40)
			Result.append (encode (a_target.system.uuid.out))
			Result.extend (name_sep)
			Result.append (encode (a_target.name))
		ensure
			result_not_void: Result /= Void
		end

	target_of_id (a_id: STRING): CONF_TARGET is
			-- Target of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			uuid: STRING
			l_target: CONF_TARGET
			l_target_name: STRING
			l_uuid: UUID
		do
			last_target_uuid := Void
			last_target_name := Void
			strings := a_id.split (name_sep)
			if strings.count >= target_id_sections then
				uuid := decode (strings.i_th (target_id_sections - 1))
				last_target_uuid := uuid
				l_target_name := decode (strings.i_th (target_id_sections))
				last_target_name := l_target_name
				if universe.target.system.uuid.out.is_equal (uuid) then
						-- Get the target from current system by name.
					l_target := universe.target.system.targets.item (l_target_name)
				else
					create l_uuid
					if l_uuid.is_valid_uuid (uuid) then
						l_target := universe.target.system.all_libraries.item (create {UUID}.make_from_string (uuid))
					end
				end
			end
			Result := l_target
			if Result /= Void then
				last_target_name := Result.name
			end
		ensure
			strings_not_void: strings /= Void
		end

feature -- Access (Group)

	id_of_group (a_group: CONF_GROUP): STRING is
			-- Identifier of `a_group'
			-- target_uuid + name_sep + group_name
			-- Assembly: assembly + name_sep + ph + name_sep + assemblyID
		require
			a_group_not_void: a_group /= Void
		local
			l_phys_as: CONF_PHYSICAL_ASSEMBLY
		do
			if a_group.is_physical_assembly then
				create Result.make (50)
				l_phys_as ?= a_group
				check
					assembly: l_phys_as /= Void
				end
				Result.append (encode (assembly_prefix))
				Result.extend (name_sep)
					-- We need a place holder to keep the same section number with other types of group.
				Result.append (encode (place_holder_string))
				Result.extend (name_sep)
				Result.append (l_phys_as.guid)
			else
				create Result.make (50)
				Result.append (id_of_target (a_group.target))
				Result.extend (name_sep)
				Result.append (encode (a_group.name))
			end
		ensure
			result_not_void: Result /= Void
		end

	group_of_id (a_id: STRING): CONF_GROUP is
			-- Group of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			group_name: STRING
			l_target: CONF_TARGET
			l_ass_id: STRING
		do
			last_group_name := Void
			strings := a_id.split (name_sep)
			if strings.count >= group_id_sections then
				if decode (strings.i_th (1)).is_equal (assembly_prefix) then
					l_ass_id := decode (strings.i_th (group_id_sections))
					Result := universe.target.system.all_assemblies.item (l_ass_id)
					if Result /= Void then
						last_group_name := Result.name
					end
				end
			end
			if Result = Void then
				l_target := target_of_id (a_id)
				if strings.count >= group_id_sections then
					group_name := decode (strings.i_th (group_id_sections))
					last_group_name := group_name
					if l_target /= Void then
						Result := l_target.groups.item (group_name)
					end
				end
			end
		end

feature -- Access (Folder)

	id_of_folder (a_folder: EB_FOLDER): STRING is
			-- Id of `a_folder'
			-- `id_of_group' + `name_sep' + path
		require
			a_folder_not_void: a_folder /= Void
		local
			l_group : CONF_GROUP
		do
			l_group := a_folder.cluster
			Result := id_of_group (l_group)
			Result.extend (name_sep)
			Result.append (encode (a_folder.path))
		ensure
			result_not_void: Result /= Void
		end

	folder_of_id (a_id: STRING): EB_FOLDER is
			-- Folder of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_path: STRING
			l_cluster: CONF_CLUSTER
			l_dir: KL_DIRECTORY
		do
			last_folder_path := Void
			l_cluster ?= group_of_id (a_id)
			if strings.count >= folder_id_sections then
				l_path := decode (strings.i_th (folder_id_sections))
				last_folder_path := l_path
				if l_cluster /= Void then
					create l_dir.make (l_cluster.location.build_path (l_path, ""))
					if l_dir.exists then
						create Result.make (l_cluster, l_path)
					end
				end
			end
		end

feature -- Access (Class)

	id_of_class (a_class: CONF_CLASS): STRING is
			-- Unique id of a class in the system
			-- `id_of_group' + `name_sep' + class_name
		require
			a_class_not_void: a_class /= Void
		local
			l_group: CONF_GROUP
		do
			l_group := a_class.group
			Result := id_of_group (l_group)
			Result.extend (name_sep)
			Result.append (encode (a_class.name))
		ensure
			result_not_void: Result /= Void
		end

	class_of_id (a_id: STRING): CONF_CLASS is
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			class_name: STRING
			l_group: CONF_GROUP
		do
			last_class_name := Void
			l_group ?= group_of_id (a_id)
			if strings.count >= class_id_sections then
				class_name := decode (strings.i_th (class_id_sections))
				last_class_name := class_name
				if l_group /= Void and then l_group.classes /= Void then
					Result := l_group.classes.item (class_name)
				end
			end
		end

feature -- Access (Feature)

	feature_of_id (a_id: STRING): E_FEATURE is
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_class: CLASS_I
			l_class_c: CLASS_C
			l_feature_name: STRING
		do
			last_feature_name := Void
			l_class ?= class_of_id (a_id)
			if strings.count >= feature_id_sections then
				l_feature_name := decode (strings.i_th (feature_id_sections))
				last_feature_name := l_feature_name
				if l_class /= Void then
					l_class_c := l_class.compiled_representation
					if l_class_c /= Void and then l_class_c.has_feature_table then
						Result := l_class_c.feature_with_name (l_feature_name)
					end
				end
			end
		end

	id_of_feature (a_feature: E_FEATURE): STRING is
			-- Unique id of a feature in the system
			-- `id_of_class'(associate class) + name_sep + feature_name
		require
			a_feature_not_void: a_feature /= Void
		local
			l_class: CONF_CLASS
		do
			l_class ?= a_feature.associated_class.lace_class
			Result := id_of_class (l_class)
			Result.extend (name_sep)
			Result.append (encode (a_feature.name))
		ensure
			result_not_void: Result /= Void
		end

	id_of_feature_ast (a_class: CONF_CLASS; a_ast: FEATURE_AS): STRING is
			-- Unique id of a feature in the system
			-- `id_of_class'(associate class) + name_sep + feature_name
		require
			a_class_not_void: a_class /= Void
			a_ast_not_void: a_ast /= Void
		do
			Result := id_of_class (a_class)
			Result.extend (name_sep)
			Result.append (encode (a_ast.feature_name.name))
		end

feature -- ID modification

	substitute_target_uuid (a_id: STRING; a_target_uuid: STRING): STRING is
			-- Substitute uuid of `a_id' to `a_target_uuid'.
		require
			a_id_not_void: a_id /= Void
			a_target_uuid_not_void: a_target_uuid /= Void
		local
			l_strings: like last_split_strings
		do
			if last_id = Void or else not last_id.is_equal (a_id) then
				last_id := a_id
				last_split_strings := a_id.split (name_sep)
			end
			check
				last_split_strings_not_void: last_split_strings /= Void
			end
			l_strings := last_split_strings
			if not decode (l_strings.i_th (1)).is_equal (assembly_prefix) then
				if l_strings.count >= target_id_sections then
					create Result.make (40)
					Result.append (encode (a_target_uuid))
					from
						l_strings.go_i_th (target_id_sections)
					until
						l_strings.after
					loop
						Result.extend (name_sep)
						Result.append (l_strings.item)
						l_strings.forth
					end
				end
			end
		end

	substitute_target_name (a_id: STRING; a_target_name: STRING): STRING is
			-- Substitute target name of `a_id' to `a_target_name'.
		require
			a_id_not_void: a_id /= Void
			a_target_name_not_void: a_target_name /= Void
		local
			l_strings: like last_split_strings
		do
			if last_id = Void or else not last_id.is_equal (a_id) then
				last_id := a_id
				last_split_strings := a_id.split (name_sep)
			end
			check
				last_split_strings_not_void: last_split_strings /= Void
			end
			l_strings := last_split_strings
			if not decode (l_strings.i_th (1)).is_equal (assembly_prefix) then
				if last_split_strings.count >= target_id_sections then
					create Result.make (40)
					Result.append (l_strings.first)
					from
						l_strings.go_i_th (target_id_sections)
					until
						l_strings.after
					loop
						Result.extend (name_sep)
						if l_strings.index = target_id_sections then
							Result.append (encode (a_target_name))
						else
							Result.append (l_strings.item)
						end
						l_strings.forth
					end
				end
			end
		end

	substitute_group (a_id: STRING; a_group_name: STRING): STRING is
			-- Substitute group name of `a_id' to `a_group_name'.
		require
			a_id_not_void: a_id /= Void
			a_group_name_not_void: a_group_name /= Void
		local
			l_strings: like last_split_strings
		do
			if last_id = Void or else not last_id.is_equal (a_id) then
				last_id := a_id
				last_split_strings := a_id.split (name_sep)
			end
			check
				last_split_strings_not_void: last_split_strings /= Void
			end
			l_strings := last_split_strings
			if not decode (l_strings.i_th (1)).is_equal (assembly_prefix) then
				if last_split_strings.count >= group_id_sections then
					create Result.make (40)
					Result.append (l_strings.first)
					from
						l_strings.go_i_th (target_id_sections)
					until
						l_strings.after
					loop
						Result.extend (name_sep)
						if l_strings.index = group_id_sections then
							Result.append (encode (a_group_name))
						else
							Result.append (l_strings.item)
						end
						l_strings.forth
					end
				end
			end
		end

feature -- UUID generation

	generate_uuid: STRING is
			-- Generate uuid
		do
			Result := uuid_gen.generate_uuid.out
		ensure
			result_not_void: Result /= Void
		end

feature -- Querry

	id_valid (a_id: !STRING): BOOLEAN is
			-- Does `a_id' represent an existing item in the system?
		local
			l_type: like most_possible_type_of_id
		do
			l_type := most_possible_type_of_id (a_id)
			if l_type >= min_type and then l_type <= max_type then
				inspect l_type
				when target_type then
					Result := target_of_id (a_id) /= Void
				when group_type then
					Result := group_of_id (a_id) /= Void
				when folder_type then
					Result := folder_of_id (a_id) /= Void
				when class_type then
					Result := class_of_id (a_id) /= Void
				when feature_type then
					Result := feature_of_id (a_id) /= Void
				else
				end
			end
		end

	possible_name_of_id (a_id: !STRING): !STRING is
			-- Extracted name from `a_id'
			-- Despite of id type, the last section is extracted as name.
			-- Target id is not appliable.
		require
			not_target_id: most_possible_type_of_id (a_id) /= target_type
		local
			l_strings: like strings
		do
			l_strings := a_id.split (name_sep)
			if {lt_name: STRING}decode (l_strings.last) then
				Result := lt_name
			else
				create Result.make_empty
			end
		end

	most_possible_type_of_id (a_id: !STRING): NATURAL is
			-- Most possible type of the given `a_id'
			-- target, group, folder, class or feature.
			-- This querry can not distinguish folder and class.
			-- In this case, `class_type' is returned by default.
		local
			l_strings: LIST [STRING]
			l_count: INTEGER
		do
			l_strings := a_id.split (name_sep)
			l_count := l_strings.count
			if l_count = target_id_sections then
				Result := target_type
			elseif l_count = group_id_sections then
				Result := group_type
			elseif l_count = folder_id_sections then
					-- We cannot distinguish it is a class id or a folder simply by sections.
					-- To avoid overload, we do not try to go further detecting.
					-- `class_type' is simply returned.
					-- The following check shows the reason, class id and folder id have the same sections.
				Result := class_type
				check
					class_id_sections_the_same_as_folder_id_sections:
						class_id_sections = folder_id_sections
				end
			elseif l_count = class_id_sections then
				Result := class_type
			elseif l_count = feature_id_sections then
				Result := feature_type
			else
			end
		end

	id_type_valid (a_id_type: NATURAL): BOOLEAN is
			-- Is `a_id_type' valid?
		do
			if a_id_type <= max_type and a_id_type > min_type then
				Result := True
			end
		end

feature -- ID type

	target_type: NATURAL is 1
	group_type: NATURAL is 2
	folder_type: NATURAL is 3
	class_type: NATURAL is 4
	feature_type: NATURAL is 5
	min_type: NATURAL is once Result := target_type end
	max_type: NATURAL is once Result := feature_type end

feature {NONE} -- Access

	target_id_sections: INTEGER is 2

	group_id_sections: INTEGER is
		once
			Result := target_id_sections + 1
		end

	folder_id_sections: INTEGER is
		once
			Result := group_id_sections + 1
		end

	class_id_sections: INTEGER is
		once
			Result := group_id_sections + 1
		end

	feature_id_sections: INTEGER is
		once
			Result := class_id_sections + 1
		end

feature {NONE} -- Implementation

	last_id: STRING
			-- Last id modified

	last_split_strings: LIST [STRING]
			-- Last split strings from `last_id'

feature {NONE} -- Implementation. Encoding/Decoding

	name_sep: CHARACTER is '@'
			-- Name separator

	escape_char: CHARACTER is '%%'

	place_holder_string: STRING is "ph"

	assembly_prefix: STRING is "assembly"

	name_sep_code: NATURAL_32 is
		once
			Result := name_sep.natural_32_code
		end

	escape_char_code: NATURAL_32 is
		once
			Result := escape_char.natural_32_code
		end

	hex_strings: ARRAY [STRING] is
		once
			Result := <<
			    "%%00", "%%01", "%%02", "%%03", "%%04", "%%05", "%%06", "%%07",
			    "%%08", "%%09", "%%0a", "%%0b", "%%0c", "%%0d", "%%0e", "%%0f",
			    "%%10", "%%11", "%%12", "%%13", "%%14", "%%15", "%%16", "%%17",
			    "%%18", "%%19", "%%1a", "%%1b", "%%1c", "%%1d", "%%1e", "%%1f",
			    "%%20", "%%21", "%%22", "%%23", "%%24", "%%25", "%%26", "%%27",
			    "%%28", "%%29", "%%2a", "%%2b", "%%2c", "%%2d", "%%2e", "%%2f",
			    "%%30", "%%31", "%%32", "%%33", "%%34", "%%35", "%%36", "%%37",
			    "%%38", "%%39", "%%3a", "%%3b", "%%3c", "%%3d", "%%3e", "%%3f",
			    "%%40", "%%41", "%%42", "%%43", "%%44", "%%45", "%%46", "%%47",
			    "%%48", "%%49", "%%4a", "%%4b", "%%4c", "%%4d", "%%4e", "%%4f",
			    "%%50", "%%51", "%%52", "%%53", "%%54", "%%55", "%%56", "%%57",
			    "%%58", "%%59", "%%5a", "%%5b", "%%5c", "%%5d", "%%5e", "%%5f",
			    "%%60", "%%61", "%%62", "%%63", "%%64", "%%65", "%%66", "%%67",
			    "%%68", "%%69", "%%6a", "%%6b", "%%6c", "%%6d", "%%6e", "%%6f",
			    "%%70", "%%71", "%%72", "%%73", "%%74", "%%75", "%%76", "%%77",
			    "%%78", "%%79", "%%7a", "%%7b", "%%7c", "%%7d", "%%7e", "%%7f",
			    "%%80", "%%81", "%%82", "%%83", "%%84", "%%85", "%%86", "%%87",
			    "%%88", "%%89", "%%8a", "%%8b", "%%8c", "%%8d", "%%8e", "%%8f",
			    "%%90", "%%91", "%%92", "%%93", "%%94", "%%95", "%%96", "%%97",
			    "%%98", "%%99", "%%9a", "%%9b", "%%9c", "%%9d", "%%9e", "%%9f",
			    "%%a0", "%%a1", "%%a2", "%%a3", "%%a4", "%%a5", "%%a6", "%%a7",
			    "%%a8", "%%a9", "%%aa", "%%ab", "%%ac", "%%ad", "%%ae", "%%af",
			    "%%b0", "%%b1", "%%b2", "%%b3", "%%b4", "%%b5", "%%b6", "%%b7",
			    "%%b8", "%%b9", "%%ba", "%%bb", "%%bc", "%%bd", "%%be", "%%bf",
			    "%%c0", "%%c1", "%%c2", "%%c3", "%%c4", "%%c5", "%%c6", "%%c7",
			    "%%c8", "%%c9", "%%ca", "%%cb", "%%cc", "%%cd", "%%ce", "%%cf",
			    "%%d0", "%%d1", "%%d2", "%%d3", "%%d4", "%%d5", "%%d6", "%%d7",
			    "%%d8", "%%d9", "%%da", "%%db", "%%dc", "%%dd", "%%de", "%%df",
			    "%%e0", "%%e1", "%%e2", "%%e3", "%%e4", "%%e5", "%%e6", "%%e7",
			    "%%e8", "%%e9", "%%ea", "%%eb", "%%ec", "%%ed", "%%ee", "%%ef",
			    "%%f0", "%%f1", "%%f2", "%%f3", "%%f4", "%%f5", "%%f6", "%%f7",
			    "%%f8", "%%f9", "%%fa", "%%fb", "%%fc", "%%fd", "%%fe", "%%ff"
  			>>
  		end

	encode (a_string: STRING): STRING is
			-- Encode `a_string' so that it does not contain `name_sep'.
		require
			a_string_not_void: a_string /= Void
		local
			l_code : NATURAL_32
			i : INTEGER
		do
			create Result.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				l_code := a_string.code (i)

				if ('A').natural_32_code <= l_code and l_code <= ('Z').natural_32_code then -- A...Z
					Result.append_code (l_code)
				elseif ('a').natural_32_code <= l_code and l_code <= ('z').natural_32_code then -- a...z
					Result.append_code (l_code)
				elseif ('0').natural_32_code <= l_code and l_code <= ('9').natural_32_code then -- 0...9
					Result.append_code (l_code)
				elseif ('-').natural_32_code = l_code or else ('_').natural_32_code = l_code then -- '-', '_'
					Result.append_code (l_code)
				elseif l_code <= 0x007f then
					Result.append (hex_strings.item (l_code.as_integer_32 + 1))
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			Result_not_contain_name_sep: not Result.has (name_sep)
		end

	decode (a_string: STRING): STRING is
			-- Decode `a_string' to be original one.
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
			l_code, c, hc, lc: NATURAL_32
		do
			create Result.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				l_code := a_string.code (i)
				if l_code = escape_char_code and then a_string.count - i >= 2 then
						i := i + 1
						hc := a_string.code (i)
						i := i + 1
						lc := a_string.code (i)
						c := natural_of_code (hc, lc)
						Result.append_code (c)
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

	natural_of_code (hc, lc: NATURAL_32): NATURAL_32 is
			-- Natural that comprises of charactors whose code are `hc' and `lc'
		do
			if ('a').natural_32_code <= hc and then hc <= ('f').natural_32_code then
				Result := (hc - ('a').natural_32_code) & 0xf + 10
			elseif ('0').natural_32_code <= hc and then hc <= ('9').natural_32_code then
				Result := (hc - ('0').natural_32_code)
			end
			if ('a').natural_32_code <= lc and then lc <= ('f').natural_32_code then
				Result := (Result |<< 4) | ((lc - ('a').natural_32_code) & 0xf + 10)
			elseif ('0').natural_32_code <= lc and then lc <= ('9').natural_32_code then
				Result := (Result |<< 4) | ((lc - ('0').natural_32_code))
			end
		end

feature {NONE} -- Implementation

	strings: LIST [STRING]
			-- Strings splitted

	uuid_gen: UUID_GENERATOR is
			-- UUID generator
		once
			create Result
		end

	reset_names is
			-- Reset last names.
		do
			last_target_uuid := Void
			last_group_name := Void
			last_folder_path := Void
			last_class_name := Void
			last_feature_name := Void
		end

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

end
