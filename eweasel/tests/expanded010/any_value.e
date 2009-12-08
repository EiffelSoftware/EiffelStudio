indexing
	description: "Containing any value."
	author: "Gyrd Thane Lange"
	date: "$Date$"
	revision: "$Revision$"

class
	ANY_VALUE

inherit
    ANY
    	redefine
    		out
    	end

create
	make,
	make_null

feature -- Initialization

	make (v: like value) is
		do
			set_value (v)
		end

	make_null is
		do
			is_null := True
		end

feature -- Access

	is_null: BOOLEAN

	value: ANY

	out: STRING is
		-- Printable representation of value
		local
			v_ref: DOUBLE_REF
		do
			v_ref ?= value
			if v_ref /= Void then
				Result := v_ref.item.truncated_to_real.out
			else
				Result := value.out
			end
		end

feature -- Element change

	set_null is
		do
			is_null := True
		end

	set_value (v: like value) is
		do
			value := v
			is_null := False
		end

feature -- Conversion

	to_string, string_value: STRING is
		do
			if value /= Void then
				Result := value.out
			end
		end

	to_character, character_value: CHARACTER is
		local
			c_ref: CHARACTER_REF
			s: STRING
		do
			c_ref ?= value
			if c_ref /= Void then
				Result := c_ref.item
			else
				s := string_value
				if s /= Void and then not s.is_empty then
					Result := s.item(1)
				end
			end
		end

	to_integer, integer_value: INTEGER is
		local
			i_ref: INTEGER_REF
			s: STRING
		do
			i_ref ?= value
			if i_ref /= Void then
				Result := i_ref.item
			else
				s := string_value
				if s /= Void and then s.is_integer then
					Result := s.to_integer
				end
			end
		end

	to_double, double_value: DOUBLE is
		local
			v_ref: DOUBLE_REF
			s: STRING
		do
			v_ref ?= value
			if v_ref /= Void then
				Result := v_ref.item
			else
				s := string_value
				if s /= Void and then s.is_double then
					Result := s.to_double
				end
			end
		end

	to_boolean, boolean_value: BOOLEAN is
		local
			s: STRING
		do
			s := string_value
			if s /= Void and then s.is_boolean then
				Result := s.to_boolean
			end
		end

feature {NONE} -- Implementation

	date_time_tools: expanded ANY

invariant
	invariant_clause: -- Your invariant here

end -- class ANY_VALUE
