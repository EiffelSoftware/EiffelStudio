note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_XML_MANAGER

inherit
	SVN_CONSTANTS

feature -- Access

	string_to_repository_info (a_unused_arg_location: READABLE_STRING_GENERAL; a_xml: STRING): detachable SVN_REPOSITORY_INFO
		local
			retried: BOOLEAN
			l_revision: READABLE_STRING_32
			tree: XML_CALLBACKS_NULL_FILTER_DOCUMENT
			docs: XML_DOCUMENT
			att: detachable XML_ATTRIBUTE
			elt: XML_ELEMENT
			resolver: XML_NAMESPACE_RESOLVER
			parser: XML_CUSTOM_PARSER
		do
			if not retried then
				create parser.make
				parser.set_carriage_return_ignored (True)

				create tree.make_null
				tree.set_source_parser (parser)
				create resolver.set_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)

				parser.parse_from_string_8 (a_xml)

				if parser.error_occurred then
					Result := Void
				else
					docs := tree.document
					elt := docs.root_element
--					create Result.make (elt.count - 1)
					if attached {XML_ELEMENT} elt.element_by_name ("entry") as elt_i then
						att := elt_i.attribute_by_name ("path")
						if att /= Void then
							create Result.make (url_from_value (att.value))
							att := elt_i.attribute_by_name ("revision")
							if att /= Void then
								l_revision := att.value
								if l_revision.is_integer then
									Result.revision := l_revision.to_integer
								end
							end
--							att := elt_i.attribute_by_name ("kind")
							if attached {XML_ELEMENT} elt_i.element_by_name ("url") as l_url then
								Result.url := url_from_value (joined_content (l_url))
							end
							if attached {XML_ELEMENT} elt_i.element_by_name ("repository") as l_repository then
								if attached {XML_ELEMENT} l_repository.element_by_name ("root") as l_repository_root then
									Result.repository_root := joined_content (l_repository_root)
								end
								if attached {XML_ELEMENT} l_repository.element_by_name ("uuid") as l_repository_uuid then
									Result.repository_uuid := ascii_from_value (joined_content (l_repository_uuid))
								end
							end
							if attached {XML_ELEMENT} elt_i.element_by_name ("commit") as l_commit then
								att := l_commit.attribute_by_name ("revision")
								if att /= Void then
									l_revision := att.value
									if l_revision.is_integer then
										Result.last_changed_rev := l_revision.to_integer
									end
								end
								if attached {XML_ELEMENT} l_commit.element_by_name ("author") as l_commit_author then
									Result.last_changed_author := joined_content (l_commit_author)
								end
								if attached {XML_ELEMENT} l_commit.element_by_name ("date") as l_commit_date then
									Result.last_changed_date := ascii_from_value (joined_content (l_commit_date))
								end
							end
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	string_to_status_on_pathes (a_prefix_path: detachable READABLE_STRING_GENERAL; dir: PATH; a_xml: READABLE_STRING_8): detachable ARRAYED_LIST [SVN_STATUS_INFO]
		local
			retried: BOOLEAN
			l_path, l_status, l_revision: detachable READABLE_STRING_32
			info: SVN_STATUS_INFO
			tree: XML_CALLBACKS_DOCUMENT
			docs: XML_DOCUMENT
			att: detachable XML_ATTRIBUTE
			elt: detachable XML_ELEMENT
			resolver: XML_NAMESPACE_RESOLVER
			parser: XML_CUSTOM_PARSER
		do
			if not retried then
				create parser.make

				create tree.make_null
				tree.set_source_parser (parser)
				create resolver.set_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)

				parser.parse_from_string_8 (a_xml)

				if parser.error_occurred then
					Result := Void
				else
					docs := tree.document
					elt := docs.root_element
					elt := elt.element_by_name ("target")
					if elt /= Void then
						create Result.make (elt.count - 1)
						from
							elt.start
						until
							elt.after
						loop
							if attached {XML_ELEMENT} elt.item_for_iteration as elt_i and then elt_i.name.is_equal ("entry") then
								if attached elt_i.attribute_by_name ("path") as l_xml_att then
									l_path := l_xml_att.value
								else
									l_path := Void
								end
								if l_path /= Void and then not l_path.is_equal (once ".") then
									create info.make (dir, l_path, a_prefix_path)
									Result.force (info)

									if attached {XML_ELEMENT} elt_i.element_by_name ("wc-status") as wc_status then
										att := wc_status.attribute_by_name ("item")
										if att /= Void then
											l_status := att.value
										else
											l_status := Void
										end
										info.set_wc_status (l_status)

										att := wc_status.attribute_by_name ("revision")
										if att /= Void then
											l_revision := att.value
										else
											l_revision := Void
										end
										if l_revision /= Void and then l_revision.is_integer then
											info.set_wc_revision (l_revision.to_integer)
										end

									end
									if attached {XML_ELEMENT} elt_i.element_by_name ("repos-status") as repos_status then
										att := repos_status.attribute_by_name ("item")
										if att /= Void then
											l_status := att.value
										else
											l_status := Void
										end
										info.set_repos_status (l_status)

										att := repos_status.attribute_by_name ("revision")
										if att /= Void then
											l_revision := att.value
										else
											l_revision := Void
										end
										if l_revision /= Void and then l_revision.is_integer then
											info.set_repos_revision (l_revision.to_integer)
										end
									end
								end
							end
							elt.forth
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	string_to_logs (a_unused_arg_location: READABLE_STRING_GENERAL; a_xml: READABLE_STRING_8): detachable ARRAYED_LIST [SVN_REVISION_INFO]
		local
			retried: BOOLEAN
			l_revision: READABLE_STRING_32
			l_kind,l_action: detachable READABLE_STRING_32
			info: SVN_REVISION_INFO
			tree: XML_CALLBACKS_DOCUMENT
			docs: XML_DOCUMENT
			att: detachable XML_ATTRIBUTE
			elt: XML_ELEMENT
			resolver: XML_NAMESPACE_RESOLVER
			parser: XML_CUSTOM_PARSER
		do
			if not retried then
				create parser.make
				parser.set_carriage_return_ignored (True)

				create tree.make_null
				tree.set_source_parser (parser)
				create resolver.set_next (tree)
				resolver.set_forward_xmlns (True)
				parser.set_callbacks (resolver)

				parser.parse_from_string_8 (a_xml)

				if parser.error_occurred then
					Result := Void
				else
					docs := tree.document
					elt := docs.root_element
					if elt.count > 0 then
						create Result.make (elt.count - 1)
					else
						create Result.make (0)
					end
					from
						elt.start
					until
						elt.after
					loop
						if attached {XML_ELEMENT} elt.item_for_iteration as elt_i and then elt_i.name.is_equal ("logentry") then
							att := elt_i.attribute_by_name ("revision")

							if att /= Void then
								l_revision := att.value
								if l_revision.is_integer then
									create info.make (l_revision.to_integer)
									Result.force (info)
									if attached {XML_ELEMENT} elt_i.element_by_name ("author") as l_author then
										info.set_author (joined_content (l_author))
									end
									if attached {XML_ELEMENT} elt_i.element_by_name ("date") as l_date then
										info.set_date (joined_content (l_date))
									end
									if attached {XML_ELEMENT} elt_i.element_by_name ("msg") as l_msg then
										info.set_log_message (joined_content (l_msg))
									end
									if attached {XML_ELEMENT} elt_i.element_by_name ("paths") as l_paths then
										from
											l_paths.start
										until
											l_paths.after
										loop
											if attached {XML_ELEMENT} l_paths.item_for_iteration as l_path_elt then
												l_kind := Void
												l_action := Void
												if attached {XML_ATTRIBUTE} l_path_elt.attribute_by_name ("kind") as l_kind_att then
													l_kind := l_kind_att.value
												else
													l_kind := ""
												end
												if attached {XML_ATTRIBUTE} l_path_elt.attribute_by_name ("action") as l_action_att then
													l_action := l_action_att.value
												else
													l_action := ""
												end
												info.add_path (joined_content (l_path_elt), l_kind, l_action)
											end
											l_paths.forth
										end
--												l_date.join_text_nodes
									end
								end
							end
						end
						elt.forth
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	url_from_value (s: READABLE_STRING_32): STRING_8
		local
			l_iri: IRI
		do
			if s.is_valid_as_string_8 then
				Result := s.to_string_8
			else
				create l_iri.make_from_string (s)
				Result := l_iri.uri_string
			end
		end

	ascii_from_value (s: READABLE_STRING_32): STRING_8
		local
			utf: UTF_CONVERTER
		do
			if s.is_valid_as_string_8 then
				Result := s.to_string_8
			else
				Result := utf.utf_32_string_to_utf_8_string_8 (s)
			end
		end

	joined_content (elt: XML_ELEMENT): STRING_32
		do
			create Result.make_empty
			across
				elt.contents as ic
			loop
				Result.append_string (ic.item.content)
			end
		end

note
	copyright: "Copyright (c) 2003-2022, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
