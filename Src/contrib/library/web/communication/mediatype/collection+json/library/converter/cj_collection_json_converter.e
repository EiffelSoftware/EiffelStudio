note
	description: "Summary description for {JSON_COLLECTION_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_COLLECTION_JSON_CONVERTER

inherit
	CJ_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make_empty
		end

feature -- Access

	object: CJ_COLLECTION

feature -- Conversion

	from_json (a_json_object: like to_json): detachable like object
		local
			i: INTEGER
			l_version: detachable READABLE_STRING_8
			l_href: detachable READABLE_STRING_8
		do
			if attached {JSON_OBJECT} a_json_object.item (collection_key) as j then
				if attached {STRING_32} json_to_object (j.item (version_key), Void) as l_ucs then
					l_version := l_ucs.to_string_8
				end
				if attached {STRING_32} json_to_object (j.item (href_key), Void) as l_ucs then
					l_href := l_ucs.to_string_8
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
						if attached {CJ_LINK} json_to_object (ja [i], {CJ_LINK}) as b then
							Result.add_link (b)
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
						if attached {CJ_ITEM} json_to_object (ja [i], {CJ_ITEM}) as b then
							Result.add_item (b)
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
						if attached {CJ_QUERY} json_to_object (ja [i], {CJ_QUERY}) as b then
							Result.add_query (b)
						end
						i := i + 1
					end
				end
				if attached {CJ_TEMPLATE} json_to_object (j.item (template_key), {CJ_TEMPLATE}) as b then
					Result.set_template (b)
				end
				if attached {CJ_ERROR} json_to_object (j.item (error_key), {CJ_ERROR}) as b then
					Result.set_error (b)
				end
			end
		end

	to_json (o: like object): JSON_OBJECT
		local
			l_collection: JSON_OBJECT
		do
			create l_collection.make
			l_collection.put (json.value (o.version), version_key)
			l_collection.put (json.value (o.href), href_key)
			if attached o.links as o_links then
				l_collection.put (json.value (o_links), links_key)
			end
			if attached o.items as o_items then
				l_collection.put (json.value (o_items), items_key)
			end
			if attached o.queries as o_queries then
				l_collection.put (json.value (o_queries), queries_key)
			end
			if attached o.template as o_template then
				l_collection.put (json.value (o_template), template_key)
			end
			if attached o.error as o_error then
				l_collection.put (json.value (o_error), error_key)
			end

			create Result.make
			Result.put (l_collection, collection_key)
		end

feature {NONE} -- Implementation

	collection_key: JSON_STRING
		once
			create Result.make_from_string ("collection")
		end

	version_key: JSON_STRING
		once
			create Result.make_from_string ("version")
		end

	href_key: JSON_STRING
		once
			create Result.make_from_string ("href")
		end

	links_key: JSON_STRING
		once
			create Result.make_from_string ("links")
		end

	items_key: JSON_STRING
		once
			create Result.make_from_string ("items")
		end

	queries_key: JSON_STRING
		once
			create Result.make_from_string ("queries")
		end

	template_key: JSON_STRING
		once
			create Result.make_from_string ("template")
		end

	error_key: JSON_STRING
		once
			create Result.make_from_string ("error")
		end

note
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
