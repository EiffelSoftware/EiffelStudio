indexing
	description: "EiffelBench resources, with access facilities"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES

inherit
	SHARED_PLATFORM_CONSTANTS

feature -- Access

	resources: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		local
			file_name: FILE_NAME
			environment: EXECUTION_ENVIRONMENT
		once
			if Platform_constants.is_windows then
				create Result.make_from_location ("D:\46dev\bench.xml","HKEY_CURRENT_USER\Software\ISE\Eiffel46")
			else
				create environment
				create file_name.make_from_string (environment.home_directory_name)
				file_name.set_file_name (".es4rc")
				create Result.make_from_location ("/home/bonnard/bench.xml", file_name)
			end
		end

feature -- Access

	color_resource_value (s: STRING): EV_COLOR is
			-- Color resource. Can be Void if no color resource called `s' exists.
		local
			s1: STRING
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
			s1: STRING
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Create Result.make_with_rgb_with_8_bits (rd, gd, bd)
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
