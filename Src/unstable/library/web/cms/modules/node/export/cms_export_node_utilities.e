note
	description: "[
				Routines usefull during node exportation (see {CMS_HOOK_EXPORT}).
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EXPORT_NODE_UTILITIES

inherit
	CMS_EXPORT_JSON_UTILITIES

	CMS_API_ACCESS

feature -- Access

	node_to_json (n: CMS_NODE; a_node_api: CMS_NODE_API): JSON_OBJECT
		local
			jo: JSON_OBJECT
			ja: JSON_ARRAY
			jterm: JSON_OBJECT
		do
			create Result.make_empty
			Result.put_string (n.content_type, "type")
			Result.put_integer (n.id, "nid")
			Result.put_integer (n.revision, "revision")
			Result.put_string (n.title, "title")
			put_date_into_json (n.creation_date, "creation_date", Result)
			put_date_into_json (n.modification_date, "modification_date", Result)
			put_date_into_json (n.publication_date, "publication_date", Result)
			Result.put_integer (n.status, "status")
			if attached n.author as u then
				Result.put (user_to_json (u), "author")
			end
			if attached n.editor as u then
				Result.put (user_to_json (u), "editor")
			end
			create jo.make_empty
			if attached n.format as l_format then
				jo.put_string (l_format, "format")
			end
			if attached n.summary as s then
				jo.put_string (s, "summary")
			end
			if attached n.content as s then
				jo.put_string (s, "content")
			end
			Result.put (jo, "data")
			if attached n.link as lnk then
				Result.put (link_to_json (lnk), "link")
			end

			if attached {CMS_TAXONOMY_API} a_node_api.cms_api.module_api ({CMS_TAXONOMY_MODULE}) as l_taxonomy_api then
				if
					attached l_taxonomy_api.terms_of_content (n, Void) as l_tags and then
					not l_tags.is_empty
				then
					create ja.make (l_tags.count)
					across
						l_tags as ic
					loop
						create jterm.make_with_capacity (2)
						jterm.put_integer (ic.item.id, "id")
						jterm.put_string (ic.item.text, "text")
						ja.extend (jterm)
					end
					Result.put (ja, "tags")
				end
			end
		end

	user_to_json (u: CMS_USER): JSON_OBJECT
		do
			create Result.make
			Result.put_integer (u.id, "uid")
			Result.put_string (u.name, "name")
		end

	link_to_json (lnk: CMS_LOCAL_LINK): JSON_OBJECT
		do
			create Result.make_empty
			Result.put_string (lnk.title, "title")
			Result.put_string (lnk.location, "location")
			Result.put_integer (lnk.weight, "weight")
		end

end
