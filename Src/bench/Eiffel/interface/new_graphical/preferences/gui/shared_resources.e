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
			create Result.make
		end

feature -- Access

	color_resource_value (s: STRING): EV_COLOR is
		local
			s1: STRING
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				s1 := clone (s)
				s1.append (" : resource name has no associated value, default applied.")
					-- Warning, we apply the default.
			end
		end

	font_resource_value (s: STRING): EV_FONT is
		local
			s1: STRING
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
--				Result := df
				s1 := clone (s)
				s1.append (" : resource name has no associated value, default applied.")
--				io.put_string (s1)
					-- Warning, we apply the default.
			end
		end

	array_resource_value (s: STRING; da: ARRAY [STRING]): ARRAY [STRING] is
		local
			r: ARRAY_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := da
			end
		end

	integer_resource_value (s: STRING; di: INTEGER): INTEGER is
		local
			r: INTEGER_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := di
			end
		end

	boolean_resource_value (s: STRING; db: BOOLEAN): BOOLEAN is
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := db
			end
		end

	string_resource_value (s: STRING; ds: STRING): STRING is
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.value
			else
				Result := ds
			end
		end

feature -- Setting

	set_integer (s: STRING; ni: INTEGER) is
		local
			r: INTEGER_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (ni)
			end
		end

	set_boolean (s: STRING; nb: BOOLEAN) is
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (nb)
			end
		end

	set_string (s: STRING; ns: STRING) is
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_value (ns)
			end
		end

end -- class SHARED_RESOURCES
