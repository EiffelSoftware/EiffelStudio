note
	description: "Summary description for {CMS_TAXONOMY_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_STORAGE_NULL

inherit
	CMS_TAXONOMY_STORAGE_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create error_handler.make
		end

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.	

feature -- Access

	vocabulary_count: INTEGER_64
			-- Count of vocabularies.
		do
		end

	term_count_from_vocabulary (a_vocab: CMS_VOCABULARY): INTEGER_64
			-- Number of terms from vocabulary `a_vocab'.
		do
		end

	vocabularies (a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_VOCABULARY_COLLECTION
			-- List of vocabularies ordered by weight from `a_offset' to `a_offset + a_limit'.
		do
			create Result.make (0)
		end

	vocabulary (a_id: INTEGER_64): detachable CMS_VOCABULARY
			-- Vocabulary by id `a_id'.
		do
		end

	vocabularies_for_type (a_type_name: READABLE_STRING_GENERAL): detachable CMS_VOCABULARY_COLLECTION
			-- <Precursor>
		do
		end

	vocabularies_for_term (a_term: CMS_TERM): detachable CMS_VOCABULARY_COLLECTION
			-- <Precursor>
		do
		end

	is_term_inside_vocabulary (a_term: CMS_TERM; a_vocab: CMS_VOCABULARY): BOOLEAN
			-- <Precursor>
		do
		end

	types_associated_with_vocabulary (a_vocab: CMS_VOCABULARY): detachable LIST [READABLE_STRING_32]
			-- <Precursor>
		do
		end

	terms_count: INTEGER_64
			-- Number of terms.
		do
		end

	term_by_id (tid: INTEGER_64): detachable CMS_TERM
			-- Term associated with id `tid'.
		do
		end

	term_by_text (a_term_text: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM
		do
		end

	terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_TERM_COLLECTION
			-- List of terms from vocabulary `a_vocab' ordered by weight from `a_offset' to `a_offset + a_limit'.
		do
			create Result.make (0)
		end

	cloud_of_terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): ARRAYED_LIST [TUPLE [term: CMS_TERM; occurrences: NATURAL_64]]
			-- List of terms from vocabulary `a_vocab' ordered by weight from `a_offset' to `a_offset + a_limit'.
		do
			create Result.make (0)
		end

	terms_of_entity (a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM_COLLECTION
			-- Terms related to `(a_type_name,a_entity)'.
		do
		end

	entities_associated_with_term (a_term: CMS_TERM): detachable LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
			-- Entities and related typename associated with `a_term'.
		do
		end

feature -- Store

	save_vocabulary (a_voc: CMS_VOCABULARY; a_with_terms: BOOLEAN)
			-- Insert or update vocabulary `a_voc'
			-- and also save {CMS_VOCABULARY}.terms if `a_with_terms' is True.
		do
			error_handler.add_custom_error (-1, "not implemented", "save_vocabulary")
		end

	save_term (t: CMS_TERM; voc: detachable CMS_VOCABULARY)
			-- <Precursor>
		do
			error_handler.add_custom_error (-1, "not implemented", "save_term")
		end

	remove_term_from_vocabulary (t: CMS_TERM; voc: CMS_VOCABULARY)
			-- Remove term `t' from vocabulary `voc'.
		do
			error_handler.add_custom_error (-1, "not implemented", "remove_term_from_vocabulary")
		end

	associate_term_with_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
		do
			error_handler.add_custom_error (-1, "not implemented", "associate_term_with_entity")
		end

	unassociate_term_from_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
		do
			error_handler.add_custom_error (-1, "not implemented", "unassociate_term_from_entity")
		end

	associate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Associate vocabulary `a_voc' with type `a_type_name'.
		do
			error_handler.add_custom_error (-1, "not implemented", "associate_vocabulary_with_type")
		end

	unassociate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Un-associate vocabulary `a_voc' from type `a_type_name'.
		do
			error_handler.add_custom_error (-1, "not implemented", "unassociate_vocabulary_with_type")
		end

end
