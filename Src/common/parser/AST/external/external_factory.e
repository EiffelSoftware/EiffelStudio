indexing
	description: "External AST node factories"
	status: "See notice at the end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_FACTORY

feature -- Low level factories

	new_external_type_as (id: ID_AS; type_prefix: STRING; is_struct: BOOLEAN; nb_pointer: INTEGER;
			is_byref: BOOLEAN): EXTERNAL_TYPE_AS
		is
			-- New EXTERNAL_TYPE_AS node.
		require
			id_not_void: id /= Void
		do
			create Result
			if type_prefix /= Void then
				id.prepend (type_prefix)
			end
			Result.initialize (id, is_struct, nb_pointer, is_byref)
		ensure
			Result_not_void: Result /= Void
		end

	new_double_quote_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			s.prepend_character ('%"')
			s.append_character ('%"')
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

	new_system_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			s.prepend_character ('<')
			s.append_character ('>')
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

end -- class EXTERNAL_FACTORY

--|----------------------------------------------------------------
--| Copyright (C), Interactive Software Engineering Inc.
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
