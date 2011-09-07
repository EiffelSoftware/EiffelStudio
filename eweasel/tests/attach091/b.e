class B

feature {TEST} -- Tests

	x: like Current assign set_x
		note
			option: stable
		attribute
			Result := Current
		end

	set_x (value: detachable like Current)
		do
		end

	y: like Current assign set_y
		note
			option: stable
		attribute
			Result := Current
		end

	set_y (value: like Current)
		do
		end

	z: like Current assign set_z
		note
			option: stable
		attribute
			Result := Current
		end

	set_z (value: attached like Current)
		do
		end

	ax: attached like Current assign set_ax
		note
			option: stable
		attribute
			Result := Current
		end

	set_ax (value: detachable like Current)
		do
		end

	ay: attached like Current assign set_ay
		note
			option: stable
		attribute
			Result := Current
		end

	set_ay (value: like Current)
		do
		end

	az: attached like Current assign set_az
		note
			option: stable
		attribute
			Result := Current
		end

	set_az (value: attached like Current)
		do
		end

	dx: detachable like Current assign set_dx
		note
			option: stable
		attribute
		end

	set_dx (value: detachable like Current)
		do
		end

	dy: detachable like Current assign set_dy
		note
			option: stable
		attribute
		end

	set_dy (value: like Current)
		do
		end

	dz: detachable like Current assign set_dz
		note
			option: stable
		attribute
		end

	set_dz (value: attached like Current)
		do
		end

end