-- Error for variant loop of bad type

class VAVE 

inherit

	FEATURE_ERROR
	
feature 

	variant_part: VARIANT_AS;
			-- Description of variant clause

	set_variant_part (v: VARIANT_AS) is
			-- Assign `v' to `variant_part'.
		do
			variant_part := v;
		end;

	code: STRING is "VAVE";
			-- Error code

end
