indexing

	description: "AST node factories"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class AST_FACTORY

feature -- Access

	new_class_as (n: ID_AS;
		is_d, is_e, is_s: BOOLEAN;
		ind: EIFFEL_LIST [INDEX_AS];
		g: EIFFEL_LIST [FORMAL_DEC_AS];
		p: EIFFEL_LIST [PARENT_AS];
		c: EIFFEL_LIST [CREATE_AS];
		f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
		inv: INVARIANT_AS;
		s: SUPPLIERS_AS;
		o: STRING_AS;
		cl: CLICK_LIST;
		e: INTEGER): CLASS_AS is
			-- New CLASS AST node
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
			cl_not_void: cl /= Void
		do
			!! Result
			Result.initialize (n, is_d, is_e, is_s, ind, g, p, c, f, inv, s, o, cl, e)
		ensure
			class_as_not_void: Result /= Void
			class_name_set: Result.class_name = n
			is_deferred_set: Result.is_deferred = is_d
			is_expanded_set: Result.is_expanded = is_e
			is_separate_set: Result.is_separate = is_s
			indexes_set: Result.indexes = ind
			generics_set: Result.generics = g
			parents_set: Result.parents = p
			creators_set: Result.creators = c
			features_set: Result.features = f
			invariant_part_set: Result.invariant_part = inv
			suppliers_set: Result.suppliers = s
			obsolete_message_set: Result.obsolete_message = o
			click_list_set: Result.click_list = cl
			end_position_set: Result.end_position = e
		end

end -- class AST_FACTORY


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
