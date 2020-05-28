note
	description: "Identifier solution for group, folder, class and feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_ID_SOLUTION

inherit
	SHARED_WORKBENCH

	SHARED_ENCODING_CONVERTER

feature -- Access names

	last_target_uuid: READABLE_STRING_32
	last_target_name: READABLE_STRING_32
	last_group_name: READABLE_STRING_32
	last_folder_path: STRING_32
	last_class_name: STRING_32
	last_feature_name: STRING_32
			-- Last names extracted from ids when retrieving XXX_of_id
			-- It is possible not valid in the system if XXX_of_id returns void.

	last_folder_name: STRING_32
			-- The outer most folder name in `last_folder_path' if possible
			-- Void if no folder name can be retrieved from `last_folder_path'.
		local
			l_last_folder_path: STRING_32
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

	id_of_target (a_target: CONF_TARGET): STRING
			-- UUID of `a_target'
		require
			a_target_not_void: a_target /= Void
		do
			create Result.make (40)
			Result.append (encode (a_target.system.uuid.out))
			Result.append (name_sep)
			Result.append (encode (a_target.name))
		ensure
			result_not_void: Result /= Void
		end

	target_of_id (a_id: STRING): CONF_TARGET
			-- Target of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			uuid: STRING_32
			l_target_name: STRING
			l_uuid: UUID
			l_strings: like split_by_string
		do
			last_target_uuid := Void
			last_target_name := Void
			l_strings := split_by_string (a_id, name_sep)
			if l_strings.count >= target_id_sections then
				uuid := decode (l_strings [target_id_sections - 1])
				last_target_uuid := uuid
				l_target_name := decode_string_8 (l_strings [target_id_sections])
				last_target_name := l_target_name
				if universe.target.system.uuid.out.same_string_general (uuid) then
						-- Get the target from current system by name.
					Result := universe.target.system.targets.item (l_target_name)
				else
					create l_uuid
					if l_uuid.is_valid_uuid (uuid) then
						Result := universe.target.system.all_libraries.item (create {UUID}.make_from_string (uuid))
					end
				end
			end
			if attached Result then
				last_target_name := Result.name
			end
		end

feature -- Access (Group)

	id_of_group (a_group: CONF_GROUP): STRING
			-- Identifier of `a_group'
			-- target_uuid + name_sep + group_name
			-- Assembly: assembly + name_sep + ph + name_sep + assemblyID
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (50)
			if attached {CONF_PHYSICAL_ASSEMBLY} a_group as l_phys_as then
				Result.append (encode (assembly_prefix))
				Result.append (name_sep)
					-- We need a place holder to keep the same section number with other types of group.
				Result.append (encode (place_holder_string))
				Result.append (name_sep)
				Result.append (l_phys_as.guid.to_string_8)
			else
				Result.append (id_of_target (a_group.target))
				Result.append (name_sep)
				Result.append (encode (a_group.name))
			end
		ensure
			result_not_void: Result /= Void
		end

	group_of_id (a_id: STRING): CONF_GROUP
			-- Group of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			group_name: STRING
			l_target: CONF_TARGET
			l_ass_id: STRING_32
			l_strings: like split_by_string
		do
			last_group_name := Void
			l_strings := split_by_string (a_id, name_sep)
			if
				l_strings.count >= group_id_sections and then
				decode (l_strings [1]).is_equal (assembly_prefix)
			then
				l_ass_id := decode (l_strings [group_id_sections])
				Result := universe.target.system.all_assemblies.item (l_ass_id)
				if Result /= Void then
					last_group_name := Result.name
				end
			end
			if Result = Void then
				l_target := target_of_id (a_id)
				if l_strings.count >= group_id_sections then
					group_name := decode_string_8 (l_strings [group_id_sections])
					last_group_name := group_name
					if l_target /= Void then
						Result := l_target.groups.item (group_name)
					end
				end
			end
		end

feature -- Access (Folder)

	id_of_folder (a_folder: EB_FOLDER): STRING
			-- Id of `a_folder'
			-- `id_of_group' + `name_sep' + path
		require
			a_folder_not_void: a_folder /= Void
		do
			Result := id_of_group (a_folder.cluster)
			Result.append (name_sep)
			Result.append (encode (a_folder.path))
		ensure
			result_not_void: Result /= Void
		end

	folder_of_id (a_id: STRING): EB_FOLDER
			-- Folder of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_path: STRING_32
			l_dir: DIRECTORY
			l_strings: like split_by_string
		do
			last_folder_path := Void
			l_strings := split_by_string (a_id, name_sep)
			if l_strings.count >= folder_id_sections then
				l_path := decode (l_strings [folder_id_sections])
				last_folder_path := l_path
				if attached {CONF_CLUSTER} group_of_id (a_id) as l_cluster then
					create l_dir.make_with_path (l_cluster.location.build_path (l_path, {STRING_32} ""))
					if l_dir.exists then
						create Result.make (l_cluster, l_path)
					end
				end
			end
		end

feature -- Access (Class)

	id_of_class (a_class: CONF_CLASS): STRING
			-- Unique id of a class in the system
			-- `id_of_group' + `name_sep' + class_name
		require
			a_class_not_void: a_class /= Void
		do
			Result := id_of_group (a_class.group)
			Result.append (name_sep)
			Result.append (encode (a_class.name))
		ensure
			result_not_void: Result /= Void
		end

	class_of_id (a_id: STRING): CONF_CLASS
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			class_name: STRING
			l_strings: like split_by_string
		do
			last_class_name := Void
			l_strings := split_by_string (a_id, name_sep)
			if l_strings.count >= class_id_sections then
				class_name := decode_string_8 (l_strings [class_id_sections])
				last_class_name := class_name
				if attached group_of_id (a_id) as l_group and then l_group.classes /= Void then
					Result := l_group.classes.item (class_name)
				end
			end
		end

feature -- Access (Feature)

	feature_of_id (a_id: STRING): E_FEATURE
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_feature_name: STRING_32
			l_strings: like split_by_string
		do
			last_feature_name := Void
			l_strings := split_by_string (a_id, name_sep)
			if l_strings.count >= feature_id_sections then
				l_feature_name := decode (l_strings [feature_id_sections])
				last_feature_name := l_feature_name
				if
					attached {CLASS_I} class_of_id (a_id) as l_class and then
					attached l_class.compiled_representation as l_class_c and then
					l_class_c.has_feature_table
				then
					Result := l_class_c.feature_with_name_32 (l_feature_name)
				end
			end
		end

	id_of_feature (a_feature: E_FEATURE): STRING
			-- Unique id of a feature in the system
			-- `id_of_class'(associate class) + name_sep + feature_name
		require
			a_feature_not_void: a_feature /= Void
		local
			c: CLASS_C
		do
			c := a_feature.associated_class
			Result := id_of_group (c.group)
			Result.append (name_sep)
			Result.append (encode (c.name))
			Result.append (name_sep)
			Result.append (encode (a_feature.name_32))
		ensure
			result_not_void: Result /= Void
		end

	id_of_feature_ast (a_class: CONF_CLASS; a_ast: FEATURE_AS): STRING
			-- Unique id of a feature in the system
			-- `id_of_class'(associate class) + name_sep + feature_name
		require
			a_class_not_void: a_class /= Void
			a_ast_not_void: a_ast /= Void
		do
			Result := id_of_class (a_class)
			Result.append (name_sep)
			Result.append (encode (a_ast.feature_name.name_32))
		end

feature  -- Element Change

	set_for_url (a_b: BOOLEAN)
			-- Encode the separator to url style,
			-- in order to get url compatible ids.
		do
			if a_b then
				if not is_for_url then
					internal_name_sep := encode (name_sep)
				end
			else
				if is_for_url then
					internal_name_sep := decode_string_8 (name_sep)
				end
			end
			is_for_url := a_b
		ensure
			is_for_url_set: is_for_url = a_b
			name_sep_set: (a_b and (not old is_for_url)) implies (old name_sep) ~ decode_string_8 (name_sep)
			name_sep_set: ((not a_b) and old is_for_url) implies (old name_sep) ~ encode (name_sep)
		end

feature -- ID modification

	substitute_target_uuid (a_id: STRING; a_target_uuid: READABLE_STRING_GENERAL): STRING
			-- Substitute uuid of `a_id' to `a_target_uuid'.
		require
			a_id_not_void: a_id /= Void
			a_target_uuid_not_void: a_target_uuid /= Void
		local
			l_strings: like last_split_strings
		do
			if last_id = Void or else not last_id.same_string (a_id) then
				last_id := a_id
				last_split_strings := split_by_string (a_id, name_sep)
			end
			check
				last_split_strings_not_void: last_split_strings /= Void
			end
			l_strings := last_split_strings
			if
				not decode (l_strings.i_th (1)).same_string (assembly_prefix) and then
				l_strings.count >= target_id_sections
			then
				create Result.make (40)
				Result.append (encode (a_target_uuid))
				from
					l_strings.go_i_th (target_id_sections)
				until
					l_strings.after
				loop
					Result.append (name_sep)
					Result.append (l_strings.item)
					l_strings.forth
				end
			end
		end

	substitute_target_name (a_id: STRING; a_target_name: READABLE_STRING_GENERAL): STRING
			-- Substitute target name of `a_id' to `a_target_name'.
		require
			a_id_not_void: a_id /= Void
			a_target_name_not_void: a_target_name /= Void
		local
			l_strings: like last_split_strings
		do
			if last_id = Void or else not last_id.same_string (a_id) then
				last_id := a_id
				last_split_strings := split_by_string (a_id, name_sep)
			end
			check
				last_split_strings_not_void: last_split_strings /= Void
			end
			l_strings := last_split_strings
			if
				not decode (l_strings.i_th (1)).same_string (assembly_prefix) and then
				last_split_strings.count >= target_id_sections
			then
				create Result.make (40)
				Result.append (l_strings.first)
				from
					l_strings.go_i_th (target_id_sections)
				until
					l_strings.after
				loop
					Result.append (name_sep)
					if l_strings.index = target_id_sections then
						Result.append (encode (a_target_name))
					else
						Result.append (l_strings.item)
					end
					l_strings.forth
				end
			end
		end

	substitute_group (a_id: STRING; a_group_name: READABLE_STRING_GENERAL): STRING
			-- Substitute group name of `a_id' to `a_group_name'.
		require
			a_id_not_void: a_id /= Void
			a_group_name_not_void: a_group_name /= Void
		local
			l_strings: like last_split_strings
		do
			if last_id = Void or else not last_id.same_string (a_id) then
				last_id := a_id
				last_split_strings := split_by_string (a_id, name_sep)
			end
			check
				last_split_strings_not_void: last_split_strings /= Void
			end
			l_strings := last_split_strings
			if
				not decode (l_strings.i_th (1)).same_string (assembly_prefix) and then
				last_split_strings.count >= group_id_sections
			then
				create Result.make (40)
				Result.append (l_strings.first)
				from
					l_strings.go_i_th (target_id_sections)
				until
					l_strings.after
				loop
					Result.append (name_sep)
					if l_strings.index = group_id_sections then
						Result.append (encode (a_group_name))
					else
						Result.append (l_strings.item)
					end
					l_strings.forth
				end
			end
		end

	url_id (a_id: STRING): STRING
			-- URL form of `a_id'.
		require
			a_id_not_void: a_id /= Void
		do
			Result := encode (a_id)
		ensure
			url_id_not_void: Result /= Void
		end

feature -- UUID generation

	generate_uuid: STRING
			-- Generate uuid
		do
			Result := uuid_gen.generate_uuid.out
		ensure
			result_not_void: Result /= Void
		end

feature -- Querry

	id_valid (a_id: STRING): BOOLEAN
			-- Does `a_id' represent an existing item in the system?
		require
			a_id_attached: a_id /= Void
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

	possible_name_of_id (a_id: STRING): STRING_32
			-- Extracted name from `a_id'
			-- Despite of id type, the last section is extracted as name.
			-- Target id is not appliable.
		require
			a_id_not_void: a_id /= Void
			not_target_id: most_possible_type_of_id (a_id) /= target_type
		local
			l_strings: like split_by_string
		do
			l_strings := split_by_string (a_id, name_sep)
			if attached decode (l_strings.last) as lt_name then
				Result := lt_name
			else
				create Result.make_empty
			end
		ensure
			Result_set: Result /= Void
		end

	most_possible_type_of_id (a_id: STRING): NATURAL
			-- Most possible type of the given `a_id'
			-- target, group, folder, class or feature.
			-- This querry can not distinguish folder and class.
			-- In this case, `class_type' is returned by default.
		require
			a_id_not_void: a_id /= Void
		local
			l_count: INTEGER
		do
			l_count := split_by_string (a_id, name_sep).count
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
			end
		end

	id_type_valid (a_id_type: NATURAL): BOOLEAN
			-- Is `a_id_type' valid?
		do
			if a_id_type <= max_type and a_id_type > min_type then
				Result := True
			end
		end

	is_for_url: BOOLEAN
			-- IDs are generated for url?

feature -- ID type

	target_type: NATURAL = 1
	group_type: NATURAL = 2
	folder_type: NATURAL = 3
	class_type: NATURAL = 4
	feature_type: NATURAL = 5
	min_type: NATURAL once Result := target_type end
	max_type: NATURAL once Result := feature_type end

feature {NONE} -- Access

	target_id_sections: INTEGER = 2

	group_id_sections: INTEGER
		once
			Result := target_id_sections + 1
		end

	folder_id_sections: INTEGER
		once
			Result := group_id_sections + 1
		end

	class_id_sections: INTEGER
		once
			Result := group_id_sections + 1
		end

	feature_id_sections: INTEGER
		once
			Result := class_id_sections + 1
		end

feature {NONE} -- Implementation

	last_id: STRING
			-- Last id modified

	last_split_strings: ARRAYED_LIST [STRING]
			-- Last split strings from `last_id'

	split_by_string (a_source_string: STRING; a_separator: STRING): ARRAYED_LIST [STRING]
			-- Split a string by a string separator.
		require
			a_source_string_attached: a_source_string /= Void
			a_separator_atatched: a_separator /= Void
		local
			l_list: like split_by_string
			i, j, c, sc: INTEGER_32
		do
			c := a_source_string.count
			sc := a_separator.count
			create l_list.make (c + 1)
			if c > 0 and c >= sc then
				from
					i := 1
				until
					i > c
				loop
					j := a_source_string.substring_index (a_separator, i)
					if j = 0 then
						j := c + 1
					end
					l_list.extend (a_source_string.substring (i, j - 1))
					i := j + sc
				end
				if j + sc - 1 = c then
					check
						last_character_is_a_separator: a_source_string.substring (j, c).same_string_general (a_separator)
					end
					l_list.extend (create {STRING}.make_empty)
				end
			else
				l_list.extend (create {STRING}.make_empty)
			end
			Result := l_list
		ensure
			split_by_string_not_void: Result /= Void
		end

feature {NONE} -- Implementation. Encoding/Decoding

	name_sep: STRING
			-- Name separator
		do
			Result := internal_name_sep
			if Result = Void then
				Result := "@"
			end
		end

	internal_name_sep: STRING

	escape_char: CHARACTER_32 = '%%'

	place_holder_string: STRING_32 = "ph"

	assembly_prefix: STRING_32 = "assembly"

	escape_char_code: NATURAL_32
		once
			Result := escape_char.natural_32_code
		end

	hex_strings: ARRAY [STRING]
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

	encode (a_string: READABLE_STRING_GENERAL): STRING
			-- Encode `a_string' so that it does not contain characters rather than
			-- [%_-a-zA-Z0-9]
			-- First convert to UTF-8, then encode it using [%_-a-zA-Z0-9].
		require
			a_string_not_void: a_string /= Void
		local
			l_code : NATURAL_32
			i : INTEGER
			l_utf8_string: STRING
			u: UTF_CONVERTER
		do
			l_utf8_string := u.utf_32_string_to_utf_8_string_8 (a_string)
			create Result.make (l_utf8_string.count)
			from
				i := 1
			until
				i > l_utf8_string.count
			loop
				l_code := l_utf8_string.code (i)

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
		end

	decode_string_8 (a_string: STRING): STRING
			-- Decode `a_string' to the original one.
			-- Hex presentations are converted back to what it was.
		local
			i: INTEGER
			l_code, hc, lc: NATURAL_32
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
						Result.append_code (natural_of_code (hc, lc))
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		end

	decode (a_string: STRING): STRING_32
			-- Decode `a_string' to the Unicode original one.
			-- Hex presentations are converted back to what it was.
		require
			a_string_not_void: a_string /= Void
		local
			u: UTF_CONVERTER
		do
				-- Decode the UTF-8 sequence first and then convert it back to STRING_32.
			Result := u.utf_8_string_8_to_string_32 (decode_string_8 (a_string))
		ensure
			result_not_void: Result /= Void
		end

	natural_of_code (hc, lc: NATURAL_32): NATURAL_32
			-- Natural that comprises of charactors whose code are `hc' and `lc'
		do
			if ('a').natural_32_code <= hc and then hc <= ('f').natural_32_code then
				Result := (hc - ('a').natural_32_code) & 0xf + 10
			elseif ('0').natural_32_code <= hc and then hc <= ('9').natural_32_code then
				Result := hc - ('0').natural_32_code
			end
			if ('a').natural_32_code <= lc and then lc <= ('f').natural_32_code then
				Result := (Result |<< 4) | ((lc - ('a').natural_32_code) & 0xf + 10)
			elseif ('0').natural_32_code <= lc and then lc <= ('9').natural_32_code then
				Result := (Result |<< 4) | (lc - ('0').natural_32_code)
			end
		end

feature {NONE} -- Implementation

	uuid_gen: UUID_GENERATOR
			-- UUID generator
		once
			create Result
		end

	reset_names
			-- Reset last names.
		do
			last_target_uuid := Void
			last_group_name := Void
			last_folder_path := Void
			last_class_name := Void
			last_feature_name := Void
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
