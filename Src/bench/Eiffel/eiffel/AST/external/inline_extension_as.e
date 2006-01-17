indexing
	description: "Encapsulation of a inline external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INLINE_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS

create
	initialize

feature  -- Initialization

	initialize (is_cpp_inline: like is_cpp; use_list: USE_LIST_AS) is
			-- Create INLINE_EXTENSION_AS node.
		do
			is_cpp := is_cpp_inline
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		ensure
			is_cpp_set: is_cpp = is_cpp_inline
		end

feature -- Properties

	is_cpp: BOOLEAN
			-- Is Current inlining a C++ one?

feature -- Get inline extension

	extension_i: INLINE_EXTENSION_I is
			-- INLINE_EXTENSION_I corresponding to current extension
		do
			create Result.make (is_cpp)
			init_extension_i (Result)
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

end -- class INLINE_EXTENSION_AS
