indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCES_TABLE

inherit
	HASH_TABLE[RESOURCE,STRING]
		
creation

	make

feature -- Access

	get_value(s: STRING): ANY is
			-- Used for font, color, and array.
		do
			if has(s) then
				Result := item(s).get_value
			else
				io.put_string("%NValue of ")
				io.put_string(s)
				io.put_string(" not supplied, default applied.")
			end
		end

	get_color(s: STRING): EV_COLOR is
		do
			Result ?= get_value(s)
		end

	get_integer(s: STRING; default_result: INTEGER): INTEGER is
		local
			r: INTEGER_RESOURCE
		do
			Result:= default_result
			if has(s) then
				r ?= item(s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_boolean(s: STRING; default_result: BOOLEAN): BOOLEAN is
		local
			r: BOOLEAN_RESOURCE
		do
			Result:= default_result
			if has(s) then
				r ?= item(s)
				if r /= Void then
					Result := r.actual_value
				end
			end
		end

	get_string(s: STRING; default_result: STRING): STRING is
		local
			r: STRING_RESOURCE
		do
			Result:= default_result
			if has(s) then
				r ?= item(s)
				if r /= Void then
					Result := r.value
				end
			end
		end



end -- class RESOURCES_TABLE
