indexing
	description: "A button representing a category in a catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CAT_BUTTON

inherit

	EV_TOGGLE_BUTTON
		redefine
			make
		end

--	FOCUSABLE

	CONSTANTS

	EV_COMMAND

creation

	make

feature {NONE} -- Initialization

	make (cat_page: CATALOG_PAGE; par: EV_CONTAINER; symb: STRING) is
		require
			valid_cat_page: cat_page /= Void
			valid_parent: par /= Void
		local
			pixmap: EV_PIXMAP
			arg: EV_ARGUMENT1 [CATALOG_PAGE]
		do
			{EV_TOGGLE_BUTTON} Precursor (par)
			create pixmap.make_from_file (Current, symb)
			create arg.make (cat_page)
			add_toggle_command (Current, arg)
		end

feature {NONE} -- Command

	execute (arg: EV_ARGUMENT1 [CATALOG_PAGE]; data: EV_EVENT_DATA) is
		do
			arg.first.select_it
		end
  
feature {NONE} -- Focus

-- 	Focus_labels: FOCUS_LABEL_CONSTANTS is
-- 		once
-- 			!! Result
-- 		end
-- 	
-- 	focus_source: WIDGET is
-- 		do
-- 			Result := Current
-- 		end;

-- 	make_visible (a_parent: COMPOSITE) is	
-- 		require
-- 			valid_a_parent: a_parent /= Void
-- 		do
-- 			pict_color_make (Widget_names.pcbutton, a_parent);
-- 			set_symbol (symbol);
--
--			-- Default value for focus_string
--			create_focus_label
--			initialize_focus;
--		end;


-- 	focus_label: FOCUS_LABEL_I is
-- 			-- has to be redefined, so that it returns correct toolkit initializer
-- 			-- to which object belongs for every instance of this class
--                 local
--                         ti: TOOLTIP_INITIALIZER
--                 do
--                         ti ?= top
--                         check
--                                 valid_tooltip_initializer: ti/= void
--                         end
--                         Result := ti.label
--                 end
-- 		
-- 	create_focus_label is
-- 		do
-- 			set_focus_string (Focus_labels.catalog_label)
-- 		end

end -- class CAT_BUTTON

