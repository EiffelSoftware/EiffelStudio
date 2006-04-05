indexing
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
			is_valid, synchronized_stone, same_as
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make (aclassi: CLASS_I) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			actual_class_i := aclassi
		end

feature -- Properties

	class_i: CLASS_I is
		do
			Result := actual_class_i
		end

	class_name: STRING is
			-- Name of `class_i'.
		do
			Result := class_i.name
		end

	group: CONF_GROUP is
			-- Group associated with current.
		do
			Result := class_i.group
		ensure
			group_not_void: Result /= Void
		end

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := Cursors.cur_Class
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := Cursors.cur_X_Class
		end

	file_name: FILE_NAME is
			-- File associated with `class_i'.
		do
			Result := class_i.file_name
		end

	stone_signature: STRING is
		do
			Result := class_i.name_in_upper
		end

	history_name: STRING is
		do
			Result := Interface_names.s_Class_stone + stone_signature
		end

	same_as (other: STONE): BOOLEAN is
			-- Do `Current' and `other' represent the same class?
		local
			convcur: CLASSI_STONE
		do
			convcur ?= other
			Result := convcur /= Void and then class_i.is_equal (convcur.class_i)
		end

feature -- Access

	header: STRING is
			-- Display class name, class' cluster and class location in
			-- window title bar.
		do
			create Result.make (20)
			Result.append (stone_signature)
			Result.append ("  in cluster ")
			Result.append (class_i.group.name)
			Result.append ("  (not in system)")
			Result.append ("  located in ")
			Result.append (class_i.file_name)
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := class_i /= Void and class_i.is_valid
		end

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore. It may also
			-- be a classc_stone if the class is compiled now)
		local
			l_classes: LIST [CLASS_I]
			l_class: CLASS_I
		do
			if class_i /= Void then
				l_classes := Eiffel_Universe.classes_with_name (class_i.name)
				if l_classes /= Void and l_classes.count = 1 then
					l_class := l_classes.first
					if l_class.compiled then
						create {CLASSC_STONE} Result.make (l_class.compiled_class)
					else
						create {CLASSI_STONE} Result.make (l_class)
					end
				end
			end
		end

feature -- Implementation

	actual_class_i: CLASS_I;

invariant
	actual_class_i_not_void: actual_class_i /= Void

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

end -- class CLASSI_STONE
