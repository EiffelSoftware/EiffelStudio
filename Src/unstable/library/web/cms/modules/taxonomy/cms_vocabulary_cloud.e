note
	description: "Summary description for {CMS_VOCABULARY_CLOUD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_VOCABULARY_CLOUD

inherit
	CMS_VOCABULARY
		redefine
			wipe_out
		end

create
	make_from_vocabulary

feature {NONE} -- Initialization

	make_from_vocabulary (voc: CMS_VOCABULARY)
		do
			make_from_term (voc)
			associated_content_type := voc.associated_content_type
			is_tags := voc.is_tags
			multiple_terms_allowed := voc.multiple_terms_allowed
			is_term_required := voc.is_term_required
			across
				voc as ic
			loop
				force (ic.item)
			end
			create statistics.make (terms.count)
		end

feature -- Access

	occurrences_count (a_term: CMS_TERM): NATURAL_64
		do
			Result := statistics.item (a_term.id)
		end

	statistics: HASH_TABLE [NATURAL_64, like {CMS_TERM}.id]

feature -- Element changes

	wipe_out
		do
			Precursor
			statistics.wipe_out
		end

	record (a_term: CMS_TERM; a_occurrences: NATURAL_64)
		local
			n64: NATURAL_64
		do
			force (a_term)
			n64 := occurrences_count (a_term) + a_occurrences
			statistics.force (n64, a_term.id)
		end

end
