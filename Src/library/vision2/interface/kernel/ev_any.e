indexing
	description: "Ancestor to all EiffelVision objects."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ANY

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
			-- (= implementation does not exist)
		do
			Result := (implementation = Void) or 
						(implementation /= Void and then 
							implementation.destroyed)
		end

	is_valid (object: EV_ANY): BOOLEAN is
			-- Is Current object valid?
		do
			Result := object /= Void and then not object.destroyed
		end

feature -- Status setting

	destroy is
			-- Destroy actual screen object of Current
			-- widget and of all children.
		require
			exists: not destroyed
		do
			implementation.destroy
			remove_implementation
		ensure
			destroyed: destroyed
		end

feature -- Comparison

	same (other: like Current): BOOLEAN is
			-- Does Current widget and `other' correspond
			-- to the same screen object?
		require
			other_exists: other /= Void
		do
			Result := other.implementation = implementation
		end

feature {EV_ANY_I} -- Implementation

	remove_implementation is
			-- Remove implementation of Current widget.
		do
			implementation := Void
		ensure
			void_implementation: implementation = Void
		end

feature -- Basic commands

	file_exists (file_name: STRING) : BOOLEAN is
			-- Does the given file name exist?
		require
			valid_file: file_name /= Void
		local
			file: RAW_FILE
		do	
			create file.make (file_name)
			if file.exists then
				Result := True
			end
		end

feature -- Implementation

	implementation: EV_ANY_I
			-- Platform dependent access

end -- class EV_ANY

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
