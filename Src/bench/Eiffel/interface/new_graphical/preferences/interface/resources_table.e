indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCES_TABLE

inherit
	HASH_TABLE [RESOURCE,STRING]
		
creation

	make

feature -- Access

	get_color (s: STRING): EV_COLOR is
		local
			r: COLOR_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_array (s: STRING; default_result: ARRAY [STRING]): ARRAY [STRING] is
		local
			r: ARRAY_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_integer (s: STRING; default_result: INTEGER): INTEGER is
		local
			r: INTEGER_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_boolean (s: STRING; default_result: BOOLEAN): BOOLEAN is
		local
			r: BOOLEAN_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_string (s: STRING; default_result: STRING): STRING is
		local
			r: STRING_RESOURCE
		do
			Result := default_result
			if has (s) then
				r ?= item (s)
				if r /= Void then
					Result := r.value
				end
			end
		end

feature -- Setting

	set_value (s: STRING; new_value: STRING) is
			-- Used for font, color, and array.
		do
			if has (s) then
				item (s).set_value (new_value)
			else
				io.put_string ("%N ")
				io.put_string (s)
				io.put_string (" does not exist. No affectaion done.")
			end
		end

--	set_color (s: STRING; new_value: EV_COLOR) is
--		do
--			set_value (s, new_value)
--		end

	set_integer (s: STRING; new_value: INTEGER)is
		local
			r: INTEGER_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					r.set_actual_value (new_value)
				end
			end
		end

	set_boolean (s: STRING; new_value: BOOLEAN) is
		local
			r: BOOLEAN_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					r.set_actual_value (new_value)
				end
			end
		end

	set_string (s: STRING; new_value: STRING) is
		local
			r: STRING_RESOURCE
		do
			if has (s) then
				r ?= item (s)
				if r /= Void then
					r.set_value (new_value)
				end
			end
		end

feature -- Element Change

	put_resource (r: RESOURCE) is
			-- adds `r' in Current.
		do
			put (r, r.name)
		end

	replace_resource (r: RESOURCE) is
			-- replace resource `r.name' by `r'.
			-- do nothing if there is no resource calles `r.name'.
		do
			replace (r, r.name)
		end

end -- class RESOURCES_TABLE
