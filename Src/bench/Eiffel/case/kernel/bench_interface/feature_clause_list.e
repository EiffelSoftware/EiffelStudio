indexing

	description: "List of feature clauses.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_CLAUSE_LIST

inherit

	LINKED_LIST [FEATURE_CLAUSE_DATA]
		rename
			make as ll_make
		end

creation

	make, make_from_storer

feature {NONE} -- Initialization

	make (c_data: like class_data) is
		require
			c_data_exists: c_data /= Void
		do
			class_data := c_data
			ll_make
		ensure
			class_data_set: class_data = c_data
		end

	make_from_storer (s: ARRAYED_LIST [S_FEATURE_CLAUSE]; c_data: like class_data) is
		require
			valid_s: s /= Void
			c_data_exists: c_data /= Void
		local
			f_clause: FEATURE_CLAUSE_DATA
		do
			--make (c_data);
			--from
			--	s.start
			--until
			--	s.after
			--loop
			--	!! f_clause.make_from_storer (s.item, c_data)
			--	put_right (f_clause);
			--	forth;
			--	s.forth
			--end
			--if not empty then
			--	current_feature_clause := first
			--	current_feature_clause.set_is_current
			--end
		end;

feature -- Properties

	class_data: CLASS_DATA
			-- Class to which Current belongs

	current_feature_clause: like item
			-- Feature clause to which features will be added

feature -- Access

	find_clause (f_data: FEATURE_DATA): FEATURE_CLAUSE_DATA is
			-- Find clause with feature `f_data'
		do
		--	from
		--		start
		--	until
		--		after or else
		--		item.features.has (f_data)
		--	loop
		--		forth
		--	end;
		--	Result := item
		end

feature -- Setting

	set_current_feature_clause (fc: like current_feature_clause) is
			-- Set `current_feature_clause' to `fc'
		require
			fc_exists: fc /= Void
			not_already: current_feature_clause /= fc
			fc_in_current_list: has (fc)
		do
		--	if current_feature_clause /= Void then
		--		current_feature_clause.unset_is_current
		--	end
		--	current_feature_clause := fc
		--	current_feature_clause.set_is_current
		ensure
			current_feature_clause_set: current_feature_clause = fc
		end

feature -- Output

	generate_feature_names (text_area: TEXT_AREA) is
			-- Generate feature names into `text_area'.
		require
			valid_text_area: text_area /= Void
		do
		--	from
		--		start
		--	until
		--		after
		--	loop
		--		item.generate_feature_names (text_area)
		--		forth;
		--	end
		end;

	generate_modified_feature_names (text_area: TEXT_AREA) is
			-- Generate feature names for modified features.
		require
			valid_text_area: text_area /= Void
		do
		--	from
		--		start
		--	until
		--		after
		--	loop
		--		item.generate_modified_feature_names (text_area)
		--		forth;
		--	end
		end;

	generate (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Generate feature names into `text_area'.
		require
			valid_text_area: text_area /= Void
		do
		--	from
		--		start
		--	until
		--		after
		--	loop
			--	if not is_spec or else not item.export_i.is_none then
			--		item.generate	( text_area	, is_spec );
			--	end;
			--	forth;
		--	end
		end;

feature -- Storage

	storage_info: ARRAYED_LIST [S_FEATURE_CLAUSE] is
		do
		--	!! Result.make (count);
		--	from
		--		start
		--	until
		--		after
		--	loop
		--		Result.extend (item.storage_info)
		--		forth
		--	end
		end;

end -- class FEATURE_CLAUSE_LIST
