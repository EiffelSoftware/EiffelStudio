note

	description:

		"Deferred common base for member wrappers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_MEMBER_WRAPPER

inherit

	EWG_ABSTRACT_WRAPPER
		rename
			make as make_abstract_wrapper
		end

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING; a_header_file_name: STRING)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		do
			make_abstract_wrapper (a_mapped_eiffel_name, a_header_file_name)
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
		end

feature {EWG_COMPOSITE_WRAPPER}

	set_composite_wrapper (a_composite_wrapper: EWG_COMPOSITE_WRAPPER)
		require
			a_composite_wrapper_not_void: a_composite_wrapper /= Void
			composite_wrapper_is_void: composite_wrapper = Void
		do
			composite_wrapper := a_composite_wrapper
		ensure
			composite_wrapper_set: composite_wrapper = a_composite_wrapper
		end

	proposed_feature_name_list: DS_LINEAR [STRING]
			-- List of Eiffel feature names this member wrapper is planing to generate
		deferred
		ensure
			proposed_feature_name_list_not_void: Result /= Void
--			proposed_feature_name_list_not_has_void: not Result.has (Void)
			proposed_feature_names_unique: are_names_unique (Result)
		end

feature {ANY} -- Assertion helpers

	are_names_unique (a_list: DS_LINEAR [STRING]): BOOLEAN
			-- Are there no two items in `a_list' who have equal names?
		require
			a_list_not_void: a_list /= Void
--			a_list_not_has_void: not a_list.has (Void)
		local
			name_set: DS_HASH_SET [STRING]
			cs: DS_LINEAR_CURSOR [STRING]
		do
			Result := True
			create name_set.make_default
			from
				cs := a_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if name_set.has (cs.item) then
					Result := False
					cs.go_after
				else
					name_set.force (cs.item)
				end
				cs.forth
			end
		end


feature

	composite_wrapper: detachable EWG_COMPOSITE_WRAPPER
			-- Composite wrapper this member belongs to

end
