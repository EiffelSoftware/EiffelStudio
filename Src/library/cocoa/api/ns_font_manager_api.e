note
	description: "Summary description for {NS_FONT_MANAGER_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_MANAGER_API

feature -- Getting the Shared Font Manager

	frozen shared_font_manager : POINTER
			-- + (NSFontManager *)sharedFontManager
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFontManager sharedFontManager];"
		end

feature -- Changing the Default Font Conversion Classes

	frozen set_font_manager_factory (a_factory_id: POINTER)
			-- + (void)setFontManagerFactory: (Class) factoryId
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSFontManager setFontManagerFactory: *(Class*)$a_factory_id];"
		end

	frozen set_font_panel_factory (a_factory_id: POINTER)
			-- + (void)setFontPanelFactory: (Class) factoryId
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSFontManager setFontPanelFactory: *(Class*)$a_factory_id];"
		end

feature -- Getting Available Fonts

	frozen available_fonts (a_ns_font_manager: POINTER): POINTER
			-- - (NSArray *)availableFonts
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager availableFonts];"
		end

	frozen available_font_families (a_ns_font_manager: POINTER): POINTER
			-- - (NSArray *)availableFontFamilies
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager availableFontFamilies];"
		end

	frozen available_font_names_with_traits (a_ns_font_manager: POINTER; a_some_traits: NATURAL): POINTER
			-- - (NSArray *)availableFontNamesWithTraits: (NSFontTraitMask) someTraits
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager availableFontNamesWithTraits: $a_some_traits];"
		end

	frozen available_members_of_font_family (a_ns_font_manager: POINTER; a_fam: POINTER): POINTER
			-- - (NSArray *)availableMembersOfFontFamily: (NSString *) fam
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager availableMembersOfFontFamily: $a_fam];"
		end

feature -- Setting and Examining the Selected Font

	frozen set_selected_font_is_multiple (a_ns_font_manager: POINTER; a_font_obj: POINTER; a_flag: BOOLEAN)
			-- - (void)setSelectedFont: (NSFont *) fontObj isMultiple: (NSFont *) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setSelectedFont: $a_font_obj isMultiple: $a_flag];"
		end

	frozen selected_font (a_ns_font_manager: POINTER): POINTER
			-- - (NSFont *)selectedFont
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager selectedFont];"
		end

	frozen is_multiple (a_ns_font_manager: POINTER): BOOLEAN
			-- - (BOOL)isMultiple
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager isMultiple];"
		end

	frozen send_action (a_ns_font_manager: POINTER): BOOLEAN
			-- - (BOOL)sendAction
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager sendAction];"
		end

	frozen localized_name_for_family_face (a_ns_font_manager: POINTER; a_family: POINTER; a_face_key: POINTER): POINTER
			-- - (NSString *)localizedNameForFamily: (NSString *) family face: (NSString *) faceKey
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager localizedNameForFamily: $a_family face: $a_face_key];"
		end

feature -- Sending Action Methods

	frozen add_font_trait (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)addFontTrait: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager addFontTrait: *(id*)$a_sender];"
		end

	frozen remove_font_trait (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)removeFontTrait: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager removeFontTrait: *(id*)$a_sender];"
		end

	frozen modify_font (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)modifyFont: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager modifyFont: *(id*)$a_sender];"
		end

	frozen modify_font_via_panel (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)modifyFontViaPanel: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager modifyFontViaPanel: *(id*)$a_sender];"
		end

	frozen order_front_styles_panel (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)orderFrontStylesPanel: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager orderFrontStylesPanel: *(id*)$a_sender];"
		end

	frozen order_front_font_panel (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)orderFrontFontPanel: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager orderFrontFontPanel: *(id*)$a_sender];"
		end

feature -- Converting Fonts Automatically

	frozen convert_font (a_ns_font_manager: POINTER; a_font_obj: POINTER): POINTER
			-- - (NSFont *)convertFont: (NSFont *) fontObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFont: $a_font_obj];"
		end

	frozen change_font (a_ns_font_manager: POINTER; a_sender: POINTER)
			-- - (void)changeFont: (id) sender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager changeFont: *(id*)$a_sender];"
		end

feature -- Converting Fonts Manually

	frozen convert_font_to_face (a_ns_font_manager: POINTER; a_font_obj: POINTER; a_typeface: POINTER): POINTER
			-- - (NSFont *)convertFont: (NSFont *) fontObj toFace: (NSFont *) typeface
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFont: $a_font_obj toFace: $a_typeface];"
		end

	frozen convert_font_to_family (a_ns_font_manager: POINTER; a_font_obj: POINTER; a_family: POINTER): POINTER
			-- - (NSFont *)convertFont: (NSFont *) fontObj toFamily: (NSFont *) family
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFont: $a_font_obj toFamily: $a_family];"
		end

	frozen convert_font_to_have_trait (a_ns_font_manager: POINTER; a_font_obj: POINTER; a_trait: NATURAL): POINTER
			-- - (NSFont *)convertFont: (NSFont *) fontObj toHaveTrait: (NSFont *) trait
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFont: $a_font_obj toHaveTrait: $a_trait];"
		end

	frozen convert_font_to_not_have_trait (a_ns_font_manager: POINTER; a_font_obj: POINTER; a_trait: NATURAL): POINTER
			-- - (NSFont *)convertFont: (NSFont *) fontObj toNotHaveTrait: (NSFont *) trait
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFont: $a_font_obj toNotHaveTrait: $a_trait];"
		end

	frozen convert_font_to_size (a_ns_font_manager: POINTER; a_font_obj: POINTER; a_size: REAL): POINTER
			-- - (NSFont *)convertFont: (NSFont *) fontObj toSize: (NSFont *) size
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFont: $a_font_obj toSize: $a_size];"
		end

	frozen convert_weight_of_font (a_ns_font_manager: POINTER; a_up_flag: BOOLEAN; a_font_obj: POINTER): POINTER
			-- - (NSFont *)convertWeight: (BOOL) upFlag ofFont: (BOOL) fontObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertWeight: $a_up_flag ofFont: $a_font_obj];"
		end

	frozen current_font_action (a_ns_font_manager: POINTER): INTEGER
			-- - (NSFontAction)currentFontAction
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager currentFontAction];"
		end

	frozen convert_font_traits (a_ns_font_manager: POINTER; a_traits: NATURAL): NATURAL
			-- - (NSFontTraitMask)convertFontTraits: (NSFontTraitMask) traits
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertFontTraits: $a_traits];"
		end

feature -- Getting a Particular Font

	frozen font_with_family_traits_weight_size (a_ns_font_manager: POINTER; a_family: POINTER; a_traits: NATURAL; a_weight: INTEGER; a_size: REAL): POINTER
			-- - (NSFont *)fontWithFamily: (NSString *) family traits: (NSString *) traits weight: (NSString *) weight size: (NSString *) size
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager fontWithFamily: $a_family traits: $a_traits weight: $a_weight size: $a_size];"
		end

feature -- Examining Fonts

	frozen traits_of_font (a_ns_font_manager: POINTER; a_font_obj: POINTER): NATURAL
			-- - (NSFontTraitMask)traitsOfFont: (NSFont *) fontObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager traitsOfFont: $a_font_obj];"
		end

	frozen font_named_has_traits (a_ns_font_manager: POINTER; a_f_name: POINTER; a_some_traits: NATURAL): BOOLEAN
			-- - (BOOL)fontNamed: (NSString *) fName hasTraits: (NSString *) someTraits
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager fontNamed: $a_f_name hasTraits: $a_some_traits];"
		end

	frozen weight_of_font (a_ns_font_manager: POINTER; a_font_obj: POINTER): INTEGER
			-- - (NSInteger)weightOfFont: (NSFont *) fontObj
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager weightOfFont: $a_font_obj];"
		end

feature -- Managing the Font Panel and Font Menu

	frozen set_enabled (a_ns_font_manager: POINTER; a_flag: BOOLEAN)
			-- - (void)setEnabled: (BOOL) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setEnabled: $a_flag];"
		end

	frozen is_enabled (a_ns_font_manager: POINTER): BOOLEAN
			-- - (BOOL)isEnabled
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager isEnabled];"
		end

	frozen font_manager_will_include_font (a_ns_font_manager: POINTER; a_sender: POINTER; a_font_name: POINTER): BOOLEAN
			-- - (BOOL)fontManager: (id) sender willIncludeFont: (id) fontName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager fontManager: *(id*)$a_sender willIncludeFont: $a_font_name];"
		end

	frozen font_panel (a_ns_font_manager: POINTER; a_create: BOOLEAN): POINTER
			-- - (NSFontPanel *)fontPanel: (BOOL) create
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager fontPanel: $a_create];"
		end

	frozen set_font_menu (a_ns_font_manager: POINTER; a_new_menu: POINTER)
			-- - (void)setFontMenu: (NSMenu *) newMenu
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setFontMenu: $a_new_menu];"
		end

	frozen font_menu (a_ns_font_manager: POINTER; a_create: BOOLEAN): POINTER
			-- - (NSMenu *)fontMenu: (BOOL) create
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager fontMenu: $a_create];"
		end

feature -- Setting the Delegate

	frozen set_delegate (a_ns_font_manager: POINTER; a_an_object: POINTER)
			-- - (void)setDelegate: (id) anObject
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setDelegate: *(id*)$a_an_object];"
		end

	frozen delegate (a_ns_font_manager: POINTER): POINTER
			-- - (id)delegate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager delegate];"
		end

feature -- Accessing the Action Method

	frozen set_action (a_ns_font_manager: POINTER; a_selector: POINTER)
			-- - (void)setAction: (SEL) aSelector
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setAction: *(SEL*)$a_selector];"
		end

	frozen action (a_ns_font_manager: POINTER): POINTER
			-- - (SEL)action
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager action];"
		end

	frozen set_target (a_ns_font_manager: POINTER; a_target: POINTER)
			-- - (void)setTarget: (id) aTarget
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setTarget: *(id*)$a_target];"
		end

	frozen target (a_ns_font_manager: POINTER): POINTER
			-- - (id)target
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager target];"
		end

feature -- Setting Attributes

	frozen set_selected_attributes_is_multiple (a_ns_font_manager: POINTER; a_attributes: POINTER; a_flag: BOOLEAN)
			-- - (void)setSelectedAttributes: (NSDictionary *) attributes isMultiple: (NSDictionary *) flag
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager setSelectedAttributes: $a_attributes isMultiple: $a_flag];"
		end

	frozen convert_attributes (a_ns_font_manager: POINTER; a_attributes: POINTER): POINTER
			-- - (NSDictionary *)convertAttributes: (NSDictionary *) attributes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager convertAttributes: $a_attributes];"
		end

feature -- Working with Font Descriptors

	frozen available_font_names_matching_font_descriptor (a_ns_font_manager: POINTER; a_descriptor: POINTER): POINTER
			-- - (NSArray *)availableFontNamesMatchingFontDescriptor: (NSFontDescriptor *) descriptor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager availableFontNamesMatchingFontDescriptor: $a_descriptor];"
		end

	frozen collection_names (a_ns_font_manager: POINTER): POINTER
			-- - (NSArray *)collectionNames
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager collectionNames];"
		end

	frozen font_descriptors_in_collection (a_ns_font_manager: POINTER; a_collection_names: POINTER): POINTER
			-- - (NSArray *)fontDescriptorsInCollection: (NSString *) collectionNames
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager fontDescriptorsInCollection: $a_collection_names];"
		end

	frozen add_collection_options (a_ns_font_manager: POINTER; a_collection_name: POINTER; a_collection_options: INTEGER): BOOLEAN
			-- - (BOOL)addCollection: (NSString *) collectionName options: (NSString *) collectionOptions
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager addCollection: $a_collection_name options: $a_collection_options];"
		end

	frozen remove_collection (a_ns_font_manager: POINTER; a_collection_name: POINTER): BOOLEAN
			-- - (BOOL)removeCollection: (NSString *) collectionName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSFontManager*)$a_ns_font_manager removeCollection: $a_collection_name];"
		end

	frozen add_font_descriptors_to_collection (a_ns_font_manager: POINTER; a_descriptors: POINTER; a_collection_name: POINTER)
			-- - (void)addFontDescriptors: (NSArray *) descriptors toCollection: (NSArray *) collectionName
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager addFontDescriptors: $a_descriptors toCollection: $a_collection_name];"
		end

	frozen remove_font_descriptor_from_collection (a_ns_font_manager: POINTER; a_descriptor: POINTER; a_collection: POINTER)
			-- - (void)removeFontDescriptor: (NSFontDescriptor *) descriptor fromCollection: (NSFontDescriptor *) collection
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSFontManager*)$a_ns_font_manager removeFontDescriptor: $a_descriptor fromCollection: $a_collection];"
		end

end
