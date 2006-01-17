indexing

	description:
		"Show the short form of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class E_SHOW_SHORT

inherit
	E_CLASS_CMD
		rename
			work as execute
		redefine
			execute
		end

create
	make, default_create

feature -- Status report

	feature_clause_order: ARRAY [STRING]
			-- Array of orderd feature clause comments

feature -- Status setting

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'.
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

feature -- Output

	execute is
			-- Execute Current command.
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			create ctxt;
			ctxt.set_is_short;
			ctxt.set_feature_clause_order (feature_clause_order);
			ctxt.set_one_class_only;
			ctxt.format (current_class);
			if not ctxt.error then
				structured_text := ctxt.text
			else
				create structured_text.make;
			end
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

end -- class E_SHOW_SHORT
