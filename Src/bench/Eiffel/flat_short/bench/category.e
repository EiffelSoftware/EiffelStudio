indexing

	description: 
		"A category is a list of feature_clauses with the%
		%same comments but with different export policy.%
		%Feature clauses are sorted from less retrictive%
		%to most restrictive export policy (if option is%
		%set - `order_same_as_text' is False).";
	date: "$Date$";
	revision: "$Revision $"

class CATEGORY 

inherit
	
	COMPARABLE
		undefine
			is_equal
		end;
	SHARED_FORMAT_INFO

creation

	make

feature -- Initialization

	make is
			-- Initialize Current.
		do
			!! clauses.make
		end;

feature -- Properties

	comment: EIFFEL_COMMENTS;
			-- Comments for Current category

	clauses: SORTED_TWO_WAY_LIST [FEATURE_CLAUSE_EXPORT];
			-- Sorted list of features based on export clauses
			-- with same comments

feature -- Access

	empty: BOOLEAN is
			-- Are the clauses empty?
		do
			Result := true;
			from
				clauses.start
			until
				clauses.after or else not Result
			loop
				Result := clauses.item.empty;
				clauses.forth
			end;
		end;

	same_comment (c: like comment): BOOLEAN is
			-- Is the comment same as `c'?
		do
			Result := comment = void and c = void
				or else comment /= void and comment.is_equal (c);
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current less than `other' comment?
			--| to be fixed-> order should be configurable
		do
			Result := comment = void
			or else (other.comment /= void
				and then comment < other.comment)
		end;

feature -- Setting

	set_comment (c: like comment) is
			-- Set comment to all clauses to `c'.
		do
			comment := c;
			from
				clauses.start
			until
				clauses.after
			loop
				clauses.item.set_comment (comment);
				clauses.forth
			end;
		end;

feature -- Element change

	merge (other: like Current) is
			-- Import other category clauses. Merge them with
			-- previous clauses when appropriate
		require
			good_argument: other /= void
		local
			other_clauses: like clauses;
			clauses_count, other_count: INTEGER;
			found: BOOLEAN;
			item: FEATURE_CLAUSE_EXPORT
		do
			from
				other_clauses := other.clauses;
				other_clauses.start
			until
				other_clauses.after
			loop
				item := other_clauses.item;
				from
					found := False;
					clauses.start
				until
					clauses.after or else
					found
				loop
					found := clauses.item.compatible (item);
					if not found then
						clauses.forth
					end
				end
				if found then
					clauses.item.merge (item);
				else
					clauses.extend (item)
				end;
				other_clauses.forth
			end
		end;

	add (feat_adapter: FEATURE_ADAPTER) is
			-- Add `feat_adapter' to a feature_clause.
		require
			good_argument:  feat_adapter /= void;
			good_adapter: feat_adapter.target_feature /= Void and then
							feat_adapter.source_feature /= Void
		local
			new_clause: FEATURE_CLAUSE_EXPORT;
		do
			from
				clauses.start
			until
				clauses.after
				or else clauses.item.can_include (feat_adapter.target_feature)
			loop
				clauses.forth;
			end;
			if not clauses.off then
				clauses.item.add (feat_adapter);
			else
				!! new_clause.make (feat_adapter);
				clauses.finish;
				clauses.put_right (new_clause)
			end;
		end;

	add_at_end (feat_adapter: FEATURE_ADAPTER) is
			-- Add `feat_adapter' to the end of feature_clause.
		require
			good_argument: feat_adapter /= void
		local
			new_clause: FEATURE_CLAUSE_EXPORT;
		do
			if clauses.empty then
				!! new_clause.make (feat_adapter);
				clauses.finish;
				clauses.put_right (new_clause)
			else
				clauses.finish;
				clauses.item.add (feat_adapter);
			end;
		end

feature -- Context output

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text
		do
			if not order_same_as_text then
					-- Sort features if needed
				clauses.sort
			end;
			from
				clauses.start
			until
				clauses.after
			loop
				clauses.item.format (ctxt);
				clauses.forth
			end;
		end;

feature -- Removal
			
	wipe_out is
			-- Wipe out Current structures.
		do
			clauses.wipe_out;	
			comment := Void
		end;	

feature {FLAT_STRUCT, FORMAT_REGISTRATION} -- Implementation

	public_features_storage_info: LINKED_LIST [S_FEATURE_DATA] is
			-- List of features relevant for EiffelCase.
		local
			feat_clause: FEATURE_CLAUSE_EXPORT
		do
			!! Result.make;
			from
				clauses.start
			until
				clauses.after
			loop
				feat_clause := clauses.item;
					-- Store feature information
				if feat_clause.export_status.storage_info.is_all then
					Result.append (feat_clause.features_storage_info);
				end;
				clauses.forth
			end;
		end;	

	private_features_storage_info: LINKED_LIST [S_FEATURE_DATA] is
			-- List of features relevant for EiffelCase.
		local
			feat_clause: FEATURE_CLAUSE_EXPORT
		do
			!! Result.make;
			from
				clauses.start
			until
				clauses.after
			loop
				feat_clause := clauses.item;
				if feat_clause.export_status.storage_info.is_none then
						-- Store feature information
					Result.append (clauses.item.features_storage_info);
				end;
				clauses.forth
			end;
		end;	

end -- class CATEGORY
