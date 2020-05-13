note
	description: "[
			Package information file is represented by {IRON_PACKAGE_INFO_FILE}.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_INFO_FILE

inherit
	IRON_PACKAGE_FILE

	IRON_PACKAGE_INFO_FILE_PARSER_CALLBACKS
		redefine
			on_package, on_setup, on_project, on_note
		end

create {IRON_PACKAGE_FILE_FACTORY}
	make_from_path,
	make_from_text

feature {NONE} -- Initialization

	make_from_path (a_path: PATH)
		do
			path := a_path
			create notes.make (0)
			import_file (a_path)
		end

	import_file (fn: PATH)
		local
			l_parser: IRON_PACKAGE_INFO_FILE_PARSER
		do
			create l_parser.make
			l_parser.set_callbacks (Current)
			l_parser.parse (fn)
			has_error := l_parser.error_occurred
		end

	make_from_text (fn: PATH; a_text: READABLE_STRING_8)
			-- Create info file `fn' with `a_text' as content.
		do
			path := fn
			create notes.make (0)
			import_text (a_text)
		end

	import_text (a_text: READABLE_STRING_8)
		local
			l_parser: IRON_PACKAGE_INFO_FILE_PARSER
		do
			create l_parser.make
			l_parser.set_callbacks (Current)
			l_parser.parse_text (a_text)
			has_error := l_parser.error_occurred
		end

feature -- Callbacks

	on_package (a_name: READABLE_STRING_32)
		do
			create package_name.make_from_string (a_name)
		end

	on_setup (a_setup_name: READABLE_STRING_32; a_op: READABLE_STRING_32)
		do
			add_setup (a_setup_name, a_op)
		end

	on_project (a_project_name: READABLE_STRING_32; a_path: READABLE_STRING_32)
		do
			add_project (a_project_name, a_path)
		end

	on_note (a_note_name: READABLE_STRING_32; a_value: READABLE_STRING_32)
		do
			notes.force (a_value, a_note_name)
		end

feature -- Access

	item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Data associated with `a_name'
		do
			Result := notes.item (a_name)
		end

	put (a_value: detachable READABLE_STRING_32; a_name: READABLE_STRING_GENERAL)
			-- Put `a_value' data associated with `a_name'.
		do
			if a_value = Void then
				remove (a_name)
			else
				notes.force (a_value, a_name)
			end
		end

	remove (a_name: READABLE_STRING_GENERAL)
			-- Remove data associated with `a_name'
		do
			notes.remove (a_name)
		end

feature -- Change

	reset
			-- <Precursor>
		do
			package_name := Void
			notes.wipe_out
		end

feature -- Access

	package_name: detachable IMMUTABLE_STRING_32

	notes: STRING_TABLE [READABLE_STRING_32]

feature -- Conversion	

	to_package (a_repo: IRON_REPOSITORY): IRON_PACKAGE
		local
			s: STRING_8
			l_loc: READABLE_STRING_8
			l_path_uri: PATH_URI
			l_name: detachable READABLE_STRING_32
			t: STRING_32
		do
			l_name := package_name

			if attached item ("id") as l_id and then l_id.is_valid_as_string_8 then
				create Result.make (l_id.to_string_8, a_repo)
			elseif l_name /= Void and then l_name.is_valid_as_string_8 then
				create Result.make (l_name.to_string_8 + "@" + a_repo.location_string, a_repo)
			else
				create Result.make_empty (a_repo)
			end
			Result.set_name (l_name)
			Result.set_title (item ("title"))
			Result.set_description (item ("description"))
			if attached item ("tags") as l_tags then
				Result.tags.wipe_out
				across
					l_tags.split (',') as ic
				loop
					t := ic.item
					t.adjust
					Result.tags.force (t)
				end
			end

			if Result.is_local_working_copy then
				create l_path_uri.make_from_path (path)
				s := l_path_uri.string
				l_loc := a_repo.location_string
				if s.starts_with (l_loc) then
						-- remove repository dir
					s := s.substring (l_loc.count + 1, s.count) -- keep first \
						-- remove repository .iron file
					if attached path.entry as e then
						s.remove_tail (e.name.count + 1)
					end
					Result.associated_paths.force (s)
				end
			end

			across
				notes as ic
			loop
				if
					ic.key.same_string ("title")
					or ic.key.same_string ("description")
					or ic.key.same_string ("tags")
				then
						-- Already stored in attributes
				else
					Result.put (ic.item, ic.key)
				end
			end
		end

	load_package (p: IRON_PACKAGE)
		local
			s: STRING_32
		do
			if attached p.name as l_name then
				create package_name.make_from_string (l_name)
			else
				package_name := Void
			end
			if attached p.title as l_title then
				notes.force (l_title, "title")
			end
			if attached p.description as l_description then
				notes.force (l_description, "description")
			end
			if attached notes.item ("tags") as l_tags then
				s := l_tags
			else
				create s.make_empty
			end
			across
				p.tags as ic
			loop
				if not s.is_empty then
					s.append_character (',')
				end
				s.append (ic.item)
			end
			if s.is_empty then
				notes.remove ("tags")
			else
				notes.force (s, "tags")
			end
			if attached p.items as l_items then
				across
					l_items as ic
				loop
					if
						attached ic.item as l_item and then
						not notes.has (ic.key)
					then
						notes.force (l_item, ic.key)
					end
				end
			end
		end

feature -- Storage

	has_expected_file_name: BOOLEAN
			-- Has expected file name for Current package file?
		local
			p: PATH
			curr_name: READABLE_STRING_32
		do
			if attached path.entry as e then
				curr_name := e.name
				Result := curr_name.same_string_general (expected_file_name.name)
				if not Result then
					if attached package_name as l_name then
						create p.make_from_string (l_name)
						p := p.appended_with_extension ("iron")
						Result := curr_name.same_string_general (p.name)
					end
				end
			end
		end

	expected_file_name: PATH
			-- Expected file name for Current package file?
		do
			create Result.make_from_string ("package")
			Result := Result.appended_with_extension ("iron")
		end

	save
			-- Save Current file representation into file `path'.
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_path (path)
			f.create_read_write
			f.put_string (text)
			f.close
		end

	text: STRING
		local
			utf: UTF_CONVERTER
			s: STRING_32
			utf8: STRING
		do
			create Result.make (0)
			if attached package_name as l_name then
				Result.append_string ("package ")
				Result.append_string (utf.string_32_to_utf_8_string_8 (l_name))
				Result.append_string ("%N")
			else
				check has_name: False end
			end
			if attached setup_operations as ops then
				Result.append_string ("%Nsetup%N")
				across
					ops as ic
				loop
					Result.append_string ("%T")
					Result.append_string (utf.string_32_to_utf_8_string_8 (ic.item.name.to_string_32))
					Result.append_string (" = ")

					s := ic.item.instruction
					utf8 := utf.string_32_to_utf_8_string_8 (s)

					if s.has ('%N') then
						Result.append ("%"[%N")
						Result.append_string (utf8)
						if not utf8.ends_with_general ("%N") then
							Result.append_character ('%N')
						end
						Result.append_string ("%T%T%T%T")
						Result.append_string ("]%"%N")
					else
						Result.append_string (utf8)
					end
					Result.append_string ("%N")
				end
			end
			if attached projects as projs then
				Result.append_string ("%Nproject%N")
				across
					projs as ic
				loop
					Result.append_string ("%T")
					Result.append_string (utf.string_32_to_utf_8_string_8 (ic.item.name.to_string_32))
					Result.append_string (" = %"")
					Result.append_string (utf.string_32_to_utf_8_string_8 (ic.item.relative_iri))
					Result.append_string ("%"%N")
				end
			end
			Result.append_string ("%Nnote%N")
			across
				notes as ic
			loop
				Result.append_string ("%T")
				Result.append_string (utf.string_32_to_utf_8_string_8 (ic.key.to_string_32))
				Result.append_string (": ")
				s := ic.item.to_string_32
				utf8 := utf.string_32_to_utf_8_string_8 (s)
				if s.has ('%N') then
					Result.append ("%"[%N")
					Result.append_string (utf8)
					if not utf8.ends_with_general ("%N") then
						Result.append_character ('%N')
					end
					Result.append_string ("%T%T%T%T")
					Result.append_string ("]%"%N")
				else
					Result.append_string (utf8)
				end
				Result.append_string ("%N")
			end
			if is_assistant_enabled and not notes.has ("title") then
				Result.append_string ("--%Ttitle: %N")
			end
			if is_assistant_enabled and not notes.has ("description") then
				Result.append_string ("--%Tdescription: %N")
			end
			if is_assistant_enabled and not notes.has ("tags") then
				Result.append_string ("--%Ttags: %N")
			end
			if is_assistant_enabled and not notes.has ("license") then
				Result.append_string ("--%Tlicense: %N")
			end
			if is_assistant_enabled and not notes.has ("copyright") then
				Result.append_string ("--%Tcopyright: %N")
			end
			if is_assistant_enabled and not notes.has ("link[doc]") then
				Result.append_string ("--%Tlink[doc]: %"Documentation%" http:// %N")
			end

			Result.append_string ("%Nend%N")
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
