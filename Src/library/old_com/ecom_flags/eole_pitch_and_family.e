indexing

	description: "Pitch and family flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EOLE_PITCH_AND_FAMILY
	
feature -- Access

	Tmpf_fixed_pitch : INTEGER is
			-- Font is a variable pitch font
			-- (meaning opposite of what the constant name implies)
		external
			"C [macro <wingdi.h>]"
		alias
			"TMPF_FIXED_PITCH"
		end

	Tmpf_vector: INTEGER is
			-- Font is a vector font
		external
			"C [macro <wingdi.h>]"
		alias
			"TMPF_VECTOR"
		end
		
	Tmpf_device: INTEGER is
			-- Font is a device font
		external
			"C [macro <wingdi.h>]"
		alias
			"TMPF_DEVICE"
		end
		
	Tmpf_truetype:INTEGER is
			-- Font is a TrueType font
		external
			"C [macro <wingdi.h>]"
		alias
			"TMPF_TRUETYPE"
		end

	is_valid_tmpf (tmpf: INTEGER): BOOLEAN is
			-- Is `tmpf' a valid text metric pitch and family?
		do
			Result := tmpf = Tmpf_fixed_pitch or
						tmpf = Tmpf_vector or
						tmpf = Tmpf_device or
						tmpf = Tmpf_truetype
		end
		
end -- class EOLE_PITCH_AND_FAMILY
