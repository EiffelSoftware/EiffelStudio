indexing

	description: 
		"Align coordinates of an entity before the drawing.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ALIGN_GRID

feature -- Access

	align_grid (coord: INTEGER): INTEGER is
			-- Aligned coordinate on grid if magnetic
		do
			if system.is_grid_magnetic then
				if coord > 0 then
					Result := coord+(system.grid_spacing // 2)
				else
					Result := coord-(system.grid_spacing // 2)
				end;
				Result := (Result // system.grid_spacing) *
								system.grid_spacing
			else
				Result := coord
			end
		ensure
			(not system.is_grid_magnetic) implies (Result = coord);
			system.is_grid_magnetic implies ((Result \\ system.grid_spacing) = 0)
		end 

feature -- Useful features

	system: SYSTEM_DATA is deferred end
		-- Shared.

end -- class ALIGN_GRID
