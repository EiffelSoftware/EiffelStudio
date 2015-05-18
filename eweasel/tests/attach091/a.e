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

	x: G $MASK_ATTACHED $MASK_DETACHABLE assign set_x -- stable, unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_x (value: detachable G)
		do
		end

	y: G assign set_y
		note
			$STABLE
		attribute
		end

	set_y (value: G)
		do
		end

	z: G $MASK_UNSTABLE_ATTACHED $MASK_UNSTABLE_DETACHABLE assign set_z -- unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_z (value: attached G)
		do
		end

	ax: attached G $MASK_ATTACHED $MASK_DETACHABLE assign set_ax -- stable, unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_ax (value: detachable G)
		do
		end

	ay: attached G $MASK_ATTACHED $MASK_DETACHABLE assign set_ay -- stable, unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_ay (value: G)
		do
		end

	az: attached G assign set_az
		note
			$STABLE
		attribute
		end

	set_az (value: attached G)
		do
		end

	dx: detachable G assign set_dx
		note
			$STABLE
		attribute
		end

	set_dx (value: detachable G)
		do
		end

	dy: detachable G $MASK_UNSTABLE_ATTACHED $MASK_UNSTABLE_DETACHABLE assign set_dy -- unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_dy (value: G)
		do
		end

	dz: detachable G $MASK_UNSTABLE_ATTACHED $MASK_UNSTABLE_DETACHABLE assign set_dz -- unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_dz (value: attached G)
		do
		end

end