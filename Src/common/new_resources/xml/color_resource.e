indexing
 
	description:
		"A resource value for color resources."
	date: "$Date$"
	revision: "$Revision$"
 
class
	COLOR_RESOURCE 
 
inherit
	STRING_RESOURCE
		redefine
			set_value, make, get_value
		end
 
creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := a_value
			if a_value /= Void then
				set_value (a_value)
			end
		end
 
feature -- Access

	actual_value: EV_COLOR
			-- Color value of resource

	valid_actual_value: EV_COLOR is
			-- Non void color value
		do
			Result := actual_value
			if Result = Void then
				Result := default_color
			end
		ensure
			valid_result: Result /= Void
		end;

	default_color: EV_COLOR is
			-- Default color
		once
			create Result.make_rgb(255,255,255)
		end

	get_value: EV_COLOR is
		-- No use
		do
			Result := actual_value
		end

feature -- Status setting

	set_value_with_color (new_value: STRING; col: EV_COLOR) is
		require
			color_exists: col /= Void
			value_exists: new_value /= Void
		do
			value := new_value
			actual_value := col
		end

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		local
			col: EV_COLOR
			s1: STRING
			r,g,b,i1: INTEGER
		do
			value := new_value
			s1 := clone(value)
			i1 := s1.index_of(';',1)
			if i1>0 then
				r := convert(s1,i1)
				s1 := s1.substring(i1+1, s1.count)
				i1 := s1.index_of(';',1)
				if i1>0 then
					g := convert(s1,i1)
					s1 := s1.substring(i1+1, s1.count)
					b := convert(s1,s1.count+1)
				else
					g := -1
				end
			else
				r:=-1
			end
			if r>-1 and r<256 and g>-1 and g<256 and b>-1 and b<256 then
				-- Correct color 
				!! col.make_rgb(r,g,b)
			else
				!! col.make_rgb(0,0,0)
			end
			if col=Void then
				actual_value := Void
			else
				actual_value:= col
			end
		end

	convert (s: STRING; i: INTEGER):INTEGER is
		require
			not_void: s /= Void
			index_possible: i>1 and then i<=s.count+1	
		local
			s1: STRING
		do
			s1 := s.substring(1,i-1)
			if s1.is_integer then
				Result := s1.to_integer
			else
				Result := -1
			end
		end

end -- class COLOR_RESOURCE
