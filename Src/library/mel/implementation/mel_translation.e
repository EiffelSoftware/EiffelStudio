indexing

	description: 
		"Mel representation of an translation string. %
		%This class is needed for the passing of translation string %
		%to C which is then retrieved in the callback to execute the %
		%corresponding Eiffel Callback. However, since we adopted the %
		%string object, the translation string had to encapsulated so it %
		%can be weaned automatically by the GC.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_TRANSLATION

inherit

	MEL_CALLBACK_KEY
		redefine
			out, is_equal
		end;

	MEMORY
		export
			{NONE} all
		redefine
			dispose, out, is_equal
		end

creation
	make,
	make_no_adopted

feature {NONE} -- Initialization

	make (a_translation: STRING) is
			-- Create a mel_translation from `a_translation'.
		require
			non_void_a_translation: a_translation /= Void
		do
			type := translation_type;
			translation_string := a_translation;
			hash_code := a_translation.hash_code;
			adopted_trans := eif_adopt (translation_string);
		ensure
			set: a_translation = translation_string
		end;

	make_no_adopted (a_translation: STRING) is
			-- Create a mel_translation from `a_translation'
			-- but do not adopt the string
		do
			type := translation_type;
			translation_string := a_translation;
			hash_code := a_translation.hash_code
		ensure
			set: a_translation = translation_string
		end;

feature -- Access

	translation_string: STRING;
			-- Translation string
	
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' translation_string equal to Current?
		local
			a: like Current
		do
			a ?= other
			if a /= Void then
				Result := type = a.type and then 
					translation_string.is_equal (a.translation_string)
			end
		end;

feature -- Output

	out: STRING is
		do
			Result := translation_string.out
		end;

feature {MEL_WIDGET} -- Access

	xt_translation_string: STRING is
			-- Translation string to be passed out
			-- to XtOverrideTranslations that will execute
			-- the callback with arguments
		do
			!! Result.make (0)
			Result.append (translation_string);
			Result.append (": ");
			Result.append (external_routine_name);
			Result.extend ('(');
			Result.append (adopted_trans.out)
			Result.append (")%N");
		end;

	xt_translation_null_string: STRING is
			-- An Translation string to be passed out
			-- to XtOverrideTranslations that will execute
			-- the callback with no arguments
		do
			!! Result.make (0);
			Result.append (translation_string)
			Result.append (": ");
			Result.append (external_routine_name);
			Result.extend ('(');
			Result.append (")%N");
		end;

feature {MEL_DISPATCHER} -- Removal

	dispose is
			-- Dispose the adopted translation.
		do
			if adopted_trans /= default_pointer then
				eif_wean (adopted_trans);
				adopted_trans := default_pointer
			end
		end;

feature {NONE} -- Implementation

	adopted_trans: POINTER;
			-- Translation adopted object

	external_routine_name: STRING is
			-- External routine name for handling
			-- translations
		do
			!! Result.make (0);
			Result.from_c (c_trans_name)
		end;

feature {NONE} -- External features

	eif_wean (obj: POINTER) is
			-- eif_wean object `obj'.
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"eif_wean"
		end

	eif_adopt (obj: ANY): POINTER is
			-- Adopt object `obj'
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"eif_adopt"
		end;

	c_trans_name: POINTER is
			-- Adopt object `obj'
		external
			"C [macro %"mel.h%"]"
		alias
			"c_trans_routine"
		end;

invariant

	non_void_translation: translation_string /= Void

end -- class MEL_TRANSLATION


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

