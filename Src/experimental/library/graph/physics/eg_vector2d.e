note
	description: "Objects that is a two dimensional vector."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_VECTOR2D [G -> NUMERIC]

inherit
	EG_VECTOR [G]

create
	make,
	default_create

feature -- Initialization

	make, set (ax, ay: G)
			-- Set `x' to `ax' and `y' to `ay'.
		do
			x := ax
			y := ay
		ensure
			set: x = ax and y = ay
		end

feature -- Access

	x: G
			-- X position of `Current'.

	y: G
			-- Y position of `Current'.

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result.make (x.one, y.one)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result.make (x.zero, y.zero)
		end

feature -- Status report

	divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		do
			Result := False
		end

	exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
		do
			Result := True
		end

feature -- Basic operations

	plus alias "+" (other: like Current): like Current
			-- Sum with `other' (commutative).
		do
			create Result.make (x + other.x, y + other.y)
		end

	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other'
		do
			create Result.make (x - other.x, y - other.y)
		end

	product alias "*" (other: like Current): like Current
			-- Product by `other'
		do
			check
				implement: False
			end
		end

	quotient alias "/" (other: like Current): like Current
			-- Division by `other'
		do
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result.make (x, y)
		end

	opposite alias "-": like Current
			-- Unary minus
		do
			create Result.make (-x, -y)
		end

	scalar_product alias "|*" (other: G): like Current
			-- Scalar product between `Current' and other.
		do
			create Result.make (x * other, y * other)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_VECTOR2D

