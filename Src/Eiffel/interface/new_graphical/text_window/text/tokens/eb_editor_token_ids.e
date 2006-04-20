indexing
	description: "Object that contains ids within Eiffel Studio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_IDS

inherit
	EDITOR_TOKEN_IDS
		redefine
			max_color_id
		end

feature -- Color ids

	breakpoint_background_color_id: INTEGER is 30
			-- Background color used to display breakpoints		

	assertion_tag_text_color_id: INTEGER is 31

	assertion_tag_background_color_id: INTEGER is 32

	indexing_tag_text_color_id: INTEGER is 33

	indexing_tag_background_color_id: INTEGER is 34

	reserved_text_color_id: INTEGER is 35

	reserved_background_color_id: INTEGER is 36

	generic_text_color_id: INTEGER is 37

	generic_background_color_id: INTEGER is 38

	local_text_color_id: INTEGER is 39

	local_background_color_id: INTEGER is 40

	class_text_color_id: INTEGER is 41

	class_background_color_id: INTEGER is 42

	feature_text_color_id: INTEGER is 43

	feature_background_color_id: INTEGER is 44

	cluster_text_color_id: INTEGER is 45

	cluster_background_color_id: INTEGER is 46

	error_text_color_id: INTEGER is 47

	error_background_color_id: INTEGER is 48

	object_text_color_id: INTEGER is 49

	object_background_color_id: INTEGER is 50

	max_color_id: INTEGER is
		do
			Result := object_background_color_id
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

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
end
