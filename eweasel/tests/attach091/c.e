class C

create
	make

feature {NONE} -- Creation

	make (v: attached TEST)
		do
			x := v
			y := v
			z := v
			ax := v
			ay := v
			az := v
			dx := v
			dy := v
			dz := v
		end

feature {TEST} -- Tests

	x: TEST assign set_x -- VFAC(3) (attached)
		note
			$STABLE
		attribute
		end

	set_x (value: detachable TEST)
		do
		end

	y: TEST assign set_y
		note
			$STABLE
		attribute
		end

	set_y (value: TEST)
		do
		end

	z: TEST assign set_z -- VFAC(3) (detachable)
		note
			$STABLE
		attribute
		end

	set_z (value: attached TEST)
		do
		end

	ax: attached TEST assign set_ax -- VFAC(3) (attached) (detachable)
		note
			$STABLE
		attribute
		end

	set_ax (value: detachable TEST)
		do
		end

	ay: attached TEST assign set_ay -- VFAC(3) (detachable)
		note
			$STABLE
		attribute
		end

	set_ay (value: TEST)
		do
		end

	az: attached TEST assign set_az
		note
			$STABLE
		attribute
		end

	set_az (value: attached TEST)
		do
		end

	dx: detachable TEST assign set_dx
		note
			$STABLE
		attribute
		end

	set_dx (value: detachable TEST)
		do
		end

	dy: detachable TEST assign set_dy -- VFAC(3) (attached)
		note
			$STABLE
		attribute
		end

	set_dy (value: TEST)
		do
		end

	dz: detachable TEST assign set_dz -- VFAC(3) (attached) (detachable)
		note
			$STABLE
		attribute
		end

	set_dz (value: attached TEST)
		do
		end

end