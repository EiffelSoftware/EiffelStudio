indexing
	description: "Facilities for convenient use of the API."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_API_ROUTINES

feature -- Access

	feature_type_as_class_c (f: E_FEATURE): CLASS_C is
			-- Associated class of `f.type'.
			-- Void if not present.
		local
			t: TYPE_A
		do
			t := f.type
			if t /= Void and then t.has_associated_class then
				Result := t.associated_class
			end
		end

	feature_type_as_class_i (f: E_FEATURE): CLASS_I is
			-- Associated class of `f.type'.
			-- Void if not present.
		local
			t: TYPE_A
		do
			t := f.type
			if t /= Void and then t.has_associated_class then
				Result := t.associated_class.lace_class
			end
		end

	class_i_by_name (name: STRING): CLASS_I is
			-- Return class with `name'.
			-- `Void' if not in system.
		local
			cl: LIST [CLASS_I]
		do
			cl := (create {SHARED_EIFFEL_PROJECT}).Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

end -- class SHARED_API_ROUTINES
