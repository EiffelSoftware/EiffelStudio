note
	description: "[
			Interface for accessing taxonomy data from storage.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_TAXONOMY_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

	vocabulary_count: INTEGER_64
			-- Count of vocabularies.
		deferred
		end

	vocabularies (a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_VOCABULARY_COLLECTION
			-- List of vocabularies ordered by weight from `a_offset' to `a_offset + a_limit'.
		deferred
		end

	vocabulary (a_id: INTEGER_64): detachable CMS_VOCABULARY
			-- Vocabulary by id `a_id'.
		require
			valid_id: a_id > 0
		deferred
		end

	vocabularies_for_type (a_type_name: READABLE_STRING_GENERAL): detachable CMS_VOCABULARY_COLLECTION
			-- Vocabularies associated with content type `a_type_name'.
		require
			valid_type_name: not a_type_name.is_whitespace
		deferred
		end

	vocabularies_for_term (a_term: CMS_TERM): detachable CMS_VOCABULARY_COLLECTION
			-- Vocabularies including `a_term'.
		deferred
		end

	is_term_inside_vocabulary (a_term: CMS_TERM; a_vocab: CMS_VOCABULARY): BOOLEAN
			-- Is `a_term' inside `a_vocab' ?
		require
			valid_term: a_term.has_id
			valid_vocabulary: a_vocab.has_id
		deferred
		end

	types_associated_with_vocabulary (a_vocab: CMS_VOCABULARY): detachable LIST [READABLE_STRING_32]
			-- Type names associated with `a_vocab'.
		deferred
		end

	terms_count: INTEGER_64
			-- Number of terms.
		deferred
		end

	term_by_id (tid: INTEGER_64): detachable CMS_TERM
			-- Term associated with id `tid'.
		deferred
		ensure
			Result /= Void implies Result.id = tid
		end

	term_by_text (a_term_text: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM
			-- Term with text `a_term_text', included in vocabulary `a_vocabulary' if provided.
		deferred
		ensure
			Result /= Void implies a_term_text.same_string (Result.text)
		end

	term_count_from_vocabulary (a_vocab: CMS_VOCABULARY): INTEGER_64
			-- Number of terms from vocabulary `a_vocab'.
		require
			has_id: a_vocab.has_id
		deferred
		end

	terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_TERM_COLLECTION
			-- List of terms from vocabulary `a_vocab' ordered by weight from `a_offset' to `a_offset + a_limit'.
		require
			has_id: a_vocab.has_id
		deferred
		end

	cloud_of_terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): ARRAYED_LIST [TUPLE [term: CMS_TERM; occurrences: NATURAL_64]]
			-- List of terms from vocabulary `a_vocab' ordered by number of usages from `a_offset' to `a_offset + a_limit'.
		require
			has_id: a_vocab.has_id
		deferred
		end

	terms_of_entity (a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM_COLLECTION
			-- Terms related to `(a_type_name,a_entity)', and if `a_vocabulary' is set
			-- constrain to be part of `a_vocabulary'.			
		deferred
		end

	entities_associated_with_term (a_term: CMS_TERM): detachable LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
			-- Entities and related typename associated with `a_term'.
		require
			a_term_exists: a_term.has_id
		deferred
		end

feature -- Store

	save_vocabulary (a_voc: CMS_VOCABULARY; a_with_terms: BOOLEAN)
			-- Insert or update vocabulary `a_voc'
			-- and also save {CMS_VOCABULARY}.terms if `a_with_terms' is True.
		deferred
		ensure
			not error_handler.has_error implies a_voc.has_id and then vocabulary (a_voc.id) /= Void
		end

	save_term (t: CMS_TERM; voc: detachable CMS_VOCABULARY)
			-- Insert or update term `t' as part of vocabulary `voc' if set.
		deferred
		ensure
			not error_handler.has_error implies t.has_id and then term_by_id (t.id) /= Void
		end

	remove_term_from_vocabulary (t: CMS_TERM; voc: CMS_VOCABULARY)
			-- Remove term `t' from vocabulary `voc'.
		require
			t_has_id: t.has_id
		deferred
		end

	associate_term_with_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Associate term `a_term' with `(a_type_name, a_entity)'.
		require
			existing_term: a_term.has_id
		deferred
		end

	unassociate_term_from_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Unassociate term `a_term' from `(a_type_name, a_entity)'.
		require
			existing_term: a_term.has_id
		deferred
		end

	associate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Associate vocabulary `a_voc' with type `a_type_name'.
		require
			existing_term: a_voc.has_id
		deferred
		end

	unassociate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Un-associate vocabulary `a_voc' from type `a_type_name'.
		require
			existing_term: a_voc.has_id
		deferred
		end

end
