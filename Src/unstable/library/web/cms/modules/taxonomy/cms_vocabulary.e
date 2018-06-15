note
	description: "[
			Taxonomy vocabulary.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_VOCABULARY

inherit
	CMS_TERM
		rename
			text as name,
			set_text as set_name
		redefine
			make
		end

	ITERABLE [CMS_TERM]
		undefine
			is_equal
		end

create
	make,
	make_with_id,
	make_from_term,
	make_none

feature {NONE} -- Initialization

	make_none
		do
			make ("")
		end

	make (a_name: READABLE_STRING_GENERAL)
		do
			Precursor (a_name)
			create terms.make (0)
		end

	make_from_term (a_term: CMS_TERM)
		do
			make_with_id (a_term.id,  a_term.text)
			description := a_term.description
			set_weight (a_term.weight)
		end

feature -- Access

	count: INTEGER
		do
			Result := terms.count
		end

	terms: CMS_TERM_COLLECTION
			-- Collection of terms.

	new_cursor: INDEXABLE_ITERATION_CURSOR [CMS_TERM]
			-- <Precursor>
		do
			Result := terms.new_cursor
		end

feature -- Status report

	associated_content_type: detachable READABLE_STRING_GENERAL
			-- Associated content type, if any.

	is_tags: BOOLEAN
			-- New terms accepted (as tags), in the context of `associated_content_type'?

	multiple_terms_allowed: BOOLEAN
			-- Accepts multiple terms, in the context of `associated_content_type'?

	is_term_required: BOOLEAN
			-- At least one term is required, in the context of `associated_content_type'?

feature -- Element change

	set_is_tags (b: BOOLEAN)
			-- Set `is_tags' to `b'.
		do
			is_tags := b
		end

	allow_multiple_term (b: BOOLEAN)
			-- Set `multiple_terms_allowed' to `b'.
		do
			multiple_terms_allowed := b
		end

	set_is_term_required (b: BOOLEAN)
			-- Set `is_term_required' to `b'.
		do
			is_term_required := b
		end

	set_associated_content_type (a_type: detachable READABLE_STRING_GENERAL; a_is_tags, a_multiple, a_is_required: BOOLEAN)
			-- If `a_type' is set, define `associated_content_type' and related options,
			-- otherwise reset `associated_content_type'.
		do
			if a_type = Void then
				associated_content_type := Void
				set_is_tags (False)
				allow_multiple_term (False)
				set_is_term_required (False)
			else
				associated_content_type := a_type
				set_is_tags (a_is_tags)
				allow_multiple_term (a_multiple)
				set_is_term_required (a_is_required)
			end
		end

feature -- Element change

	force, extend (a_term: CMS_TERM)
			-- Add `a_term' to the vocabulary terms `terms'.
		do
			terms.force (a_term)
		end

	wipe_out
		do
			terms.wipe_out
		end

	sort
			--  Sort `items'
		do
			terms.sort
		end

end

