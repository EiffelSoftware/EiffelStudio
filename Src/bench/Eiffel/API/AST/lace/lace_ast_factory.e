indexing

	description: "Lace AST node factories"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_AST_FACTORY

feature -- Checking

	valid_identifier (st: STRING): BOOLEAN is
			-- Is `st' a valid identifer for Lace syntax.
		local
			i, nb: INTEGER
		do
			Result := st /= Void and then not st.is_empty
			if
				Result and then
				valid_first_identifier_character (st.item (1))
			then
				from
					nb := st.count
					i := 2
				until
					i > nb or not Result
				loop
					Result := valid_identifier_character (st.item (i))
					i := i + 1
				end
			end
		end

	valid_first_identifier_character (c: CHARACTER): BOOLEAN is
			-- Is `c' a good character as first character of a Lace identifier?
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z' then
				Result := True
			else
			end
		end

	valid_identifier_character (c: CHARACTER): BOOLEAN is
			-- Is `c' a good character as first character of a Lace identifier?
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
				Result := True
			else
			end
		end

feature -- Access

	new_id_sd (s: STRING; is_str: BOOLEAN): ID_SD is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			!! Result.initialize (s)
			if is_str then
				Result.set_is_string
			end
		ensure
			id_sd_not_void: Result /= Void
		end

	new_clas_visi_sd (cn, vn: ID_SD; cr, er: LACE_LIST [ID_SD];
		r: LACE_LIST [TWO_NAME_SD]): CLAS_VISI_SD is
			-- New CLAS_VISI AST node
		require
			cn_not_void: cn /= Void
		do
			!! Result.initialize (cn, vn, cr, er, r)
		ensure
			clas_visi_sd_not_void: Result /= Void
			class_name_set: Result.class_name = cn
			visible_name_set: Result.visible_name = vn
			creation_restriction_set: Result.creation_restriction = cr
			export_restriction_set: Result.export_restriction = er
			renamings_set: Result.renamings = r
		end

	new_file_name_sd (fn: ID_SD): FILE_NAME_SD is
			-- New EXCLUDE AST node
		require
			fn_not_void: fn /= Void
		do
			create Result.initialize (fn)
		ensure
			exclude_sd_not_void: Result /= Void
			file__name: Result.file__name = fn
		end

end -- class LACE_AST_FACTORY

--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
