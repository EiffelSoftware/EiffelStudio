indexing
	description: "Information on a feature of the system for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMI_FEATURE

inherit
	XMI_ITEM

feature -- Initialization

	make (id: INTEGER; n: STRING; t: XMI_TYPE) is
			-- Initialization of `Current'.
		do
			xmi_id := id
			type := t
			is_public := false
			is_protected := false
			is_private := false
			name := n
		end

feature -- Properties

	is_public: BOOLEAN
			-- Is `Current' exorted to all classes?

	is_protected: BOOLEAN
			-- Is `Current' exported to some classes only?

	is_private: BOOLEAN
			-- Is `Current' exported to none?

feature -- Status setting

	set_public is
			-- Set `Current' export status to public.
		do
			is_public := true
		end

	set_protected is
			-- Set `Current' export status to protected.
		do
			is_protected := true
		end

	set_private is
			-- Set `Current' export status to private.
		do
			is_private := true
		end

feature -- Access

	type: XMI_TYPE
			-- Type of the feature represented by `Current'.

	name: STRING;
			-- Name of `Current'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class XMI_FEATURE
