indexing
	description: "Routines generally used by documentation generating classes."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_FACILITIES

inherit
	SHARED_EIFFEL_PROJECT

feature -- Access

	class_by_name (name: STRING): CLASS_I is
			-- Return class with `name'. `Void' if not in system.
		require
			name_not_void: name /= Void
			is_class_name: (create {IDENTIFIER_CHECKER}).is_valid_upper (name)
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
		require
			name_not_void: name /= Void
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
