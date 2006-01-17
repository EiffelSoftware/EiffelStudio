indexing

	description: 
		"Mark appearing before or after major syntactic constructs."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FILTER_ITEM

inherit

	TEXT_ITEM
		rename
			image as empty_string
		end

create

	make

feature -- Initialize

	make (new_construct: like construct) is
			-- Initialize Current with `new_construct'.
		require
			new_construct_not_void: new_construct /= Void
		do
			construct := new_construct
		ensure
			construct = new_construct
		end;

feature -- Properties

	construct: STRING;
			-- Name of the syntactic construct

	is_before: BOOLEAN;
			-- Does `Current' appear before the syntactic construct?

feature -- Setting

	set_before is
			-- Set is_before to True.
		do
			is_before := True
		ensure
			is_before: is_before
		end;

	set_after is
			-- Set is_before to False.
		do
			is_before := false
		ensure
			is_after: not is_before
		end;

feature {TEXT_FILTER} -- Access

	on_before_processing (f: TEXT_FILTER) is
			-- `Current' is about to be processed.
		do
		end

	on_after_processing (f: TEXT_FILTER) is
			-- `Current' has just been processed.
		do
		end

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current fileter text to `text'.
        do
			text.process_filter_item (Current)	
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

end -- class FILTER_ITEM
