indexing

	description: 
		"A collection of features with the same export policy and%
		%comments. Features are sorted alphabetically (if option is%
		%set - `order_same_as_text' is False)."
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_CLAUSE_EXPORT

inherit

	PART_COMPARABLE
		undefine
			is_equal
		end;
	SHARED_FORMAT_INFO;
	SHARED_TEXT_ITEMS;
	COMPILER_EXPORTER

creation

	make

feature -- Initialization

	make (feat_adapter: FEATURE_ADAPTER) is
			-- Initialize Current.
		require
			valid_feat_adapter: feat_adapter /= Void;
		do
			if feat_adapter.target_feature = Void then
				! EXPORT_ALL_I ! export_status;
			else
				export_status := feat_adapter.target_feature.export_status;
			end;
			!! features.make;
			add (feat_adapter);
		ensure
			has_feat_adapter: features.has (feat_adapter);
		end;

feature -- Properties

	features: PART_SORTED_TWO_WAY_LIST [FEATURE_ADAPTER];
			-- Features sorted on name within 
			-- Current feature clause
	
feature -- Access

	is_empty: BOOLEAN is
			-- Are there any features?
		do
			Result := features.is_empty;
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current less restrictive than `other'?
		do
			Result := not export_status.is_subset (other.export_status);
		end;
						
	compatible (other: like Current): BOOLEAN is
			-- Is `other' clause compatible with Current?
		do
			Result := other.export_status.same_as (export_status);	
		end;

	can_include (feat: FEATURE_I): BOOLEAN is
			-- Can current include export status from `feat'?
		do
			Result := export_status.same_as (feat.export_status);
		end;

feature -- Element change
	
	add (f: FEATURE_ADAPTER) is
			-- Add feature adapter `f' to Current feature clause.
		require
			valid_f: f /= Void
		do
			features.finish;
			features.put_right (f)
		ensure
			added: features.has (f)
		end;

	merge (other: like Current) is
			-- Merge `other' clause with Current.
		require
			valid_other: other /= Void
		do
			features.merge (other.features);			
		end;

feature -- Context output

	format (ctxt: FORMAT_CONTEXT; comments: EIFFEL_COMMENTS) is
			-- Reconstitute text.
		local
			not_first: BOOLEAN
		do
			ctxt.put_text_item (ti_Before_feature_clause);
			ctxt.put_text_item (ti_Before_feature_clause_header)
			ctxt.put_text_item (ti_Feature_keyword);
			ctxt.put_space;
			if not export_status.is_all then
				export_status.format (ctxt);
				ctxt.put_space;
			end;
			if comments = Void then
				ctxt.new_line
			else
				ctxt.put_comments (comments);
			end;
			ctxt.put_text_item (ti_After_feature_clause_header)
			ctxt.indent;
			ctxt.set_separator (Void);
			ctxt.set_new_line_between_tokens;
			if not order_same_as_text then
					-- Sort features if needed
				features.sort
			end
			from
				features.start
			until
				features.after
			loop
				if not_first then
					not_first := True;
					ctxt.put_separator
				end;
				features.item.format (ctxt);
				features.forth;
			end;
			ctxt.put_text_item (ti_After_feature_clause)
			ctxt.exdent;
			ctxt.new_line;
		end

feature {FEATURE_CLAUSE_EXPORT, CATEGORY} -- Implementation

	export_status: EXPORT_I;
			-- Export status of Current feature clause

feature -- Debug
		
	trace is
		do
			from features.start until features.after loop
				io.error.put_string ("%T" + features.item.ast.feature_name + "%N")
				features.forth
			end
		end

invariant
	
	valid_features: features /= Void;
	valid_export_status: export_status /= Void

end
