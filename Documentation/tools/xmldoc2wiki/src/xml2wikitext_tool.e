indexing
	description: "Summary description for {XML2WIKITEXT_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML2WIKITEXT_TOOL

inherit
	KL_SHARED_FILE_SYSTEM

feature {NONE} -- Initialization

	initialize_tool
		do
			product_name := "studio"

			create url_resolver
			url_resolver.base_directory := constants_.hardcoded_base_directory
			url_resolver.prefix_url := constants_.hardcoded_prefix_url
			url_resolver.current_filename := Void

			create all_pages.make (1050)
		end

	constants_: XML2WIKITEXT_CONSTANTS
		once
			create Result
		end

	reset
		do
			if url_resolver /= Void then
				url_resolver.current_filename := Void
			end
			if all_pages /= Void then
				all_pages.wipe_out
			end
		end

feature -- Access

	base_directory: STRING

	product_name: STRING

	url_resolver: URL_RESOLVER

	all_pages: HASH_TABLE [XMLDOC_PAGE, STRING]
			-- indexed by src

	target_directory (a_base_dir: STRING): STRING
		require
			a_base_dir_attached: a_base_dir /= Void
		do
			Result := a_base_dir + "__export"
		end

feature -- Basic operation

	notify_status (m: STRING)
		do
			print (m + "%N")
--			status_label.set_text (m)
--			status_label.refresh_now			
		end

	notify_page_fetched, notify_page_saved
		do
--					ev_application.process_events			
		end

	export_filenames (lst: ARRAYED_LIST [!STRING_8]) is
		local
			bd,td: STRING
			wbt: WIKIBOOK_TOOL
			s: STRING
			pges: ARRAYED_LIST [ TUPLE [fn: STRING; page: XMLDOC_PAGE; src: STRING]]
		do
			bd := url_resolver.base_directory
			if lst /= Void then
				from
					lst.start
					create pges.make (lst.count)
				until
					lst.after
				loop
					notify_status ("Get Page " + lst.index.out + " / " + lst.count.out + " items")
					if {p: like xmldoc_page} xmldoc_page (Void, lst.item) then
						pges.extend ([lst.item, p, url_resolver.source_url])
						add_page (p, url_resolver.source_url)
					else
						check False end
					end
					notify_page_fetched
					lst.forth
				end

				from
					pges.start
				until
					pges.after
				loop
					notify_status ("Save WikiText" + pges.index.out + " / " + pges.count.out + " items")
					if {t: TUPLE [fn: STRING; page: XMLDOC_PAGE; src: STRING]} pges.item then
						s := wikitext_from_page (t.page, t.src)
						save_output (s, t.fn, url_resolver.base_directory)
					end
					notify_page_saved
					pges.forth
				end
			end
			td := target_directory (url_resolver.base_directory)
			create wbt.make (td)
			notify_status ("Export all completed")
		end

	add_page (p: XMLDOC_PAGE; s: STRING) is
		do
			all_pages.force (p, s)
		end

feature -- Logs

	append_error_to_log (e: ERROR)
		local
			s: STRING
			r: INTEGER
		do
			if {ee: ERROR_EXCEPTION} e then
				append_detailled_log (" - Exception: " + e.to_string, ee.exception.exception_trace)
			elseif {eu: ERROR_UNAVAILABLE} e then
				append_detailled_log (" - Unavailable: " + eu.associated_tag, Void)
			else
				append_detailled_log (e.to_string, Void)
			end
		end

	append_detailled_log (m: STRING; s: STRING)
		do
			print (m)
			print ("%N")
			if s /= Void then
				print ("%T")
				print (m)
				print ("%N")
			end
		end

feature {NONE} -- Implementation

	get_xmldoc_source_from_pathname (pn: !STRING_8; lst: !LIST [!STRING_8]) is
			-- Pathname `pn' dropped
		local
			f: RAW_FILE
		do
			create f.make (pn)
			if f.exists and then f.is_directory then
				get_xmldoc_source_from_directory (pn, lst)
			else
				get_xmldoc_source_from_filename (pn, lst)
			end
		end

	get_xmldoc_source_from_filename (fn: !STRING_8; lst: !LIST [!STRING_8]) is
			-- Filename `fn' dropped
		do
			if fn.count > 4 and then fn.substring (fn.count - 3, fn.count).is_case_insensitive_equal (once ".xml") then
				lst.extend (fn)
			end
		end

	get_xmldoc_source_from_directory (dn: !STRING_8; lst: !LIST [!STRING_8]) is
			-- Directory `dn' dropped
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
				fns.do_all (agent get_xmldoc_source_from_pathname (?, lst))
			end
		end

	get_imgdoc_source_from_pathname (pn: !STRING_8; lst: !LIST [!STRING_8]) is
			-- Pathname `pn' dropped
		local
			f: RAW_FILE
		do
			create f.make (pn)
			if f.exists and then f.is_directory then
				get_imgdoc_source_from_directory (pn, lst)
			else
				get_imgdoc_source_from_filename (pn, lst)
			end
		end

	get_imgdoc_source_from_filename (fn: !STRING_8; lst: !LIST [!STRING_8]) is
			-- Filename `fn' dropped
		local
			e: STRING
		do
			if fn.count > 4 then
				e := fn.substring (fn.count - 3, fn.count)
				e.to_lower
				if
					e.is_equal (once ".jpg") or e.is_equal (once ".png") or e.is_equal (once ".ico")
				then
					lst.extend (fn)
				end
			end
		end

	get_imgdoc_source_from_directory (dn: !STRING_8; lst: !LIST [!STRING_8]) is
			-- Directory `dn' dropped
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
				fns.do_all (agent get_imgdoc_source_from_pathname (?, lst))
			end
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
			create nfn.make_from_string (target_directory (a_base_dir))
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
			vis.set_source (src)

			Result.append ("#src=")
			Result.append (src)
			Result.append ("%N")

			vis.process_page (p)
		end

end
