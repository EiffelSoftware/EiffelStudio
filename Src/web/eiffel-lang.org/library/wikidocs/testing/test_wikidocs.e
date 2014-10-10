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
			cfg: WDOCS_DEFAULT_CONFIG
			d: DIRECTORY
			p: PATH
			n: READABLE_STRING_GENERAL
			s: STRING
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			i: INTEGER
			ut: FILE_UTILITIES
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

			p := cfg.documentation_dir.extended (cfg.documentation_default_version)
			wikidocs_dir := p
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			create book_infos.make (3)
			book_infos.put (Void, "First_book")
			book_infos.put (Void, "Second_book")
			book_infos.put (Void, "Third_book")

			across
				book_infos as ic
			loop
				n := ic.key
				create d.make_with_path (p.extended (n))
				d.recursive_create_dir
				create s.make_from_string ("Overview of ")
				s.append_string_general (n)
				create lst.make (1)
				save_page (n, "index", s)
				lst.force ("index")
				book_infos.force (lst, ic.key)
			end

			create wdocs.make (cfg.root_dir, p, cfg.documentation_default_version)
			wdocs.refresh_data
		end

	on_clean
		local
			p: PATH
			d: DIRECTORY
		do
			p := wdocs.root_dir
			create d.make_with_path (p)
			if d.exists then
				d.recursive_delete
			end
		end

	save_page (a_book_name: READABLE_STRING_GENERAL; a_page_name: READABLE_STRING_GENERAL; a_content: READABLE_STRING_8)
		local
			f: RAW_FILE
		do
			create f.make_with_path (wikidocs_dir.extended (a_book_name).extended (a_page_name).appended_with_extension ("wiki"))
			f.create_read_write
			f.put_string (a_content)
			f.close
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
		local
			lst: STRING_TABLE [READABLE_STRING_GENERAL]
		do
			across
				book_infos as ic
			loop
				if attached wdocs.book (ic.key) as wb then
					if attached ic.item as l_page_names then
						across
							l_page_names as p_ic
						loop
							assert ({STRING_32} "Page " + p_ic.item.to_string_32 + " exists", wdocs.page (ic.key, p_ic.item) /= Void)
						end
					end
				else
					assert ({STRING_32} "Book " + ic.key.to_string_32 + " exists", False)
				end
			end
		end

feature {NONE} -- Implementation

end
