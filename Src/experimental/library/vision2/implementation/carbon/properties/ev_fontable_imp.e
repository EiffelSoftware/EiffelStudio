note
	description: "EiffelVision fontable, Carbon implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Access

	font: EV_FONT
			-- Character appearance for `Current'.
		do
			if private_font = void then
				create Result
				-- Default create is standard carbon font
			else
				Result := private_font--.twin
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		do
			private_font := a_font
		end

feature {NONE} -- Implementation

	fontable_widget: POINTER  --is
			-- Pointer to the widget that is fontable.
	--	do
	--	end

	private_font: EV_FONT

	interface: EV_FONTABLE;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FONTABLE_IMP

