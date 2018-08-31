note
	description: "Summary description for {CODEBOARD_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODEBOARD_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

create {CODEBOARD_MODULE}
	make

feature {NONE} -- Initialization

	initialize
			-- Create user profile api object with api `a_api' and storage `a_storage'.
		do
			Precursor
		end

feature -- Access

	code_count: INTEGER
		local
			d: DIRECTORY
		do
			if
				attached cms_api.storage.custom_value ("snippet.count", {CODEBOARD_MODULE}.name) as l_count and then
				l_count.is_integer
			then
				Result := l_count.to_integer
			else
				create d.make_with_path (cms_api.module_resource_location_by_name ({CODEBOARD_MODULE}.name, (create {PATH}.make_from_string ("snippet"))))
				across
					d.entries as ic
				loop
					if attached ic.item.extension as ext then
						if
							ext.is_case_insensitive_equal_general ("e")
							or ext.is_case_insensitive_equal_general ("json")
						then
							Result := Result + 1
						end
					end
				end
			end
		end

	code (a_code_id: INTEGER): detachable CODEBOARD_SNIPPET
		local
			p: PATH
			fut: FILE_UTILITIES
			jp: JSON_PARSER
			l_json_text: detachable READABLE_STRING_GENERAL
		do
			l_json_text := cms_api.storage.custom_value ("snippet." + a_code_id.out, {CODEBOARD_MODULE}.name)
			if l_json_text = Void then
				p := cms_api.module_resource_location_by_name ({CODEBOARD_MODULE}.name, (create {PATH}.make_from_string ("snippet")).extended (a_code_id.out))
				if fut.file_path_exists (p.appended_with_extension ("json")) then
					l_json_text := file_unicode_content (p.appended_with_extension ("json"))
				end
			end
			if l_json_text /= Void then
				create jp.make_with_string (cms_api.utf_8_encoded (l_json_text))
				jp.parse_content
				if jp.is_parsed and jp.is_valid and attached jp.parsed_json_object as jo then
					if attached {JSON_STRING} jo.item ("code") as l_code then
						create Result.make (l_code.unescaped_string_32)
						if attached {JSON_STRING} jo.item ("caption") as l_caption then
							Result.set_caption (l_caption.unescaped_string_32)
						end
						if attached {JSON_STRING} jo.item ("lang") as l_lang then
							Result.set_lang (l_lang.unescaped_string_8)
						end
						if attached {JSON_BOOLEAN} jo.item ("is_locked") as l_is_locked then
							Result.set_is_locked (l_is_locked.item)
						end
						if attached {JSON_STRING} jo.item ("link") as js_link then
							Result.set_link (js_link.unescaped_string_8)
						elseif
							attached {JSON_OBJECT} jo.item ("link") as j_link and then
							attached {JSON_STRING} j_link.item ("href") as j_link_href
						then
							Result.set_link (j_link_href.unescaped_string_8)
						end
					end
				end
			else
				p := cms_api.module_resource_location_by_name ({CODEBOARD_MODULE}.name, (create {PATH}.make_from_string ("snippet")).extended (a_code_id.out))
				if
					fut.file_path_exists (p.appended_with_extension ("e")) and then
					attached file_unicode_content (p.appended_with_extension ("e")) as l_code
				then
					create Result.make (l_code)
					Result.lang := "eiffel"
				end
			end
		end

	is_code_locked (a_code_id: INTEGER): BOOLEAN
			-- Is code related to `a_code_id` locked?
		do
			if attached code (a_code_id) as l_code then
				Result := l_code.is_locked
			end
		end

	code_to_json (a_code: CODEBOARD_SNIPPET): STRING_8
		do
			Result := code_with_id_to_json (a_code, 0)
		end

	code_with_id_to_json (a_code: CODEBOARD_SNIPPET; a_code_id: INTEGER): STRING_8
		local
			j: JSON_OBJECT
		do
			create j.make_with_capacity (3)
				-- Code id  (ignore a_code.id) !
			if a_code_id > 0 then
				j.put_integer (a_code_id, "id")
			end
			if a_code.is_locked then
				j.put_boolean (True, "is_locked")
			end
			if attached a_code.lang as l_lang then
				j.put_string (l_lang, "lang")
			end
			if attached a_code.caption as l_caption then
				j.put_string (l_caption, "caption")
			end
			j.put_string (a_code.text, "code")
			if attached a_code.link as l_link then
				j.put_string (l_link, "link")
			end

			Result := j.representation
		end

feature -- Element change

	on_code_changed (a_code: detachable CODEBOARD_SNIPPET; a_mesg: READABLE_STRING_8)
		local
			l_mesg_text, l_subject: STRING
		do
			create l_subject.make_from_string (a_mesg)
			if a_code /= Void then
				if a_code.has_id then
					l_subject.append ("(code #" + a_code.id.out + ")")
				end
				l_mesg_text := code_with_id_to_json (a_code, a_code.id)
			else
				create l_mesg_text.make_from_string (a_mesg)
			end
			l_mesg_text.append_character ('%N')
			if attached cms_api.new_email (cms_api.setup.site_email, a_mesg, l_mesg_text) as e then
				cms_api.process_email (e)
			end
		end

	create_code (a_code: CODEBOARD_SNIPPET)
		local
			l_new_id: like code_count
		do
			if
				attached cms_api.storage.custom_value ("snippet.count", {CODEBOARD_MODULE}.name) as l_count and then
				l_count.is_integer
			then
				l_new_id := l_count.to_integer + 1
				cms_api.storage.set_custom_value ("snippet.count", l_new_id.out, {CODEBOARD_MODULE}.name)
			else
				import_code_snippet_from_module_resources
				l_new_id := code_count + 1
			end
			cms_api.storage.set_custom_value ("snippet." + l_new_id.out, code_to_json (a_code), {CODEBOARD_MODULE}.name)
			a_code.set_id (l_new_id)
			on_code_changed (a_code, "New code snippet")
		end

	update_code (a_code: CODEBOARD_SNIPPET)
		require
			a_code_id_valid: a_code.has_id
			existing_code: code (a_code.id) /= Void
		do
			cms_api.storage.set_custom_value ("snippet." + a_code.id.out, code_to_json (a_code), {CODEBOARD_MODULE}.name)
			on_code_changed (a_code, "Updated code snippet")
		end

	insert_code (a_code_id: INTEGER; a_code: CODEBOARD_SNIPPET)
		require
			a_code_id_valid: a_code_id > 0
		local
			i, nb: INTEGER
		do
				-- Insert code at `a_code_id` , i.e move code snippet i..n into i+1..n+1, and replace at `a_code_id`.
			from
				nb := code_count
				i := nb
				cms_api.storage.set_custom_value ("snippet.count", (nb + 1).out, {CODEBOARD_MODULE}.name)
			until
				i < a_code_id
			loop
				if attached cms_api.storage.custom_value ("snippet." + i.out, {CODEBOARD_MODULE}.name) as v then
					cms_api.storage.set_custom_value ("snippet." + (i+1).out, v, {CODEBOARD_MODULE}.name)
				end
				i := i - 1
			end
			cms_api.storage.set_custom_value ("snippet." + a_code_id.out, code_to_json (a_code), {CODEBOARD_MODULE}.name)
			on_code_changed (a_code, "New code snippet inserted before " + a_code_id.out)
		ensure
			not has_error implies (old code_count) + 1 = code_count
		end

	delete_code (a_code_id: INTEGER)
		require
			a_code_id_valid: a_code_id > 0
			not_locked: not is_code_locked (a_code_id)
		local
			i, nb: INTEGER
		do
				-- Delete code `a_code_id` , i.e move code snippet i+1 into i, and delete last one.
			nb := code_count
			from
				i := a_code_id
			until
				i >= nb
			loop
				if attached cms_api.storage.custom_value ("snippet." + (a_code_id + 1).out, {CODEBOARD_MODULE}.name) as v then
					cms_api.storage.set_custom_value ("snippet." + a_code_id.out, v, {CODEBOARD_MODULE}.name)
				end
				i := i + 1
			end
			cms_api.storage.unset_custom_value ("snippet." + nb.out, {CODEBOARD_MODULE}.name)
			nb := nb - 1
			cms_api.storage.set_custom_value ("snippet.count", nb.out, {CODEBOARD_MODULE}.name)
			on_code_changed (Void, "Code snippet #"+ a_code_id.out +" deleted")
		ensure
			not has_error implies (old code_count) - 1 = code_count
		end

	import_code_snippet_from_module_resources
		local
			i,n: INTEGER
			lst: ARRAYED_LIST [attached like code]
		do
			from
				i := 1
				n := code_count
				create lst.make (n)
			until
				i > n
			loop
				if attached code (i) as l_code then
					lst.force (l_code)
				end
				i := i + 1
			end
			i := 0
			cms_api.storage.set_custom_value ("snippet.count", lst.count.out, {CODEBOARD_MODULE}.name)
			across
				lst as ic
			loop
				i := i + 1
				cms_api.storage.set_custom_value ("snippet." + i.out, code_to_json (ic.item), {CODEBOARD_MODULE}.name)
			end
		end

	last_updated_code_id: INTEGER

feature {NONE} -- Implementation

	file_unicode_content (p: PATH): detachable STRING_32
		local
			utf: UTF_CONVERTER
		do
			if attached file_content (p) as s then
				Result := utf.utf_8_string_8_to_string_32 (s)
			end
		end

	file_content (p: PATH): detachable STRING_8
		local
			f: PLAIN_TEXT_FILE
			l_done: BOOLEAN
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
					f.start
				until
					l_done
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
					l_done := f.last_string.count < 1_024
								or f.exhausted
								or f.end_of_file
				end
				f.close

			end
		end

end
