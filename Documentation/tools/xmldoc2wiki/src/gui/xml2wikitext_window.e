indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XML2WIKITEXT_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize
		end

	KL_SHARED_FILE_SYSTEM
		undefine
			default_create, copy
		end

feature {NONE} -- Initialize

	initialize is
			--
		local
			vb, gb: EV_VERTICAL_BOX
			hv: EV_HORIZONTAL_BOX
			hsp: EV_HORIZONTAL_SPLIT_AREA
			vsp: EV_VERTICAL_SPLIT_AREA
			noteb: EV_NOTEBOOK
			tb: EV_TOOL_BAR
			tbb: EV_TOOL_BAR_BUTTON
			lab: EV_LABEL
		do
			Precursor
			create vb
			vb.set_padding_width (4)
			vb.set_border_width (3)
			extend (vb)

			create gb

			create grid
			initialize_grid
			gb.extend (grid)

			create hv
			create prefix_url_tf
			create base_directory_tf
			create product_tf

			create {EV_LABEL} lab.make_with_text ("product:"); lab.set_minimum_width (3 + lab.font.string_width (lab.text)); hv.extend (lab); hv.disable_item_expand (lab)
			hv.extend (product_tf)
			product_tf.set_minimum_width_in_characters (10)
			create {EV_LABEL} lab.make_with_text ("prefix:"); lab.set_minimum_width (3 + lab.font.string_width (lab.text)); hv.extend (lab); hv.disable_item_expand (lab)
			hv.extend (prefix_url_tf)
			hv.disable_item_expand (prefix_url_tf)
			prefix_url_tf.set_minimum_width_in_characters (10)
			create {EV_LABEL} lab.make_with_text ("base:"); lab.set_minimum_width (3 + lab.font.string_width (lab.text)); hv.extend (lab); hv.disable_item_expand (lab)
			hv.extend (base_directory_tf)
			hv.disable_item_expand (product_tf)
			gb.extend (hv)
			gb.disable_item_expand (hv)

			create tb
			gb.extend (tb)
			gb.disable_item_expand (tb)

			create hsp

			create vsp
			vb.extend (vsp)
			vsp.extend (gb)
			vsp.extend (hsp)

			create xmldoc_text
			create wikitext_text
			create logs_box
			logs_box.enable_tree
			logs_box.disable_row_height_fixed
			logs_box.set_column_count_to (1)
			logs_box.hide_header

			create noteb

			hsp.extend (xmldoc_text)
			hsp.extend (noteb)
			hsp.set_proportion (0.5)

			noteb.extend (wikitext_text)
			noteb.item_tab (wikitext_text).set_text ("WikiText")
			noteb.extend (logs_box)
			noteb.item_tab (logs_box).set_text ("Logs")

			create status_label
			vb.extend (status_label)
			vb.disable_item_expand (status_label)

			show_actions.extend_kamikaze (agent (i_vsp,i_hsp: EV_SPLIT_AREA)
					do
						i_vsp.set_proportion (0.25)
						i_hsp.set_proportion (0.5)
					end(vsp,hsp)
				)

			close_request_actions.extend (agent destroy_and_exit_if_last)
			set_size (800, 500)

			create tbb.make_with_text ("Process All")
			tbb.select_actions.extend (agent process_all)
			tb.extend (tbb)


			create tbb.make_with_text ("Export All")
			tbb.select_actions.extend (agent export_all)
			tb.extend (tbb)

			create tbb.make_with_text ("Refresh")
			tbb.select_actions.extend (agent
					do
						current_text := xmldoc_text.text.as_string_8
						update_wikitext
					end)
			tb.extend (tbb)

			create tbb.make_with_text ("Clear")
			tbb.select_actions.extend (agent reset)
			tb.extend (tbb)

			initialize_tool
			customize_text (xmldoc_text)
			customize_text (wikitext_text)
		end

	initialize_tool
		do
			product_name := "studio"
			product_tf.set_text (product_name)

			create url_resolver
			url_resolver.base_directory := {XML2WIKITEXT_CONSTANTS}.hardcoded_base_directory
			url_resolver.prefix_url := {XML2WIKITEXT_CONSTANTS}.hardcoded_prefix_url
			url_resolver.current_filename := Void

			if url_resolver.prefix_url = Void then
				prefix_url_tf.remove_text
			else
				prefix_url_tf.set_text (url_resolver.prefix_url)
			end
			if url_resolver.base_directory = Void then
				base_directory_tf.remove_text
			else
				base_directory_tf.set_text (url_resolver.base_directory)
			end

			create all_pages.make (1050)
		end

	customize_text (t: EV_TEXT) is
		do
			t.set_default_key_processing_handler (agent (it: EV_TEXT; k: EV_KEY): BOOLEAN
					do
						Result := not ev_application.ctrl_pressed
					end(t, ?))
			t.key_press_actions.extend (agent on_key_pressed_for (t, ?))
		end

	on_key_pressed_for (t: EV_TEXT; k: EV_KEY) is
		local
		do
			if ev_application.ctrl_pressed then
				inspect k.code
				when {EV_KEY_CONSTANTS}.key_a then
					t.select_all
				when {EV_KEY_CONSTANTS}.key_c then
					ev_application.clipboard.set_text (t.selected_text)
				else
				end
			end
		end

	on_key_pressed_grid	(g: EV_GRID; k: EV_KEY) is
		local
			r: INTEGER
			s: STRING
			glab: EV_GRID_LABEL_ITEM
		do
			if ev_application.ctrl_pressed then
				inspect k.code
				when {EV_KEY_CONSTANTS}.key_c then
					from
						create s.make_empty
						r := 1
					until
						r > g.row_count
					loop
						glab ?= g.row (r).item (1)
						if glab /= Void then
							s.append (glab.text)
							s.append ("%N")
						end
						r := r + 1
					end
					ev_application.clipboard.set_text (s)
				else
				end
			end
		end

	update_parameters
		do
			product_name := product_tf.text.as_string_8.as_lower
			product_name.left_adjust
			product_name.right_adjust
			url_resolver.base_directory := base_directory_tf.text.as_string_8
			url_resolver.prefix_url := prefix_url_tf.text.as_string_8
		end

	initialize_grid
		local
			g: like grid
		do
			g := grid
			g.set_column_count_to (1)g.hide_header
			g.file_drop_actions.extend (agent on_files_dropped)
			g.row_select_actions.extend (agent on_row_selected)
			g.key_press_actions.extend (agent on_key_pressed_grid (g, ?))
		end

	all_filenames: ARRAYED_LIST [!STRING_8]
		local
			g: EV_GRID
			r: INTEGER
		do
			g := grid
			from
				create Result.make (g.row_count)
				r := 1
			until
				r > g.row_count
			loop
				if {fn: STRING_8} g.row (r).data then
					Result.extend (fn)
				end
				r := r + 1
			end
		end

	process_all is
		do
			discard_display
			if {lst: like all_filenames} all_filenames then
				from
					lst.start
				until
					lst.after
				loop
					status_label.set_text (lst.index.out + " / " + lst.count.out + " items")
					status_label.refresh_now
					ev_application.process_events
					set_xmldoc_filename (lst.item)
					lst.forth
				end
			end
			restore_display
		end

	export_all is
		local
			bd,td: STRING
			wbt: WIKIBOOK_TOOL
			s: STRING
			pges: ARRAYED_LIST [ TUPLE [fn: STRING; page: XMLDOC_PAGE; src: STRING]]
		do
			bd := url_resolver.base_directory
			td := url_resolver.base_directory + "__export"
			set_export_status (True)
			discard_display
			if {lst: like all_filenames} all_filenames then
				from
					lst.start
					create pges.make (lst.count)
				until
					lst.after
				loop
					status_label.set_text ("Get Page " + lst.index.out + " / " + lst.count.out + " items")
					status_label.refresh_now
					if {p: like xmldoc_page} xmldoc_page (Void, lst.item) then
						pges.extend ([lst.item, p, url_resolver.source_url])
						add_page (p, url_resolver.source_url)
					else
						check False end
					end
					ev_application.process_events
					lst.forth
				end

				from
					pges.start
				until
					pges.after
				loop
					status_label.set_text ("Save WikiText" + pges.index.out + " / " + pges.count.out + " items")
					status_label.refresh_now

					if {t: TUPLE [fn: STRING; page: XMLDOC_PAGE; src: STRING]} pges.item then
						s := wikitext_from_page (t.page, t.src)
						save_output (s, t.fn, url_resolver.base_directory)
					end

					ev_application.process_events

					pges.forth
				end
			end
			restore_display
			set_export_status (False)

			create wbt.make (td)
			status_label.set_text (status_label.text + " Export all completed")
		end

feature -- Access

	status_label: EV_LABEL

	grid: EV_GRID

	xmldoc_text: EV_TEXT

	wikitext_text: EV_TEXT

	base_directory_tf: EV_TEXT_FIELD

	prefix_url_tf: EV_TEXT_FIELD

	product_tf: EV_TEXT_FIELD

	logs_box: EV_GRID

	colors: TUPLE [error: EV_COLOR; unavailable: EV_COLOR]
		once
			create Result;
			Result.error := create {EV_COLOR}.make_with_8_bit_rgb (255,0,0)
			Result.unavailable := create {EV_COLOR}.make_with_8_bit_rgb (255,170,0)
		end

	default_font: EV_FONT
		once
			create Result
		end

	details_font: EV_FONT is
		local
			f: EV_FONT
		once
			create f
			f.preferred_families.extend ("Lucida Console")
			f.preferred_families.extend ("Terminal")

			f.set_family ({EV_FONT_CONSTANTS}.family_typewriter)
			f.set_shape ({EV_FONT_CONSTANTS}.Shape_regular)
			f.set_height_in_points (7)

			Result := f
		end

feature {NONE} -- Settings

	current_text: STRING

	current_filename: STRING

	base_directory: STRING

	display_discarded: BOOLEAN

	export_enabled: BOOLEAN

	product_name: STRING

	url_resolver: URL_RESOLVER

	all_pages: HASH_TABLE [XMLDOC_PAGE, STRING]
			-- indexed by src

feature {NONE} -- Settings change

	reset
		do
			current_filename := Void
			current_text := Void
			xmldoc_text.remove_text
			wikitext_text.remove_text
			if url_resolver /= Void then
				url_resolver.current_filename := Void
			end
			if all_pages /= Void then
				all_pages.wipe_out
			end
		end

	set_export_status (b: BOOLEAN)
		do
			export_enabled := b
		end

	discard_display
		do
			display_discarded := True
		end

	restore_display
		do
			display_discarded := False
		end

	save_output (s: STRING; source_fn: STRING; a_base_dir: STRING) is
		require
			ok: source_fn.substring_index (a_base_dir, 1) = 1
		local
			fn: STRING
			nfn: STRING
			dn: STRING
			f: RAW_FILE
		do
			create fn.make_from_string (source_fn)
			fn.remove_head (a_base_dir.count)
			create nfn.make_from_string (a_base_dir + "__export")
			nfn.append (fn)
			dn := file_system.dirname (nfn)
			file_system.recursive_create_directory (dn)
			nfn.remove_tail (3) -- remove  xml
			nfn.append ("wiki")
			create f.make (nfn)
			if not f.exists or else f.is_writable then
				f.open_write
				f.put_string (s)
				f.close
			end
		end

feature -- Logs

	add_page (p: XMLDOC_PAGE; s: STRING) is
		do
			all_pages.force (p, s)
		end

	append_error_to_log (e: ERROR)
		local
			s: STRING
			r: INTEGER
		do
			r := logs_box.row_count
			if {ee: ERROR_EXCEPTION} e then
				append_detailled_log (" - Exception: " + e.to_string, ee.exception.exception_trace)
				logs_box.row (r+1).set_foreground_color (colors.error)
			elseif {eu: ERROR_UNAVAILABLE} e then
				append_detailled_log (" - Unavailable: " + eu.associated_tag, Void)
				logs_box.row (r+1).set_foreground_color (colors.unavailable)
			else
				append_detailled_log (e.to_string, Void)
			end
		end

	append_detailled_log (m: STRING; s: STRING)
		local
			g1,g2: EV_GRID_LABEL_ITEM
			r: EV_GRID_ROW
			ft: EV_FONT
		do
			create g1.make_with_text (m)
			logs_box.set_item (1, logs_box.row_count + 1, g1)
			if s /= Void then
				ft := details_font
				create g2.make_with_text (s)g2.set_font (ft)
				g1.row.insert_subrow (g1.row.subrow_count + 1)
				r := g1.row.subrow (g1.row.subrow_count)
				r.set_item (1, g2)
				r.set_height (ft.string_size (s).height)
			end
			logs_box.column (1).resize_to_content
			logs_box.row (logs_box.row_count).enable_select
		end

feature -- Basic operation

	on_files_dropped (lst: LIST [STRING_32]) is
			-- Files dropped
		require
			lst_attached: lst /= Void
		do
			from lst.start until lst.after loop
				on_pathname_dropped (lst.item.as_string_8)
				lst.forth
			end
			grid.column (1).resize_to_content
			status_label.set_text (grid.row_count.out + " input(s)")
		end

	on_pathname_dropped (pn: STRING) is
			-- Pathname `pn' dropped
		local
			f: RAW_FILE
		do
			create f.make (pn)
			if f.exists and then f.is_directory then
				on_directory_dropped (pn)
			else
				on_filename_dropped (pn)
			end
		end

	on_filename_dropped (fn: STRING) is
			-- Filename `fn' dropped
		local
			gi: EV_GRID_LABEL_ITEM
		do
			if fn.count > 4 and then fn.substring (fn.count - 3, fn.count).is_case_insensitive_equal (once ".xml") then
				create gi.make_with_text (fn)
				grid.set_item (1, grid.row_count + 1, gi)
				gi.row.set_data (fn)
			end
		end

	on_directory_dropped (dn: STRING) is
			-- Directory `dn' dropped
		require
			dn_attached: dn /= Void
		local
			d: KL_DIRECTORY
			fns: ARRAYED_LIST [STRING]
		do
			create d.make (dn)
			if d.exists and d.is_readable then
				create fns.make (1050)
				d.do_all (agent (ibn, ifn: STRING; ifns: LIST [STRING])
					local
						fn: FILE_NAME
					do
						if not ifn.is_case_insensitive_equal (once ".svn") then
							create fn.make_from_string (ibn)
							fn.set_file_name (ifn)
							ifns.extend (fn.string)
						end
					end (dn, ?, fns))
				fns.do_all (agent on_pathname_dropped)
			end
		end

	on_row_selected (a_row: EV_GRID_ROW)
			-- `a_row' is selected
		require
			a_row_attached: a_row /= Void
		do
			if {fn: STRING} a_row.data then
				set_xmldoc_filename (fn)
			end
		end

	set_xmldoc_filename (fn: !STRING)
			-- Set filename source for xmldoc
		local
			f: PLAIN_TEXT_FILE
			s: STRING
		do
			reset
			current_filename := fn
			s := text_from_filename (fn)
			if s /= Void then
				append_detailled_log ("Process [" + fn + "]", Void)
				current_text := s
				if not display_discarded then
					xmldoc_text.set_text (current_text)
				end
				update_wikitext
			end
		end

	text_from_filename (fn: STRING): STRING
		local
			f: PLAIN_TEXT_FILE
			s: STRING
		do
			create f.make (fn)
			if f.exists and then f.is_readable then
				f.open_read
				from
					create Result.make (f.count)
					f.start
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (512)
					Result.append (f.last_string)
				end
				f.close
			end
		end

	xmldoc_page (txt: STRING; fn: STRING): XMLDOC_PAGE
		local
			x: STRING
			vis: WIKITEXT_XMLDOC_VISITOR
			x2w: XML2WIKITEXT
		do
			create x2w.make
			update_parameters
			url_resolver.current_filename := fn
			x2w.url_resolver := url_resolver
			x2w.product_name := product_name
			if {l_xml: STRING} txt then
				x2w.process_string (l_xml)
			elseif {l_xml2: STRING} text_from_filename (fn) then
				x2w.process_string (l_xml2)
			end
			Result := x2w.page
			if {err: LIST [ERROR]} x2w.errors then
				from
					err.start
				until
					err.after
				loop
					append_error_to_log (err.item)
					err.forth
				end
			end
			if Result /= Void then
				add_page (Result, url_resolver.source_url)
			end
		end

	wikitext_from_page (p: XMLDOC_PAGE; src: STRING): STRING
		local
			vis: WIKITEXT_XMLDOC_VISITOR
		do
			create Result.make_empty
			create vis.make (Result)
			vis.set_all_pages (all_pages)
			vis.set_url_resolver (url_resolver)

			Result.append ("#src=")
			Result.append (src)
			Result.append ("%N")

			vis.process_page (p)
		end

	update_wikitext
			-- Update wikitext content
		local
			s: STRING
			vis: WIKITEXT_XMLDOC_VISITOR
			x2w: XML2WIKITEXT
			page: XMLDOC_PAGE
		do
			if {l_xml: STRING} current_text and then not l_xml.is_empty then
				page := xmldoc_page (l_xml, current_filename)
				if page /= Void then
					add_page (page, url_resolver.source_url)
					s := wikitext_from_page (page, url_resolver.source_url)
					if export_enabled then
						save_output (s, current_filename, url_resolver.base_directory)
					end
					if not display_discarded then
						wikitext_text.set_text (s)
					end
				else
					wikitext_text.set_text ("Exception occurred!%N")
					if {e: EXCEPTION} x2w.exception then
						wikitext_text.append_text (e.exception_trace)
					end
				end
			end
		end

end

