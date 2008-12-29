note

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
		end

	EXPORT_FORMATTER
		rename
			format as format_export
		end

	SHARED_FORMAT_INFO;
	SHARED_TEXT_ITEMS;
	COMPILER_EXPORTER

create

	make

feature -- Initialization

	make (feat_adapter: FEATURE_ADAPTER)
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

	is_empty: BOOLEAN
			-- Are there any features?
		do
			Result := features.is_empty;
		end;

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is Current less restrictive than `other'?
		do
			Result := not export_status.is_subset (other.export_status);
		end;

	compatible (other: like Current): BOOLEAN
			-- Is `other' clause compatible with Current?
		do
			Result := other.export_status.same_as (export_status);
		end;

	can_include (feat: FEATURE_I): BOOLEAN
			-- Can current include export status from `feat'?
		do
			Result := export_status.same_as (feat.export_status);
		end;

feature -- Element change

	add (f: FEATURE_ADAPTER)
			-- Add feature adapter `f' to Current feature clause.
		require
			valid_f: f /= Void
		do
			features.finish;
			features.put_right (f)
		ensure
			added: features.has (f)
		end;

	merge (other: like Current)
			-- Merge `other' clause with Current.
		require
			valid_other: other /= Void
		do
			features.merge (other.features);
		end;

feature -- Context output

	format (ctxt: TEXT_FORMATTER_DECORATOR; comments: EIFFEL_COMMENTS)
			-- Reconstitute text.
		local
			l_feature_i: FEATURE_I
		do
			ctxt.process_filter_item (f_feature_clause, true)
			ctxt.process_filter_item (f_feature_clause_header, true)
			ctxt.process_keyword_text (ti_Feature_keyword, Void);
			ctxt.put_space;
			if not export_status.is_all then
				format_export (ctxt, export_status)
				ctxt.put_space;
			end;
			if comments = Void or else comments.is_empty then
				ctxt.put_new_line
			else
				ctxt.put_comments (comments);
			end;
			ctxt.process_filter_item (f_feature_clause_header, false)
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
				ctxt.put_new_line
				l_feature_i := features.item.source_feature
				if l_feature_i /= Void and then not l_feature_i.written_class.is_true_external then
					features.item.format (ctxt);
				end
				features.forth;
			end;
			ctxt.process_filter_item (f_feature_clause, false)
			ctxt.exdent;
			ctxt.put_new_line;
		end

feature {FEATURE_CLAUSE_EXPORT, CATEGORY} -- Implementation

	export_status: EXPORT_I;
			-- Export status of Current feature clause

feature -- Debug

	trace
		do
			from features.start until features.after loop
				io.error.put_string ("%T" + features.item.ast.feature_name.name + "%N")
				features.forth
			end
		end

invariant

	valid_features: features /= Void;
	valid_export_status: export_status /= Void

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
