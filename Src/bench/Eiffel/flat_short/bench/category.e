class CATEGORY 

inherit
	
	COMPARABLE
		undefine
			is_equal
		end;
	SPECIAL_AST_B

creation

	make

feature

	comment: EIFFEL_COMMENTS;

	clauses: SORTED_TWO_WAY_LIST [FEATURE_CLAUSE_EXPORT];
			-- Sorted list of features based on export clauses
			-- and comments

	make is
		do
			!!clauses.make
		end;

	set_comment (c: like comment) is
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

	same_comment (c: like comment): BOOLEAN is
		do
			Result := comment = void and c = void
				or else comment /= void and comment.is_equal (c);
		end;

	empty: BOOLEAN is
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

	add (names_adapter: NAMES_ADAPTER) is
		require
			good_argument:  names_adapter /= void
		local
			names: NAMES_LIST;
			new_clause: FEATURE_CLAUSE_EXPORT;
		do
			names := names_adapter.names_list;
			if names /= Void then
				from
					clauses.start
				until
					clauses.after
					or else clauses.item.can_include (names)
				loop
					clauses.forth;
				end;
			end;
			if names /= Void then 
				names_adapter.update_ast;
				if not clauses.off then
					clauses.item.add (names_adapter.ast);
				else
					!!new_clause.make (names_adapter.ast, names.feature_i);
					clauses.finish;
					clauses.put_right (new_clause)
				end
			end;
		end;

	add_at_end (names_adapter: NAMES_ADAPTER) is
		require
			good_argument: names_adapter /= void
		local
			names: NAMES_LIST;
			new_clause: FEATURE_CLAUSE_EXPORT;
		do
			names := names_adapter.names_list;
			names_adapter.update_ast;
			if clauses.empty then
				!!new_clause.make (names_adapter.ast, names.feature_i);
				clauses.finish;
				clauses.put_right (new_clause)
			else
				clauses.finish;
				clauses.item.add (names_adapter.ast);
			end;
		end

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text
		do
			ctxt.begin;
			from
				clauses.start
			until
				clauses.after
			loop
				clauses.item.format (ctxt);
				clauses.forth
			end;
			ctxt.commit;
		end;


	infix "<" (other: like Current): BOOLEAN is
		do
			Result := comment = void
			or else (other.comment /= void
				and then comment < other.comment)
		end;
			
	wipe_out is
		do
			clauses.wipe_out;	
			comment := Void
		end;	

feature {FLAT_STRUCT}

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
				if feat_clause.reference.storage_info.is_all then
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
				if feat_clause.reference.storage_info.is_none then
						-- Store feature information
					Result.append (clauses.item.features_storage_info);
				end;
				clauses.forth
			end;
		end;	

end

					
				
