note
	description: "[
				Routines usefull during node exportation (see {CMS_HOOK_IMPORT}).
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_IMPORT_NODE_UTILITIES

inherit
	CMS_IMPORT_JSON_UTILITIES

	CMS_API_ACCESS

feature -- Access

	user_by_name (a_name: READABLE_STRING_GENERAL; a_node_api: CMS_NODE_API): detachable CMS_USER
			-- CMS user named `a_name`.
		do
			Result := a_node_api.cms_api.user_api.user_by_name (a_name)
		end

feature -- Comments helpers

	import_comments_file_for_entity (fn: PATH; a_entity: CMS_CONTENT; api: CMS_API; a_import_ctx: CMS_IMPORT_CONTEXT)
		local
			l_comment: CMS_COMMENT
			l_log: STRING_8
		do
			if attached {CMS_COMMENTS_API} api.module_api ({CMS_COMMENTS_MODULE}) as l_comments_api then
				if attached json_value_from_location (fn) as j_comments then
					if attached json_to_comments (j_comments, a_entity, l_comments_api) as l_comments then
						across
							l_comments as ic
						loop
							l_comment := ic.item
							l_comments_api.save_recursively_comment (l_comment)
							l_log := "comment #" + l_comment.id.out + " (count="+ l_comment.count.out +") imported from %"" + api.html_encoded (fn.name) + "%""
							l_log.append (" into " + a_entity.content_type)
							if attached a_entity.identifier as l_id then
								l_log.append (" #" + l_id.out)
							end
							l_log.append (" .")
							a_import_ctx.log (l_log)
						end
					end
				end
			end
		end


feature -- Conversion

	json_to_node (a_node_type: CMS_NODE_TYPE [CMS_NODE]; j: JSON_OBJECT; a_node_api: CMS_NODE_API): detachable CMS_NODE
		local
			l_node: CMS_PARTIAL_NODE
		do
			if
				attached json_string_item (j, "title") as l_title
			then
				create l_node.make_empty (a_node_type.name)
				l_node.set_title (l_title)
				Result := l_node
				if attached json_date_item (j, "creation_date") as dt then
					l_node.set_creation_date (dt)
				end
				if attached json_date_item (j, "modification_date") as dt then
					l_node.set_modification_date (dt)
				end
				if attached json_date_item (j, "publication_date") as dt then
					l_node.set_publication_date (dt)
				end
				if attached json_integer_item (j, "status") as l_status then
					inspect l_status
					when {CMS_NODE_API}.published then
						l_node.mark_published
					when {CMS_NODE_API}.not_published then
						l_node.mark_not_published
					when {CMS_NODE_API}.trashed then
						l_node.mark_trashed
					else
					end
				end
				if attached {JSON_OBJECT} j.item ("author") as j_author then
					l_node.set_author (json_to_user (j_author, a_node_api))
				end
				if attached {JSON_OBJECT} j.item ("editor") as j_editor then
					l_node.set_editor (json_to_user (j_editor, a_node_api))
				end

				if attached {JSON_OBJECT} j.item ("data") as j_data then
					l_node.set_all_content (json_string_item (j_data, "content"), json_string_item (j_data, "summary"), json_string_8_item (j_data, "format"))
				end
				if
					attached {JSON_OBJECT} j.item ("link") as j_link and then
					attached json_to_local_link (j_link) as lnk
				then
					l_node.set_link (lnk)
				end
			end
		end

	apply_taxonomy_to_node (j: JSON_OBJECT; a_node: CMS_NODE; a_cms_api: CMS_API)
		require
			a_node.has_id
		local
			l_term: CMS_TERM
		do
			if attached {JSON_ARRAY} j.item ("tags") as j_tags and then j_tags.count > 0 then
				if
					attached {CMS_TAXONOMY_API} a_cms_api.module_api ({CMS_TAXONOMY_MODULE}) as l_taxonomy_api and then
					attached l_taxonomy_api.vocabularies_for_type (a_node.content_type) as l_voc_coll and then
					attached l_voc_coll.item_by_name ("Tags") as l_voc
				then
					across
						j_tags as ic
					loop
						if
							attached {JSON_OBJECT} ic.item as j_tag and then
							attached json_string_item (j_tag, "text") as l_tag_text
						then
							if attached l_taxonomy_api.term_by_text (l_tag_text, Void) as t then
								l_term := t
							else
								create l_term.make (l_tag_text)
								l_taxonomy_api.save_term (l_term, l_voc)
							end
							if l_term.has_id then
								l_taxonomy_api.associate_term_with_content (l_term, a_node)
							end
						end
					end
				end
			end
		end

	json_to_user (j_user: JSON_OBJECT; a_node_api: CMS_NODE_API): detachable CMS_USER
		do
			if
				attached json_string_item (j_user, "name") as l_author_name
			then
				Result := user_by_name (l_author_name, a_node_api)
			end
		end

	json_to_local_link (j_link: JSON_OBJECT): detachable CMS_LOCAL_LINK
		do
			if
				attached json_string_8_item (j_link, "location") as loc
			then
				create Result.make (json_string_item (j_link, "title"), loc)
				Result.set_weight (json_integer_item (j_link, "weight").to_integer_32)
			end
		end

	json_to_comments (j: JSON_VALUE; a_entity: CMS_CONTENT; a_comments_api: CMS_COMMENTS_API): detachable LIST [CMS_COMMENT]
		do
			if attached {JSON_ARRAY} j as j_array then
				create {ARRAYED_LIST [CMS_COMMENT]} Result.make (j_array.count)
				across
					j_array as ic
				loop
					if
						attached {JSON_OBJECT} ic.item as jo and then
						attached json_to_comment (jo, a_entity, a_comments_api) as c
					then
						Result.extend (c)
					end
				end
			end
		end

	json_to_comment (j: JSON_OBJECT; a_entity: CMS_CONTENT; a_comments_api: CMS_COMMENTS_API): detachable CMS_COMMENT
		local
			l_title, l_content: detachable READABLE_STRING_32
		do
			create Result.make
			Result.set_entity (a_entity)
			if attached {JSON_STRING} j.item ("title") as j_title then
				l_title := j_title.unescaped_string_32
				if l_title.is_whitespace then
					l_title := Void
				end
			end

			if attached {JSON_STRING} j.item ("content") as j_content then
				l_content := j_content.unescaped_string_32
				if l_content.is_whitespace then
					l_content := Void
				end
			elseif attached {JSON_STRING} j.item ("body") as j_body then
				l_content := j_body.unescaped_string_32
				if l_content.is_whitespace then
					l_content := Void
				end
			end

			if l_content = Void then
				if l_title /= Void then
					Result.set_content (l_title)
				end
			elseif l_title = Void then
				Result.set_content (l_content)
				Result.set_format ("wikitext")
			else
				if l_content.starts_with (l_title) then
					Result.set_content (l_content)
				else
					Result.set_content (l_title + {STRING_32} "%N%N" + l_content)
				end
				Result.set_format ("wikitext")
			end

			if attached {JSON_STRING} j.item ("format") as j_format then
				Result.set_format (j_format.unescaped_string_8)
			end
			if attached {JSON_OBJECT} j.item ("author") as j_author then
				if attached {JSON_STRING} j_author.item ("name") as j_author_name then
					if attached a_comments_api.cms_api.user_api.user_by_name (j_author_name.unescaped_string_32) as u then
						Result.set_author (u)
						Result.set_author_name (u.name)
					else
							-- User unknown!
						Result.set_author_name (j_author_name.unescaped_string_32)
					end
				end
			end
			if attached json_date_item (j, "date") as dt then
				Result.set_modification_date (dt)
				Result.set_creation_date (dt)
			end
			if
				attached j.item ("comments") as j_comments and then
				attached json_to_comments (j_comments, a_entity, a_comments_api) as lst
			then
				across
					lst as ic
				loop
					Result.extend (ic.item)
				end
			end
		end

end
