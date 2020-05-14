note
	description: "Convert JSON string to Collection+JSON object."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TO_CJ

inherit
	CJ_TOKENS
		export
			{NONE} all
		end

feature -- Access

	collection (js: STRING): detachable CJ_COLLECTION
		do
			Result := to_collection (json_object (js))
		end

	to_collection (jv: detachable JSON_VALUE): detachable CJ_COLLECTION
		local
			j: detachable JSON_OBJECT
			i: INTEGER
			l_version: detachable STRING_8
			l_href: detachable STRING_8
		do
			if attached {JSON_OBJECT} jv as l_obj then
				if attached {JSON_OBJECT} l_obj.item (collection_key) as j_collection then
					j := j_collection
				else
					j := l_obj
				end

				if attached {JSON_STRING} j.item (version_key) as js then
					l_version := js.unescaped_string_8.to_string_8
				end
				if attached {JSON_STRING} j.item (href_key) as js then
					l_href := js.unescaped_string_8.to_string_8
				end
				if l_href /= Void then
					if l_version /= Void then
						create Result.make_with_href_and_version (l_href, l_version)
					else
						create Result.make_with_href (l_href)
					end
				else
					if l_version /= Void then
						create Result.make_with_version (l_version)
					else
						create Result.make_empty
					end
				end

				if attached {JSON_ARRAY} j.item (links_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached to_link (ja [i]) as l_link then
							Result.add_link (l_link)
						end
						i := i + 1
					end
				end
				if attached {JSON_ARRAY} j.item (items_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached to_item (ja [i]) as l_item then
							Result.add_item (l_item)
						end
						i := i + 1
					end
				end
				if attached {JSON_ARRAY} j.item (queries_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached to_query (ja [i]) as l_query then
							Result.add_query (l_query)
						end
						i := i + 1
					end
				end
				if attached to_template (j.item (template_key)) as l_template then
					Result.set_template (l_template)
				end
				if attached to_error (j.item (error_key)) as l_error then
					Result.set_error (l_error)
				end
			end
		end

	to_link (jv: detachable JSON_VALUE): detachable CJ_LINK
		do
			if attached {JSON_OBJECT} jv as j then
				create Result.make_empty
				if attached {JSON_STRING} j.item (href_key) as js then
					Result.set_href (js.unescaped_string_8)
				end
				if attached {JSON_STRING} j.item (rel_key) as js then
					Result.set_rel (js.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (name_key) as js then
					Result.set_name (js.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (prompt_key) as js then
					Result.set_prompt (js.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (render_key) as js then
					Result.set_render (js.unescaped_string_32)
				end
			end
		end

	to_item (jv: detachable JSON_VALUE): detachable CJ_ITEM
		local
			i: INTEGER
		do
			if
				attached {JSON_OBJECT} jv as j and then
				attached {JSON_STRING} j.item (href_key) as js
			then
				create Result.make (js.unescaped_string_8)
				if attached {JSON_ARRAY} j.item (data_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached to_data (ja [i]) as l_data then
							Result.add_data (l_data)
						end
						i := i + 1
					end
				end
				if attached {JSON_ARRAY} j.item (links_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached to_link (ja [i]) as l_link then
							Result.add_link (l_link)
						end
						i := i + 1
					end
				end
			end
		end

	to_data (jv: detachable JSON_VALUE): detachable CJ_DATA
		do
			if attached {JSON_OBJECT} jv as j then
				if attached {JSON_STRING} j.item (name_key) as js_name then
					create Result.make_with_name (js_name.unescaped_string_32)
				else
					create Result.make
				end
				if attached {JSON_STRING} j.item (prompt_key) as js_prompt then
					Result.set_prompt (js_prompt.unescaped_string_32)
				end
				if attached {JSON_STRING} j.item (value_key) as js then
					Result.set_value (js.unescaped_string_32)
				elseif attached {JSON_BOOLEAN} j.item (value_key) as jb  then
					Result.set_value (jb.item.out)
				end
			end
		end

	to_query (jv: detachable JSON_VALUE): detachable CJ_QUERY
		local
			i: INTEGER
			l_href: detachable READABLE_STRING_8
			l_rel: detachable READABLE_STRING_32
		do
			if attached {JSON_OBJECT} jv as j then
				if attached {JSON_STRING} j.item (href_key) as j_href then
					l_href := j_href.unescaped_string_8
				end
				if attached {JSON_STRING} j.item (rel_key) as j_rel then
					l_rel := j_rel.unescaped_string_32
				end
				if l_href /= Void and l_rel /= Void then
					create Result.make (l_href.to_string_8, l_rel)
					if attached {JSON_STRING} j.item (name_key) as j_name then
						Result.set_name (j_name.unescaped_string_32)
					end
					if attached {JSON_STRING} j.item (prompt_key) as j_prompt then
						Result.set_prompt (j_prompt.unescaped_string_32)
					end
					if attached {JSON_ARRAY} j.item (data_key) as ja then
						from
							i := 1
						until
							i > ja.count
						loop
							if attached to_data (ja [i]) as l_data then
								Result.add_data (l_data)
							end
							i := i + 1
						end
					end
				else
					-- error
				end
			end
		end

	to_template (jv: detachable JSON_VALUE): detachable CJ_TEMPLATE
		local
			i: INTEGER
		do
			if attached {JSON_OBJECT} jv as j then
				create Result.make
				if attached {JSON_ARRAY} j.item (data_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached to_data (ja [i]) as l_data then
							Result.add_data (l_data)
						end
						i := i + 1
					end
				end
			end
		end

	to_error (jv: detachable JSON_VALUE): detachable CJ_ERROR
		local
			l_title: detachable STRING_32
			l_code: detachable STRING_32
			l_message: detachable STRING_32
		do
			if attached {JSON_OBJECT} jv as j then
				if attached {JSON_STRING} j.item (title_key) as j_title then
					l_title := j_title.unescaped_string_32
				end
				if attached {JSON_STRING} j.item (code_key) as j_code then
					l_code := j_code.unescaped_string_32
				end
				if attached {JSON_STRING} j.item (message_key) as j_message then
					l_message := j_message.unescaped_string_32
				end
				--|TODO improve this code
				--|is there a better way to write this?
				--|is a good idea create the Result object at the first line and then set the value
				--|if it is attached?
				create Result.make_empty
				if l_title /= Void then
					Result.set_title (l_title)
				end
				if l_code /= Void then
					Result.set_code (l_code)
				end
				if l_message /= Void then
					Result.set_message (l_message)
				end
			end
		end

feature {NONE} -- Implementation		

	json_object (s: READABLE_STRING_8): detachable JSON_OBJECT
		do
			if attached {JSON_OBJECT} json_value (s) as obj then
				Result := obj
			end
		end

	json_value (s: READABLE_STRING_8): detachable JSON_VALUE
		local
			p: JSON_PARSER
		do
			create p.make_with_string (s)
			p.parse_content
			if p.is_valid then
				Result := p.parsed_json_value
			end
		end

note
	copyright: "2011-2020, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
