note
	description: "Summary description for {WDOCS_EDIT_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_MANAGER

inherit
	WDOCS_MANAGER
		redefine
			initialize,
			link_to_wiki_url,
			image_to_url,
			image_to_wiki_url,
			page_by_title
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor/>.
		do
			create error_handler.make
			Precursor
		end

feature -- Access

	current_book_name: detachable READABLE_STRING_GENERAL

	server_url: detachable IMMUTABLE_STRING_8

feature -- Error management

	error_handler: ERROR_HANDLER
			-- Error handler.

feature -- Query

	page_by_title (a_page_title: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Wiki page with title `a_page_title', and in book related to `a_bookid' if provided.
		do
			if a_bookid = Void and attached current_book_name as bn then
				Result := Precursor (a_page_title, bn)
				if Result = Void then
					Result := Precursor (a_page_title, a_bookid)
				end
			end
			if Result = Void then
				Result := Precursor (a_page_title, a_bookid)
			end
		end

feature -- Element change

	set_edited_page (wp: detachable WIKI_PAGE)
		do
			set_current_book_name (Void)
			if wp /= Void then
				set_current_book_name (book_name (wp))
			else
				set_current_book_name (Void)
			end
		end

	set_current_book_name (n: like current_book_name)
		do
			current_book_name := n
		end

	set_server_url (a_url: detachable READABLE_STRING_8)
		do
			if a_url = Void then
				server_url := Void
			else
				create server_url.make_from_string (a_url)
			end
		end

feature -- Access: link

	page_url (a_page: WIKI_PAGE): detachable STRING
		do
			Result := link_to_wiki_url (create {WIKI_LINK}.make ("[["+ a_page.title +"]]"), a_page)
		end

	link_to_wiki_url (a_link: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		do
			Result := Precursor (a_link, a_page)
			if
				Result /= Void and then
				attached server_url as l_server_url
			then
				Result.prepend (l_server_url)
			end
		end

feature -- Access: Image

	image_to_wiki_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		do
			Result := Precursor (a_link, a_page)
			if
				Result /= Void and then
				attached server_url as l_server_url
			then
				Result.prepend (l_server_url)
			end
		end

	image_to_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		do
			Result := Precursor (a_link, a_page)
			if
				Result /= Void and then
				attached server_url as l_server_url
			then
				Result.prepend (l_server_url)
			end
		end

feature -- Basic operation		

	save_wiki_text (p: WIKI_PAGE; a_text: READABLE_STRING_8)
		require
			path_set: p.path /= Void
		local
			f: RAW_FILE
		do
			if attached p.path as l_path then
				create f.make_with_path (l_path)
				if f.exists then
					backup_file (f)
				end
				save_content_to_file (a_text, f.path)
			end
		end

	create_page_under (a_parent: WIKI_PAGE; a_title: READABLE_STRING_8)
		require
			parent_path_set: a_parent.path /= Void
		local
			wp: WIKI_PAGE
			l_target_folder_path: PATH
			d: DIRECTORY
		do
			create wp.make (a_title, a_parent.key)
			if attached a_parent.path as l_parent_path then
				l_target_folder_path := wiki_folder_path (a_parent)
				create d.make_with_path (l_target_folder_path)
				if not d.exists then
					d.recursive_create_dir
				end
				wp.set_path (l_target_folder_path.extended (a_title).appended_with_extension ("wiki"))
				save_wiki_text (wp, "")
				a_parent.extend (wp)
				to_implement ("Smart data update")
				refresh_data
			end
		end

	delete_page (a_page: WIKI_PAGE)
		require
			page_path_set: a_page.path /= Void
		local
			d: DIRECTORY
		do
			if a_page.has_page then
				error_handler.add_custom_error (-1, "page has sub page", "Page has sub page, can not delete it!")
			elseif attached a_page.path as l_path then
				delete_file (l_path)
				delete_file (md_path (a_page))

				create d.make_with_path (wiki_folder_path (a_page))
				if d.exists and d.is_empty then
					delete_folder (d.path)
				end
				to_implement ("Smart data update")
				refresh_data
			end
		end

	change_page_title (a_page: WIKI_PAGE; a_new_title: READABLE_STRING_GENERAL)
		require
			page_path_set: a_page.path /= Void
		local
			p: PATH
			ut: FILE_UTILITIES
		do
			if attached a_page.path as l_path then
				move_file_to (l_path, l_path.parent.extended (a_new_title).appended_with_extension ("wiki"))
				p := md_path (a_page)
				if ut.file_path_exists (p) then
					move_file_to (p, p.parent.extended (a_new_title).appended_with_extension ("md"))
				end
				to_implement ("Smart data update")
				refresh_data
			end
		end

	move_page (a_page: WIKI_PAGE; a_target_parent: WIKI_PAGE)
		require
			page_path_set: a_page.path /= Void
		local
			l_target_folder_path: PATH
			p: PATH
			ut: FILE_UTILITIES
		do
			if attached a_target_parent.path as l_target_page_path then
				l_target_folder_path := l_target_page_path.parent
				if attached a_page.path as l_page_path then
					move_file_to (l_page_path, l_target_folder_path.extended (a_page.title).appended_with_extension ("wiki"))
					p := md_path (a_page)
					if ut.file_path_exists (p) then
						move_file_to (p, l_target_folder_path.extended (a_page.title).appended_with_extension ("md"))
					end
					a_target_parent.extend (a_page)
					to_implement ("Smart data update")
					refresh_data
				end
			end
		end

feature {NONE} -- Implementation: File system

	wiki_folder_path (a_page: WIKI_PAGE): PATH
		require
			path_set: a_page.path /= Void
		local
			l_name: STRING_32
		do
			if attached a_page.path as l_path then
				if a_page.is_index_page then
					Result := l_path.parent
				else
					l_name := l_path.name
					if attached l_path.extension as ext then
						l_name.remove_tail (ext.count + 1)
					end
					create Result.make_from_string (l_name)
				end
			else
				create Result.make_from_string (a_page.title)
			end
		end

	md_path (a_page: WIKI_PAGE): PATH
		require
			path_set: a_page.path /= Void
		local
			l_name: STRING_32
		do
			if attached a_page.path as l_path then
				l_name := l_path.name
				if attached l_path.extension as ext then
					l_name.remove_tail (ext.count + 1)
				end
				create Result.make_from_string (l_name)
			else
				create Result.make_from_string (a_page.title)
			end
			Result := Result.appended_with_extension ("md")
		end

	delete_file (a_path: PATH)
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (a_path)
				if f.exists and then f.is_access_writable then
					f.delete
				end
			else
				error_handler.add_custom_error (-1, "error:delete_file", {STRING_32} "Error: could not delete %"" + a_path.name + "%".")
			end
		rescue
			retried := True
			retry
		end

	delete_folder (a_path: PATH)
		local
			d: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create d.make_with_path (a_path)
				if d.exists and then d.is_writable then
					d.recursive_delete
				end
			else
				error_handler.add_custom_error (-1, "error:delete_folder", {STRING_32} "Error: could not delete %"" + a_path.name + "%".")
			end
		rescue
			retried := True
			retry
		end

	move_file_to (a_origin, a_target: PATH)
		local
			f1: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f1.make_with_path (a_origin)
				if f1.exists and then f1.is_readable then
					f1.rename_path (a_target)
				end
			else
				error_handler.add_custom_error (-1, "error:move_file_to", {STRING_32} "Error: could not move %"" + a_origin.name + "%" to %"" + a_target.name + "%".")
			end
		rescue
			retried := True
			retry
		end


end
