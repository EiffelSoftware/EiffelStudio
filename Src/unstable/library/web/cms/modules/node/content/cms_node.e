note
	description: "[
			CMS abstraction for CMS content entity, named "node".
		]"
	status: "draft"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE

inherit

	REFACTORING_HELPER

--create
--	make,
--	make_empty

feature{NONE} -- Initialization

	make_empty
			-- Create empty node.
		do
			make ({STRING_32} "")
		end

	make (a_title: READABLE_STRING_32)
			-- Create current node with `a_title'.
		local
			l_time: DATE_TIME
		do
			create l_time.make_now_utc
			set_title (a_title)
			set_creation_date (l_time)
			set_modification_date (l_time)
			set_publication_date (l_time)

			debug ("refactor_fixme")
				fixme ("Remove default harcoded format")
			end
		ensure
			title_set: title = a_title
		end

feature -- Conversion

	import_node (a_node: CMS_NODE)
			-- Import `a_node' into current node.
		do
			set_id (a_node.id)
			set_revision (a_node.revision)
			set_title (a_node.title)
			set_creation_date (a_node.creation_date)
			set_modification_date (a_node.modification_date)
			set_publication_date (a_node.publication_date)
			set_author (a_node.author)
			set_content (
						a_node.content,
						a_node.summary,
						a_node.format
					)
		end

feature -- Access

	id: INTEGER_64 assign set_id
			-- Unique id.
			--| Should we use NATURAL_64 instead?

	revision: INTEGER_64 assign set_revision
			-- Revision value.
			--| Note: for now version is not supported.

	content_type: READABLE_STRING_8
			-- Associated content type name.
			-- Page, Article, Blog, News, etc.
		deferred
		end

feature -- Access		

	title: READABLE_STRING_32
			-- Full title of the node.
			-- Required!

	summary: detachable READABLE_STRING_8
			-- A short summary of the node.
		deferred
		end

	content: detachable READABLE_STRING_8
			-- Content of the node.
		deferred
		end

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc
		deferred
		end

feature -- Access: date			

	modification_date: DATE_TIME
			-- When the node was updated.

	creation_date: DATE_TIME
			-- When the node was created.

	publication_date: DATE_TIME
			-- When the node was published.

	publication_date_output: READABLE_STRING_32
			-- Formatted output.

feature -- Access: author			

	author: detachable CMS_USER
			-- Author of current node.

feature -- status report

	has_id: BOOLEAN
			-- Has unique identifier?
		do
			Result := id > 0
		end

	same_node (a_node: CMS_NODE): BOOLEAN
			-- Is `a_node' same node as Current?
		do
				-- FIXME: if we introduce notion of revision, update this part!
			Result := Current = a_node or id = a_node.id
		ensure
			valid_result: Result implies a_node.id = id
		end

	is_typed_as (a_content_type: READABLE_STRING_GENERAL): BOOLEAN
			-- Is current node of type `a_content_type' ?
		do
			Result := a_content_type.is_case_insensitive_equal (content_type)
		end

feature -- Element change

	set_content (a_content: like content; a_summary: like summary; a_format: like format)
			-- Set `content', `summary' and `format' to `a_content', `a_summary' and `a_format'.
			-- The `format' is associated with both `content' and `summary'
		deferred
		ensure
			content_assigned: content = a_content
			summary_assigned: summary = a_summary
			format_assigned: format = a_format
		end

	set_title (a_title: like title)
			-- Assign `title' with `a_title'.
		do
			title := a_title
		ensure
			title_assigned: title = a_title
		end

	set_modification_date (a_modification_date: like modification_date)
			-- Assign `modification_date' with `a_modification_date'.
		do
			modification_date := a_modification_date
		ensure
			modification_date_assigned: modification_date = a_modification_date
		end

	set_creation_date (a_creation_date: like creation_date)
			-- Assign `creation_date' with `a_creation_date'.
		do
			creation_date := a_creation_date
		ensure
			creation_date_assigned: creation_date = a_creation_date
		end

	set_publication_date (a_publication_date: like publication_date)
			-- Assign `publication_date' with `a_publication_date'.
		do
			publication_date := a_publication_date
			publication_date_output := publication_date.formatted_out ("yyyy/[0]mm/[0]dd")
		ensure
			publication_date_assigned: publication_date = a_publication_date
		end

	set_id (a_id: like id)
			-- Assign `id' with `a_id'.
		do
			id := a_id
		ensure
			id_assigned: id = a_id
		end

	set_revision (a_revision: like revision)
			-- Assign `revision' with `a_revision'.
		do
			revision := a_revision
		ensure
			revision_assigned: revision = a_revision
		end

	set_author (u: like author)
			-- Assign 'author' with `u'
		do
			author := u
		ensure
			auther_set: author = u
		end

note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
