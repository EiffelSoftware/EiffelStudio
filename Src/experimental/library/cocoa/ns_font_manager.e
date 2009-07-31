note
	description: "Summary description for {NS_FONT_MANAGER}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_MANAGER

inherit
	NS_OBJECT

create {NS_OBJECT, NS_ENVIRONEMENT}
	make_from_pointer,
	share_from_pointer

feature -- Changing the Default Font Conversion Classes

	set_font_manager_factory (a_factory_id: POINTER)
			-- Sets the class object used to create the font manager to the given class.
		do
			{NS_FONT_MANAGER_API}.set_font_manager_factory (a_factory_id.item)
		end

	set_font_panel_factory (a_factory_id: POINTER)
			-- Sets the class used to create the Font panel to the given class.
		do
			{NS_FONT_MANAGER_API}.set_font_panel_factory (a_factory_id.item)
		end

feature -- Getting Available Fonts

--	available_fonts: NS_ARRAY
--			-- Returns the names of the fonts available in the system (not the <code>NSFont</code> objects themselves).
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.available_fonts (item))
--		end

--	available_font_families: NS_ARRAY
--			-- Returns the names of the font families available in the system.
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.available_font_families (item))
--		end

--	available_font_names_with_traits (a_some_traits: NATURAL): NS_ARRAY
--			-- Returns the names of the fonts available in the system whose traits are described exactly by the given font trait mask (not the <code>NSFont</code> objects themselves).
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.available_font_names_with_traits (item, a_some_traits))
--		end

--	available_members_of_font_family (a_fam: NS_STRING): NS_ARRAY
--			-- Returns an array with one entry for each available member of a font family.
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.available_members_of_font_family (item, a_fam.item))
--		end

feature -- Setting and Examining the Selected Font

	set_selected_font_is_multiple (a_font_obj: NS_FONT; a_flag: BOOLEAN)
			-- Records the given font as the currently selected font and updates the Font panel to reflect this.
		do
			{NS_FONT_MANAGER_API}.set_selected_font_is_multiple (item, a_font_obj.item, a_flag)
		end

	selected_font: NS_FONT
			-- Returns the last font recorded.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.selected_font (item))
		end

	is_multiple: BOOLEAN
			-- Indicates whether the last font selection recorded has multiple fonts.
		do
			Result := {NS_FONT_MANAGER_API}.is_multiple (item)
		end

	send_action: BOOLEAN
			-- Sends the receiver`s action message up the responder chain, initiating a font change for whatever conversion and trait to change were last requested.
		do
			Result := {NS_FONT_MANAGER_API}.send_action (item)
		end

	localized_name_for_family_face (a_family: NS_STRING; a_face_key: NS_STRING): NS_STRING
			-- Returns a localized string with the name of the specified font family and face, if one exists.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.localized_name_for_family_face (item, a_family.item, a_face_key.item))
		end

feature -- Sending Action Methods

	add_font_trait (a_sender: NS_OBJECT)
			-- This action method causes the receiver to send its action message up the responder chain.
		do
			{NS_FONT_MANAGER_API}.add_font_trait (item, a_sender.item)
		end

	remove_font_trait (a_sender: NS_OBJECT)
			-- This action method causes the receiver to send its action message up the responder chain.
		do
			{NS_FONT_MANAGER_API}.remove_font_trait (item, a_sender.item)
		end

	modify_font (a_sender: NS_OBJECT)
			-- This action method causes the receiver to send its action message up the responder chain.
		do
			{NS_FONT_MANAGER_API}.modify_font (item, a_sender.item)
		end

	modify_font_via_panel (a_sender: NS_OBJECT)
			-- This action method causes the receiver to send its action message up the responder chain.
		do
			{NS_FONT_MANAGER_API}.modify_font_via_panel (item, a_sender.item)
		end

	order_front_styles_panel (a_sender: NS_OBJECT)
			-- This action method opens the Font styles panel.
		do
			{NS_FONT_MANAGER_API}.order_front_styles_panel (item, a_sender.item)
		end

	order_front_font_panel (a_sender: NS_OBJECT)
			-- This action method opens the Font panel by sending it an <code>orderFront:</code> message, creating the Font panel if necessary.
		do
			{NS_FONT_MANAGER_API}.order_front_font_panel (item, a_sender.item)
		end

feature -- Converting Fonts Automatically

	convert_font (a_font_obj: NS_FONT): NS_FONT
			-- Converts the given font according to the object that initiated a font change, typically the Font panel or Font menu.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_font (item, a_font_obj.item))
		end

	change_font (a_sender: NS_OBJECT)
			-- Informs responders of a font change.
		do
			{NS_FONT_MANAGER_API}.change_font (item, a_sender.item)
		end

feature -- Converting Fonts Manually

	convert_font_to_face (a_font_obj: NS_FONT; a_typeface: NS_STRING): NS_FONT
			-- Returns a font whose traits are as similar as possible to those of the given font except for the typeface, which is changed to the given typeface.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_font_to_face (item, a_font_obj.item, a_typeface.item))
		end

	convert_font_to_family (a_font_obj: NS_FONT; a_family: NS_STRING): NS_FONT
			-- Returns a font whose traits are as similar as possible to those of the given font except for the font family, which is changed to the given family.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_font_to_family (item, a_font_obj.item, a_family.item))
		end

	convert_font_to_have_trait (a_font_obj: NS_FONT; a_trait: NATURAL): NS_FONT
			-- Returns a font whose traits are the same as those of the given font, except that the traits are changed to include the single specified trait.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_font_to_have_trait (item, a_font_obj.item, a_trait))
		end

	convert_font_to_not_have_trait (a_font_obj: NS_FONT; a_trait: NATURAL): NS_FONT
			-- Returns an <code>NSFont</code> object with the same traits as the given font, except for the traits in the given font trait mask, which are removed.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_font_to_not_have_trait (item, a_font_obj.item, a_trait))
		end

	convert_font_to_size (a_font_obj: NS_FONT; a_size: REAL): NS_FONT
			-- Returns an <code>NSFont</code> object whose traits are the same as those of the given font, except for the size, which is changed to the given size.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_font_to_size (item, a_font_obj.item, a_size))
		ensure
			size_set: (Result.point_size - a_size).abs < .001
		end

	convert_weight_of_font (a_up_flag: BOOLEAN; a_font_obj: NS_FONT): NS_FONT
			-- Returns an <code>NSFont</code> object whose weight is greater or lesser than that of the given font, if possible.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_weight_of_font (item, a_up_flag, a_font_obj.item))
		end

	current_font_action: INTEGER
			-- Returns the current font conversion action.
		do
			Result := {NS_FONT_MANAGER_API}.current_font_action (item)
		end

	convert_font_traits (a_traits: NATURAL): NATURAL
			-- Converts font traits to a new traits mask value.
		do
			Result := {NS_FONT_MANAGER_API}.convert_font_traits (item, a_traits)
		end

feature -- Getting a Particular Font

	font_with_family_traits_weight_size (a_family: NS_STRING; a_traits: NATURAL; a_weight: INTEGER; a_size: REAL): NS_FONT
			-- Attempts to load a font with the specified characteristics.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.font_with_family_traits_weight_size (item, a_family.item, a_traits, a_weight, a_size))
		end

feature -- Examining Fonts

	traits_of_font (a_font_obj: NS_FONT): NATURAL
			-- Returns the traits of the given font.
		do
			Result := {NS_FONT_MANAGER_API}.traits_of_font (item, a_font_obj.item)
		end

	font_named_has_traits (a_f_name: NS_STRING; a_some_traits: NATURAL): BOOLEAN
			-- Indicates whether the given font has all the specified traits.
		do
			Result := {NS_FONT_MANAGER_API}.font_named_has_traits (item, a_f_name.item, a_some_traits)
		end

	weight_of_font (a_font_obj: NS_FONT): INTEGER
			-- Returns a rough numeric measure the weight of the given font.
		do
			Result := {NS_FONT_MANAGER_API}.weight_of_font (item, a_font_obj.item)
		end

feature -- Managing the Font Panel and Font Menu

	set_enabled (a_flag: BOOLEAN)
			-- Controls whether the font conversion system`s user interface items (the Font panel and Font menu items) are enabled.
		do
			{NS_FONT_MANAGER_API}.set_enabled (item, a_flag)
		end

	is_enabled: BOOLEAN
			-- Indicates whether the font conversion system`s user interface items (the Font panel and Font menu items) are enabled.
		do
			Result := {NS_FONT_MANAGER_API}.is_enabled (item)
		end

	font_manager_will_include_font (a_sender: NS_OBJECT; a_font_name: NS_STRING): BOOLEAN
			-- Requests permission from the Font panel delegate to display the given font name in the Font panel.
		do
			Result := {NS_FONT_MANAGER_API}.font_manager_will_include_font (item, a_sender.item, a_font_name.item)
		end

	font_panel (a_create: BOOLEAN): NS_FONT_PANEL
			-- Returns the application`s shared Font panel object, optionally creating it if necessary.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.font_panel (item, a_create))
		end

	set_font_menu (a_new_menu: NS_MENU)
			-- Records the given menu as the application`s Font menu.
		do
			{NS_FONT_MANAGER_API}.set_font_menu (item, a_new_menu.item)
		end

	font_menu (a_create: BOOLEAN): NS_MENU
			-- Returns the menu that`s hooked up to the font conversion system, optionally creating it if necessary.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.font_menu (item, a_create))
		end

feature -- Setting the Delegate

	set_delegate (a_an_object: NS_OBJECT)
			-- Sets the receiver`s delegate to the given object.
		do
			{NS_FONT_MANAGER_API}.set_delegate (item, a_an_object.item)
		end

	delegate: NS_OBJECT
			-- Returns the receiver`s delegate.
		do
			create Result.make_from_pointer ({NS_FONT_MANAGER_API}.delegate (item))
		end

feature -- Accessing the Action Method

--	set_action (a_selector: OBJC_SELECTOR)
--			-- Sets the action that`s sent to the first responder, when the user selects a new font from the Font panel or chooses a command from the Font menu, to the given selector.
--		do
--			{NS_FONT_MANAGER_API}.set_action (item, a_selector.item)
--		end

--	action: OBJC_SELECTOR
--			-- Returns the action sent to the first responder when the user selects a new font from the Font panel or chooses a command from the Font menu.
--		do
--			create Result.make
--			{NS_FONT_MANAGER_API}.action (item, Result.item)
--		end

--	set_target (a_target: NS_OBJECT)
--			-- Sets the target for the <code>sendAction</code> method.
--		do
--			{NS_FONT_MANAGER_API}.set_target (item, a_target.item)
--		end

--	target: NS_OBJECT
--			-- Returns the target for the <code>sendAction</code> method.
--		do
--			create Result.make
--			{NS_FONT_MANAGER_API}.target (item, Result.item)
--		end

feature -- Setting Attributes

	set_selected_attributes_is_multiple (a_attributes: NS_DICTIONARY; a_flag: BOOLEAN)
			-- Informs the paragraph and character formatting panels when text in a selection has changed attributes.
		do
			{NS_FONT_MANAGER_API}.set_selected_attributes_is_multiple (item, a_attributes.item, a_flag)
		end

	convert_attributes (a_attributes: NS_DICTIONARY): NS_DICTIONARY
			-- Converts attributes in response to an object initiating an attribute change, typically the Font panel or Font menu.
		do
			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.convert_attributes (item, a_attributes.item))
		end

feature -- Working with Font Descriptors

--	available_font_names_matching_font_descriptor (a_descriptor: NS_FONT_DESCRIPTOR): NS_ARRAY
--			-- Returns the names of the fonts that match the attributes in the given font descriptor.
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.available_font_names_matching_font_descriptor (item, a_descriptor.item))
--		end

--	collection_names: NS_ARRAY
--			-- Returns the names of the currently loaded font collections.
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.collection_names (item))
--		end

--	font_descriptors_in_collection (a_collection_names: NS_STRING): NS_ARRAY
--			-- Returns an array of the font descriptors in the collection specified by the given collection name.
--		do
--			create Result.share_from_pointer ({NS_FONT_MANAGER_API}.font_descriptors_in_collection (item, a_collection_names.item))
--		end

	add_collection_options (a_collection_name: NS_STRING; a_collection_options: INTEGER): BOOLEAN
			-- Adds a specified font collection to the font manager with a given set of options.
		do
			Result := {NS_FONT_MANAGER_API}.add_collection_options (item, a_collection_name.item, a_collection_options)
		end

	remove_collection (a_collection_name: NS_STRING): BOOLEAN
			-- Removes the specified font collection.
		do
			Result := {NS_FONT_MANAGER_API}.remove_collection (item, a_collection_name.item)
		end

--	add_font_descriptors_to_collection (a_descriptors: NS_ARRAY; a_collection_name: NS_STRING)
--			-- Adds an array of font descriptors to the specified font collection.
--		do
--			{NS_FONT_MANAGER_API}.add_font_descriptors_to_collection (item, a_descriptors.item, a_collection_name.item)
--		end

	remove_font_descriptor_from_collection (a_descriptor: NS_FONT_DESCRIPTOR; a_collection: NS_STRING)
			-- Removes the specified font descriptor from the specified collection.
		do
			{NS_FONT_MANAGER_API}.remove_font_descriptor_from_collection (item, a_descriptor.item, a_collection.item)
		end

end
