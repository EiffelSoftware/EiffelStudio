indexing
	description: 
		"Mark appearing before or after major syntactic constructs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision $"

class
	TOOLTIP_ITEM

inherit
	FILTER_ITEM
		rename
			make as old_make
		redefine
			on_after_processing,
			on_before_processing
		end

	SHARED_FILTER

create
	make

feature -- Initialize

	make (a_tooltip: STRING) is
			-- Initialize Current with `a_f_name'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			old_make (f_Tooltip)
			tooltip := a_tooltip
		end

feature -- Access

	tooltip: STRING
			-- Text applying to this construct.

feature {TEXT_FILTER} -- Access

	on_before_processing (f: TEXT_FILTER) is
			-- `Current' is about to be processed.
		do
			f.set_keyword (kw_Tooltip, f.escaped_text (tooltip))
		end

	on_after_processing (f: TEXT_FILTER) is
			-- `Current' has just been processed.
		do
			f.set_keyword (kw_Tooltip, Void)
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

end -- class TOOLTIP_ITEM


