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

	x: detachable G
			-- X position of `Current'.

	y: detachable G
			-- Y position of `Current'.

	attached_x: G
			-- Attached `x'
		require
			set: attached x
		local
			l_x: like x
		do
			l_x := x
			check l_x /= Void end -- Implied by precondition `set'
			Result := l_x
		end

	attached_y: G
			-- Attached `y'
		require
			set: attached y
		local
			l_y: like y
		do
			l_y := y
			check l_y /= Void end -- Implied by precondition `set'
			Result := l_y
		end

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result.make (attached_x.one, attached_y.one)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result.make (attached_x.zero, attached_y.zero)
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

	is_x_y_set: BOOLEAN
			-- If `x' and `y' has been set?
		do
			Result := (attached x) and (attached y)
		end

feature -- Basic operations

	plus alias "+" (other: like Current): like Current
			-- Sum with `other' (commutative).
		do
			create Result.make (attached_x + other.attached_x, attached_y + other.attached_y)
		end

	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other'
		do
			create Result.make (attached_x - other.attached_x, attached_y - other.attached_y)
		end

	product alias "*" (other: like Current): like Current
			-- Product by `other'
		local
			l_result: detachable like product
		do
			check
				implement: False
			end
			check l_result /= Void end -- Satisfy void-safe compiler
			Result := l_result
		end

	quotient alias "/" (other: like Current): like Current
			-- Division by `other'
		local
			l_result: detachable like quotient
		do
			check implement: False end
			check l_result /= Void end -- Satisfy void-safe compiler
			Result := l_result
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result.make (attached_x, attached_y)
		end

	opposite alias "-": like Current
			-- Unary minus
		do
			create Result.make (-attached_x, -attached_y)
		end

	scalar_product alias "|*" (other: G): like Current
			-- Scalar product between `Current' and other.
		do
			create Result.make (attached_x * other, attached_y * other)
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

