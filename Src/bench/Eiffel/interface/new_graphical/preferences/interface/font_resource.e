indexing
	description	: "A resource value for string resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_RESOURCE

inherit
	STRING_RESOURCE
		redefine
			make, set_value, xml_trace, registry_name
		end

	EV_FONT_CONSTANTS
		undefine
			is_equal
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := a_value
			set_value (a_value)
			if a_value /= Void then
				set_value (a_value)
			end
		end

feature -- Access

	actual_value: EV_FONT is
			-- Font value
		local
			i, j: INTEGER
		do
			create Result.make_with_values (family, weight, shape, height)
			from
				i := 1
				j := faces.index_of (',', i)
			until
				j = 0
			loop
				Result.preferred_faces.extend (faces.substring (i, j))
				i := j + 1
				j := faces.index_of (',', i)
			end
			Result.preferred_faces.extend (faces.substring (i, faces.count))
		end

	valid_actual_value: EV_FONT is
			-- A non void font value
		do
			Result := actual_value
			if Result = Void then
				create Result
			end
		ensure
			valid_result: Result /= Void
		end;

feature -- Status Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		local
			s: STRING
			i: INTEGER
			syntax_is_bad: BOOLEAN
		do
			value := new_value
			s := clone (value)
			i := s.index_of('-', 1)
			if i > 0 then
				faces := s.substring (1, i - 1)
				s := s.substring (i + 1, s.count)
				i := s.index_of ('-',1)
				if i > 0 then
					set_shape (s.substring (1, i - 1))
					s := s.substring (i + 1, s.count)
					i := s.index_of ('-',1)
					if i > 0 then
						set_weight (s.substring (1, i - 1))
						s := s.substring (i + 1, s.count)
						i := s.index_of ('-',1)
						if i > 0 then
							set_height (s.substring (1, i - 1))
							set_family (s.substring (i + 1, s.count))
						end
					end
				end
			end
		end

feature -- Implementation

	faces : STRING

	shape, weight, height, family: INTEGER

	set_shape (s: STRING) is
			-- Set shape according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s
			s1.to_lower
			if s1.is_equal ("i") or s1.is_equal ("italic") then
				shape := Ev_font_shape_italic
			elseif s1.is_equal ("r") or s1.is_equal ("regular") then
				shape := Ev_font_shape_regular
			end
		end

	set_weight (s: STRING) is
			-- Set `weight' according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s
			s1.to_lower
			if s1.is_equal ("thin") then
				weight := Ev_font_weight_thin
			elseif s1.is_equal ("regular") then
				weight := Ev_font_weight_regular
			elseif s1.is_equal ("bold") then
				weight := Ev_font_weight_bold
			elseif s1.is_equal ("black") then
				weight := Ev_font_weight_black
			end
		end

	set_family (s: STRING) is
			-- Set `family' according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s
			s1.to_lower
			if s1.is_equal ("screen") then
				family := Ev_font_family_screen
			elseif s1.is_equal ("roman") then
				family := Ev_font_family_roman
			elseif s1.is_equal ("sans") then
				family := Ev_font_family_sans
			elseif s1.is_equal ("typewriter") then
				family := Ev_font_family_typewriter
			elseif s1.is_equal ("modern") then
				family := Ev_font_family_modern
			end
		end

	set_height (s: STRING) is
			-- Set `height' according to `s'
		require
			not_void: s /= Void
		do
			if s.is_integer then
				height := s.to_integer
			end
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		local
			xml_name, xml_value: STRING
		do
			xml_name := name
			xml_value := value

			create Result.make (27 + xml_name.count + xml_value.count)
			Result.append ("<TEXT>")
			Result.append (xml_name)
			Result.append ("<FONT>")
			Result.append (xml_value)
			Result.append ("</FONT></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFFON_" + name
		end


end -- class FONT_RESOURCE
