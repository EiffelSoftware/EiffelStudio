indexing
	description: "Objects used as translator between WEL and bench formats for a resource."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	REGISTRY_RESOURCE

creation
	make, make_from_resource

feature -- Initialization
	
	make (s: STRING; root_resource: WEL_REGISTRY_KEY_VALUE) is
			-- initialization
		require
			not_void: root_resource /= Void
		local
		do
			name := s
			key_value := root_resource
			update_value
		end

	make_from_resource (r: RESOURCE) is
			-- initialization
		require
			not_void: r /= Void
		local
		do
			value := r
			name := r.name
			update_key_value
		end

feature -- Access

	value: RESOURCE
		-- Value of the variable.

	key_value: WEL_REGISTRY_KEY_VALUE
		-- WEL representation of the resource

	name: STRING
		-- Name of the variable.

feature -- Implementation

	update_value is
			-- Gets the appropriate resource from `key_value'
			-- if the type is unknown, it is assumed to be a string.
		local
			s: STRING
			type: INTEGER
			b: BOOLEAN
			sprefix: STRING
		do
				--| For backward compatibilities, everything is now stored through STRINGs.
			if key_value.type = key_value.Reg_dword then
				type := integer_type
				create {INTEGER_RESOURCE} value.make (name, key_value.dword_value)
			else
				s := key_value.string_value
				type := string_type
				if name.count > 7 then
					sprefix := name.substring (1, 7)
					if equal (sprefix, "EIFBOL_") then
						type := boolean_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFINT_") then
						type := integer_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFCOL_") then
						type := color_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFFNT_") then
						type := font_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFARR_") then
						type := array_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFSTR_") then
						type := array_type
						name := name.substring (8, name.count)
					else
						check
							error: False
						end
					end

					if type = string_type then
						create {STRING_RESOURCE} value.make (name, s)
					elseif type = color_type then
						create {COLOR_RESOURCE} value.make (name, s)
					elseif type = integer_type then
						create {INTEGER_RESOURCE} value.make (name, s.to_integer)
					elseif type = font_type then
						create {FONT_RESOURCE} value.make (name, s)
					elseif type = boolean_type then
						s.to_upper
						b := s.is_equal ("TRUE")
						create {BOOLEAN_RESOURCE} value.make (name, b)
					elseif type = array_type then
						create {ARRAY_RESOURCE} value.make_from_string (name, s)
					else
						create {STRING_RESOURCE} value.make (name, s)
					end
				else
					check
						Error: False
					end
				end
			end
		end

	update_key_value is
			-- Gets the appropriate resource from `key_value'
			-- if the type is unknown, it is assumed to be a string.
--		local
--			ir: INTEGER_RESOURCE
		do
			create key_value.make
--			ir ?= value
--			if ir /= Void then
--				key_value.set_type (key_value.Reg_dword)
--				key_value.set_dword_value (ir.actual_value)
--			else
				key_value.set_type (key_value.Reg_sz)
				key_value.set_string_value (value.value)
--			end
		end

feature {NONE} -- Constants

	string_type, color_type, integer_type,
	font_type, boolean_type, array_type: INTEGER is unique

feature -- Implementation

	external_name: STRING
		-- Name for the outside world of Current.

invariant
	REGISTRY_RESOURCE_contains_something: value /= Void or key_value /= Void
	REGISTRY_RESOURCE_consistency: name /= Void and not name.empty

end -- class REGISTRY_RESOURCE
