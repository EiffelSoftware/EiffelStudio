indexing
	description: "Access facilities to a standard resource structure."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES

feature -- Initialization

	register_basic_types is
			-- Append basic resource types to the list of known resource types.
		require
			no_registered_type: registered_types.is_empty
		do
			resources.register_basic_types
		ensure
			basic_types_registered: basic_types_registered
		end

	register_basic_graphical_types is
			-- Append the graphical version of the basic resource types to the list of known resource types.
		require
			no_registered_type: registered_types.is_empty
		do
			resources.register_type (create {BOOLEAN_GRAPHICAL_RESOURCE_TYPE}.make)
			resources.register_type (create {INTEGER_GRAPHICAL_RESOURCE_TYPE}.make)
			resources.register_type (create {STRING_GRAPHICAL_RESOURCE_TYPE}.make)
			resources.register_type (create {ARRAY_GRAPHICAL_RESOURCE_TYPE}.make)
			resources.register_type (create {COLOR_GRAPHICAL_RESOURCE_TYPE}.make)
			resources.register_type (create {FONT_GRAPHICAL_RESOURCE_TYPE}.make)
		ensure
			basic_types_registered: basic_types_registered
		end

	initialize (default_file_name: STRING; location: STRING) is
			-- Initialize the resources.
			-- `default_file_name' is the path of the file that contains the default values,
			-- `location' is the path to either:
			--		* the root registry key where preferences are stored,
			--		* or the file where preferences are stored,
			-- depending on which implementation is chosen (registry or xml).
		require
			basic_types_registered: basic_types_registered
		do
			resources.make_from_location (default_file_name, location)
		ensure
			initialized_if_no_error: error_message = Void implies initialized
		end

feature -- Status report

	initialized: BOOLEAN is
			-- Have the preferences been successfully initialized?
		do
			Result := resources.initialized
		ensure
			need_basic_types: Result implies basic_types_registered
		end

	error_message: STRING is
			-- Message explaining why `Current' could not be initialized.
		do
			Result := resources.error_message
		end

	basic_types_registered: BOOLEAN is
			-- Are the basic types of resource (integer, string, etc.) known?
		do
			Result := resources.basic_types_registered
		end

feature -- Access

	resources: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		once
			create Result
		end

	registered_types: LINEAR [RESOURCE_TYPE] is
			-- Known resource types.
		do
			Result := resources.registered_types
		end

	boolean_resource_value (s: STRING; db: BOOLEAN): BOOLEAN is
			-- Get the value of boolean resource named `s'.
			-- Default to `db' if `s' could not be found.
		require
			initialized: initialized
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

	integer_resource_value (s: STRING; di: INTEGER): INTEGER is
			-- Get the value of integer resource named `s'.
			-- Default to `di' if `s' could not be found.
		require
			initialized: initialized
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

	string_resource_value (s: STRING; ds: STRING): STRING is
			-- Get the value of string resource named `s'.
			-- Default to `ds' if `s' could not be found.
		require
			initialized: initialized
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

	array_resource_value (s: STRING; da: ARRAY [STRING]): ARRAY [STRING] is
			-- Get the value of array resource named `s'.
			-- Default to `da' if `s' could not be found.
		require
			initialized: initialized
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

	color_resource_value (s: STRING; rd, gd, bd: INTEGER): EV_COLOR is
			-- Color value of resource named `s', or rgb color defined by
			-- `rd', `gd', `bd' if resource does not exist.
		require
			initialized: initialized
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

	font_resource_value (s: STRING; df: EV_FONT): EV_FONT is
			-- Font value of resource named `s', or font defined by
			-- `df' if resource does not exist.
		require
			initialized: initialized
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				Result := r.actual_value
			else
				Result := df
			end
		end

feature -- Status report

	has_resource (n: STRING): BOOLEAN is
			-- Does a resource with name `n' exist?
		require
			initialized: initialized
		do
			Result := resources.item (n) /= Void
		end

	has_boolean_resource (n: STRING): BOOLEAN is
			-- Does a boolean resource with name `n' exist?
		require
			initialized: initialized
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (n)
			Result := r /= Void
		end

	has_integer_resource (n: STRING): BOOLEAN is
			-- Does an integer resource with name `n' exist?
		require
			initialized: initialized
		local
			r: INTEGER_RESOURCE
		do
			r ?= resources.item (n)
			Result := r /= Void
		end

	has_string_resource (n: STRING): BOOLEAN is
			-- Does a string resource with name `n' exist?
		require
			initialized: initialized
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (n)
			Result := r /= Void
		end

	has_array_resource (n: STRING): BOOLEAN is
			-- Does a string array resource with name `n' exist?
		require
			initialized: initialized
		local
			r: ARRAY_RESOURCE
		do
			r ?= resources.item (n)
			Result := r /= Void
		end

	has_color_resource (n: STRING): BOOLEAN is
			-- Does a color resource with name `n' exist?
		require
			initialized: initialized
		local
			r: COLOR_RESOURCE
		do
			r ?= resources.item (n)
			Result := r /= Void
		end

	has_font_resource (n: STRING): BOOLEAN is
			-- Does a font resource with name `n' exist?
		require
			initialized: initialized
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (n)
			Result := r /= Void
		end

feature -- Setting

	set_boolean_resource (s: STRING; nb: BOOLEAN) is
			-- Set the value of resource `s' to `nb'.
		require
			initialized: initialized
		local
			r: BOOLEAN_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (nb)
			else
				create r.make (s, nb, Resources.registered_types @ Resources.Boolean_type_index)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_integer_resource (s: STRING; ni: INTEGER) is
			-- Set the value of resource `s' to `ni'.
		require
			initialized: initialized
		local
			r: INTEGER_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (ni)
			else
				create r.make (s, ni, Resources.registered_types @ Resources.Integer_type_index)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_string_resource (s: STRING; ns: STRING) is
			-- Set the value of resource `s' to `ns'.
		require
			initialized: initialized
		local
			r: STRING_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_value (ns)
			else
				create r.make (s, ns, Resources.registered_types @ Resources.String_type_index)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_array_resource (a_resource_name: STRING; a_value: ARRAY [STRING]) is
			-- Set the value of `a_resource_name' to `a_value'.
		require
			initialized: initialized
		local
			resource_item: ARRAY_RESOURCE
		do
			resource_item ?= resources.item (a_resource_name)
			if resource_item /= Void then
				resource_item.set_actual_value (a_value)
			else
				create resource_item.make (a_resource_name, a_value, Resources.registered_types @ Resources.Array_type_index)
				resources.root_folder.resource_list.extend (resource_item)
				resources.put_resource (resource_item)
			end
		end

	set_color_resource (s: STRING; nc: EV_COLOR) is
			-- Set the value of resource `s' to `nc'.
		require
			initialized: initialized
			valid_color: nc = Void or else not nc.is_destroyed
		local
			r: COLOR_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_value_with_color (nc.red_8_bit, nc.green_8_bit, nc.blue_8_bit)
			else
				create r.make_with_color (s, nc, Resources.registered_types @ Resources.Color_type_index)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

	set_font_resource (s: STRING; nf: EV_FONT) is
			-- Set the value of resource `s' to `ni'.
		require
			initialized: initialized
			valid_font: nf /= Void and then not nf.is_destroyed
		local
			r: FONT_RESOURCE
		do
			r ?= resources.item (s)
			if r /= Void then
				r.set_actual_value (nf)
			else
				create r.make_with_font (s, nf, Resources.registered_types @ Resources.Font_type_index)
				resources.root_folder.resource_list.extend (r)
				resources.put_resource (r)
			end
		end

feature -- Basic operations

	save_resources is
			-- Commit all changes by saving the registry/.es5rc file.
		require
			initialized: initialized
		do
			resources.save
		end

feature {NONE} -- Implementation

	resources_cell: CELL [RESOURCE_STRUCTURE] is
			-- Cell that contains the resource structure.
		once
			create Result.put (Void)
		end

end -- class SHARED_RESOURCES
