note
	description: "Convert Collection+JSON object to JSON content"
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_TO_JSON

inherit
	CJ_TOKENS
		export
			{NONE} all
		end

feature -- Access

	collection_to_json (cj: CJ_COLLECTION): JSON_OBJECT
		local
			l_collection: JSON_OBJECT
			ja: JSON_ARRAY
		do
			create l_collection.make_with_capacity (7)
			l_collection.put_string (cj.version, version_key)
			l_collection.put_string (cj.href, href_key)
			if attached cj.links as l_links then
				l_collection.put (link_list_to_json (l_links), links_key)
			end
			if attached cj.items as l_items then
				create ja.make (l_items.count)
				across
					l_items as ic
				loop
					ja.add (item_to_json (ic.item))
				end
				l_collection.put (ja, items_key)
			end
			if attached cj.queries as l_queries then
				create ja.make (l_queries.count)
				across
					l_queries as ic
				loop
					ja.add (query_to_json (ic.item))
				end
				l_collection.put (ja, queries_key)
			end
			if attached cj.template as l_template then
				l_collection.put (template_to_json (l_template), template_key)
			end
			if attached cj.error as l_error then
				l_collection.put (error_to_json (l_error), error_key)
			end

			create Result.make_with_capacity (1)
			Result.put (l_collection, collection_key)
		end

	link_to_json (a_link: CJ_LINK): JSON_OBJECT
		do
			create Result.make_with_capacity (5)
			Result.put_string (a_link.href, href_key)
			Result.put_string (a_link.rel, rel_key)
			if attached a_link.prompt as l_prompt then
				Result.put_string (l_prompt, prompt_key)
			end
			if attached a_link.name as l_name then
				Result.put_string (l_name, name_key)
			end
			if attached a_link.render as l_render then
				Result.put_string (l_render, render_key)
			end
		end

	item_to_json (a_link: CJ_ITEM): JSON_OBJECT
		do
			create Result.make_with_capacity (3)
			Result.put_string (a_link.href, href_key)
			if attached a_link.data as l_data then
				Result.put (data_list_to_json (l_data), data_key)
			end
			if attached a_link.links as l_links then
				Result.put (link_list_to_json (l_links), links_key)
			end
		end

	data_to_json (a_data: CJ_DATA): JSON_OBJECT
		do
			create Result.make_with_capacity (3)
			Result.put_string (a_data.name, name_key)
			if attached a_data.prompt as l_prompt then
				Result.put_string (l_prompt, prompt_key)
			end
			if attached a_data.value as l_value then
				Result.put_string (l_value, value_key)
			end
		end

	query_to_json (a_query: CJ_QUERY): JSON_OBJECT
		do
			create Result.make_with_capacity (5)
			Result.put_string (a_query.href, href_key)
			Result.put_string (a_query.rel, rel_key)
			if attached a_query.prompt as l_prompt then
				Result.put_string (l_prompt, prompt_key)
			end
			if attached a_query.name as l_name then
				Result.put_string (l_name, name_key)
			end
			if attached a_query.data as l_data then

				Result.put (data_list_to_json (l_data), data_key)
			end
		end

	template_to_json (a_template: CJ_TEMPLATE): JSON_OBJECT
		do
			create Result.make_with_capacity (1)
			Result.put (data_list_to_json (a_template.data), data_key)
		end

	error_to_json (a_error: CJ_ERROR): JSON_OBJECT
		do
			create Result.make_with_capacity (3)
			Result.put_string (a_error.title, title_key)
			Result.put_string (a_error.code, code_key)
			Result.put_string (a_error.message, message_key)
		end

feature {NONE} -- Implementation	

	data_list_to_json (lst: LIST [CJ_DATA]): JSON_ARRAY
		do
			create Result.make (lst.count)
			across
				lst as ic
			loop
				Result.add (data_to_json (ic.item))
			end
		end

	link_list_to_json (lst: LIST [CJ_LINK]): JSON_ARRAY
		do
			create Result.make (lst.count)
			across
				lst as ic
			loop
				Result.add (link_to_json (ic.item))
			end
		end

	json_string (s: READABLE_STRING_GENERAL): JSON_STRING
		do
			create Result.make_from_string_general (s)
		end

note
	copyright: "2011-2020, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
