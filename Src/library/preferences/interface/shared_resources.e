indexing
	description: "EiffelStudio resources, with access facilities"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES

feature -- Initialization

	initialize (default_file_name: STRING; location: STRING) is
			-- Initialize the resources.
			-- `default_file_name' is the path of the file that contains the default values,
			-- `location' is the path to either:
			--		* the registry key where preferences are stored,
			--		* or the file where preferences are stored,
			-- depending on which implementation is chosen (registry or xml).
		do
			resources_cell.put (create {RESOURCE_STRUCTURE}.make_from_location (default_file_name, location))
		ensure
			initialized_if_no_error: error_message = Void implies initialized
		end

feature -- Access

	initialized: BOOLEAN is
			-- Have the preferences been successfully initialized?
		do
			Result := Resources_cell.item /= Void and then Resources_cell.item.error_message = Void
		end

	error_message: STRING is
			-- Message explaining why `Current' could not be initialized.
		do
			if Resources_cell.item /= Void then
				Result := Resources_cell.item.error_message
			end
		end

	resources: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		require
			initialized: initialized
		do
			Result := resources_cell.item
		end

feature -- Access

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

	font_resource_value (s: STRING; df: STRING): EV_FONT is
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
				create r.make (s, df)
				Result := r.actual_value
			end
		end

	array_resource_value (s: STRING; da: ARRAY [STRING]): ARRAY [STRING] is
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

	integer_resource_value (s: STRING; di: INTEGER): INTEGER is
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

	boolean_resource_value (s: STRING; db: BOOLEAN): BOOLEAN is
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

	string_resource_value (s: STRING; ds: STRING): STRING is
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
				create r.make (s, nb)
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
				create r.make (s, ni)
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
				create r.make (s, ns)
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
				create resource_item.make (a_resource_name, a_value)
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
				create r.make_with_color (s, nc)
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
				create r.make_with_font (s, nf)
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
