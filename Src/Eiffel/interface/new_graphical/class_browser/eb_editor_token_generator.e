indexing
	description: "Generator to generate editro token lists"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_GENERATOR

inherit
	EDITOR_TOKEN_WRITER
		redefine
			make,
			comment_context_class
		end
create
	make

feature {NONE} -- Initialization

	make is
		do
			create last_line.make_empty_line
			seperate_comment := True
		end

feature -- Access

	comment_context_class : CLASS_C is
			-- Current class for comment context.
		do
			if comment_content_class_internal = Void then
				Result := eiffel_system.system.current_class
			else
				Result := comment_content_class_internal
			end
		ensure then
			result_attached: Result /= Void
		end

feature -- Setting

	set_comment_context_class (a_class_c: CLASS_C) is
			-- Set `comment_content_class' with `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			comment_content_class_internal := a_class_c
		ensure
			comment_content_class_internal_set: comment_content_class_internal = a_class_c
		end

feature{NONE} -- Implementation

	comment_content_class_internal: like comment_context_class;
			-- Implementation of `comment_context_class'		

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
