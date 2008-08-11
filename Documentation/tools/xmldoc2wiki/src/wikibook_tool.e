indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKIBOOK_TOOL

inherit
	WIKI_WITH_CHILD

	KL_SHARED_FILE_SYSTEM

create
	make

feature {NONE} -- Initialization

	make (dn: STRING)
		local
			fn: FILE_NAME
			f: FILE
			k,v: STRING
			lst: LIST [WIKIPAGE]
			use_io: BOOLEAN
		do
			root := dn.twin
			process

			if use_io then
				f := io.output
			else
				create fn.make_from_string (root)
				fn.set_file_name ("book.index")
				create {RAW_FILE} f.make (fn)
				f.create_read_write
			end
			create max_depth_info
			print_book (f, pages, 0)
			f.put_new_line
			if not use_io then
				f.close
			end


			get_book_conflicts

			if use_io then
				f := io.output
			else
				create fn.make_from_string (root)
				fn.set_file_name ("book.log")
				create {RAW_FILE} f.make (fn)
				f.create_read_write
			end

			f.put_string ("Log for book: %N")
			f.put_string (" - source: " + root + "%N")
			f.put_string (" - pages: " + book_pages.count.out + "%N")
			f.put_string (" - depth: " + max_depth_info.depth.out + " reached " + max_depth_info.nb.out + " time(s) %N")
			f.put_string (" - title conflict(s): " + book_conflicts.count.out + "%N")
			if book_conflicts.count > 0 then
				from
					book_conflicts.start
				until
					book_conflicts.after
				loop
					k := book_conflicts.key_for_iteration
					f.put_string ("%T#[" + k + "]%N")
					lst := book_conflicts.item_for_iteration
					from
						lst.start
					until
						lst.after
					loop
						f.put_string ("%T  - " + lst.item.src )
						f.put_string (" : %"" + lst.item.title + "%"")
--						f.put_string (" : %"" + lst.item.title + "%"")
						f.put_new_line
						lst.forth
					end
					book_conflicts.forth
				end
			end
			f.put_new_line
			if not use_io then
				f.close
			end
		end

	print_book (output: FILE; pge: LIST [WIKIPAGE]; dep: INTEGER) is
		local
			o: STRING
			p: WIKIPAGE
		do
			create o.make_filled (' ', dep)
			from
				pge.start
			until
				pge.after
			loop
				p := pge.item
				check not p.failed end
				notify_page (dep, p)
				output.put_string (o)
				output.put_string ("[" + p.depth.out + ":" + p.base_id + "] ")
				output.put_string (p.title + "%N")

				output.put_string (o + "  !src=" + p.src + "%N")
--				output.put_string (o + "  !path=" + p.path + "%N")

				if p.pages /= Void and then not p.pages.is_empty then
--					notify_page (dep + 1, p.pages.first)
					print_book (output, p.pages, dep + 1)
				end
				pge.forth
			end
		end

feature -- Access

	root: STRING
			-- Root directory

	book_conflicts: HASH_TABLE [LIST [WIKIPAGE], STRING]
			-- indexed by WIKIPAGE.title

	book_by_titles: HASH_TABLE [LIST [WIKIPAGE], STRING]
			-- indexed by WIKIPAGE.title

	book_pages: like pages

	max_depth_info: TUPLE [depth: INTEGER; path: STRING; nb: INTEGER]

feature -- Measurement

	notify_page (dep: INTEGER; p: WIKIPAGE)
		require
--			same_dep: dep = p.depth
		do
			if dep > max_depth_info.depth then
				max_depth_info.depth := dep
				max_depth_info.nb := 1
			elseif dep = max_depth_info.depth then
				max_depth_info.nb := max_depth_info.nb + 1
			end
		end

	get_book_conflicts
		local
		do
			from
				create book_conflicts.make (100)
				book_by_titles.start
			until
				book_by_titles.after
			loop
				if book_by_titles.item_for_iteration.count > 1 then
					book_conflicts.put (book_by_titles.item_for_iteration.twin, book_by_titles.key_for_iteration)
				end
				book_by_titles.forth
			end
		end

feature -- Basic operations

	process
		local
		do
			create book_pages.make (1500)
			create book_by_titles.make (30)
			book_by_titles.compare_objects

			get_pages (root, "Book", Current, 1)
		end

	add_page_entry (wpg: WIKIPAGE)
		local
			t: STRING
			lst: LIST [WIKIPAGE]
		do
			book_pages.extend (wpg)
			t := wpg.title.as_lower
			t.left_adjust
			t.right_adjust
			if book_by_titles.has_key (t) then
				lst := book_by_titles.found_item
			else
				create {ARRAYED_LIST [WIKIPAGE]} lst.make (3)
				book_by_titles.put (lst, t)
			end
			lst.extend (wpg)
		end

feature {NONE} -- Implementation

	path_from_root (fn: STRING): STRING
		require
			valid_fn: fn.substring (1, root.count).is_case_insensitive_equal (root)
		do
			create Result.make_from_string (fn)
			Result.remove_head (root.count + 1)
		end

	get_pages (dn: STRING; a_folder_id: STRING; a_parent: WIKI_WITH_CHILD; dep: INTEGER)
		require
			a_parent_attached: a_parent /= Void
		local
			d: KL_DIRECTORY
			fn: FILE_NAME
			wpg_index: like wikifile_details
		do
			create d.make (dn)
			if d.exists and then d.is_readable then
					--| First check for the index.xml
				create fn.make_from_string (dn)
				fn.set_file_name ("index.wiki")
				wpg_index := wikifile_details (fn.string)
				check wpg_index /= Void and then wpg_index.is_index end
				wpg_index.depth := dep - 1
				wpg_index.force_base_id (a_folder_id) --| Set base_id to folder's id
				add_page_entry (wpg_index)
				a_parent.add_page (wpg_index)

				d.do_all (agent (idn: STRING; ifn: STRING; a_par: WIKI_WITH_CHILD; idep: INTEGER)
						local
							l_fn: FILE_NAME
							wpg: WIKIPAGE
						do
							create l_fn.make_from_string (idn)
							l_fn.set_file_name (ifn)
							if file_system.is_file_readable (l_fn) then
								wpg := wikifile_details (l_fn.string)
								if
									wpg /= Void and then
									not wpg.failed and then
									not wpg.is_index --| Already handled by wpg_index
								then
									wpg.depth := idep
									add_page_entry (wpg)
									a_par.add_page (wpg)
								end
							elseif file_system.is_directory_readable (l_fn) then
								get_pages (l_fn.string, ifn.twin, a_par, idep + 1)
							end
						end(dn, ?, wpg_index, dep)
					)
			end
		end

	wikifile_local_id (fn: STRING): STRING is
			-- Return wikifile_local_id which is the basename, without the extension
			-- if this is a wikifile
		do
			create Result.make_from_string (file_system.basename (fn))
			if Result.count > 4 and then Result.substring (Result.count - 4, Result.count).is_equal (once ".wiki") then
				Result.remove_tail (5)
			else
				Result := Void
			end
		end

	wikifile_details (a_fn: STRING): WIKIPAGE
		local
			f: PLAIN_TEXT_FILE
			line: STRING
			done: BOOLEAN
			p: INTEGER
			k,v: STRING
		do
			line := wikifile_local_id (a_fn)
			if line /= Void then
				create Result.make (line, path_from_root (a_fn))

				create f.make (a_fn)
				if f.exists and then f.is_readable then
					f.open_read
					from
						f.start
					until
						done or f.exhausted or f.end_of_file
					loop
						f.read_line
						line := f.last_string
						if line.count > 1 and then line.item (1) = '#' then
							p := line.index_of ('=', 2)
							if p > 0 then
								k := line.substring (2, p - 1)
								if k.is_empty or k.has (' ') or k.has ('%T') then
									k := Void
									done := True
									--| We scan a generated file, and we are sure of the format beginning
								else
									v := line.substring (p + 1, line.count)
								end
								if k /= Void and v /= Void then
									if k.is_equal (once "src") then
										Result.src := v
									elseif k.is_equal (once "title") then
										Result.title := v
									else
										print ("Error .. unknown settings [" + k + "=" + v + "] %N")
										Result.failed := True
									end
								end
							else
								done := True
							end
						else
							done := True
						end
					end
					f.close
				else
					Result.failed := True
				end
			end
		end

end
