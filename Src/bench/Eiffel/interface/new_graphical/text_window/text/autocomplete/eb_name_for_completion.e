indexing
	description: "Name of a feature to be inserted by autocomplete"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NAME_FOR_COMPLETION

inherit
	STRING
		rename
			make_from_string as make_with_name
		redefine
			make_with_name, 
			is_equal, infix "<"
		select
			infix "<", is_equal
		end

	STRING
		rename
			make_from_string as make_with_name,
			infix "<" as lower_than,
			is_equal as is_same_string
		redefine
			make_with_name
		end
		
	EB_SHARED_PREFERENCES
		undefine
		    copy,
		    out, 
		    is_equal
		end

create
	make_with_name,
	make_with_name_and_feature,
	make_with_name_and_class

create {EB_NAME_FOR_COMPLETION}
	make

feature -- Initialization

	make_with_name (a_name: STRING) is
			-- create feature name with value `name'
		do
			Precursor {STRING} (a_name)
			has_dot := True
		end
		
	make_with_name_and_feature (a_name: STRING; a_e_feature: E_FEATURE) is
			-- create feature name with value `name' and e_feature with value `a_e_feature'
		do
			e_feature := a_e_feature			
			make_with_name (a_name)
			if show_signature then				
				append (feature_signature)				
			end			
			if show_type then
				append (feature_type)
			end
		end

	make_with_name_and_class (a_name: STRING; a_e_class: CLASS_I) is
			-- create feature name with value `name' and a_class with value `a_e_class'
		do
			make_with_name (a_name)
			e_class := a_e_class
		end

feature -- Query

	is_class: BOOLEAN is
			-- Is a class?
		do
			Result := e_class /= Void
		end

feature -- Access

	full_insert_name: STRING is
			-- Full name to insert in editor
		do			
			Result := out
			if has_data then										
				if show_type then
					Result.replace_substring ("", count - feature_type.count + 1, count)
				end	
				if not show_signature then				
					Result.append (feature_signature)				
				end	
			end
		end		

	icon: EV_PIXMAP is
			-- Associated icon based on data
		require
			has_data: has_data
		local
			shared_pixmaps: EB_SHARED_PIXMAPS
			class_c: CLASS_C
		do
			create shared_pixmaps
			if e_feature /= Void then
				if e_feature.is_attribute then
					Result := shared_pixmaps.icon_format_attributes
				elseif e_feature.is_constant or e_feature.is_once then
					Result := shared_pixmaps.icon_format_onces
				elseif e_feature.is_deferred then
					Result := shared_pixmaps.icon_format_deferreds
				elseif e_feature.is_external then
					Result := shared_pixmaps.icon_format_externals
				elseif e_feature.is_function or e_feature.is_procedure then
					Result := shared_pixmaps.icon_format_routines
				end
			elseif e_class /= Void then
				if e_class.is_compiled then
					class_c := e_class.compiled_class
					if class_c.is_deferred then
						Result := shared_pixmaps.icon_deferred_class_symbol_color					
					else
						Result := shared_pixmaps.icon_class_symbol_color
					end
				else
					Result := shared_pixmaps.icon_class_symbol_gray
				end
			end
		end		

	tooltip_text: STRING is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		require
			not show_signature or not show_type
		do
			create Result.make_from_string (Current.out)		
			if not is_class then
				Result.append (feature_signature)
				if not feature_type.is_empty then
					Result.append (feature_type)					
				end
			end			
		ensure
			result_not_void: Result /= Void
		end		

feature -- Status Report

	has_dot: BOOLEAN

	has_data: BOOLEAN is
			-- Does Current have Eiffel feature/class internal data?
		do
			Result := e_feature /= Void or e_class /= Void	
		end		
		
	show_signature: BOOLEAN is
			-- Should signature be displayed?
		do
		    Result := preferences.editor_data.show_completion_signature
		end

	show_type: BOOLEAN is
			-- Should feature return type be displayed?
		do
		    Result := preferences.editor_data.show_completion_type
		end

feature -- Status setting

	set_has_dot (hd: BOOLEAN) is
			-- assign `hd' to `has_dot'
		do
			has_dot := hd
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is name made of same character sequence as `other' (case has no importance)
		do
			Result := as_lower.is_same_string (other.as_lower)
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is name lexicographically lower than `other'?
		do
			Result := as_lower.lower_than (other.as_lower)
		end
		
	begins_with (s:STRING): BOOLEAN is
			-- Does this feature name begins with `s'?
		local
			lower_s: STRING
		do
			if count >= s.count then
				lower_s := s.as_lower
				Result := as_lower.substring_index_in_bounds (lower_s, 1, lower_s.count) = 1
			end
		end	

feature {NONE} -- Implementation

	e_feature: E_FEATURE
			-- Corresponding feature

	e_class: CLASS_I
			-- Corresponding class

	feature_signature: STRING is
			-- The signature of `e_feature'
		do	
			create Result.make_empty
			if not e_feature.is_infix then
				Result := e_feature.feature_signature
				Result.remove_substring (1, e_feature.name.count)
			else
				Result := e_feature.feature_signature.substring (e_feature.name.count + 1, e_feature.feature_signature.count)
			end
		ensure
			result_not_void: Result /= Void
		end	
		
	feature_type: STRING is
			-- The type of the feature (for a function, attribute)
		do
			create Result.make_empty
			if e_feature.type /= Void then
				Result.append (": " + e_feature.type.dump)			
			end
		ensure
			result_not_void: Result /= Void
		end		

end -- class EB_NAME_FOR_COMPLETION
