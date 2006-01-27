indexing

	description:
		"Adding debug breakpoints to simple format text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SIMPLE_DEBUG_CONTEXT

inherit

	FORMAT_CONTEXT
		rename
			emit_tabs as old_emit_tabs,
			make as old_make
		redefine
			put_breakable, formal_name, put_class_name
		end
	FORMAT_CONTEXT
		rename
			make as old_make
		redefine
			put_breakable, emit_tabs,
			formal_name, put_class_name
		select
			emit_tabs
		end;
	SHARED_WORKBENCH

create

	make

feature {NONE} -- Initialization

	make (a_feat: E_FEATURE) is
			-- Initialize current with `a_class'.
		require
			valid_feat: a_feat /= Void
		local
			ast: FEATURE_AS
		do
			make_for_case;
			e_class := a_feat.associated_class;
			e_feature := a_feat;
			ast := a_feat.ast;
			if ast = Void then
				execution_error := True
			else
				formatter.format (ast)
			end;
		end;

feature -- Access

	e_class: CLASS_C;
			-- Class where feature is defined

	e_feature: E_FEATURE;
			-- Class where feature is defined

feature -- Element change

	formal_name (pos: INTEGER): ID_AS is
			-- Formal name of class_c generics at position `pos.
		do
			Result := e_class.generics.i_th (pos).name.as_upper
		end;

	put_class_name (s: STRING) is
			-- Append `s' to `text'.
		local
			classi: CLASS_I;
			tmp: STRING
		do
			if not tabs_emitted then
				emit_tabs;
			end;
			tmp := s.as_lower
			classi := Universe.class_named (tmp, e_class.cluster);
			if classi = Void then
				text.add_string (s);
			else
				text.add_classi (classi, s);
			end
		end;

feature {NONE} -- Implementation

	breakpoint_index: INTEGER;
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
		local
			bp: BREAKPOINT_ITEM
		do
			breakpoint_index := breakpoint_index + 1;
			create bp.make (e_feature, breakpoint_index);
			added_breakpoint := True;
			text.add (bp)
		end;

	emit_tabs is
		do
			if added_breakpoint then
				added_breakpoint := false;
			else
				text.add (ti_padded_debug_mark)
			end;
			old_emit_tabs;
		end;

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

end	 -- class SIMPLE_DEBUG_CONTEXT
