indexing
	description: "This allows undoable class file renaming."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CLASS_FILE_RENAME

inherit
	ERF_FILE_RENAME
		rename
			make as make_file_rename
		redefine
			undo,
			redo
		end

	CONF_REFACTORING

create
	make

feature {NONE} -- Initialization

	make (a_new_name: STRING; a_class: CLASS_I) is
			-- Rename the file of `a_class' into `a_new_name'
			-- (a_new_name is just the file_name without path or extension)
			-- and update the information in `a_class' accordingly.
		require
			a_class_not_void: a_class /= Void
			a_new_name_not_void: a_new_name /= Void
		local
			new_file_name: FILE_NAME
		do
			class_i := a_class
			conf_todo
--			create new_file_name.make_from_string (a_class.cluster.path)
			new_file_name.set_file_name (a_new_name)
			new_file_name.add_extension ("e")
			create old_name_ext.make_from_string (a_class.base_name)
			create new_name_ext.make_from_string (a_new_name)
			new_name_ext.append (".e")

			make_file_rename (a_class.file_name, new_file_name)
		end

feature -- Basic operations

	undo is
			-- Undo the actions.
		do
			Precursor
			conf_todo
--			class_i.set_base_name (old_name_ext)
		end

	redo is
			-- Redo the actions.
		do
			Precursor
			conf_todo
--			class_i.set_base_name (new_name_ext)
		end

feature {NONE} -- Implementation

	class_i: CLASS_I
			-- The class we changed.

	old_name_ext: STRING
			-- The old name of the file including the extension but without path.

	new_name_ext: STRING
			-- The new name of the file including the extension but without path.


invariant
	class_i_not_void: class_i /= Void
	old_name_ext_set: old_name_ext /= Void and not old_name_ext.is_empty
	new_name_ext_set: new_name_ext /= Void and not new_name_ext.is_empty

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
end
