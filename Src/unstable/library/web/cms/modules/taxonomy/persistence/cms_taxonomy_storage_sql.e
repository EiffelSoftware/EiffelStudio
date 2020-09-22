note
	description: "[
				Implementation of taxonomy storage using a SQL database.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_STORAGE_SQL

inherit
	CMS_TAXONOMY_STORAGE_I

	CMS_PROXY_STORAGE_SQL

create
	make

feature -- Access

	vocabulary_count: INTEGER_64
			-- Count of vocabularies.
		do
			error_handler.reset
			sql_query (sql_select_vocabularies_count, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (sql_select_vocabularies_count)
		end

	vocabularies (a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_VOCABULARY_COLLECTION
			-- List of vocabularies ordered by weight from `a_offset' to `a_offset + a_limit'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create Result.make (0)
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (0, "parent_tid")
			from
				sql_query (sql_select_terms, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_term as l_term then
					Result.force (create {CMS_VOCABULARY}.make_from_term (l_term))
				end
				sql_forth
			end
			sql_finalize_query (sql_select_terms)
		end

	vocabulary (a_tid: INTEGER_64): detachable CMS_VOCABULARY
			-- Vocabulary by id `a_tid'.
		do
			if attached term_by_id (a_tid) as t then
				create Result.make_from_term (t)
			end
		end

	term_count_from_vocabulary (a_vocab: CMS_VOCABULARY): INTEGER_64
			-- Number of terms from vocabulary `a_vocab'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_vocab.id, "parent_tid")
			sql_query (sql_select_vocabulary_terms_count, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (sql_select_vocabulary_terms_count)
		end

	terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_TERM_COLLECTION
			-- List of terms from vocabulary `a_vocab' ordered by weight from `a_offset' to `a_offset + a_limit'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create Result.make (0)
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_vocab.id, "parent_tid")
--			l_parameters.put (a_limit, "limit")
--			l_parameters.put (a_offset, "offset")
			from
				sql_query (sql_select_terms, l_parameters)
--				sql_query (sql_select_terms_with_range, l_parameters)			
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_term as l_term then
					Result.force (l_term)
				end
				sql_forth
			end
			sql_finalize_query (sql_select_terms)
--			sql_finalize_query (sql_select_terms_with_range)
		end

	cloud_of_terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): ARRAYED_LIST [TUPLE [term: CMS_TERM; occurrences: NATURAL_64]]
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_sql: like sql_select_cloud_of_terms
		do
			create Result.make (0)
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_vocab.id, "parent_tid")
			if a_limit > 0 then
				l_sql := sql_select_cloud_of_terms
				l_parameters.put (a_limit, "limit")
				l_parameters.put (a_offset, "offset")
			else
				l_sql := sql_select_cloud_of_all_terms
			end
			from
				sql_query (l_sql, l_parameters)
				sql_start
			until
				sql_after or has_error
			loop
				if attached fetch_term as l_term then
					if attached sql_read_natural_64 (5) as l_count then
						Result.force ([l_term, l_count])
					end
				end
				sql_forth
			end
			sql_finalize_query (l_sql)
		end

	terms_count: INTEGER_64
			-- Number of terms.
		do
			error_handler.reset
			sql_query (sql_select_terms_count, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (sql_select_terms_count)
		end

	term_by_id (a_tid: INTEGER_64): detachable CMS_TERM
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (1)
			l_parameters.put (a_tid, "tid")
			sql_query (sql_select_term, l_parameters)
			sql_start
			if not has_error and not sql_after then
				Result := fetch_term
			end
			sql_finalize_query (sql_select_term)
		end

	term_by_text (a_term_text: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (1)
			l_parameters.put (a_term_text, "text")
			if a_vocabulary /= Void then
				l_parameters.put (a_vocabulary.id, "parent_tid")
				sql_query (sql_select_vocabulary_term_by_text, l_parameters)
			else
				sql_query (sql_select_term_by_text, l_parameters)
			end
			sql_start
			if not has_error and not sql_after then
				Result := fetch_term
			end
			if a_vocabulary /= Void then
				sql_finalize_query (sql_select_vocabulary_term_by_text)
			else
				sql_finalize_query (sql_select_term_by_text)
			end
		end

	terms_of_entity (a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM_COLLECTION
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_tids: ARRAYED_LIST [INTEGER_64]
			tid: INTEGER_64
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_type_name, "type")
			l_parameters.put (a_entity , "entity")
			if a_vocabulary /= Void then
				l_parameters.put (a_vocabulary.id , "parent_tid")
				sql_query (sql_select_vocabulary_terms_of_entity, l_parameters)
			else
				sql_query (sql_select_terms_of_entity, l_parameters)
			end

			create l_tids.make (0)
			from
				sql_start
			until
				sql_after or has_error
			loop
				tid := sql_read_integer_64 (1)
				if tid > 0 then
					l_tids.force (tid)
				end
				sql_forth
			end
			if a_vocabulary /= Void then
				sql_finalize_query (sql_select_vocabulary_terms_of_entity)
			else
				sql_finalize_query (sql_select_terms_of_entity)
			end
			if not l_tids.is_empty then
				create Result.make (l_tids.count)
				across
					l_tids as ic
				loop
					if
						ic.item > 0 and then
						attached term_by_id (ic.item) as t
					then
						Result.force (t)
					end
				end
			end
		end

	entities_associated_with_term (a_term: CMS_TERM): detachable LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
			-- Entities and related typename associated with `a_term'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_typename: detachable READABLE_STRING_32
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_term.id, "tid")
			sql_query (sql_select_entity_and_type_by_term, l_parameters)

			if not has_error then
				create {ARRAYED_LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]} Result.make (0)
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached sql_read_string_32 (1) as l_entity then
						l_typename := sql_read_string_32 (2)
						if l_typename /= Void and then l_typename.is_whitespace then
							l_typename := Void
						end
						Result.force ([l_entity, l_typename])
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_entity_and_type_by_term)
		end

feature -- Store

	save_vocabulary (voc: CMS_VOCABULARY; a_with_terms: BOOLEAN)
		local
			l_terms: CMS_TERM_COLLECTION
		do
			save_term (voc, create {CMS_VOCABULARY}.make_none)

			if a_with_terms then
				l_terms := terms (voc, 0, 0)
				across
					voc.terms as ic
				until
					has_error
				loop
					if attached l_terms.term_by_id (ic.item.id) as t then
							-- Already contained.
							-- Remove from `l_terms' to leave only terms to remove.
						l_terms.remove (t)
					else
						save_term (ic.item, voc)
					end
				end
				across
					l_terms as ic
				until
					has_error
				loop
					remove_term_from_vocabulary (ic.item, voc)
				end
			end
		end

	save_term (t: CMS_TERM; voc: detachable CMS_VOCABULARY)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_insert_voc: BOOLEAN
		do
			error_handler.reset

			create l_parameters.make (5)
			l_parameters.put (t.text, "text")
			l_parameters.put (t.description, "description")
			l_parameters.put (t.weight, "weight")

			l_insert_voc := voc /= Void and then is_term_inside_vocabulary (t, voc)

			sql_begin_transaction
			if t.has_id then
				l_parameters.put (t.id, "tid")
				sql_modify (sql_update_term, l_parameters)
				sql_finalize_modify (sql_update_term)
			else
				sql_insert (sql_insert_term, l_parameters)
				t.set_id (last_inserted_term_id)
				sql_finalize_insert (sql_insert_term)
			end
			if
				not has_error and
				voc /= Void and then
				not l_insert_voc
			then
				l_parameters.wipe_out
				l_parameters.put (t.id, "tid")
				if voc.has_id then
					l_parameters.put (voc.id, "parent_tid")
				else
					l_parameters.put (0, "parent_tid")
				end
				sql_insert (sql_insert_term_in_vocabulary, l_parameters)
				sql_finalize_insert (sql_insert_term_in_vocabulary)
			end
			if has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

	remove_term_from_vocabulary (t: CMS_TERM; voc: CMS_VOCABULARY)
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (t.id, "tid")
			l_parameters.put (voc.id, "parent_tid")
			sql_modify (sql_remove_term_from_vocabulary, l_parameters)
			sql_finalize_modify (sql_remove_term_from_vocabulary)
		end

	associate_term_with_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Associate term `a_term' with `(a_type_name, a_entity)'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_term.id, "tid")
			l_parameters.put (a_entity, "entity")
			l_parameters.put (a_type_name, "type")

			sql_insert (sql_insert_term_index, l_parameters)
			sql_finalize_insert (sql_insert_term_index)
		end

	unassociate_term_from_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Unassociate term `a_term' from `(a_type_name, a_entity)'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_term.id, "tid")
			l_parameters.put (a_entity, "entity")
			l_parameters.put (a_type_name, "type")

			sql_modify (sql_delete_term_index, l_parameters)
			sql_finalize_modify (sql_delete_term_index)
		end

feature -- Vocabulary and types

	mask_is_tags: INTEGER = 0b0001 -- 1
	mask_multiple_terms: INTEGER = 0b0010 -- 2
	mask_is_required: INTEGER = 0b0100 -- 4

	vocabularies_for_type (a_type_name: READABLE_STRING_GENERAL): detachable CMS_VOCABULARY_COLLECTION
			-- <Precursor>
			-- note: vocabularies are not filled with associated terms.
		local
			voc: detachable CMS_VOCABULARY
			l_parameters: STRING_TABLE [detachable ANY]
			l_data: ARRAYED_LIST [TUPLE [tid: INTEGER_64; entity: INTEGER_64]]
			tid, ent: INTEGER_64
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_type_name, "type")
			sql_query (sql_select_vocabularies_for_type, l_parameters)

			create l_data.make (0)
			from
				sql_start
			until
				sql_after or has_error
			loop
				tid := sql_read_integer_64 (1)
				if attached sql_read_string_32 (2) as s and then s.is_integer_64 then
					ent := s.to_integer_64
				else
					ent := 0
				end
				if ent > 0 then
						-- Vocabulary index should have 0 or negative value for `entity'!
					check zero_or_negative_entity_value: False end
				else
					ent := - ent
					if tid > 0 then
						l_data.force ([tid, ent])
					end
				end
				sql_forth
			end
			sql_finalize_query (sql_select_vocabularies_for_type)
			if not l_data.is_empty then
				create Result.make (l_data.count)
				across
					l_data as ic
				loop
					tid := ic.item.tid
					ent := ic.item.entity
					check ic.item.tid > 0 end

					if
						attached term_by_id (tid) as t
					then
						create voc.make_from_term (t)
							--| 1: mask 0001: New terms allowed (i.e tags)
							--| 2: mask 0010: Allow multiple tags
							--| 4: mask 0100: At least one tag is required
						voc.set_associated_content_type (a_type_name, ent & mask_is_tags = mask_is_tags, ent & mask_multiple_terms = mask_multiple_terms, ent & mask_is_required = mask_is_required)
						Result.force (voc)
					end
				end
			end
		end

	is_term_inside_vocabulary (a_term: CMS_TERM; a_voc: CMS_VOCABULARY): BOOLEAN
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (a_term.id, "tid")
			l_parameters.put (a_voc.id, "parent_tid")
			sql_query (sql_select_term_in_vocabulary, l_parameters)
			sql_start
			if not has_error or sql_after then
				Result := sql_read_integer_64 (1) > 0
			end
			sql_finalize_query (sql_select_term_in_vocabulary)
		end

	vocabularies_for_term (a_term: CMS_TERM): detachable CMS_VOCABULARY_COLLECTION
			-- <Precursor>
		local
			voc: detachable CMS_VOCABULARY
			l_parameters: STRING_TABLE [detachable ANY]
			l_parent_id: INTEGER_64
			l_ids: ARRAYED_LIST [INTEGER_64]
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_term.id, "tid")
			sql_query (sql_select_vocabularies_for_term, l_parameters)

			create l_ids.make (1)
			from
				sql_start
			until
				sql_after or has_error
			loop
				l_parent_id := sql_read_integer_64 (1)
				l_ids.force (l_parent_id)
				sql_forth
			end
			sql_finalize_query (sql_select_vocabularies_for_term)

			if l_ids.count > 0 then
				create Result.make (1)
				across
					l_ids as ic
				loop
					voc := vocabulary (ic.item)
					if voc /= Void then
						Result.force (voc)
					end
				end
				if Result.count = 0 then
					Result := Void
				end
			end
		end

	types_associated_with_vocabulary (a_vocab: CMS_VOCABULARY): detachable LIST [READABLE_STRING_32]
			-- Type names associated with `a_vocab'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (1)
			l_parameters.put (a_vocab.id, "tid")
			sql_query (sql_select_type_associated_with_vocabulary, l_parameters)

			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (3)
			from
				sql_start
			until
				sql_after or has_error
			loop
				if attached sql_read_string_32 (1) as l_typename then
					Result.force (l_typename)
				end
				sql_forth
			end
			sql_finalize_query (sql_select_type_associated_with_vocabulary)
		end

	associate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			i: INTEGER
		do
			error_handler.reset

			create l_parameters.make (3)
			l_parameters.put (a_voc.id, "tid")
			if a_voc.is_tags then
				i := i | mask_is_tags
			end
			if a_voc.is_term_required then
				i := i | mask_multiple_terms
			end
			if a_voc.multiple_terms_allowed then
				i := i | mask_is_required
			end
			l_parameters.put ((- i).out, "entity")
			l_parameters.put (a_type_name, "type")

			if
				attached vocabularies_for_type (a_type_name) as lst and then
				across lst as ic some a_voc.id = ic.item.id  end
			then
				sql_modify (sql_update_term_index, l_parameters)
				sql_finalize_modify (sql_update_term_index)
			else
				sql_insert (sql_insert_term_index, l_parameters)
				sql_finalize_insert (sql_insert_term_index)
			end
		end

	unassociate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (2)
			l_parameters.put (a_voc.id, "tid")
			l_parameters.put (a_type_name, "type")

			sql_modify (sql_delete_vocabulary_index, l_parameters)
			sql_finalize_modify (sql_delete_vocabulary_index)
		end

feature {NONE} -- Queries

	last_inserted_term_id: INTEGER_64
			-- Last insert term id.
		do
			error_handler.reset
			sql_query (Sql_last_inserted_term_id, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_query (Sql_last_inserted_term_id)
		end

	fetch_term: detachable CMS_TERM
		local
			tid: INTEGER_64
			l_text: detachable READABLE_STRING_32
		do
			tid := sql_read_integer_64 (1)
			l_text := sql_read_string_32 (2)
			if tid > 0 and l_text /= Void then
				create Result.make_with_id (tid, l_text)
				Result.set_weight (sql_read_integer_32 (3))
				if attached sql_read_string_32 (4) as l_desc then
					Result.set_description (l_desc)
				end
			end
		end

	sql_select_terms_count: STRING = "SELECT count(*) FROM taxonomy_term ;"
			-- Number of terms.

	sql_select_vocabularies_count: STRING = "SELECT count(*) FROM taxonomy_term INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid WHERE taxonomy_hierarchy.parent = 0;"
			-- Number of terms without parent.

	sql_select_vocabulary_terms_count: STRING = "SELECT count(*) FROM taxonomy_term INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid WHERE taxonomy_hierarchy.parent = :parent_tid;"
			-- Number of terms under :parent_tid.

	sql_select_terms: STRING = "[
				SELECT taxonomy_term.tid, taxonomy_term.text, taxonomy_term.weight, taxonomy_term.description 
				FROM taxonomy_term INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid 
				WHERE taxonomy_hierarchy.parent = :parent_tid
				ORDER BY taxonomy_term.weight ASC ;
			]"
			-- Terms under :parent_tid.

	sql_select_cloud_of_terms: STRING = "[
				SELECT taxonomy_term.tid, taxonomy_term.text , taxonomy_term.weight, taxonomy_term.description, count(taxonomy_index.entity) as nb
				FROM taxonomy_term 
				INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid
				INNER JOIN taxonomy_index ON taxonomy_term.tid = taxonomy_index.tid 
				WHERE taxonomy_hierarchy.parent = :parent_tid
				GROUP BY taxonomy_term.tid ORDER BY nb DESC 
				LIMIT :limit OFFSET :offset ;
								]"
			-- Cloud of terms under :parent_tid.

	sql_select_cloud_of_all_terms: STRING = "[
				SELECT taxonomy_term.tid, taxonomy_term.text , taxonomy_term.weight, taxonomy_term.description, count(taxonomy_index.entity) as nb
				FROM taxonomy_term
				INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid
				INNER JOIN taxonomy_index ON taxonomy_term.tid = taxonomy_index.tid
				WHERE taxonomy_hierarchy.parent = :parent_tid
				GROUP BY taxonomy_term.tid ORDER BY nb DESC
				;
								]"
			-- Cloud of terms under :parent_tid.			

	sql_select_vocabularies_for_term: STRING = "[
				SELECT parent 
				FROM taxonomy_hierarchy
				WHERE tid = :tid
				;
		]"

	sql_select_term_in_vocabulary: STRING = "[
				SELECT count(*)
				FROM taxonomy_hierarchy
				WHERE tid = :tid and parent = :parent_tid
				;
		]"

	sql_select_terms_with_range: STRING = "[
				SELECT taxonomy_term.tid, taxonomy_term.text, taxonomy_term.weight, taxonomy_term.description
				FROM taxonomy_term INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid
				WHERE taxonomy_hierarchy.parent = :parent_tid
				ORDER BY taxonomy_term.weight ASC LIMIT :limit OFFSET :offset
				;
			]"
			-- Terms under :parent_tid, and :limit, :offset

	sql_select_term: STRING = "SELECT tid, text, weight, description FROM taxonomy_term WHERE tid=:tid;"
			-- Term with tid :tid .

	sql_select_term_by_text: STRING = "SELECT tid, text, weight, description FROM taxonomy_term WHERE text=:text;"
			-- Term with text :text .

	sql_select_vocabulary_term_by_text: STRING = "[
				SELECT taxonomy_term.tid, taxonomy_term.text, taxonomy_term.weight, taxonomy_term.description 
				FROM taxonomy_term INNER JOIN taxonomy_hierarchy ON taxonomy_term.tid = taxonomy_hierarchy.tid
				WHERE taxonomy_hierarchy.parent=:parent_tid AND taxonomy_term.text=:text
				;
			]"
			-- Term with text :text and with parent :parent_tid

	Sql_last_inserted_term_id: STRING = "SELECT MAX(tid) FROM taxonomy_term;"

	sql_insert_term: STRING = "[
				INSERT INTO taxonomy_term (text, weight, description, langcode) 
				VALUES (:text, :weight, :description, null);
			]"

	sql_update_term: STRING = "[
				UPDATE taxonomy_term 
				SET tid=:tid, text=:text, weight=:weight, description=:description, langcode=null
				WHERE tid=:tid;
			]"

	sql_insert_term_in_vocabulary: STRING = "[
				INSERT INTO taxonomy_hierarchy (tid, parent) 
				VALUES (:tid, :parent_tid);
			]"

	sql_remove_term_from_vocabulary: STRING = "[
				DELETE FROM taxonomy_hierarchy WHERE tid=:tid AND parent=:parent_tid;
			]"

	sql_select_terms_of_entity: STRING = "[
			SELECT tid FROM taxonomy_index WHERE type=:type AND entity=:entity;
		]"

	sql_select_entity_and_type_by_term: STRING = "[
			SELECT entity, type FROM taxonomy_index WHERE tid=:tid AND entity <> '-1'
			ORDER BY type ASC, entity ASC
			;
		]"

	sql_select_vocabulary_terms_of_entity: STRING = "[
				SELECT taxonomy_index.tid
				FROM taxonomy_index INNER JOIN taxonomy_hierarchy ON taxonomy_index.tid=taxonomy_hierarchy.tid
				WHERE taxonomy_hierarchy.parent=:parent_tid AND taxonomy_index.type=:type AND taxonomy_index.entity=:entity;
			]"

	sql_select_vocabularies_for_type: STRING = "[
				SELECT tid, entity
				FROM taxonomy_index
				WHERE type=:type AND entity = '-1';
			]"

	sql_select_type_associated_with_vocabulary: STRING = "[
				SELECT type
				FROM taxonomy_index
				WHERE tid=:tid AND entity = '-1';
			]"

	sql_update_term_index: STRING = "[
				UPDATE taxonomy_index 
				SET entity=:entity
				WHERE tid=:tid and type=:type
				;
			]"

	sql_insert_term_index: STRING = "[
				INSERT INTO taxonomy_index (tid, entity, type) 
				VALUES (:tid, :entity, :type);
			]"

	sql_delete_term_index: STRING = "[
				DELETE FROM taxonomy_index WHERE tid=:tid AND entity=:entity AND type=:type
				;
			]"

	sql_delete_vocabulary_index: STRING = "[
				DELETE FROM taxonomy_index WHERE tid=:tid AND type=:type
				;
			]"


end
