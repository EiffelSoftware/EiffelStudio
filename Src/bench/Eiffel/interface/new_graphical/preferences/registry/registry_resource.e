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
	
	make (s: STRING; root_resource: WEL_REGISTRY_KEY_VALUE; r: RESOURCE_STRUCTURE) is
			-- initialization
		require
			not_void: root_resource /= Void and r /= Void
		local
		do
			name := s
			structure := r
			key_value := root_resource
			update_value
		end

	make_from_resource (r: RESOURCE; rs: RESOURCE_STRUCTURE) is
			-- initialization
		require
			not_void: r /= Void and rs /= Void
		local
		do
			value := r
			name := r.name
			structure := rs
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
			if key_value.type = key_value.Reg_dword then
				type := integer_type
			elseif key_value.type = key_value.Reg_multi_sz then
				type := array_type
			else
				s := key_value.string_value
				type := string_type
				if name.count > 7 then
					sprefix := name.substring (1, 7)
					if equal (sprefix, "EIFBOL_") then
						type := boolean_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFCOL_") then
						type := color_type
						name := name.substring (8, name.count)
					elseif equal (sprefix, "EIFFNT_") then
						type := font_type
						name := name.substring (8, name.count)
					end
				end
			end
					
			if type = string_type then
				create {STRING_RESOURCE} value.make (name, s)
			elseif type = color_type then
				create {COLOR_RESOURCE} value.make (name, s)
			elseif type = integer_type and then s.is_integer then
				create {INTEGER_RESOURCE} value.make (name, key_value.dword_value)
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
			structure.table.add_resource (value)
		end

	update_key_value is
			-- Gets the appropriate resource from `key_value'
			-- if the type is unknown, it is assumed to be a string.
		local
			type: INTEGER
			ir: INTEGER_RESOURCE
			br: BOOLEAN_RESOURCE
			cr: COLOR_RESOURCE
			fr: FONT_RESOURCE
			sr: STRING_RESOURCE
			ar: ARRAY_RESOURCE
		do
			create key_value.make
			ir ?= value
			if ir /= Void then
				key_value.set_type (key_value.Reg_dword)
				key_value.set_dword_value (ir.actual_value)
			else
				ar ?= value
				if ar /= void then
					key_value.set_type (key_value.Reg_multi_sz)
					key_value.set_string_value (ar.value)
				else
					key_value.set_type (key_value.Reg_sz)
					key_value.set_string_value (value.value)
				end
			end
		end

feature {NONE} -- Constants

	string_type, color_type, integer_type,
	font_type, boolean_type, array_type: INTEGER is unique

feature -- Implementation

	structure: RESOURCE_STRUCTURE
		-- Structure of the resources.

	external_name: STRING
		-- Name for the outside world of Current.

invariant
	XML_RESOURCE_not_void: structure /= Void and name /= Void and value /= Void and key_value /= Void
	XML_RESOURCE_consistency: not name.empty

end -- class REGISTRY_RESOURCE
