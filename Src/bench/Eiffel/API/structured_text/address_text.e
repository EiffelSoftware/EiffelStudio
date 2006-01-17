indexing
	description	: "Text item to show the address of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class ADDRESS_TEXT

inherit
	BASIC_TEXT
		rename
			image as address,
			make as old_make
		redefine
			append_to
		end

create
	make

feature -- Initialization

	make (addr: like address; a_name: STRING; eclass: CLASS_C) is
			-- Initialize Current with address is `addr' and
			-- `e_class' is `eclass' referenced by `a_name'.
		do
			address := addr
			name := a_name
			e_class := eclass
		end

feature -- Properties

	name: STRING
			-- Name of the object address (it is an attribute,
			-- local or argument name)

	e_class: CLASS_C
			-- Eiffel class of which object at `address' is an
			-- instantiation.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append `address' to `text'.
		do
			text.process_address_text (Current)
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

end -- class ADDRESS_TEXT
