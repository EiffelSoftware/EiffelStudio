expanded class POINT

inherit
	ANY
		redefine
			default_create,
			out
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'.
		do
			x := 3
			y := 7
		end

feature -- Access

	x: INTEGER
			-- Coordinate x.

	y: INTEGER
			-- Coordinate y.

feature -- Movement

	move (delta_x: like x; delta_y: like y)
			-- Change `x' and `y' by `delta_x' and `delta_y' respectively.
		do
			x := x + delta_x
			y := y + delta_y
		ensure
			x_set: x = old x + delta_x
			y_set: y = old y + delta_y
		end

	moved (delta_x: like x; delta_y: like y): POINT
			-- A copy of current object moved by `delta_x' and `delta_y'.
		do
			Result := Current
			Result.move (delta_x, delta_y)
		ensure
			x_set: Result.x = x + delta_x
			y_set: Result.y = y + delta_y
		end

feature -- Modification

	set_x (value: like x)
			-- Set `x' to `value'.
		do
			x := value
		ensure
			x_set: x = value
		end

	set_y (value: like y)
			-- Set `y' to `value'.
		do
			y := value
		ensure
			y_set: y = value
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := "(" + x.out + ", " +y.out + ")"
		end

end
