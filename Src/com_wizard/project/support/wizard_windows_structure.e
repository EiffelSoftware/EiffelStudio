indexing
	description: "Windows structure"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WINDOWS_STRUCTURE

create
	make

feature {NONE} -- Initialization

	make (a_line: STRING) is
			-- Initialize
		require
			non_void_line: a_line /= Void
			valid_line: not a_line.is_empty
		local
			i, J, a_count: INTEGER
			words: ARRAY [STRING]
			tmp_string: STRING
		do
			a_count := a_line.count
			from
				i := 1
				j := 1
				create words.make (1, 3)
			variant
				a_count - i + 1
			until
				i > a_count
			loop
				from
				until
					i > a_count or else
					a_line.item (i) /= ' ' 
				loop
					i := i + 1
				end

				from
					create tmp_string.make (100)
					words.put (tmp_string, j)
				until
					i > a_count or else
					a_line.item (i) = ' ' 
				loop
					words.item (j).append_character (a_line.item (i))
					i := i + 1
				end
				j := j + 1
			end
			name := words.item (1)
			file_protector := words.item (2)
			structure_protector := words.item (3)
		ensure
			non_void_name:  name /= Void
			valid_name: not name.is_empty
		end

feature -- Access

	name: STRING 
			-- Structure name.

	file_protector: STRING
			-- File protector name for file where structure is defined.

	structure_protector: STRING
			-- Structure protector name.

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty
	non_void_file_protector: file_protector /= Void
	valid_file_protector: not file_protector.is_empty

end -- class WIZARD_WINDOWS_STRUCTURE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
