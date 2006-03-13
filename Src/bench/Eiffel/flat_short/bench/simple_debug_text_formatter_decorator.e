indexing
	description	: "Facilities to handle breakpoints adding in flat/short formats"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class SIMPLE_DEBUG_TEXT_FORMATTER_DECORATOR

inherit
	TEXT_FORMATTER_DECORATOR
		rename
			emit_tabs as old_emit_tabs,
			make as old_make
		redefine
			put_breakable, formal_name
		end

	TEXT_FORMATTER_DECORATOR
		rename
			make as old_make
		redefine
			put_breakable, emit_tabs,
			formal_name
		select
			emit_tabs
		end

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (a_feat: E_FEATURE; a_text_formatter: TEXT_FORMATTER) is
			-- Initialize current with `a_class'.
		require
			valid_feat: a_feat /= Void
		local
			ast: FEATURE_AS
		do
			make_for_case (a_text_formatter);
			e_class := a_feat.associated_class;
			e_feature := a_feat;
			ast := a_feat.ast;
			if ast = Void then
				execution_error := True
			else
				ast.process (ast_output_strategy)
			end;
		end;

feature -- Access

	e_class: CLASS_C
			-- Class where feature is defined.

	e_feature: E_FEATURE
			-- Current feature.

feature -- Element change

	formal_name (pos: INTEGER): ID_AS is
			-- Formal name of class_c generics at position `pos.
		do
			Result := e_class.generics.i_th (pos).name.as_upper
		end

feature {NONE} -- Implementation

	breakpoint_index: INTEGER;
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
		do
			breakpoint_index := breakpoint_index + 1
			added_breakpoint := True
			text_formatter.process_breakpoint (e_feature, breakpoint_index)
		end

	emit_tabs is
		do
			if added_breakpoint then
				added_breakpoint := false
			else
				text_formatter.process_padded
			end
			old_emit_tabs
		end

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

end	 -- class SIMPLE_DEBUG_TEXT_FORMATTER_DECORATOR
