indexing
	description: "EiffelBench resources, with access facilities"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES

feature -- Access

	resources: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		once
			create {RESOURCE_STRUCTURE_IMP} Result.make
		end

feature -- Access

	color_resource_value (s: STRING): EV_COLOR is
		local
			s1: STRING
		do
			Result ?= resources.table.get_value (s)
			if Result= Void then
				s1 := clone (s)
				s1.append (" : resource name has no associated value, default applied.")
				-- Warning, we apply the default.
			end
		end

	font_resource_value (s: STRING): EV_FONT is
		local
			s1: STRING
		do
			Result ?= resources.table.get_value (s)
			if Result= Void then
				s1 := clone (s)
				s1.append (" : resource name has no associated value, default applied.")
				-- Warning, we apply the default.
			end
		end

	array_resource_value (s: STRING; da: ARRAY [STRING]): ARRAY [STRING] is
		do
			Result := resources.table.get_array (s, da)
		end

	integer_resource_value (s: STRING; di: INTEGER): INTEGER is
		do
			Result := resources.table.get_integer (s, di)
		end

	boolean_resource_value (s: STRING; db: BOOLEAN): BOOLEAN is
		do
			Result := resources.table.get_boolean (s, db)
		end

	string_resource_value (s: STRING; ds: STRING): STRING is
		do
			Result := resources.table.get_string (s, ds)
		end

feature -- Setting

	set_integer (s: STRING; ni: INTEGER) is
		do
			resources.table.set_integer (s, ni)
		end

	set_boolean (s: STRING; nb: BOOLEAN) is
		do
			resources.table.set_boolean (s, nb)
		end

	set_string (s: STRING; ns: STRING) is
		do
			resources.table.set_string (s, ns)
		end

end -- class SHARED_RESOURCES
