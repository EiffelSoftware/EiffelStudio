class CATEGORY 

inherit
	
	COMPARABLE

creation

	make

feature

	comment: EIFFEL_COMMENTS;

	clauses: LINKED_LIST [FEATURE_CLAUSE_EXPORT];


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
				clauses.offright
			loop
				clauses.item.set_comment (comment);
				clauses.forth
			end;
			if comment /= void then
				io.putstring ("CATEGORY ");
				io.putstring (c.text.item (0));
				io.new_line;
			else
				io.putstring ("EMPTY CATEGORY COMMENT %N");
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
				clauses.offright or else not Result
			loop
				Result := clauses.item.empty
			end;
		end;



	merge (other: like Current) is
			-- Import other categories clauses. Merge them with
			-- previous clauses when appropriate
		require
			good_argument: other /= void
		local
			new_clauses: like clauses;
			clauses_count, other_count: INTEGER;
		do
			from
				!!new_clauses.make;
				clauses.start;
				other.clauses.start;
				clauses_count := clauses.count;
				other_count := other.clauses.count
			invariant
				clauses_is_stable: clauses.count = clauses_count;
				other_is_stable: other.clauses.count = other_count;
			variant
				other_count + clauses_count + 3
				- clauses.position - other.clauses.position	
			--	clauses_count + other_count - new_clauses.count + 1
			until
				clauses.offright
				and other.clauses.offright
			loop
				from
				until
					clauses.offright 
					or else ((not other.clauses.offright)
						and then clauses.item >= other.clauses.item )
				loop
					new_clauses.add (clauses.item);
					clauses.forth;
				end;
				if not  new_clauses.off and not other.clauses.off
					and then new_clauses.item.compatible (other.clauses.item) 
				then
					new_clauses.item.merge (other.clauses.item);
					other.clauses.forth;
				end;
				from
				until
					other.clauses.offright
					or else ((not clauses.offright)
						and then not (clauses.item >= other.clauses.item))
				loop
					new_clauses.add (other.clauses.item);
					other.clauses.forth;
				end;
			end;
			clauses := new_clauses;
		end;



	add (names_adapter: NAMES_ADAPTER) is
		require
			good_argument:  names_adapter /= void
		local
			names: NAMES_LIST;
			new_clause: FEATURE_CLAUSE_EXPORT;
			synonymous: LINKED_LIST [NAMES_LIST];
		do
			from
				synonymous := names_adapter.synonymous;
				synonymous.start;
			until
				synonymous.offright
			loop
				names := synonymous.item;
				from
					clauses.start
				until
					clauses.offright 
					or else clauses.item.export_less_than (names)
				loop
					clauses.forth;
				end;
				clauses.back;
				if
					not clauses.off
					and then clauses.item.can_include (names) 
				then
					clauses.item.add (names_adapter.new_as (names));
				else
					!!new_clause.make (names_adapter.new_as (names), names.feature_i);
					clauses.put_right (new_clause)	
				end;
				synonymous.forth;
			end
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.begin;
			from
				clauses.start
			until
				clauses.offright
			loop
				clauses.item.format (ctxt);
				ctxt.next_line;
				clauses.forth
			end;
			ctxt.commit;
		end;	

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := comment /= void
			and (other.comment = void
				or else comment < other.comment)
		end;
				

end

					
				
