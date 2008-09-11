indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XML2WIKITEXT

inherit
	XM_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			x: XM_EIFFEL_PARSER
		do
			create x.make
			x.set_callbacks (Current)
			parser := x
		end

	parser: XM_EIFFEL_PARSER

feature -- Access

	url_resolver: URL_RESOLVER assign set_url_resolver

	product_name: STRING assign set_product_name

	inside_help_element: BOOLEAN
			-- Is inside <help> element?
			--| this is needed to handle <keyword></keyword> differently according to the context

	inside_preformatted_element: BOOLEAN
			-- Is inside a preformatted element?
			--| such as code, code_block ..

	enter_preformatted_element
		require
			not_inside_preformatted_element: not inside_preformatted_element
		do
			inside_preformatted_element := True
		end

	exit_preformatted_element
		require
			inside_preformatted_element: inside_preformatted_element
		do
			inside_preformatted_element := False
		end

	output_switch: XMLDOC_OUTPUT

	is_valid_output_scope: BOOLEAN
		do
			Result := output_switch = Void or else output_switch.matched (product_name)
		end

feature -- Element change

	set_output_switch (o: like output_switch)
		require
			switched: o /= Void implies output_switch = void
		do
			output_switch := o
		end

	set_product_name (v: like product_name)
			-- Set `product_name'
		do
			if v = Void then
				product_name := Void
			else
				product_name := v.twin
				product_name.left_adjust
				product_name.right_adjust
				product_name.to_lower
				if product_name.is_empty then
					product_name := Void
				end
			end
		end

	set_url_resolver (v: like url_resolver)
			-- set `url_resolver' to `v'
		do
			url_resolver := v
		end

feature -- Basic operations

	process_filename (fn: STRING)
		local
			l_xml_content: STRING
			f: RAW_FILE
		do
			create f.make (fn)
			if f.exists and then f.is_readable then
				f.open_read
				from
					create l_xml_content.make (f.count)
					f.start
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (512)
					l_xml_content.append (f.last_string)
				end
				f.close
			end
			if l_xml_content /= Void then
				if url_resolver = Void then
					create url_resolver
				end
				url_resolver.current_filename := fn
				process_string (l_xml_content)
				url_resolver.current_filename := Void
			end
		end

	process_string (s: !STRING)
			-- Process xmldoc contained in string `s'
		local
			retried: BOOLEAN
			em: EXCEPTION_MANAGER
		do
			if not retried then
				reset
				parser.parse_from_string (s)
			else
				create em
				if {e: EXCEPTION} em.last_exception then
					exception := e
					raise_exception_error ("Convertion failed [" + e.meaning + "]", e)
				else
					raise_exception_error ("Convertion failed: exception ...", Void)
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Result

	reset is
			-- Reset results
		do
			if parser /= Void then
				parser.reset
			end
			if errors /= Void then
				errors.wipe_out
			end
			if opened_items /= Void then
				opened_items.wipe_out
			end
			inside_preformatted_element := False
			exception := Void
			page := Void
		end

	raise_error (m: STRING)
		local
			s: STRING
			err: ERROR
		do
			create err
			create s.make_from_string (m)
			if parser /= Void then
				err.position := parser.byte_position
			end

			err.message := s
			errors.extend (err)
			if parser /= Void then
				err.position := parser.byte_position
			end
		end

	raise_error_unavailable (m: STRING)
		local
			err: ERROR_UNAVAILABLE
		do
			create err
			err.associated_tag := m
			err.message := "unavailable: " + m
			if parser /= Void then
				err.position := parser.byte_position
			end
			errors.extend (err)
		end

	raise_exception_error (m: STRING; e: EXCEPTION)
		local
			err: ERROR_EXCEPTION
		do
			create err
			err.message := m
			if e /= Void then
				err.exception := e
			end
			if parser /= Void then
				err.position := parser.byte_position
			end
			errors.extend (err)
		end

	exception: EXCEPTION

	errors: LIST [ERROR]

	page: XMLDOC_PAGE

	opened_items: ARRAYED_STACK [XMLDOC_ITEM]

	last_content: XMLDOC_CONTENT
		do
			if not opened_items.is_empty then
				Result ?= opened_items.item
			end
		end

	last_but_one_item: XMLDOC_ITEM
		local
			i: like last_item
		do
			if not opened_items.is_empty then
				i := opened_items.item
				remove_last_item
				if not opened_items.is_empty then
					Result := opened_items.item
				end
				push_last_item (i)
			end
		end

	last_item: XMLDOC_ITEM
		do
			if not opened_items.is_empty then
				Result := opened_items.item
			end
		end

	remove_last_item
		do
			opened_items.remove
		end

	push_last_item (i: like last_item)
		do
			opened_items.extend (i)
		end

feature -- Document

	on_start is
			-- Called when parsing starts.
		do
			create {LINKED_LIST [ERROR]} errors.make
			create opened_items.make (10)
			page := Void
		end

	on_finish is
			-- Called when parsing finished.
		do
			if page = Void then
				page ?= last_item
			end
			check page_attached: page /= Void end
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN) is
			-- XML declaration.
		do
		end

feature -- Errors

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			raise_error (a_message)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING) is
			-- Processing instruction.
		do
		end

	on_comment (a_content: STRING) is
			-- Processing comment.
			-- Atomic: single comment produces single event
		do
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_paragraph: XMLDOC_PARAGRAPH
			l_img: XMLDOC_IMAGE
			l_parent_item: like last_item
			l_item: like last_item
			l_list_item: XMLDOC_LIST_ITEM
			l_table: XMLDOC_TABLE
			l_row: XMLDOC_TABLE_ROW
			l_cell: XMLDOC_TABLE_CELL
			l_content: like last_content
			l_meta_data: XMLDOC_METADATA
		do
			if is_valid_output_scope then
				l_content := last_content
				if l_content /= Void then
					remove_last_item
					if l_content.is_empty then
						l_content := Void
					end
				end
				check last_content = Void end
				l_parent_item := last_item
				if l_content /= Void then
					if {l_w_content: XMLDOC_WITH_CONTENT} l_parent_item then
						l_w_content.add_item (create {XMLDOC_TEXT}.make (l_content))
					else
	--					check only_paragraph: False end
						--| Let's ignore this content
					end
					l_content := Void
				end
				inspect tag_to_id (a_local_part)
				when id_document then
					create page.make
					push_last_item (page)
					l_item := page
				when id_meta_data then
					create {XMLDOC_METADATA} l_meta_data.make
					if {l_page: XMLDOC_PAGE} last_item then
						l_page.set_meta_data (l_meta_data)
					end
					push_last_item (l_meta_data)
					l_item := Void
				when id_meta then
					if {l_meta: XMLDOC_META} (create {XMLDOC_META}.make) then
						if {ot_meta_data: XMLDOC_METADATA} last_but_one_item then
							ot_meta_data.add_meta (l_meta)
						end
						push_last_item (l_meta)
					else
						check False end
					end
					l_item := Void
				when id_list then
					create {XMLDOC_LIST} l_item.make
					push_last_item (l_item)
				when id_item then
					if {lst: XMLDOC_LIST} last_item then
						create {XMLDOC_LIST_ITEM} l_list_item.make
						lst.add_item (l_list_item)
						push_last_item (l_list_item)
						l_item := Void
					else
						check False end
					end
				when id_content then
					create {XMLDOC_COMPOSITE_TEXT} l_item.make
					push_last_item (l_item)
					l_item := Void
	--				if {l_heading: XMLDOC_HEADING} last_item then
	--					--| content is the heading itself
	--					l_item := Void
	--				else
	--					check False end
	--				end
				when id_table then
					create {XMLDOC_TABLE} l_item.make
					push_last_item (l_item)
				when id_row then
					if {table: XMLDOC_TABLE} last_item then
						create {XMLDOC_TABLE_ROW} l_row.make
						table.add_row (l_row)
						push_last_item (l_row)
						l_item := Void
					else
						check False end
					end
				when id_cell then
					if {table_row: XMLDOC_TABLE_ROW} last_item then
						create {XMLDOC_TABLE_CELL} l_cell.make
						table_row.add_cell (l_cell)
						push_last_item (l_cell)
						l_item := Void
					else
						check False end
					end
				when id_info then
					create {XMLDOC_INFO} l_item.make
					push_last_item (l_item)
				when id_code_block then
					create {XMLDOC_CODE_BLOCK} l_item.make
					push_last_item (l_item)
					enter_preformatted_element
				when id_code then
					create {XMLDOC_CODE} l_item.make
					push_last_item (l_item)
--					enter_preformatted_element
				when id_note then
					create {XMLDOC_NOTE} l_item.make
					push_last_item (l_item)
				when id_output then
					set_output_switch (create {XMLDOC_OUTPUT}.make)
					l_item := Void
				when id_paragraph then
					create {XMLDOC_PARAGRAPH} l_item.make
					push_last_item (l_item)
				when id_sample then
					create {XMLDOC_SAMPLE} l_item.make
					push_last_item (l_item)
				when id_seealso then
					create {XMLDOC_SEEALSO} l_item.make
					push_last_item (l_item)
				when id_tip then
					create {XMLDOC_TIP} l_item.make
					push_last_item (l_item)
				when id_warning then
					create {XMLDOC_WARNING} l_item.make
					push_last_item (l_item)
				when id_line_break then
					create {XMLDOC_LINE_BREAK} l_item.make
					push_last_item (l_item)
				when id_image then
					create l_img.make
					if {img_link: XMLDOC_IMAGE_LINK} last_item then
						img_link.set_image (l_img)
						l_item := Void
					else
						l_item := l_img
					end
					push_last_item (l_img)
				when id_heading then
					create {XMLDOC_HEADING} l_item.make
					push_last_item (l_item)
				when id_label then
					create {XMLDOC_LABEL} l_item.make
					push_last_item (l_item)
				when id_anchor then
					create {XMLDOC_ANCHOR} l_item.make
					push_last_item (l_item)
				when id_cluster_name then
					create {XMLDOC_CLUSTER_NAME} l_item.make
					push_last_item (l_item)
				when id_class_name then
					create {XMLDOC_CLASS_NAME} l_item.make
					push_last_item (l_item)
				when id_feature_name then
					create {XMLDOC_FEATURE_NAME} l_item.make
					push_last_item (l_item)
				when id_bold then
					create {XMLDOC_BOLD} l_item.make
					push_last_item (l_item)
				when id_italic then
					create {XMLDOC_ITALIC} l_item.make
					push_last_item (l_item)
				when id_underline then
					create {XMLDOC_UNDERLINE} l_item.make
					push_last_item (l_item)
				when id_span then
					create {XMLDOC_SPAN} l_item.make
					push_last_item (l_item)
				when id_div then
					create {XMLDOC_DIV} l_item.make
					push_last_item (l_item)
				when id_link then
					create {XMLDOC_LINK} l_item.make
					push_last_item (l_item)
				when id_image_link then
					create {XMLDOC_IMAGE_LINK} l_item.make
					push_last_item (l_item)
				when id_url, id_alignment, id_style,
					id_width, id_height, id_border, id_size,
					id_legend, id_target, id_anchor_name, id_alt_text
				then
					--| handle by on_end_tag
					push_last_item (create {XMLDOC_UNUSED}.make (a_local_part))
					l_item := Void
				when id_string, id_number, id_character, id_reserved_word,
					id_local_variable, id_symbol, id_local_variable_quoted, id_generics,
					id_contract_tag, id_indexing_tag, id_keyword,
					id_syntax, id_compiler_error, id_sub_script,
					id_comment
				then
					if not inside_help_element then
						create {XMLDOC_CODE_ENTITY} l_item.make (a_local_part)
						push_last_item (l_item)
						if {l_code: XMLDOC_CODE} l_parent_item then
							l_code.add_item (l_item)
							l_item := Void
						elseif {l_code_b: XMLDOC_CODE_BLOCK} l_parent_item then
							l_code_b.add_item (l_item)
							l_item := Void
						elseif {l_code_entity: XMLDOC_CODE_ENTITY} l_parent_item then
							l_code_entity.add_item (l_item)
							l_item := Void
						elseif {l_code_fake: XMLDOC_COMPOSITE_TEXT} l_parent_item then
							l_code_fake.add_item (l_item)
							l_item := Void
						elseif {l_unav: XMLDOC_UNAVAILABLE} l_parent_item then
	--						l_item := Void
						else
							check error: False end
						end
					else
						push_last_item (create {XMLDOC_UNAVAILABLE}.make (a_local_part))
						raise_error ("Element <" + a_local_part + "> inside help element")
						l_item := last_item
					end
				else
					if tag_to_id (a_local_part) = id_help then
						inside_help_element := True
					end
					push_last_item (create {XMLDOC_UNAVAILABLE}.make (a_local_part))
					raise_error_unavailable (a_local_part)
					l_item := last_item
				end

				if l_item /= Void then
					check l_item /= Void implies l_item = last_item end

					if {l_ppage: XMLDOC_PAGE} l_parent_item then
						if {l_comp: XMLDOC_COMPOSITE_TEXT} l_item then
							l_ppage.add_composite_text (l_comp)
						elseif {l_unavailable: XMLDOC_UNAVAILABLE} l_item then
						else
							check mismatch: False end
						end
					elseif {l_with_content: XMLDOC_WITH_CONTENT} l_parent_item then
						if {l_text_cont: XMLDOC_TEXT_CONTAINER} l_with_content then
							if l_text_cont.valid_item (l_item) then
								l_text_cont.add_item (l_item)
							else
								check False end
							end
						else
							l_with_content.add_item (l_item)
						end
					end
				end
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		do
				--| should not be used ... in this xmldoc schema
			if a_local_part /= Void then
				if {l_output: XMLDOC_OUTPUT} output_switch then
					if a_local_part.is_case_insensitive_equal (att_output) then
						l_output.set_output (a_value)
					end
				elseif is_valid_output_scope and then last_item /= Void then
					if {l_title: XMLDOC_WITH_TITLE} last_item then
						if a_local_part.is_case_insensitive_equal (att_title) then
							l_title.set_title (a_value)
						end
					elseif {lst: XMLDOC_LIST} last_item then
						if a_local_part.is_case_insensitive_equal (att_ordered) then
							lst.set_ordered (a_value.is_case_insensitive_equal (value_true))
						end
					end
				end
			end
		end

	on_start_tag_finish is
			-- End of start tag.
		do
			--| should not be used ... in this xmldoc schema
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		local
			l_item: like last_item
			l_content: like last_content
			l_id: INTEGER
		do
			l_id := tag_to_id (a_local_part)
			if is_valid_output_scope then
				l_content := last_content
				if l_content /= Void then
					remove_last_item
				end
				l_item := last_item
				if last_item = Void then
					--| most probably, there is a remaining empty text content
					check has_text_content: l_content /= Void end
				else
					remove_last_item
					if l_content = Void and {unused: XMLDOC_UNUSED} l_item then
							--| hack: to handle  <label><bold>foobar</bold><label>
							--|       process as <label>foobar</label>
						l_content := unused.text_representation
					end
					inspect l_id
					when id_document then
						page ?= l_item
						check page /= Void end
					else
							--| Only if non empty content |--
						if l_content /= Void and then not l_content.is_empty then
							inspect l_id
							when id_item then
								if {lst_item: XMLDOC_LIST_ITEM} l_item then
									lst_item.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								else
									check mismatch_item: False end
								end
							when id_paragraph,
								id_code_block, id_code,
								id_info, id_note, id_sample, id_seealso, id_tip, id_warning,
								id_span, id_div,
								id_heading, id_cell
							then
								if {l_comp: XMLDOC_COMPOSITE_TEXT} l_item then
									l_comp.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								elseif {l_w_content: XMLDOC_WITH_CONTENT} l_item then
									l_w_content.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								else
									check mismatch_item: False end
								end
							when id_cluster_name, id_class_name, id_feature_name then
								if {l_txt_cont2: XMLDOC_TEXT_CONTAINER} l_item then
									l_txt_cont2.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								else
									check mismatch_item: False end
								end
							when id_label then -- Immediate
								if {l_label: XMLDOC_LABEL} l_item then
									l_label.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
									if {l_with_label: XMLDOC_WITH_LABEL} last_item then
										l_with_label.set_label (l_label)
									else
										check error: False end
									end
								else
									check mismatch_item: False end
								end
							when id_bold, id_italic, id_underline then
								if {l_txt_cont: XMLDOC_TEXT_CONTAINER} l_item then
									l_txt_cont.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								else
									check mismatch_item: False end
								end
							when id_string, id_number, id_character, id_reserved_word,
								id_local_variable, id_symbol, id_local_variable_quoted, id_generics,
								id_contract_tag, id_indexing_tag, id_keyword,
								id_syntax, id_compiler_error, id_sub_script,
								id_comment
							then
								if {l_entity_containers: XMLDOC_CODE_ENTITY} l_item then
									l_entity_containers.add_item (create {XMLDOC_TEXT}.make (l_content))
--									l_txt.set_text (l_content.text)
									l_content := Void
								elseif {l_unuv: XMLDOC_UNAVAILABLE} l_item then
									l_content := Void
								else
									check mismatch_item: False end
								end
							when id_anchor then
								if {l_anchor: XMLDOC_ANCHOR} l_item then
									l_anchor.set_name (l_content.text)
									l_content := Void
								else
									check mismatch: False end
								end
							when id_alignment then -- Immediate
								if {l_alignment: XMLDOC_WITH_ALIGNMENT} last_item then
									l_alignment.set_alignment (l_content.text)
									l_content := Void
								else
									check alignment_only_for_paragraph_or_cell: False end
								end
							when id_style then -- Immediate
								if {l_style: XMLDOC_WITH_STYLE} last_item then
									l_style.set_style (l_content.text)
									l_content := Void
								else
									check mismatch: False end
								end
							when id_width then -- Immediate
								if {l_width: XMLDOC_WITH_WIDTH} last_item then
									l_width.set_width (l_content.text)
									l_content := Void
								else
									check mismatch: False end
								end
							when id_height then -- Immediate
								if {l_height: XMLDOC_WITH_HEIGHT} last_item then
									l_height.set_height (l_content.text)
									l_content := Void
								else
									check mismatch: False end
								end
							when id_border then -- Immediate
								if {l_border: XMLDOC_WITH_BORDER} last_item then
									l_border.set_border (l_content.to_integer)
									l_content := Void
								else
									check mismatch: False end
								end
							when id_size then -- Immediate
								if {l_size: XMLDOC_WITH_SIZE} last_item then
									l_size.set_size (l_content.to_integer)
									l_content := Void
								else
									check mismatch: False end
								end
							when id_url then -- Immediate
								if {l_url: XMLDOC_WITH_URL} last_item then
									set_resolved_url (l_url, l_content.text)
									l_content := Void
								else
									check url_only_for_image_or_link: False end
								end
--							when id_label then -- Immediate
--								if {l_label: XMLDOC_WITH_LABEL} last_item then
--									l_label.set_label (l_content.text)
--									l_content := Void
--								else
--									check error: False end
--								end
							when id_alt_text then -- Immediate
								if {l_alt_text: XMLDOC_WITH_ALT_TEXT} last_item then
									l_alt_text.set_alt_text (l_content.text)
									l_content := Void
								else
									check error: False end
								end
							when id_legend then -- Immediate
								if {l_legend: XMLDOC_WITH_LEGEND} last_item then
									l_legend.set_legend (l_content.text)
									l_content := Void
								else
									check error: False end
								end
							when id_target then -- Immediate
								if {l_target: XMLDOC_WITH_TARGET} last_item then
									l_target.set_target (l_content.text)
									l_content := Void
								else
									check error: False end
								end
							when id_anchor_name then -- Immediate
								if {l_anchor_name: XMLDOC_WITH_ANCHOR_NAME} last_item then
									l_anchor_name.set_anchor_name (l_content.text)
									l_content := Void
								else
									check error: False end
								end
							when id_meta_content then
								if {l_meta_1: XMLDOC_META} last_item then
									l_meta_1.set_content (l_content.text)
									l_content := Void
								else
									check error: False end
								end
							when id_name then
								if {l_meta_2: XMLDOC_META} last_item then
									l_meta_2.set_name (l_content.text)
									l_content := Void
								else
									check error: False end
								end
							else
								do_nothing
							end
							if l_content /= Void then
								--| it hasn't been handled !
								if {l_comp_text: XMLDOC_COMPOSITE_TEXT} l_item then
									l_comp_text.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								elseif {l_with_content: XMLDOC_WITH_CONTENT} l_item then
									l_with_content.add_item (create {XMLDOC_TEXT}.make (l_content))
									l_content := Void
								end
							end
	--						check content_handled: l_content = Void end
						end --| if l_content attached

							--| Always do those case |--					
						inspect l_id
						when id_content then
							if {l_compo: XMLDOC_COMPOSITE_TEXT} l_item then
								if {l_heading: XMLDOC_HEADING} last_item then
									l_heading.set_content (l_compo)
								else
									check False end
								end
							else
								check mismatch_item: False end
							end
						when id_code_block then
							exit_preformatted_element
						when id_help then
							inside_help_element := False
						else
						end
					end
				end
				if l_id = id_output then
						--| Restore the last removed item, which is the parent of `<output/>'
					push_last_item (l_item)
					set_output_switch (Void)
				end
			else
				--| not is_valid_output_scope then
				if l_id = id_output then
					set_output_switch (Void)
				end
			end
		end

feature -- Content

	on_content (a_content: STRING) is
			-- Text content.
		local
			t: XMLDOC_CONTENT
		do
			if is_valid_output_scope then
				t ?= last_content
				if t /= Void then
					t.append_text (a_content)
				else
					create t.make_with_text (a_content)
					push_last_item (t)
				end
				check t_attached: t /= Void end
				if not inside_preformatted_element then
					t.update
				end
			end
		end

feature {NONE} -- Implementation

	set_resolved_url (a_with_url: XMLDOC_WITH_URL; a_url: STRING)
		local
			s: STRING
		do
			if {i: XMLDOC_IMAGE} a_with_url then
				s := resolved_url (a_url, True)
			else
				s := resolved_url (a_url, False)
			end
			a_with_url.set_url (s)
		end

	resolved_url (s: STRING; a_is_image: BOOLEAN): STRING is
		do
			if url_resolver = Void or s.substring_index ("://", 1) > 0 then
				Result := s
			else
				if a_is_image then
					Result := url_resolver.resolved_for_image (s)
				else
					Result := url_resolver.resolved (s)
				end
			end
		end

	tag_to_id (a_tag: STRING): INTEGER
		require
			a_tag_not_empty: a_tag /= Void and then not a_tag.is_empty
		local
			t: STRING
			c: CHARACTER
		do
			t := a_tag.twin
			t.to_lower

			inspect t.item (1)
			when 'a' then
				if t.is_equal (tag_alignment) then
					Result := id_alignment
				elseif t.is_equal (tag_alt_text) then
					Result := id_alt_text
				elseif t.is_equal (tag_anchor) then
					Result := id_anchor
				elseif t.is_equal (tag_anchor_name) then
					Result := id_anchor_name
				end
			when 'b' then
				if t.is_equal (tag_bold) then
					Result := id_bold
				elseif t.is_equal (tag_border) then
					Result := id_border
				end
			when 'c' then
				if t.is_equal (tag_cell) then
					Result := id_cell
				elseif t.is_equal (tag_code) then
					Result := id_code
				elseif t.is_equal (tag_code_block) then
					Result := id_code_block
				elseif t.is_equal (tag_content) then
					Result := id_content
				elseif t.is_equal (tag_class_name) then
					Result := id_class_name
				elseif t.is_equal (tag_cluster_name) then
					Result := id_cluster_name
				elseif t.is_equal (tag_character) then
					Result := id_character
				elseif t.is_equal (tag_comment) then
					Result := id_comment
				elseif t.is_equal (tag_contract_tag) then
					Result := id_contract_tag
				elseif t.is_equal (tag_compiler_error) then
					Result := id_compiler_error
				end
			when 'd' then
				if t.is_equal (tag_div) then
					Result := id_div
				elseif t.is_equal (tag_document) then
					Result := id_document
				end
			when 'f' then
				if t.is_equal (tag_feature_name) then
					Result := id_feature_name
				end
			when 'g' then
				if t.is_equal (tag_generics) then
					Result := id_generics
				end
			when 'h' then
				if t.is_equal (tag_heading) then
					Result := id_heading
				elseif t.is_equal (tag_height) then
					Result := id_height
				elseif t.is_equal (tag_help) then
					Result := id_help
				end
			when 'i' then
				if t.is_equal (tag_image) then
					Result := id_image
				elseif t.is_equal (tag_image_link) then
					Result := id_image_link
				elseif t.is_equal (tag_italic) then
					Result := id_italic
				elseif t.is_equal (tag_item) then
					Result := id_item
				elseif t.is_equal (tag_info) then
					Result := id_info
				elseif t.is_equal (tag_indexing_tag) then
					Result := id_indexing_tag
				elseif t.is_equal (tag_index) then
					Result := id_index
				end
			when 'k' then
				if t.is_equal (tag_keyword) then
					Result := id_keyword
				end
			when 'l' then
				if t.is_equal (tag_label) then
					Result := id_label
				elseif t.is_equal (tag_legend) then
					Result := id_legend
				elseif t.is_equal (tag_line_break) then
					Result := id_line_break
				elseif t.is_equal (tag_link) then
					Result := id_link
				elseif t.is_equal (tag_list) then
					Result := id_list
				elseif t.is_equal (tag_local_variable) then
					Result := id_local_variable
				elseif t.is_equal (tag_local_variable_quoted) then
					Result := id_local_variable_quoted
				end
			when 'm' then
				if t.is_equal (tag_meta_data) then
					Result := id_meta_data
				elseif t.is_equal (tag_meta) then
					Result := id_meta
				elseif t.is_equal (tag_meta_content) then
					Result := id_meta_content
				end
			when 'n' then
				if t.is_equal (tag_note) then
					Result := id_note
				elseif t.is_equal (tag_number) then
					Result := id_number
				elseif t.is_equal (tag_name) then
					Result := id_name
				end
			when 'o' then
				if t.is_equal (tag_output) then
					Result := id_output
				end
			when 'p' then
				if t.is_equal (tag_paragraph) then
					Result := id_paragraph
				end
			when 'r' then
				if t.is_equal (tag_row) then
					Result := id_row
				elseif t.is_equal (tag_reserved_word) then
					Result := id_reserved_word
				end
			when 's' then
				if t.is_equal (tag_sample) then
					Result := id_sample
				elseif t.is_equal (tag_seealso) then
					Result := id_seealso
				elseif t.is_equal (tag_size) then
					Result := id_size
				elseif t.is_equal (tag_span) then
					Result := id_span
				elseif t.is_equal (tag_style) then
					Result := id_style
				elseif t.is_equal (tag_string) then
					Result := id_string
				elseif t.is_equal (tag_symbol) then
					Result := id_symbol
				elseif t.is_equal (tag_sub_script) then
					Result := id_sub_script
				elseif t.is_equal (tag_syntax) then
					Result := id_syntax

				end
			when 't' then
				if t.is_equal (tag_table) then
					Result := id_table
				elseif t.is_equal (tag_target) then
					Result := id_target
				elseif t.is_equal (tag_tip) then
					Result := id_tip
				elseif t.is_equal (tag_title) then
					Result := id_title
				elseif t.is_equal (tag_term) then
					Result := id_term
				end
			when 'u' then
				if t.is_equal (tag_underline) then
					Result := id_underline
				elseif t.is_equal (tag_url) then
					Result := id_url
				end
			when 'w' then
				if t.is_equal (tag_warning) then
					Result := id_warning
				elseif t.is_equal (tag_width) then
					Result := id_width
				end
			when 'x' then
				if t.is_equal (tag_xml) then
					Result := id_xml
				elseif t.is_equal (tag_xmlkeyword) then
					Result := id_xmlkeyword
				end
			else
--				check not_implemented: False end
			end
		end

feature {NONE} -- Item id

	id__none: INTEGER = 0
	id_alignment: INTEGER = 1
	id_alt_text: INTEGER = 2
	id_anchor: INTEGER = 3
	id_anchor_name: INTEGER = 4
	id_bold: INTEGER = 5
	id_border: INTEGER = 6
	id_cell: INTEGER = 7
	id_code: INTEGER = 8
	id_content: INTEGER = 9
	id_div: INTEGER = 10
	id_document: INTEGER = 11
	id_heading: INTEGER = 12
	id_height: INTEGER = 13
	id_image: INTEGER = 14
	id_image_link: INTEGER = 15
	id_italic: INTEGER = 16
	id_item: INTEGER = 17
	id_label: INTEGER = 18
	id_legend: INTEGER = 19
	id_line_break: INTEGER = 20
	id_link: INTEGER = 21
	id_list: INTEGER = 22
	id_meta_data: INTEGER = 23
	id_note: INTEGER = 24
	id_paragraph: INTEGER = 25
	id_row: INTEGER = 26
	id_sample: INTEGER = 27
	id_seealso: INTEGER = 28
	id_size: INTEGER = 29
	id_span: INTEGER = 30
	id_style: INTEGER = 31
	id_table: INTEGER = 32
	id_target: INTEGER = 33
	id_tip: INTEGER = 34
	id_underline: INTEGER = 35
	id_url: INTEGER = 36
	id_warning: INTEGER = 37
	id_width: INTEGER = 38
	id_cluster_name: INTEGER = 39
	id_class_name: INTEGER = 40
	id_feature_name: INTEGER = 41
	id_code_block: INTEGER = 42
	id_info: INTEGER = 43
	id_string: INTEGER = 44
	id_number: INTEGER = 45
	id_character: INTEGER = 46
	id_reserved_word: INTEGER = 47
	id_comment: INTEGER = 48
	id_local_variable: INTEGER = 49
	id_symbol: INTEGER = 50
	id_local_variable_quoted: INTEGER = 51
	id_generics: INTEGER = 52
	id_contract_tag: INTEGER = 53
	id_indexing_tag: INTEGER = 54
	id_keyword: INTEGER = 55
	id_syntax: INTEGER = 56
	id_compiler_error: INTEGER = 57
	id_sub_script: INTEGER = 58
	id_output: INTEGER = 59
	id_title: INTEGER = 60
	id_xml: INTEGER = 61
	id_xmlkeyword: INTEGER = 62
	id_index: INTEGER = 63
	id_term: INTEGER = 64
	id_meta_content: INTEGER = 65
	id_help: INTEGER = 66
	id_meta: INTEGER = 67
	id_name: INTEGER = 68

feature {NONE} -- Item name

	tag_alignment: STRING = "alignment"
	tag_alt_text: STRING = "alt_text"
	tag_anchor: STRING = "anchor"
	tag_anchor_name: STRING = "anchor_name"
	tag_bold: STRING = "bold"
	tag_border: STRING = "border"
	tag_cell: STRING = "cell"
	tag_code: STRING = "code"
	tag_content: STRING = "content"
	tag_div: STRING = "div"
	tag_document: STRING = "document"
	tag_heading: STRING = "heading"
	tag_height: STRING = "height"
	tag_image: STRING = "image"
	tag_image_link: STRING = "image_link"
	tag_italic: STRING = "italic"
	tag_item: STRING = "item"
	tag_label: STRING = "label"
	tag_legend: STRING = "legend"
	tag_line_break: STRING = "line_break"
	tag_link: STRING = "link"
	tag_list: STRING = "list"
	tag_meta_data: STRING = "meta_data"
	tag_note: STRING = "note"
	tag_paragraph: STRING = "paragraph"
	tag_row: STRING = "row"
	tag_sample: STRING = "sample"
	tag_seealso: STRING = "seealso"
	tag_size: STRING = "size"
	tag_span: STRING = "span"
	tag_style: STRING = "style"
	tag_table: STRING = "table"
	tag_target: STRING = "target"
	tag_tip: STRING = "tip"
	tag_underline: STRING = "underline"
	tag_url: STRING = "url"
	tag_warning: STRING = "warning"
	tag_width: STRING = "width"
	tag_cluster_name: STRING = "cluster_name"
	tag_class_name: STRING = "class_name"
	tag_feature_name: STRING = "feature_name"
	tag_code_block: STRING = "code_block"
	tag_info: STRING = "info"
	tag_string: STRING = "string"
	tag_number: STRING = "number"
	tag_character: STRING = "character"
	tag_reserved_word: STRING = "reserved_word"
	tag_comment: STRING = "comment"
	tag_local_variable: STRING = "local_variable"
	tag_symbol: STRING = "symbol"
	tag_local_variable_quoted: STRING = "local_variable_quoted"
	tag_generics: STRING = "generics"
	tag_contract_tag: STRING = "contract_tag"
	tag_indexing_tag: STRING = "indexing_tag"
	tag_keyword: STRING = "keyword"
	tag_syntax: STRING = "syntax"
	tag_compiler_error: STRING = "compiler_error"
	tag_sub_script: STRING = "sub_script"
	tag_output: STRING = "output"
	tag_title: STRING = "title"
	tag_xml: STRING = "xml"
	tag_xmlkeyword: STRING = "xmlkeyword"
	tag_index: STRING = "index"
	tag_term: STRING = "term"
	tag_meta_content: STRING = "meta_content"
	tag_meta: STRING = "meta"
	tag_help: STRING = "help"
	tag_name: STRING = "name"

	att_ordered: STRING = "ordered"
	att_output: STRING = "output"
	att_title: STRING = "title"
	value_true: STRING = "true"

invariant
--	invariant_clause: True

end
