indexing
	description: 
		"Comments for an eiffel class. Eiffel comments are hashed%
		%on position within the eiffel text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_COMMENTS

inherit
	HASH_TABLE [EIFFEL_COMMENTS, INTEGER]
		rename
			make as table_make
		export
			{CLASS_COMMENTS} all;
			{ANY} put, clear_all, remove, item, is_empty, valid_key
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (id: like class_id; init_size: INTEGER) is
			-- Create precompiled comments with class_id `id'
			-- with initial size `init_size'.
		require
			valid_id: id /= 0
		do
			table_make (init_size);
			class_id := id
		ensure
			class_id = id
		end;

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				io.error.put_string ("Position: ");
				io.error.put_integer (key_for_iteration);
				io.error.put_new_line;
				item_for_iteration.trace;
				forth
			end
		end;

invariant

	class_id_not_void: class_id /= 0

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

end -- class CLASS_COMMENTS
