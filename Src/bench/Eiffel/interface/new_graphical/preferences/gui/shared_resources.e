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
				create Result.make_from_location (System_general, "HKEY_CURRENT_USER\Software\ISE\Eiffel50")
			else
				create environment
				create file_name.make_from_string (environment.home_directory_name)
				file_name.set_file_name (".es5rc")
				create Result.make_from_location (System_general, file_name)
			end
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

feature {NONE} -- File names

	system_general: FILE_NAME is
			-- General system level resource specification file
			-- ($EIFFEL5/eifinit/application_name/general)
		local
			Eiffel5: STRING
		do
			Eiffel5 := Exec_environment.get ("EIFFEL5")
			if Eiffel5 /= Void then
				create Result.make_from_string (Eiffel5)
				if Platform_constants.is_windows then
					Result.extend_from_array (<<"eifinit", "bench", "spec", "windows">>)
				else
					Result.extend_from_array (<<"eifinit", "bench", "spec", "gtk">>)
				end
				Result.set_file_name ("default")
				Result.add_extension ("xml")
			end
		ensure
			Result_not_empty: Result /= Void
		end

feature {NONE} -- Constants

	Exec_environment: EXECUTION_ENVIRONMENT is
		once	
			create Result
		end

end -- class SHARED_RESOURCES
