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
	
	PART_COMPARABLE;
	SHARED_FORMAT_INFO
		undefine
			is_equal
		end

creation

	make

feature -- Initialization

	make is
			-- Initialize Current and set comments to `c'.
		do
			!! clauses.make;
		end;

feature -- Properties

	comments: EIFFEL_COMMENTS;
			-- Comments for Current category

	clauses: LINKED_LIST [FEATURE_CLAUSE_EXPORT];
			-- Sorted list of features based on export clauses
			-- with same comments

	order: INTEGER;
			-- Predefined order in class

feature -- Access

	is_empty: BOOLEAN is
			-- Are the clauses empty?
		do
			Result := True;
			from
				clauses.start
			until
				clauses.after or else not Result
			loop
				Result := clauses.item.is_empty;
				clauses.forth
			end;
		end;

	same_comment (c: like comments): BOOLEAN is
			-- Is the comment same as `c'?
		do
			Result := comments = Void and c = Void
				or else comments /= Void and c /= Void and comments.is_equal (c);
		end;

feature -- Setting

	set_comments (c: like comments) is
			-- Set comment to all clauses to `c'.
		do
			comments := c;
		end;

	set_order (o: like order) is
			-- Set `order' to `o'.
		require
			valid_o: o > 0
		do
			order := o
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current less than `other' comment?
		do
			Result := (order < other.order);
			if not Result and then order = other.order then
				Result := 
					((comments = Void and then other.comments /= Void)
					or else (other.comments /= Void
						and then comments < other.comments))
			end
		end;

feature -- Element change

	merge (other: like Current) is
			-- Import other category clauses. Merge them with
			-- previous clauses when appropriate
		require
			good_argument: other /= Void
		local
			other_clauses: like clauses
			found: BOOLEAN
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
			good_argument:  feat_adapter /= Void
		local
			new_clause: FEATURE_CLAUSE_EXPORT;
		do
			if feat_adapter.target_feature = Void then
				clauses.finish
			else
				from
					clauses.start
				until
					clauses.after
					or else clauses.item.can_include (feat_adapter.target_feature)
				loop
					clauses.forth
				end
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
			good_argument: feat_adapter /= Void
		local
			new_clause: FEATURE_CLAUSE_EXPORT;
		do
			if clauses.is_empty then
				!! new_clause.make (feat_adapter);
				clauses.finish;
				clauses.put_right (new_clause)
			else
				clauses.finish;
				clauses.item.add (feat_adapter);
			end;
		end

feature -- Context output

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			from
				clauses.start
			until
				clauses.after
			loop
				clauses.item.format (ctxt, comments);
				clauses.forth
			end;
		end;

feature -- Removal
			
	wipe_out is
			-- Wipe out Current structures.
		do
			clauses.wipe_out;	
			comments := Void
		end;	

invariant

	non_void_clauses: clauses /= Void

end -- class CATEGORY
