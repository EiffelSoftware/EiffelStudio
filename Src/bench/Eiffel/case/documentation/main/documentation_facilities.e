indexing
	description: "Routines generally used by documentation generating classes."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_FACILITIES

inherit
	SHARED_EIFFEL_PROJECT

feature -- Access

	is_class_name (s: STRING): BOOLEAN is
			-- Could `s' be the name of a class?
			-- i.e. Does `s' consist of only underscores, uppercases and digits.
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := True
			from i := 1 until not Result or else i > s.count loop
				c := s @ i
				i := i + 1
				Result := c = '_' or else c.is_upper or else c.is_digit
			end
		end

	class_by_name (name: STRING): CLASS_I is
			-- Return class with `name'. `Void' if not in system.
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

	cluster_by_name (name: STRING): CLUSTER_I is
			-- Return cluster with `name'. `Void' if not in system.
		do
			Result := Eiffel_universe.cluster_of_name (name)
		end

	feature_by_name (name: STRING): E_FEATURE is
			-- Return feature in current class with `name'. `Void' if not in system.
		local
			cc: CLASS_C
		do
			cc := Eiffel_system.System.current_class
			if cc /= Void then
				Result := cc.feature_with_name (name)
			end
		end

end -- class DOCUMENTATION_FACILITIES
