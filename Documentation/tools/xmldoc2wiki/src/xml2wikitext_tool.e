indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML2WIKITEXT_TOOL

inherit
	ARGUMENTS

	KL_SHARED_FILE_SYSTEM

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current
		do
--			process_filename ("d:\_dev\trunk\Documentation\xmldoc", "tools/eiffelstudio/reference/40_debugger/30_call_stack_tool/10_call_stack_tool.xml")
--			process_filename ("d:\_dev\trunk\Documentation\xmldoc", "tools/eiffelstudio/reference/40_debugger/35_execution_record_and_replay/00_introduction.xml")
		end

--	process_filename (dn: STRING; fn: STRING)
--		local
--			filename: STRING
--			vis: WIKITEXT_XMLDOC_VISITOR
--			s: STRING
--			x2w: XML2WIKITEXT
--			page: XMLDOC_PAGE
--			f: RAW_FILE
--		do
--			filename := filename_from (dn, fn)

--			create x2w.make
--			x2w.process_filename (filename.string)
--			page := x2w.page

--			create s.make_empty
--			create vis.make (s)
--			vis.process_page (page)

--			if {err: LIST [STRING]} x2w.errors then
--				from
--					err.start
--				until
--					err.after
--				loop
--					print (err.item + "%N")
--					err.forth
--				end
--			end

--			filename.append_string (".wiki")
--			create f.make (filename)
--			if not f.exists or else f.is_writable then
--				f.create_read_write
--				f.put_string (s)
--				f.close
--			end
--		end

--	filename_from (dn: STRING; fn: STRING): STRING is
--		local
--			f: FILE_NAME
--			s: STRING
--			i,p: INTEGER
--		do
--			create f.make_from_string (dn)
--			from
--				i := 1
--				p := 1
--			until
--				not fn.valid_index (i)
--			loop
--				i := fn.index_of ('/', p)
--				if i > 1 and then fn.item (i - 1) /= '\' then
--					f.extend (fn.substring (p, i - 1))
--					p := i + 1
--					i := p
--				end
--			end
--			if fn.valid_index (p) then
--				f.set_file_name (fn.substring (p, fn.count))
--			end
--			Result := f.string
--		end

end
