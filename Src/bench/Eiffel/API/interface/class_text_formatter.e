indexing

	description:
		"Formats Eiffel class text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_TEXT_FORMATTER

inherit
	E_TEXT_FORMATTER

	SHARED_INST_CONTEXT

	SHARED_WORKBENCH

	SHARED_FORMAT_INFO
		rename
			is_short as format_is_short,
			set_is_short as format_set_is_short,
			set_order_same_as_text as format_set_order_same_as_text
		end

feature -- Properties

	is_for_documentation: BOOLEAN
			-- Is the format for documentation?

	is_one_class_only: BOOLEAN;
			-- Is the format performed on one class only?

	is_short: BOOLEAN;
			-- Is the format doing a short?

	ordered_same_as_text: BOOLEAN;
			-- Will the format output be in the same order as text file?

	feature_clause_order: ARRAY [STRING]
			-- Array of orderd feature clause comments

	is_flat: BOOLEAN is
			-- Is the format doing a flat?
		do
			Result := not is_short
		ensure
			not_short: Result = not is_short
		end;

feature -- Setting

	set_documentation (a_doc: like documentation) is
			-- Set `is_for_documentation'
		do
			is_for_documentation := true
			documentation := a_doc
		end

	set_is_short is
			-- Set `is_short' to True.
		do
			is_short := True
		ensure
			is_short: is_short
		end;

	set_order_same_as_text is
			-- Set ordered_same_as_text_bool to True.
		do
			ordered_same_as_text := True
		ensure
			ordered_same_as_text: ordered_same_as_text
		end;

	set_one_class_only is
			-- Set current_class_only to True.
		do
			is_one_class_only := True;
		ensure
			is_one_class_only: is_one_class_only
		end;

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'.
		require
			not_orded_same_as_text: not ordered_same_as_text
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

feature -- Output

	format (e_class: CLASS_C; a_formatter: TEXT_FORMATTER) is
			-- Format text for eiffel class `e_class'.
		require
			valid_e_class: e_class /= Void
		local
			f: TEXT_FORMATTER_DECORATOR
		do
			if is_with_breakable then
				create {CLASS_DEBUG_TEXT_FORMATTER_DECORATOR} f.make (e_class, a_formatter)
			else
				create f.make (e_class, a_formatter)
			end
			if is_short then
				f.set_is_short
			end;
			if is_one_class_only then
				f.set_current_class_only
			end;
			if is_clickable then
				f.set_in_bench_mode
			end;
			if ordered_same_as_text then
				f.set_order_same_as_text
			else
				f.set_feature_clause_order (feature_clause_order)
			end;
			if is_for_documentation then
				f.set_for_documentation (documentation)
			end
			f.execute;
			error := f.execution_error
		end;

	format_invariants (e_class: CLASS_C; a_formatter: TEXT_FORMATTER) is
			-- Format invariants for eiffel class `e_class'.
		require
			valid_e_class: e_class /= Void
		local
			f: TEXT_FORMATTER_DECORATOR;
			old_group: CONF_GROUP
			old_class, class_c: CLASS_C;
		do
			create f.make (e_class, a_formatter);
			if is_clickable then
				f.set_in_bench_mode
			end;
			old_class := System.current_class;
			old_group := Inst_context.group;
			class_c ?= e_class;
			System.set_current_class (class_c);
			Inst_context.set_group (e_class.group);
			f.register_invariants;
			f.format_invariants;
			System.set_current_class (old_class);
			Inst_context.set_group (old_group);
			error := f.execution_error
		end;

feature {NONE} -- Implementation

	documentation: DOCUMENTATION_ROUTINES;

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

end -- class CLASS_TEXT_FORMATTER
