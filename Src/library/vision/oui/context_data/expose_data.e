indexing

	description:
		"Information given by EiffelVision when a part of a window becomes %
		%visible. %
		%X event associated: `Expose'. Raised by `expose action' too"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	EXPOSE_DATA 

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_clip: CLIP; expose_count: INTEGER) is
			-- Create a context_data for `Expose' event.
		do
			widget := a_widget;
			clip := a_clip;
			exposes_to_come := expose_count;
		end

feature -- Access

	clip: CLIP;
			-- Exposed region

	exposes_to_come: INTEGER;
			-- Number of expose events to come

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EXPOSE_DATA

