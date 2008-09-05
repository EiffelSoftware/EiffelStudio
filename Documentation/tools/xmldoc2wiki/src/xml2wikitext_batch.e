indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML2WIKITEXT_BATCH

inherit
	ARGUMENTS

	XML2WIKITEXT_TOOL
		redefine
			initialize_tool,
			target_directory
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current
		local
			files: ARRAYED_LIST [!STRING_8]
			imgs: ARRAYED_LIST [!STRING_8]
			ht: like checked_images
			fn,bfn: FILE_NAME
		do
			initialize_tool
			create imgs.make (500)
			create files.make (1050)
			if {s: STRING_8} url_resolver.base_directory then
				get_imgdoc_source_from_pathname (s, imgs)
--				files.extend ("D:\_dev\trunk\Documentation\xmldoc\general\guided_tour\studio\index-06.xml")
--				files.extend ("D:\_dev\trunk\Documentation\xmldoc\general\guided_tour\studio\index-12.xml")
				get_xmldoc_source_from_pathname (s, files)
			end
			ht := checked_images (imgs)

			from
				ht.start
				create bfn.make_from_string (target_directory (url_resolver.base_directory))
				bfn.extend ("images")
				file_system.recursive_create_directory (bfn.string)
			until
				ht.after
			loop
				url_resolver.add_image (ht.key_for_iteration, ht.item_for_iteration)
				debug
					print (" - " + ht.item_for_iteration + ": " + ht.key_for_iteration + "%N")
				end
				create fn.make_from_string (bfn)
				fn.extend (ht.item_for_iteration)
				file_system.copy_file (ht.key_for_iteration, fn.string)
				ht.forth
			end
			export_filenames (files)
		end

	checked_images (imgs: LIST [!STRING_8]): HASH_TABLE [STRING, !STRING_8]
		local
			ht: HASH_TABLE [LINKED_LIST [!STRING_8], STRING]
			rht: HASH_TABLE [STRING, !STRING_8]
			l_imgid, l_new_imgid: STRING
			fn: !STRING_8
			l_conflicts: INTEGER

			i, n: INTEGER
			s: STRING
			lst, lst2: LINKED_LIST [!STRING_8]
		do
			create ht.make (imgs.count)
			ht.compare_objects
			from
				imgs.start
			until
				imgs.after
			loop
				fn := imgs.item
				s := file_system.basename (fn)
				s.to_lower
				s.replace_substring_all ("_", "-") --| For now, let's do this way to ease Drupal's wiki module ...
--				i := s.last_index_of ('.', s.count)
--				check i > 0 end
--				s.remove_tail (s.count - i + 1)
				if ht.has_key (s) then
					lst := ht.found_item
					l_conflicts := l_conflicts + 1
				else
					create lst.make
					lst.compare_objects
					ht.put (lst, s)
				end
				lst.extend (fn)
				imgs.forth
			end
			from until l_conflicts = 0 loop
				l_conflicts := 0
				from
					ht.start
				until
					ht.after
				loop
					lst := ht.item_for_iteration
					l_imgid := ht.key_for_iteration

					if lst.count > 1 then
						from
							lst.start
							lst.forth -- Keep first as it is ?
						until
							lst.after
						loop
							fn := lst.item
							l_new_imgid := file_system.basename (file_system.dirname (fn)) + "--" + l_imgid
							l_new_imgid.replace_substring_all ("_", "-") --| For now, let's do this way to ease Drupal's wiki module ...
							if ht.has (l_new_imgid) then
								lst2 := ht.item (l_new_imgid)
								l_conflicts := l_conflicts + 1
							else
								create lst2.make
								lst2.compare_objects
								ht.put (lst2, l_new_imgid)
							end
							lst2.extend (fn)
							lst.remove
----							l_new_imgid := l_imgid + "-" + lst.index.out
----							rht.put (l_new_imgid, lst.item)
----							print ("-> " +  l_new_imgid + ": " + lst.item + "%N")
--							lst.forth
						end
					end
					ht.forth
				end
			end

			create rht.make (ht.count)
			from
				ht.start
			until
				ht.after
			loop
				lst := ht.item_for_iteration
				l_imgid := ht.key_for_iteration
				rht.put (ht.key_for_iteration, lst.first)
				ht.forth
			end

			Result := rht
		end

	initialize_tool
		do
			Precursor
		end

	target_directory (a_base_dir: STRING): STRING
		do
			Result := a_base_dir + "__export_batch"
		end

end
