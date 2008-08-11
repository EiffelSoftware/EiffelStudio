indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKITEXT_XMLDOC_VISITOR

inherit
	XMLDOC_VISITOR

create
	make

feature {NONE} -- Initialization

	make (s: STRING) is
			-- Initialize `Current'.
		require
			s_attached: s /= Void
		do
			output := s
			reset
		end

	reset
		do
			inside_code_block := False
			create list_bullet.make_empty
		end

	output: STRING
			-- Associated output

	inside_code_block: BOOLEAN
			-- Is inside code block?

	list_bullet: STRING
			-- Bullet prefix for list item

feature -- Access

	all_pages: HASH_TABLE [XMLDOC_PAGE, STRING]

	url_resolver: URL_RESOLVER

	url_to_wiki_url (a_url: STRING): STRING
		local
			p: XMLDOC_PAGE
			t: STRING
			l: STRING
		do
			l := a_url.twin
			if l.substring_index ("://", 1) > 0 then
				Result := l
			else
				if
					l.count > 4 and then
					l.substring (l.count - 3, l.count).is_case_insensitive_equal (".xml")
				then
					l.remove_tail (4)
				end
				p := all_pages.item (l)
				if p /= Void then
					t := p.title
				end

				if t /= Void then
					Result := t
				else
					Result := l
				end
			end
		end

	url_to_wiki_image_url (a_url: STRING): STRING
		do
			Result := a_url
		end

	url_to_eiffel_url (a_url: STRING): STRING
		do
			Result := a_url
		end

feature -- Element change

	set_all_pages (v: like all_pages)
		do
			all_pages := v
		end

	set_url_resolver (v: like url_resolver)
		do
			url_resolver := v
		end

feature -- Visiting

	process_item (i: XMLDOC_ITEM)
		do
			check False end
		end

	process_unused (i: XMLDOC_UNUSED)
		do
			check should_not_occur: False end
		end

	process_metadata (i: XMLDOC_METADATA)
		do

		end

	process_unavailable (i: XMLDOC_UNAVAILABLE)
		do
			output.append ("<!Unavailable:")
			output.append (i.tagname)
			output.append ("!>")
		end

	process_image (i: XMLDOC_IMAGE)
		do
			output.append ("[[Image:")
			output.append (url_to_wiki_image_url (i.url))
			if i.legend /= Void then
				output.append ("|")
				output.append (i.legend)
			end
			output.append ("]] ")
		end

	process_anchor (i: XMLDOC_ANCHOR)
		do
			if i.name /= Void then
				output.append ("<span id=%"" + i.name + "%" />")
			end
		end

	process_external_link (i: XMLDOC_LINK)
		do
			check i.is_external end
			output.append ("[")
			if i.url /= Void then
				output.append (i.url)
			elseif i.anchor_name /= Void then
				output.append ("#" + i.anchor_name)
			end

			if i.label /= Void then
				output.append (" ")
				output.append (i.label)
			end
			output.append ("] ")
		end

	process_link (i: XMLDOC_LINK)
		do
			if i.is_external then
				process_external_link (i)
			else
				output.append ("[[")
				if i.url /= Void then
					output.append (url_to_wiki_url (i.url))
				elseif i.anchor_name /= Void then
					output.append ("#" + i.anchor_name)
				end

				if i.label /= Void then
					output.append ("|")
					output.append (i.label)
				end
				output.append ("]] ")
			end
		end

	process_image_link (i: XMLDOC_IMAGE_LINK)
		do
			process_image (i.image)
			output.append ("[[")
			output.append (url_to_wiki_image_url (i.url))
			output.append ("|(link)")
			output.append ("]] ")
		end

	process_page (i: XMLDOC_PAGE)
		local
			comps: LIST [XMLDOC_COMPOSITE_TEXT]
			retried: BOOLEAN
		do
			if not retried then
				if i.title /= Void then
					output.append ("#title=")
					output.append (i.title)
					output.append ("%N")
				end
				comps := i.composite_texts
				from
					comps.start
				until
					comps.after
				loop
					comps.item.process_visitor (Current)
					comps.forth
				end
				output.append ("%N")
			else
				output.append ("%N%N ERROR ... VISITOR RAIZED AN EXCEPTION !!!")
			end
		rescue
			retried := True
			retry
		end

	process_text (i: XMLDOC_TEXT)
		do
			output.append (i.text)
		end

	process_list (i: XMLDOC_LIST)
		local
			elts: LIST [XMLDOC_LIST_ITEM]
		do
			if False then
				process_list_tag (i)
			else
				if i.ordered then
					list_bullet.append_character ('#')
				else
					list_bullet.append_character ('*')
				end
				elts := i.items
				from
					elts.start
				until
					elts.after
				loop
					output.append_character ('%N')
					output.append_string (list_bullet)
					output.append_character (' ')
					elts.item.process_visitor (Current)
					if not elts.islast then
						output.append_character ('%N')
					end
					elts.forth
				end
				output.append_character ('%N')
				list_bullet.remove_tail (1)
			end
		ensure then
			same_list_bullet: list_bullet.count = old (list_bullet.count)
		end

	process_list_tag (i: XMLDOC_LIST)
		local
			bul: STRING
			elts: LIST [XMLDOC_LIST_ITEM]
		do
			if i.ordered then
				bul := once "ol"
			else
				bul := once "ul"
			end
			elts := i.items
			output.append ("<" + bul + ">%N")
			list_bullet.append ("  ")
			from
				elts.start
			until
				elts.after
			loop
				output.append_string (list_bullet)
				output.append_string ("<li>")
				output.append_character (' ')
				elts.item.process_visitor (Current)
				output.append_string ("</li>%N")
				elts.forth
			end
			list_bullet.remove_tail (2)
			output.append ("</" + bul + ">%N")
		end

	process_list_item (i: XMLDOC_LIST_ITEM)
		local
			n: STRING
		do
			if False then
				process_composite_text (i)
			else
				if {o: like output} output then
					create n.make_empty
					output := n
					process_composite_text (i)
					n.prune_all ('%N')
					output := o
					output.append (n)
				end
			end
		end

	process_with_content (i: XMLDOC_WITH_CONTENT)
		do
			i.items.do_all (agent {XMLDOC_ITEM}.process_visitor (Current))
		end

	process_composite_text_with_template (i: XMLDOC_COMPOSITE_TEXT; tpl: STRING)
		do
			output.append ("%N{{" + tpl + "|")
			process_with_content (i)
			output.append ("}}%N")
		end

	process_composite_text_with_tag (i: XMLDOC_COMPOSITE_TEXT; tag: STRING)
		do
			output.append ("%N<" + tag + ">")
			process_with_content (i)
			output.append ("</" + tag + ">%N")
		end

	process_composite_text (i: XMLDOC_COMPOSITE_TEXT)
		do
			process_with_content (i)
		end

	process_code (i: XMLDOC_CODE)
		local
			b: like inside_code_block
		do
			b := inside_code_block
			inside_code_block := True

			process_composite_text_with_tag (i, "eiffel")

			inside_code_block := b
		end

	process_note (i: XMLDOC_NOTE)
		do
			process_composite_text_with_template (i, "note")
		end

	process_paragraph (i: XMLDOC_PARAGRAPH)
		do
			output.append_character ('%N')
			process_composite_text (i)
			output.append_character ('%N')
		end

	process_sample (i: XMLDOC_SAMPLE)
		do
			process_composite_text_with_template (i, "sample")
		end

	process_seealso (i: XMLDOC_SEEALSO)
		do
			process_composite_text_with_template (i, "seealso")
		end

	process_tip (i: XMLDOC_TIP)
		do
			process_composite_text_with_template (i, "tip")
		end

	process_warning (i: XMLDOC_WARNING)
		do
			process_composite_text_with_template (i, "warning")
		end

	process_info (i: XMLDOC_INFO)
		do
			process_composite_text_with_template (i, "info")
		end

	process_text_container (i: XMLDOC_TEXT_CONTAINER)
		require
			i_attached: i /= Void
		local
			lst: LIST [XMLDOC_ITEM]
			e: XMLDOC_ITEM
		do
			lst := i.items
			from
				lst.start
			until
				lst.after
			loop
				e := lst.item
				if {t: XMLDOC_TEXT} e then
					process_text (t)
				elseif {tc: XMLDOC_TEXT_CONTAINER} e then
					process_text_container (tc)
				elseif {l: XMLDOC_LINK} e then
					process_link (l)
				else
					check False end
				end
				lst.forth
			end
		end

	process_heading (i: XMLDOC_HEADING) is
		local
			s: STRING
			n: like output
		do
			inspect i.size
			when 1 then
				s := "="
			when 2 then
				s := "=="
			when 3 then
				s := "==="
			when 4 then
				s := "===="
			when 5 then
				s := "====="
			when 6 then
				s := "======"
			else
				s := ""
			end
			output.append ("%N")
			output.append (s)
			output.append_character (' ')

			if {o: like output} output then
				create n.make_empty
				output := n
				process_with_content (i)
				n.prune_all ('%N')
				output := o
				output.append (n)
			end

			output.append_character (' ')
			output.append (s)
			output.append ("%N")
		end

	process_cluster_name (i: XMLDOC_CLUSTER_NAME)
		do
			if inside_code_block then
				process_text_container (i)
			else
				output.append ("<cluster>")
				if i.url /= Void then
					output.append ("[")
					output.append (url_to_eiffel_url (i.url))
					output.append ("|")
					process_text_container (i)
					output.append ("]")
				else
					process_text_container (i)
				end

				output.append ("</cluster>")
			end
		end

	process_class_name (i: XMLDOC_CLASS_NAME)
		do
			if inside_code_block then
				process_text_container (i)
			else
				output.append ("<class>")
				if i.url /= Void then
					output.append ("[")
					output.append (url_to_eiffel_url (i.url))
					output.append ("|")
					process_text_container (i)
					output.append ("]")
				else
					process_text_container (i)
				end
				output.append ("</class>")
			end
		end

	process_feature_name (i: XMLDOC_FEATURE_NAME)
		do
			if inside_code_block then
				process_text_container (i)
			else
				output.append ("<feature>")
				if i.url /= Void then
					output.append ("[")
					output.append (url_to_eiffel_url (i.url))
					output.append ("|")
					process_text_container (i)
					output.append ("]")
				else
					process_text_container (i)
				end

				output.append ("</feature>")
			end
		end

	process_bold (i: XMLDOC_BOLD)
		do
			if not i.is_empty then
				output.append ("'''")
				process_text_container (i)
				output.append ("'''")
			end
		end

	process_italic (i: XMLDOC_ITALIC)
		do
			if not i.is_empty then
				output.append ("''")
				process_text_container (i)
				output.append ("''")
			end
		end

	process_underline (i: XMLDOC_UNDERLINE)
		do
			if not i.is_empty then
				output.append ("<u>")
				process_text_container (i)
				output.append ("</u>")
			end
		end

	process_span (i: XMLDOC_SPAN)
		do
			output.append ("<span>")
			process_composite_text (i)
			output.append ("</span>")
		end

	process_div (i: XMLDOC_DIV)
		do
			if i.style = Void then
				output.append ("<div>")
			else
				output.append ("<div style=%"" + i.style + "%" >")
			end
			process_composite_text (i)
			output.append ("</div>")
		end

	process_line_break (i: XMLDOC_LINE_BREAK)
		do
			output.append ("<br/>%N")
		end

	process_table (i: XMLDOC_TABLE)
		do
			output.append ("{| ")
			if i.has_border then
				output.append ("border=%"" + i.border.out + "%" ")
			end
			if i.style /= Void then
				output.append ("style=%"" + i.style.out + "%" ")
			end
			output.append ("%N")
			if i.legend /= Void then
				output.append ("|+ " + i.legend + "%N")
			end
			i.rows.do_all (agent process_table_row)
			output.append ("|}%N")
		end

	process_table_row (i: XMLDOC_TABLE_ROW)
		local
			s: STRING
		do
			output.append ("|- ")
			if i.style /= Void or i.height /= Void then
				s := " style=%""
				if i.style /= Void then
					s.append (i.style + ";")
				end
				if i.height /= Void then
					s.append ("height=" + i.height + ";")
				end
				s.append ("%"")
				output.append ("%N! " + s + " ")
			end
			output.append ("%N")
			i.cells.do_all (agent process_table_cell)
		end

	process_table_cell (i: XMLDOC_TABLE_CELL)
		local
			s: STRING
		do
			output.append ("| ")
			process_composite_text (i)
			if i.style /= Void or i.width /= Void or i.height /= Void then
				s := "|| style=%""
				if i.style /= Void then
					s.append (i.style + ";")
				end
				if i.width /= Void then
					s.append ("width=" + i.width + ";")
				end
				if i.height /= Void then
					s.append ("height=" + i.height + ";")
				end
				s.append ("%"")
				output.append (s)
			end
			output.append ("%N")
		end

	process_code_entity (i: XMLDOC_CODE_ENTITY)
		do
			if not i.is_empty then
				if inside_code_block then
					output.append (i.text)
				else
					output.append ("<code>")
					output.append (i.text)
					output.append ("</code>")
				end
			end
		end

invariant
	output_attached: output /= Void

end
