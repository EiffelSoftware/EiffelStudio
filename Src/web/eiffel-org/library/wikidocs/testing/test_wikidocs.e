note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_WIKIDOCS

inherit

	ANY
		undefine
			default_create
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		local
			cfg: WDOCS_DEFAULT_SETUP
			d: DIRECTORY
			p: PATH
			n: READABLE_STRING_GENERAL
			s: STRING
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			i: INTEGER
			ut: FILE_UTILITIES
			l_version: detachable READABLE_STRING_GENERAL
		do
			create d.make_with_path (execution_environment.current_working_path.extended ("tmp"))
--			if d.exists then
--				d.recursive_delete
--				Execution_environment.sleep (1_000_000)
--			end
			from
				i := 0
				p := d.path.extended ("root")
			until
				not ut.directory_path_exists (p)
			loop
				i := i + 1
				p := d.path.extended ("root_" + i.out)
			end

			create cfg.make (p, Void)

			create d.make_with_path (cfg.documentation_dir)
			assert ("directory does not exists", not d.exists)
			l_version := cfg.documentation_default_version
			if l_version = Void then
				l_version := "current"
			end
			p := cfg.documentation_dir.extended (l_version)

			wikidocs_dir := p
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			create book_infos.make (3)
			book_infos.put (Void, "Book_Three")
			book_infos.put (Void, "Book_Two")
			book_infos.put (Void, "Book_One")

			across
				book_infos as ic
			loop
				n := ic.key
				create d.make_with_path (p.extended (n))
				d.recursive_create_dir
				create s.make_from_string ("Overview of ")
				s.append_string_general (n)
				create lst.make (4)
				if n.is_case_insensitive_equal ("Book_One") then
					save_page (n, "index", s, <<["weight","1"]>>)
				elseif n.is_case_insensitive_equal ("Book_Two") then
					save_page (n, "index", s, <<["weight","2"]>>)
				elseif n.is_case_insensitive_equal ("Book_Three") then
					save_page (n, "index", s, <<["weight","3"]>>)
				end
				lst.force ("index")

				save_page (n, "one", "First page",<<["weight","1"]>>)
				lst.force ("one")
				save_page (n, "two", "Second page",<<["weight","2"]>>)
				lst.force ("two")
				save_page (n, "three", "Third page",<<["weight","3"]>>)
				lst.force ("three")

				book_infos.force (lst, ic.key)
			end

			create wdocs.make (p, l_version, cfg.temp_dir)
			wdocs.refresh_data
		end

	on_clean
		local
			p: PATH
			d: DIRECTORY
		do
			p := wdocs.tmp_dir
			create d.make_with_path (p)
			if d.exists then
				d.recursive_delete
			end

			p := wdocs.wiki_database_path
			create d.make_with_path (p)
			if d.exists then
				d.recursive_delete
			end
		end

	save_page (a_book_name: READABLE_STRING_GENERAL; a_page_name: READABLE_STRING_GENERAL; a_content: READABLE_STRING_8; a_metadata: detachable ITERABLE [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]])
		local
			f: RAW_FILE
		do
			create f.make_with_path (wikidocs_dir.extended (a_book_name).extended (a_page_name).appended_with_extension ("wiki"))
			f.create_read_write
			f.put_string (a_content)
			f.close
			if a_metadata /= Void then
				create f.make_with_path (wikidocs_dir.extended (a_book_name).extended (a_page_name).appended_with_extension ("data"))
				f.create_read_write
				across
					a_metadata as ic
				loop
					f.put_string (ic.item.name)
					f.put_character ('=')
					f.put_string (ic.item.value)
					f.put_new_line
				end
				f.close
			end
		end

	wdocs: WDOCS_MANAGER

	wikidocs_dir: PATH

feature -- Tests data

	book_infos: STRING_TABLE [detachable LIST [READABLE_STRING_GENERAL]]
			--

	book_names: ARRAYED_SET [READABLE_STRING_GENERAL]
		local
			l_infos: like book_infos
		do
			l_infos := book_infos
			create Result.make (l_infos.count)
			across
				l_infos as ic
			loop
				Result.extend (ic.key)
			end
		end

feature -- Tests

	test_books
		note
			testing:  "execution/isolated"
		local
			lst: STRING_TABLE [READABLE_STRING_GENERAL]
		do
			create lst.make (3)
			across
				wdocs.book_names as ic
			loop
				lst.force (ic.item, ic.item)
			end
			assert("expected list of books", across book_names as ic all lst.has (ic.item) end)
		end

	test_pages
		note
			testing:  "execution/isolated"
		local
			s,s1: STRING_32
		do
			across
				book_infos as ic
			loop
				if attached wdocs.book (ic.key) as wb then
					create s.make_empty
					if
						attached wb.root_page as rp and then
						attached rp.pages as rp_pages
					then
						across
							rp_pages as p_ic
						loop
							s.append_string_general (p_ic.item.title)
							s.append_string_general (",")
						end
					end
					s1 := s
					create s.make_empty
					if attached ic.item as l_page_names then
						across
							l_page_names as p_ic
						loop
							s.append_string_general (p_ic.item)
							s.append_string_general (",")
							assert ({STRING_32} "Page " + p_ic.item.to_string_32 + " exists", wdocs.page (ic.key, p_ic.item) /= Void)
						end
					end
					assert("same ordered pages", s.tail (s.count - ("index,").count).same_string (s1))
				else
					assert ({STRING_32} "Book " + ic.key.to_string_32 + " exists", False)
				end
			end
		end

feature {NONE} -- Implementation

end
