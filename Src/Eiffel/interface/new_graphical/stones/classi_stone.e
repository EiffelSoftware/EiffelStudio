note
	description:
		"Stone representing an uncompiled Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	CLASSI_STONE

inherit

	FILED_STONE
		redefine
			is_valid, synchronized_stone, same_as,
			stone_name
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make (aclassi: CLASS_I)
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			actual_class_i := aclassi
		end

feature -- Properties

	class_i: CLASS_I
		do
			Result := actual_class_i
		end

	class_name: STRING
			-- Name of `class_i'.
		require
			is_valid: is_valid
		do
			Result := class_i.name
		end

	group: CONF_GROUP
			-- Group associated with current.
		require
			is_valid: is_valid
		do
			Result := class_i.group
		ensure
			group_not_void: Result /= Void
		end

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := Cursors.cur_Class
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := Cursors.cur_X_Class
		end

	file_name: like {ERROR}.file_name
			-- File associated with `class_i'.
		do
			Result := class_i.file_name.name
		end

	stone_signature: STRING_32
		do
			Result := class_i.name
		end

	history_name: STRING_32
		do
			Result := Interface_names.s_Class_stone.twin
			Result.append_string (stone_signature)
		end

	header: STRING_GENERAL
			-- Display class name, class' cluster and class location in
			-- window title bar.
		do
			Result := interface_names.l_classi_header (eiffel_system.name,
														 eiffel_universe.target_name,
														 class_i.group.name,
														 stone_signature,
														 class_i.file_name.name)
		end

	synchronized_stone: CLASSI_STONE
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore. It may also
			-- be a classc_stone if the class is compiled now)
		do
			if class_i /= Void and then class_i.is_valid then
				if class_i.is_compiled then
					create {CLASSC_STONE} Result.make (class_i.compiled_class)
				else
					create {CLASSI_STONE} Result.make (class_i)
				end
			end
		end

	stone_name: READABLE_STRING_GENERAL
			-- Name of Current stone
		do
			if is_valid then
				Result := class_i.name.twin
			else
				Result := Precursor
			end
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		do
			Result := class_i /= Void and then class_i.is_valid
		end

	is_dotnet_class: BOOLEAN
		do
			Result := class_i /= Void and then class_i.is_valid and then class_i.is_external_class
		end

	same_as (other: STONE): BOOLEAN
			-- Do `Current' and `other' represent the same class?
		do
			Result := attached {CLASSI_STONE} other as convcur and then class_i.is_equal (convcur.class_i)
				and then equal (class_i.config_class.overriden_by, convcur.class_i.config_class.overriden_by)
		end

feature {NONE} -- Implementation

	actual_class_i: CLASS_I;

invariant
	actual_class_i_not_void: class_i /= Void

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CLASSI_STONE
