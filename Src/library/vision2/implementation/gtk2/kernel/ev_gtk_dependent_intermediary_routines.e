indexing
	description: "Intermediary routines between gtk and eiffel."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

inherit
	IDENTIFIED
		undefine
			copy, is_equal
		end
		
	ANY
	
feature {EV_GTK_CALLBACK_MARSHAL, EV_ANY_IMP} -- Tuple optimizations

	empty_tuple: TUPLE is
		once
			Result := []
		end

feature {EV_ANY_I} -- Implementation

	text_buffer_mark_set_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER) is
			-- 
		local
			a_rich_text: EV_RICH_TEXT_IMP
			a_text_iter, a_text_mark: POINTER
		do
			a_rich_text ?= eif_id_object (a_object_id)
			if a_rich_text /= Void and then not a_rich_text.is_destroyed then
				a_text_iter := feature {EV_GTK_EXTERNALS}.gtk_value_pointer (feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_array_i_th (args, 1))
				a_text_mark := feature {EV_GTK_EXTERNALS}.gtk_value_pointer (feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_array_i_th (args, 2))
				a_rich_text.on_text_mark_changed (a_text_iter, a_text_mark )
			end
		end

	page_switch_translate (n: INTEGER; args: POINTER): TUPLE is
			-- Retrieve index of switched page.
		local
			gtkarg2: POINTER
		do
			gtkarg2 := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1)
			Result := [feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_uint (gtkarg2)]
		end

feature {EV_ANY_I} -- Externals

	frozen c_get_eif_reference_from_object_id (a_c_object: POINTER): EV_ANY_IMP is
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		end

end -- class EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

