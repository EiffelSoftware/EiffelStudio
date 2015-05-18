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

	x: TEST $MASK_ATTACHED assign set_x -- stable, unstable: VFAC(3) (attached)
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

	z: TEST $MASK_UNSTABLE_DETACHABLE assign set_z -- unstable: VFAC(3) (detachable)
		note
			$STABLE
		attribute
		end

	set_z (value: attached TEST)
		do
		end

	ax: attached TEST $MASK_ATTACHED $MASK_DETACHABLE assign set_ax -- stable, unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_ax (value: detachable TEST)
		do
		end

	ay: attached TEST $MASK_DETACHABLE assign set_ay -- stable, unstable: VFAC(3) (detachable)
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

	dy: detachable TEST $MASK_UNSTABLE_ATTACHED assign set_dy -- unstable: VFAC(3) (attached)
		note
			$STABLE
		attribute
		end

	set_dy (value: TEST)
		do
		end

	dz: detachable TEST $MASK_UNSTABLE_ATTACHED $MASK_UNSTABLE_DETACHABLE assign set_dz -- unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_dz (value: attached TEST)
		do
		end

end