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
			link_to_wiki_url,
			image_to_url,
			image_to_wiki_url,
			page_by_title
		end

create
	make

feature -- Access

	current_book_name: detachable READABLE_STRING_GENERAL

	server_url: detachable IMMUTABLE_STRING_8

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

end
