-- A collection of features with common comment and export
-- policies

class FEATURE_CLAUSE_EXPORT

inherit

	COMPARABLE
	SPECIAL_AST

creation

	make


feature

	make (ast: FEATURE_AS; f: FEATURE_I) is
		do
			reference := f.export_status;
			!!features.make;
			add (ast);
		end;

	features: SORTED_TWO_WAY_LIST [FEATURE_AS];
	
	comment: EIFFEL_COMMENTS;

	set_comment (c: like comment) is
		do
			comment := c;
		end;

	
	add (f: FEATURE_AS) is
		do
			if not order_same_as_text then
				features.extend (f);
			else
				features.finish;
				features.put_right (f)
			end;
		end;

	empty: BOOLEAN is
		do
			Result := features.empty;
		end;

			
	infix "<" (other: like Current): BOOLEAN is
			-- is other more export restrictive than current
		do
			Result := other.reference.equiv (reference);
		end;
						
			
	compatible (other: like Current): BOOLEAN is
		do
			Result := other.reference.same_as (reference);	
		end;

	export_less_than (names: NAMES_LIST): BOOLEAN is
		do
			--Result := reference  names.feature_i.export_status;
		end;

	can_include (names: NAMES_LIST): BOOLEAN is
		do
			Result := reference.same_as (names.feature_i.export_status);
		end;

	merge (other: like Current) is
		do
			features.merge (other.features);			
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_before_feat_clause;
			ctxt.begin;
			ctxt.next_line;
			ctxt.put_keyword ("feature");
			ctxt.put_string (" ");
			--clients_list.format (ctxt);
			reference.format (ctxt);
			ctxt.put_string (" ");
			ctxt.put_comment (comment);
			ctxt.next_line;
			ctxt.indent_one_more;
			from
				features.start
			until
				features.after
			loop
				features.item.format (ctxt);
				features.forth;
			end;
			ctxt.commit;
			ctxt.put_after_feat_clause;
		end

	features_storage_info: LINKED_LIST [S_FEATURE_DATA] is
			-- List of features in case format within
			-- a feature clause
		do
			!! Result.make;
			from
				features.start
			until
				features.after
			loop
				Result.extend (features.item.storage_info);
				features.forth;
			end;
		end;	
			
feature {FEATURE_CLAUSE_EXPORT}

	reference: EXPORT_I;

end



	
