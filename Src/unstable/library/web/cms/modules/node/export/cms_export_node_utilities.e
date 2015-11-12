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

feature -- Access

	node_to_json (n: CMS_NODE): JSON_OBJECT
		local
			jo,j_author: JSON_OBJECT
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
				create j_author.make
				j_author.put_integer (u.id, "uid")
				j_author.put_string (u.name, "name")
				Result.put (j_author, "author")
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
				create jo.make_empty
				jo.put_string (lnk.title, "title")
				jo.put_string (lnk.location, "location")
				jo.put_integer (lnk.weight, "weight")
				Result.put (jo, "link")
			end
		end

end
