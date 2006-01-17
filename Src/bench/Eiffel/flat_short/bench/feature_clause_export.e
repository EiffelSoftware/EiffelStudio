indexing

	description: 
		"A collection of features with the same export policy and%
		%comments. Features are sorted alphabetically (if option is%
		%set - `order_same_as_text' is False)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create

	make

feature -- Initialization

	make (feat_adapter: FEATURE_ADAPTER) is
			-- Initialize Current.
		require
			valid_feat_adapter: feat_adapter /= Void;
		do
			if feat_adapter.target_feature = Void then
				create { EXPORT_ALL_I } export_status;
			else
				export_status := feat_adapter.target_feature.export_status;
			end;
			create features.make;
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
				ctxt.put_new_line
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
				if not features.item.source_feature.written_class.is_true_external then
					features.item.format (ctxt);		
				end
				features.forth;
			end;
			ctxt.put_text_item (ti_After_feature_clause)
			ctxt.exdent;
			ctxt.put_new_line;
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
