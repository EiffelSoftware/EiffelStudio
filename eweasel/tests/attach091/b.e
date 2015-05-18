class B

feature {TEST} -- Tests

	x: like Current $MASK_ATTACHED $MASK_DETACHABLE assign set_x -- stable, unstable: VFAC(3)
		note
			$STABLE
		attribute
			Result := Current
		end

	set_x (value: detachable like Current)
		do
		end

	y: like Current assign set_y
		note
			$STABLE
		attribute
			Result := Current
		end

	set_y (value: like Current)
		do
		end

	z: like Current assign set_z
		note
			$STABLE
		attribute
			Result := Current
		end

	set_z (value: attached like Current)
		do
		end

	ax: attached like Current $MASK_ATTACHED $MASK_DETACHABLE assign set_ax -- stable, unstable: VFAC(3)
		note
			$STABLE
		attribute
			Result := Current
		end

	set_ax (value: detachable like Current)
		do
		end

	ay: attached like Current assign set_ay
		note
			$STABLE
		attribute
			Result := Current
		end

	set_ay (value: like Current)
		do
		end

	az: attached like Current assign set_az
		note
			$STABLE
		attribute
			Result := Current
		end

	set_az (value: attached like Current)
		do
		end

	dx: detachable like Current assign set_dx
		note
			$STABLE
		attribute
		end

	set_dx (value: detachable like Current)
		do
		end

	dy: detachable like Current $MASK_UNSTABLE_ATTACHED $MASK_UNSTABLE_DETACHABLE assign set_dy -- unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_dy (value: like Current)
		do
		end

	dz: detachable like Current $MASK_UNSTABLE_ATTACHED $MASK_UNSTABLE_DETACHABLE assign set_dz -- unstable: VFAC(3)
		note
			$STABLE
		attribute
		end

	set_dz (value: attached like Current)
		do
		end

end