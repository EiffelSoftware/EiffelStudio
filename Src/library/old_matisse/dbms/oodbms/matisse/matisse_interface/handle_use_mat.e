indexing

	Product: EiffelStore
	Database: Matisse

class HANDLE_USE_MAT


feature {NONE} -- Access

	handle_mat: HANDLE_MAT  is
		-- Shared handle reference
		once
			!! Result
		end -- handle_mat
	
end -- class HANDLE_USE_MAT

