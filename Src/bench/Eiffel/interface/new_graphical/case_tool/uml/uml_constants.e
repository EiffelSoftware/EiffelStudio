indexing
	description: "Objects that defines constants for UML figures"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CONSTANTS
		
feature {NONE} -- UML class
		
	uml_class_name_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_sans)
			Result.set_height (14)
		end
		
	uml_class_deferred_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_sans)
			Result.set_shape (fc.shape_italic)
			Result.set_height (14)
		end
		
	uml_class_properties_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_sans)
			Result.set_shape (fc.shape_italic)
			Result.set_height (14)
		end
		
	uml_class_properties_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.5, 0, 0)
		end

	uml_class_name_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.1, 0.5)
		end

	uml_class_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	uml_class_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

	uml_class_line_width: INTEGER is
		do
			Result := 1
		end

	uml_generics_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_sans)
			Result.set_height (14)
		end

	uml_generics_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 0.0, 0.0)
		end
		
	uml_class_features_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_sans)
--			Result.set_shape (fc.shape_italic)
			Result.set_height (15)
		end
		
	uml_class_features_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.5, 0.0)
		end
		
		
	uml_class_feature_section_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_sans)
--			Result.set_shape (fc.shape_italic)
			Result.set_weight (fc.weight_bold)
			Result.set_height (15)
		end
		

feature {NONE} -- Cluster

	uml_cluster_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end
		
	uml_cluster_line_width: INTEGER is 1

	uml_cluster_fill_color: EV_COLOR

	uml_cluster_iconified_fill_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	uml_cluster_name_area_color: EV_COLOR is
		once
			create Result.make_with_rgb (1.0, 1.0, 1.0)
		end

	uml_cluster_name_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end
		
	uml_cluster_name_font: EV_FONT is
		once
			create Result
		end

	max_cluster_name_length: INTEGER is
		do
			Result := 25
		end
		
feature {NONE} -- Client supplier link

	uml_client_label_font: EV_FONT is
		local
			fc: EV_FONT_CONSTANTS
		once
			create fc
			create Result
			Result.set_family (fc.family_roman)
--			Result.set_shape (fc.shape_italic)
			Result.set_height (15)
		end

	uml_client_label_color: EV_COLOR is
		once
			create Result.make_with_rgb (0, 0, 0)
		end
		
	uml_client_color: EV_COLOR is
		once
			create Result.make_with_rgb (0, 0, 0)
		end
		
	uml_client_line_width: INTEGER is 1
	
feature {NONE} -- Inheritance link

	uml_inheritance_color: EV_COLOR is
		once
			create Result.make_with_rgb (0, 0, 0)
		end
		
	uml_inheritance_line_width: INTEGER is 1

end -- class UML_CONSTANTS
