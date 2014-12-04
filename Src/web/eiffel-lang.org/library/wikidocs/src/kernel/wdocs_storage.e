note
	description: "Summary description for {WDOCS_STORAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_STORAGE

feature -- Access

	book_names: ITERABLE [READABLE_STRING_32]
			-- Available book names.
		deferred
		end

	book (a_bookid: READABLE_STRING_GENERAL): detachable WIKI_BOOK
			-- Book named `a_bookid' if any.
		deferred
		end

	page (a_bookid: READABLE_STRING_GENERAL; a_bookpage: detachable READABLE_STRING_GENERAL): detachable like new_page
			-- Wiki page for book `a_bookid', and if provided title `a_bookpage', otherwise the root page of related wiki book.
		deferred
		end

	page_by_title (a_page_title: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Wiki page with title `a_page_title', and in book related to `a_bookid' if provided.
		deferred
		end

	page_by_uuid (a_page_uuid: READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Wiki page associated to UUID `a_page_uuid'.
		deferred
		end

	metadata (a_source: PATH; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		deferred
		ensure
			result_attached_implies_exists: Result /= Void implies (
						(not attached {WDOCS_METADATA_FILE} Result as en_mdf or else en_mdf.exists)
					or
						(not attached {WDOCS_METADATA_WIKI} Result as en_mdw or else en_mdw.exists)
					)
		end

	page_metadata (pg: WIKI_PAGE; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		deferred
		ensure
			result_attached_implies_exists: Result /= Void implies not attached {WDOCS_METADATA_FILE} Result as mdf or else mdf.exists
		end

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		deferred
		end

	images_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki image path indexed by title for each book.
		deferred
		end

	templates_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki template path indexed by title for each book.
		deferred
		end

	template_content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Text content for template `a_template' in the context of `a_page' if precised.
		deferred
		end

	wiki_text (p: WIKI_PAGE): detachable READABLE_STRING_8
		deferred
		end

feature -- Factory

	new_page (a_title: READABLE_STRING_8; a_parent_key: READABLE_STRING_8): WIKI_BOOK_PAGE
			-- Instantiate a new wiki page with title `a_title' and a parent key `a_parent_key'.
		deferred
		end

feature -- Basic operations

	reload
		deferred
		end

	refresh
		deferred
		end

feature -- Persistency

	save_image_path (a_path: PATH; a_image_name: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL)
		deferred
		end

end
