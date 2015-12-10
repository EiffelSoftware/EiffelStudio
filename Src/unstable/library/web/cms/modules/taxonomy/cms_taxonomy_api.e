note
	description: "[
				API to handle taxonomy vocabularies and terms.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor

				-- Create the node storage for type blog
			if attached storage.as_sql_storage as l_storage_sql then
				create {CMS_TAXONOMY_STORAGE_SQL} taxonomy_storage.make (l_storage_sql)
			else
				create {CMS_TAXONOMY_STORAGE_NULL} taxonomy_storage.make
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	taxonomy_storage: CMS_TAXONOMY_STORAGE_I

feature -- Access node

	vocabulary_count: INTEGER_64
			-- Number of vocabulary.
		do
			Result := taxonomy_storage.vocabulary_count
		end

	vocabularies (a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_VOCABULARY_COLLECTION
			-- List of vocabularies ordered by weight and limited by limit and offset.
		do
			Result := taxonomy_storage.vocabularies (a_limit, a_offset)
		end

	vocabulary (a_id: INTEGER_64): detachable CMS_VOCABULARY
			-- Vocabulary associated with id `a_id'.
		require
			valid_id: a_id > 0
		do
			Result := taxonomy_storage.vocabulary (a_id)
		end

	vocabularies_for_type (a_type_name: READABLE_STRING_GENERAL): detachable CMS_VOCABULARY_COLLECTION
			-- Vocabularies associated with content type `a_type_name'.
		do
			Result := taxonomy_storage.vocabularies_for_type (a_type_name)
		end

	types_associated_with_vocabulary (a_vocab: CMS_VOCABULARY): detachable LIST [READABLE_STRING_32]
			-- Type names associated with `a_vocab'.
		do
			Result := taxonomy_storage.types_associated_with_vocabulary (a_vocab)
		end

	vocabularies_for_term (a_term: CMS_TERM): detachable CMS_VOCABULARY_COLLECTION
			-- Vocabularies including `a_term'.
		do
			Result := taxonomy_storage.vocabularies_for_term (a_term)
		end

	is_term_inside_vocabulary (a_term: CMS_TERM; a_vocab: CMS_VOCABULARY): BOOLEAN
			-- Is `a_term' inside `a_vocab' ?
		require
			valid_term: a_term.has_id
			valid_vocabulary: a_vocab.has_id
		do
			Result := taxonomy_storage.is_term_inside_vocabulary (a_term, a_vocab)
		end

	fill_vocabularies_with_terms (a_vocab: CMS_VOCABULARY)
			-- Fill `a_vocab' with associated terms.
		do
			reset_error
			a_vocab.terms.wipe_out
			if attached terms (a_vocab, 0, 0) as lst then
				across
					lst as ic
				loop
					a_vocab.extend (ic.item)
				end
			end
		end

	term_count_from_vocabulary (a_vocab: CMS_VOCABULARY): INTEGER_64
			-- Number of terms from vocabulary `a_vocab'.
		require
			has_id: a_vocab.has_id
		do
			Result := taxonomy_storage.term_count_from_vocabulary (a_vocab)
		end

	terms_of_entity (a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM_COLLECTION
			-- Terms related to `(a_type_name,a_entity)', and if `a_vocabulary' is set
			-- constrain to be part of `a_vocabulary'.
		do
			Result := taxonomy_storage.terms_of_entity (a_type_name, a_entity, a_vocabulary)
		end

	terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_TERM_COLLECTION
			-- List of terms ordered by weight and limited by limit and offset.
		require
			has_id: a_vocab.has_id
		do
			Result := taxonomy_storage.terms (a_vocab, a_limit, a_offset)
		end

	term_by_id (a_tid: INTEGER_64): detachable CMS_TERM
		do
			Result := taxonomy_storage.term_by_id (a_tid)
		end

	term_by_text (a_term_text: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM
			-- Term with text `a_term_text', included in vocabulary `a_vocabulary' if provided.
		do
			Result := taxonomy_storage.term_by_text (a_term_text, a_vocabulary)
		end

	entities_associated_with_term (a_term: CMS_TERM): detachable LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
			-- Entities and related typename associated with `a_term'.
		require
			a_term_exists: a_term.has_id
		do
			Result := taxonomy_storage.entities_associated_with_term (a_term)
		end

feature -- Write

	save_vocabulary (a_voc: CMS_VOCABULARY)
			-- Insert or update vocabulary `a_voc'
			-- and also save {CMS_VOCABULARY}.terms if `a_with_terms' is True.	
		do
			reset_error
			taxonomy_storage.save_vocabulary (a_voc, False)
			error_handler.append (taxonomy_storage.error_handler)
		end

	save_vocabulary_and_terms (a_voc: CMS_VOCABULARY)
			-- Insert or update vocabulary `a_voc'
			-- and also save {CMS_VOCABULARY}.terms.	
		do
			reset_error
			taxonomy_storage.save_vocabulary (a_voc, True)
			error_handler.append (taxonomy_storage.error_handler)
		end

	save_term (a_term: CMS_TERM; voc: detachable CMS_VOCABULARY)
			-- Save `a_term' inside `voc' if set.
		do
			reset_error
			taxonomy_storage.save_term (a_term, voc)
			error_handler.append (taxonomy_storage.error_handler)
		end

	remove_term_from_vocabulary (t: CMS_TERM; voc: CMS_VOCABULARY)
			-- Remove term `t' from vocabulary `voc'.
		do
			reset_error
			taxonomy_storage.remove_term_from_vocabulary (t, voc)
			error_handler.append (taxonomy_storage.error_handler)
		end

	associate_term_with_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Associate term `a_term' with `(a_type_name, a_entity)'.
		do
			reset_error
			taxonomy_storage.associate_term_with_entity (a_term, a_type_name, a_entity)
			error_handler.append (taxonomy_storage.error_handler)
		end

	unassociate_term_from_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Unassociate term `a_term' from `(a_type_name, a_entity)'.
		do
			reset_error
			taxonomy_storage.unassociate_term_from_entity (a_term, a_type_name, a_entity)
			error_handler.append (taxonomy_storage.error_handler)
		end

	associate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Associate vocabulary `a_voc' with type `a_type_name'.
		require
			existing_term: a_voc.has_id
		do
			reset_error
			taxonomy_storage.associate_vocabulary_with_type (a_voc, a_type_name)
			error_handler.append (taxonomy_storage.error_handler)
		end

	unassociate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Un-associate vocabulary `a_voc' from type `a_type_name'.
		require
			existing_term: a_voc.has_id
		do
			reset_error
			taxonomy_storage.unassociate_vocabulary_with_type (a_voc, a_type_name)
			error_handler.append (taxonomy_storage.error_handler)
		end

feature -- Helpers

	splitted_string (s: READABLE_STRING_32; sep: CHARACTER): LIST [READABLE_STRING_32]
			-- Splitted string from `s' with separator `sep', and support '"..."' wrapping.
		local
			i,j,n,b: INTEGER
			t: STRING_32
		do
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (1)
			Result.compare_objects
			from
				i := 1
				b := 1
				n := s.count
				create t.make_empty
			until
				i > n
			loop
				if s[i].is_space then
					if not t.is_empty then
						t.append_character (s[i])
					end
				elseif s[i] = sep then
					t.left_adjust
					t.right_adjust
					if t.count > 2 and t.starts_with_general ("%"") and t.ends_with_general ("%"") then
						t.remove_head (1)
						t.remove_tail (1)
					end
					Result.force (t)
					create t.make_empty
				elseif s[i] = '"' then
					j := s.index_of ('"', i + 1)
					if j > 0 then
						t.append (s.substring (i, j))
					end
					i := j
				else
					t.append_character (s[i])
				end
				i := i + 1
			end
			if not t.is_empty then
				t.left_adjust
				t.right_adjust
				Result.force (t)
			end
		end

end
