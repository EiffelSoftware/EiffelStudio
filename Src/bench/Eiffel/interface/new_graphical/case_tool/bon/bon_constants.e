indexing
	description: "Objects that defines constants for the BON view."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CONSTANTS

inherit
	EV_SHARED_SCALE_FACTORY
	
	EB_CONSTANTS
		
feature {NONE} -- Bon class
		
	bon_class_name_font: EV_IDENTIFIED_FONT is
		local
			fc: EV_FONT_CONSTANTS
			font: EV_FONT
		once
			create fc
			create font
			font.set_family (fc.family_sans)
			font.set_height (14)
			Result := font_factory.registered_font (font)
			font_factory.register_font (Result)
		end

	bon_class_name_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.1, 0.5)
		end

	bon_class_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 0.0)
		end

	bon_class_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

	bon_class_line_width: INTEGER is
		do
			Result := 1
		end

	bon_generics_font: EV_IDENTIFIED_FONT is
		local
			fc: EV_FONT_CONSTANTS
			font: EV_FONT
		once
			create fc
			create font
			font.set_family (fc.family_roman)
			font.set_weight (fc.weight_bold)
			font.set_height (12)
			Result := font_factory.registered_font (font)
			font_factory.register_font (Result)
		end

	bon_generics_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.4, 0.7)
		end

	max_class_name_length: INTEGER is
		do
			Result := 15
		end
		
	max_generics_name_length: INTEGER is
		do
			Result := 15
		end
		
	bon_deferred_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.icon_bon_deferred
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
	bon_effective_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.icon_bon_effective
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
	bon_interfaced_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.icon_bon_interfaced
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end

	bon_persistent_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.icon_bon_persistent
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
	bon_anchor: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.icon_bon_anchor
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
feature {NONE} -- Cluster

	bon_cluster_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.8, 0.1, 0.0)
		end
		
	bon_cluster_line_width: INTEGER is 1

	bon_cluster_fill_color: EV_COLOR

	bon_cluster_iconified_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 0.9, 0.9)
		end

	bon_cluster_name_area_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	bon_cluster_name_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.5, 0.0, 0.0)
		end
		
	bon_cluster_name_font: EV_IDENTIFIED_FONT is
		local
			font: EV_FONT
		once
			create font
			Result := font_factory.registered_font (font)
			font_factory.register_font (Result)
		end

	max_cluster_name_length: INTEGER is
		do
			Result := 25
		end
		
feature {NONE} -- Client supplier link

	bon_client_label_font: EV_IDENTIFIED_FONT is
		local
			fc: EV_FONT_CONSTANTS
			font: EV_FONT
		once
			create fc
			create font
			font.set_family (fc.family_roman)
			font.set_height (15)
			Result := font_factory.registered_font (font)
			font_factory.register_font (Result)
		end

	bon_client_label_color: EV_COLOR is
		once
			create Result.make_with_rgb (0, 0, 0)
		end
		
	bon_client_color: EV_COLOR is
		once
			create Result.make_with_rgb (0, 0, 1)
		end
		
	bon_client_line_width: INTEGER is 5
	
feature {NONE} -- Inheritance link

	bon_inheritance_color: EV_COLOR is
		once
			create Result.make_with_rgb (1, 0, 0)
		end
		
	bon_inheritance_line_width: INTEGER is 2

end -- class BON_CONSTANTS
