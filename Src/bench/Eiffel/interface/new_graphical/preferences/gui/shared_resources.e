indexing
	description: "EiffelBench resources, with access facilities"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES

inherit
	EIFFEL_ENV

feature -- Access

	resources: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		once
			create Result.make_from_location (System_general, Eiffel_preferences)
		end

feature -- Access

	color_resource_value (s: STRING): EV_COLOR is
			-- Color resource. Can be Void if no color resource called `s' exists.
		local
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			end
		end

	secure_color_resource_value (s: STRING; rd, gd, bd: INTEGER): EV_COLOR is
			-- Color value of resource named `s', or rgb color defined by
			-- `rd', `gd', `bd' if resource does not exist.
		local
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create Result.make_with_8_bit_rgb (rd, gd, bd)
			end
		end

	font_resource_value (s: STRING): EV_FONT is
			-- Font value of resource named `s', or a default font
			-- if resource does not exist.
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create r.make (s, "verdana,arial,helvetica-r-regular-12-screen")
				Result := r.actual_value
			end
		end

	secure_font_resource_value (s: STRING; df: STRING): EV_FONT is
			-- Font value of resource named `s', or font defined by
			-- `df' if resource does not exist.
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create r.make (s, df)
				Result := r.actual_value
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
			else
				create r.make (s, ni)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_boolean (s: STRING; nb: BOOLEAN) is
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (nb)
			else
				create r.make (s, nb)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_string (s: STRING; ns: STRING) is
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_value (ns)
			else
				create r.make (s, ns)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_array (a_resource_name: STRING; a_value: ARRAY [STRING]) is
			-- Set the value of `a_resource_name' to `a_value'.
		local
			resource_item: ARRAY_RESOURCE
		do
			resource_item ?= resources.item (a_resource_name)
			if resource_item /= Void then
				resource_item.set_actual_value (a_value)
			else
				create resource_item.make (a_resource_name, a_value)
				resources.root_folder.resource_list.extend (resource_item)
				resources.put_resource (resource_item)
			end
		end

feature -- Basic operations

	save_resources is
			-- Commit all changes by saving the registry/.es5rc file.
		do
			resources.save
		end

end -- class SHARED_RESOURCES
