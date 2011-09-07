class A [G]

create
	make

feature {NONE} -- Creation

	make (v: attached G)
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

	x: G assign set_x -- VFAC(3)
		note
			option: stable
		attribute
		end

	set_x (value: detachable G)
		do
		end

	y: G assign set_y -- VFAC(3)
		note
			option: stable
		attribute
		end

	set_y (value: G)
		do
		end

	z: G assign set_z
		note
			option: stable
		attribute
		end

	set_z (value: attached G)
		do
		end

	ax: attached G assign set_ax -- VFAC(3)
		note
			option: stable
		attribute
		end

	set_ax (value: detachable G)
		do
		end

	ay: attached G assign set_ay -- VFAC(3)
		note
			option: stable
		attribute
		end

	set_ay (value: G)
		do
		end

	az: attached G assign set_az
		note
			option: stable
		attribute
		end

	set_az (value: attached G)
		do
		end

	dx: detachable G assign set_dx -- VFAC(3)
		note
			option: stable
		attribute
		end

	set_dx (value: detachable G)
		do
		end

	dy: detachable G assign set_dy -- VFAC(3)
		note
			option: stable
		attribute
		end

	set_dy (value: G)
		do
		end

	dz: detachable G assign set_dz
		note
			option: stable
		attribute
		end

	set_dz (value: attached G)
		do
		end

end