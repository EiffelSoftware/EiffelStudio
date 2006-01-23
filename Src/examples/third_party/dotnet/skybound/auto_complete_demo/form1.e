indexing
	description: "Summary description for Form1."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	FORM1

inherit
	EXCEPTIONS
		undefine
			default_create
		end
		
	WINFORMS_FORM
		redefine
			default_create,
			dispose_boolean
		end	

create
	default_create
	
feature {NONE} -- Initialization

	default_create is
			-- No description available.
		local
			l_recent: RECENT
		do
			initialize_component
			
			check
				auto_complete_manager_not_void: auto_complete_manager /= Void
				cbo_recent_addresses_not_void: cbo_recent_addresses /= Void
				cbo_recent_files_not_void: cbo_recent_files /= Void
			end

			create l_recent

			auto_complete_manager.item (txt_data_source).set_data_source (read_data)
			cbo_recent_addresses.items.add_range (l_recent.typed_urls)
			cbo_recent_files.items.add_range (l_recent.run_mru)
		end

		
feature {NONE} -- Access

	components: SYSTEM_DLL_ICONTAINER
	btn_close: WINFORMS_BUTTON
	auto_complete_manager: AUTO_COMPLETE_MANAGER;
	lbl_recent_files: WINFORMS_LABEL
	cbo_recent_files: WINFORMS_COMBO_BOX
	gbx_my_computer: WINFORMS_GROUP_BOX
	gbx_recent_locations: WINFORMS_GROUP_BOX
	lbl_recent_addresses: WINFORMS_LABEL
	cbo_recent_addresses: WINFORMS_COMBO_BOX
	gbx_data_binding: WINFORMS_GROUP_BOX
	lbl_data_source: WINFORMS_LABEL
	lbl_items: WINFORMS_LABEL
	txt_items: WINFORMS_TEXT_BOX
	pic_recent_addresses: WINFORMS_PICTURE_BOX
	pic_recent_files: WINFORMS_PICTURE_BOX
	pic_data_binding: WINFORMS_PICTURE_BOX
	lbl_recent_addresses_desc: WINFORMS_LABEL
	lbl_recent_files_desc: WINFORMS_LABEL
	pic_my_computer: WINFORMS_PICTURE_BOX
	lbl_my_computer: WINFORMS_LABEL
	lbl_my_computer_files: WINFORMS_LABEL
	txt_files: WINFORMS_TEXT_BOX
	txt_folders: WINFORMS_TEXT_BOX
	lbl_folders: WINFORMS_LABEL
	lbl_data_binding: WINFORMS_LABEL
	label1: WINFORMS_LABEL
	txt_data_source: WINFORMS_TEXT_BOX
		
		
feature {NONE} -- Basic Operations
		
	initialize_component is
			-- 
		local
			l_auto_complete1: AUTO_COMPLETE
			l_auto_complete2: AUTO_COMPLETE
			l_auto_complete3: AUTO_COMPLETE
			l_auto_complete4: AUTO_COMPLETE
			l_auto_complete5: AUTO_COMPLETE
			l_resources: RESOURCE_MANAGER
			l_bitmap: DRAWING_IMAGE
		do
			create {SYSTEM_DLL_SYSTEM_CONTAINER}components.make
			create l_auto_complete1.make
			create l_auto_complete2.make
			create l_auto_complete3.make
			create l_auto_complete4.make
			create l_auto_complete5.make
			create l_resources.make (get_type)
			create auto_complete_manager.make (components)
			create cbo_recent_files.make
			create cbo_recent_addresses.make
			create txt_items.make
			create txt_files.make
			create txt_folders.make
			create txt_data_source.make
			create lbl_recent_files.make
			create gbx_my_computer.make
			create lbl_folders.make
			create lbl_my_computer.make
			create lbl_my_computer_files.make
			create pic_my_computer.make
			create gbx_recent_locations.make
			create lbl_recent_addresses_desc.make
			create pic_recent_addresses.make
			create lbl_recent_addresses.make
			create lbl_recent_files_desc.make
			create pic_recent_files.make
			create gbx_data_binding.make
			create label1.make
			create lbl_data_binding.make
			create pic_data_binding.make
			create lbl_items.make
			create lbl_data_source.make
			create btn_close.make
			gbx_my_computer.suspend_layout
			gbx_recent_locations.suspend_layout
			gbx_data_binding.suspend_layout
			suspend_layout
			-- 
			-- auto_complete_manager
			-- 
			auto_complete_manager.add_delete (create {DELETE_EVENT_HANDLER}.make (Current, $auto_complete_manager_delete))
			-- 
			-- cbo_recent_files
			-- 
			cbo_recent_files.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left | {WINFORMS_ANCHOR_STYLES}.right)
			l_auto_complete1.set_include_combo_box_items (True)
			l_auto_complete1.set_include_recent ({AUTO_COMPLETE_RECENT}.files)
			auto_complete_manager.set_auto_complete (cbo_recent_files, l_auto_complete1)
			cbo_recent_files.set_location (create {DRAWING_POINT}.make (80, 120))
			cbo_recent_files.set_name (("cbo_recent_files").to_cil)
			cbo_recent_files.set_size (create {DRAWING_SIZE}.make (316, 21))
			cbo_recent_files.set_tab_index (5)
			-- 
			-- cbo_recent_addresses
			-- 
			cbo_recent_addresses.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left | {WINFORMS_ANCHOR_STYLES}.right)
			l_auto_complete2.set_include_combo_box_items (True)
			l_auto_complete2.set_include_recent ({AUTO_COMPLETE_RECENT}.urls)
			l_auto_complete2.set_quick_complete_format ("http://www.{0}.com")
			l_auto_complete2.set_show_search (True)
			auto_complete_manager.set_auto_complete (cbo_recent_addresses, l_auto_complete2)
			cbo_recent_addresses.set_location (create {DRAWING_POINT}.make (80, 56))
			cbo_recent_addresses.set_name ("cbo_recent_addresses")
			cbo_recent_addresses.set_size (create {DRAWING_SIZE}.make (316, 21))
			cbo_recent_addresses.set_tab_index (2)
			-- 
			-- txt_items
			--
			txt_items.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left | {WINFORMS_ANCHOR_STYLES}.right)
			l_auto_complete3.set_allow_delete (True)
			l_auto_complete3.items.add_range ((<< ("AliceBlue").to_cil,
												  ("AntiqueWhite").to_cil,
												  ("Aqua").to_cil,
												  ("Aquamarine").to_cil,
												  ("Azure").to_cil,
												  ("Beige").to_cil,
												  ("Bisque").to_cil,
												  ("Black").to_cil,
												  ("BlanchedAlmond").to_cil,
												  ("Blue").to_cil,
												  ("BlueViolet").to_cil,
												  ("Brown").to_cil,
												  ("BurlyWood").to_cil,
												  ("CadetBlue").to_cil,
												  ("Chartreuse").to_cil,
												  ("Chocolate").to_cil,
												  ("Coral").to_cil,
												  ("CornflowerBlue").to_cil,
												  ("Cornsilk").to_cil,
												  ("Crimson").to_cil,
												  ("Cyan").to_cil,
												  ("DarkBlue").to_cil,
												  ("DarkCyan").to_cil,
												  ("DarkGoldenRod").to_cil,
												  ("DarkGray").to_cil,
												  ("DarkGreen").to_cil,
												  ("DarkKhaki").to_cil,
												  ("DarkMagenta").to_cil,
												  ("DarkOliveGreen").to_cil,
												  ("DarkOrange").to_cil,
												  ("DarkOrchid").to_cil,
												  ("DarkRed").to_cil,
												  ("DarkSalmon").to_cil,
												  ("DarkSeaGreen").to_cil,
												  ("DarkSlateBlue").to_cil,
												  ("DarkSlateGray").to_cil,
												  ("DarkTurquoise").to_cil,
												  ("DarkViolet").to_cil,
												  ("DeepPink").to_cil,
												  ("DeepSkyBlue").to_cil,
												  ("DimGray").to_cil,
												  ("DodgerBlue").to_cil,
												  ("Feldspar").to_cil,
												  ("FireBrick").to_cil,
												  ("FloralWhite").to_cil,
												  ("ForestGreen").to_cil,
												  ("Fuchsia").to_cil,
												  ("Gainsboro").to_cil,
												  ("GhostWhite").to_cil,
												  ("Gold").to_cil,
												  ("GoldenRod").to_cil,
												  ("Gray").to_cil,
												  ("Green").to_cil,
												  ("GreenYellow").to_cil,
												  ("HoneyDew").to_cil,
												  ("HotPink").to_cil,
												  ("IndianRed ").to_cil,
												  ("Indigo ").to_cil,
												  ("Ivory").to_cil,
												  ("Khaki").to_cil,
												  ("Lavender").to_cil,
												  ("LavenderBlush").to_cil,
												  ("LawnGreen").to_cil,
												  ("LemonChiffon").to_cil,
												  ("LightBlue").to_cil,
												  ("LightCoral").to_cil,
												  ("LightCyan").to_cil,
												  ("LightGoldenRodYellow").to_cil,
												  ("LightGrey").to_cil,
												  ("LightGreen").to_cil,
												  ("LightPink").to_cil,
												  ("LightSalmon").to_cil,
												  ("LightSeaGreen").to_cil,
												  ("LightSkyBlue").to_cil,
												  ("LightSlateBlue").to_cil,
												  ("LightSlateGray").to_cil,
												  ("LightSteelBlue").to_cil,
												  ("LightYellow").to_cil,
												  ("Lime").to_cil,
												  ("LimeGreen").to_cil,
												  ("Linen").to_cil,
												  ("Magenta").to_cil,
												  ("Maroon").to_cil,
												  ("MediumAquaMarine").to_cil,
												  ("MediumBlue").to_cil,
												  ("MediumOrchid").to_cil,
												  ("MediumPurple").to_cil,
												  ("MediumSeaGreen").to_cil,
												  ("MediumSlateBlue").to_cil,
												  ("MediumSpringGreen").to_cil,
												  ("MediumTurquoise").to_cil,
												  ("MediumVioletRed").to_cil,
												  ("MidnightBlue").to_cil,
												  ("MintCream").to_cil,
												  ("MistyRose").to_cil,
												  ("Moccasin").to_cil,
												  ("NavajoWhite").to_cil,
												  ("Navy").to_cil,
												  ("OldLace").to_cil,
												  ("Olive").to_cil,
												  ("OliveDrab").to_cil,
												  ("Orange").to_cil,
												  ("OrangeRed").to_cil,
												  ("Orchid").to_cil,
												  ("PaleGoldenRod").to_cil,
												  ("PaleGreen").to_cil,
												  ("PaleTurquoise").to_cil,
												  ("PaleVioletRed").to_cil,
												  ("PapayaWhip").to_cil,
												  ("PeachPuff").to_cil,
												  ("Peru").to_cil,
												  ("Pink").to_cil,
												  ("Plum").to_cil,
												  ("PowderBlue").to_cil,
												  ("Purple").to_cil,
												  ("Red").to_cil,
												  ("RosyBrown").to_cil,
												  ("RoyalBlue").to_cil,
												  ("SaddleBrown").to_cil,
												  ("Salmon").to_cil,
												  ("SandyBrown").to_cil,
												  ("SeaGreen").to_cil,
												  ("SeaShell").to_cil,
												  ("Sienna").to_cil,
												  ("Silver").to_cil,
												  ("SkyBlue").to_cil,
												  ("SlateBlue").to_cil,
												  ("SlateGray").to_cil,
												  ("Snow").to_cil,
												  ("SpringGreen").to_cil,
												  ("SteelBlue").to_cil,
												  ("Tan").to_cil,
												  ("Teal").to_cil,
												  ("Thistle").to_cil,
												  ("Tomato").to_cil,
												  ("Turquoise").to_cil,
												  ("Violet").to_cil,
												  ("VioletRed").to_cil,
												  ("Wheat").to_cil,
												  ("White").to_cil,
												  ("WhiteSmoke").to_cil,
												  ("Yellow").to_cil,
												  ("YellowGreen").to_cil>>).to_cil)
 		
			auto_complete_manager.set_auto_complete (txt_items, l_auto_complete3)
			txt_items.set_location (create {DRAWING_POINT}.make (80, 76))
			txt_items.set_name ("txt_items")
			txt_items.set_size (create {DRAWING_SIZE}.make (316, 20))
			txt_items.set_tab_index (3)
			txt_items.set_text ("LightSlateBlue")
			-- 
			-- txt_files
			-- 
			txt_files.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left | {WINFORMS_ANCHOR_STYLES}.right)
			l_auto_complete4.set_include_files ({AUTO_COMPLETE_FILES}.files)
			auto_complete_manager.set_auto_complete (txt_files, l_auto_complete4)
			txt_files.set_location (create {DRAWING_POINT}.make (80, 52))
			txt_files.set_name ("txt_files")
			txt_files.set_size (create {DRAWING_SIZE}.make (316, 20))
			txt_files.set_tab_index (2)
			txt_files.set_text ("")
			-- 
			-- txt_folders
			-- 
			txt_folders.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left | {WINFORMS_ANCHOR_STYLES}.right)
			l_auto_complete5.set_include_files ({AUTO_COMPLETE_FILES}.folders)
			auto_complete_manager.set_auto_complete (txt_folders, l_auto_complete5)
			txt_folders.set_location (create {DRAWING_POINT}.make (80, 80))
			txt_folders.set_name ("txt_folders")
			txt_folders.set_size (create {DRAWING_SIZE}.make (316, 20))
			txt_folders.set_tab_index (4)
			txt_folders.set_text ("")
			-- 
			-- txt_data_source
			-- 
			txt_data_source.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left | {WINFORMS_ANCHOR_STYLES}.right)
			txt_data_source.set_location (create {DRAWING_POINT}.make (80, 104))
			txt_data_source.set_name ("txt_data_source")
			txt_data_source.set_size (create {DRAWING_SIZE}.make (316, 20))
			txt_data_source.set_tab_index (5)
			txt_data_source.set_text ("Zeus")
			-- 
			-- lbl_recent_files
			-- 
			lbl_recent_files.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left)
			lbl_recent_files.set_location (create {DRAWING_POINT}.make (8, 124))
			lbl_recent_files.set_name ("lbl_recent_files")
			lbl_recent_files.set_size (create {DRAWING_SIZE}.make (68, 16))
			lbl_recent_files.set_tab_index (4)
			lbl_recent_files.set_text ("&Files:")
			-- 
			-- gbx_my_computer
			-- 
			gbx_my_computer.controls.add (txt_folders)
			gbx_my_computer.controls.add (lbl_folders)
			gbx_my_computer.controls.add (txt_files)
			gbx_my_computer.controls.add (lbl_my_computer)
			gbx_my_computer.controls.add (lbl_my_computer_files)
			gbx_my_computer.controls.add (pic_my_computer)
			gbx_my_computer.set_flat_style ({WINFORMS_FLAT_STYLE}.system)
			gbx_my_computer.set_location (create {DRAWING_POINT}.make (8, 168))
			gbx_my_computer.set_name ("gbx_my_computer")
			gbx_my_computer.set_size (create {DRAWING_SIZE}.make (404, 112))
			gbx_my_computer.set_tab_index (1)
			gbx_my_computer.set_tab_stop (False)
			gbx_my_computer.set_text ("My Computer")
			-- 
			-- lbl_folders
			-- 
			lbl_folders.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left)
			lbl_folders.set_location (create {DRAWING_POINT}.make (8, 84))
			lbl_folders.set_name ("lbl_folders")
			lbl_folders.set_size (create {DRAWING_SIZE}.make (68, 16))
			lbl_folders.set_tab_index (3)
			lbl_folders.set_text ("Fol&ders:")
			-- 
			-- lbl_my_computer
			-- 
			lbl_my_computer.set_location (create {DRAWING_POINT}.make (80, 16))
			lbl_my_computer.set_name ("lbl_my_computer")
			lbl_my_computer.set_size (create {DRAWING_SIZE}.make (316, 32))
			lbl_my_computer.set_tab_index (0)
			lbl_my_computer.set_text ("These fields suggest all files or folders.  This is similar to the %"name%" field in the Open, Save and Browse for Folder dialogs.")
			-- 
			-- lbl_my_computer_files
			-- 
			lbl_my_computer_files.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left)
			lbl_my_computer_files.set_location (create {DRAWING_POINT}.make (8, 56))
			lbl_my_computer_files.set_name ("lbl_my_computer_files")
			lbl_my_computer_files.set_size (create {DRAWING_SIZE}.make (68, 16))
			lbl_my_computer_files.set_tab_index (1)
			lbl_my_computer_files.set_text ("Fil&es:")
			-- 
			-- pic_my_computer
			--
			l_bitmap ?= l_resources.get_object("picMyComputer.Image")
			pic_my_computer.set_image (l_bitmap)
			pic_my_computer.set_location (create {DRAWING_POINT}.make (12, 20))
			pic_my_computer.set_name ("pic_my_computer")
			pic_my_computer.set_size (create {DRAWING_SIZE}.make (36, 32))
			pic_my_computer.set_tab_index (0)
			pic_my_computer.set_tab_stop (False)
			-- 
			-- gbx_recent_locations
			-- 
			gbx_recent_locations.controls.add (lbl_recent_addresses_desc)
			gbx_recent_locations.controls.add (pic_recent_addresses)
			gbx_recent_locations.controls.add (lbl_recent_addresses)
			gbx_recent_locations.controls.add (cbo_recent_addresses)
			gbx_recent_locations.controls.add (lbl_recent_files)
			gbx_recent_locations.controls.add (lbl_recent_files_desc)
			gbx_recent_locations.controls.add (pic_recent_files)
			gbx_recent_locations.controls.add (cbo_recent_files)
			gbx_recent_locations.set_flat_style ({WINFORMS_FLAT_STYLE}.system)
			gbx_recent_locations.set_location (create {DRAWING_POINT}.make (8, 8))
			gbx_recent_locations.set_name ("gbx_recent_locations")
			gbx_recent_locations.set_size (create {DRAWING_SIZE}.make (404, 152))
			gbx_recent_locations.set_tab_index (0)
			gbx_recent_locations.set_tab_stop (False)
			gbx_recent_locations.set_text ("Recent Locations")
			-- 
			-- lbl_recent_addresses_desc
			-- 
			lbl_recent_addresses_desc.set_location (create {DRAWING_POINT}.make (80, 20))
			lbl_recent_addresses_desc.set_name ("lbl_recent_addresses_desc")
			lbl_recent_addresses_desc.set_size (create {DRAWING_SIZE}.make (316, 32))
			lbl_recent_addresses_desc.set_tab_index (0)
			lbl_recent_addresses_desc.set_text ("Here, suggestions are made from the list of recently visited web sites.  This is similar to the address bar in Internet Explorer.")
			-- 
			-- pic_recent_addresses
			-- 
			l_bitmap ?= l_resources.get_object ("picRecentAddresses.Image")
			pic_recent_addresses.set_image (l_bitmap)
			pic_recent_addresses.set_location (create {DRAWING_POINT}.make (12, 20))
			pic_recent_addresses.set_name ("pic_recent_addresses")
			pic_recent_addresses.set_size (create {DRAWING_SIZE}.make (36, 32))
			pic_recent_addresses.set_tab_index (4)
			pic_recent_addresses.set_tab_stop (False)
			-- 
			-- lbl_recent_addresses
			-- 
			lbl_recent_addresses.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left)
			lbl_recent_addresses.set_location (create {DRAWING_POINT}.make (8, 60))
			lbl_recent_addresses.set_name ("lbl_recent_addresses")
			lbl_recent_addresses.set_size (create {DRAWING_SIZE}.make (68, 16))
			lbl_recent_addresses.set_tab_index (1)
			lbl_recent_addresses.set_text ("&Addresses:")
			-- 
			-- lbl_recent_files_desc
			-- 
			lbl_recent_files_desc.set_location (create {DRAWING_POINT}.make (80, 84))
			lbl_recent_files_desc.set_name ("lbl_recent_files_desc")
			lbl_recent_files_desc.set_size (create {DRAWING_SIZE}.make (316, 32))
			lbl_recent_files_desc.set_tab_index (3)
			lbl_recent_files_desc.set_text ("This list includes recently opened documents and opened applications.  This is similar to the Run dialog in the Start Menu.")
			-- 
			-- pic_recent_files
			-- 
			l_bitmap ?= l_resources.get_object ("picRecentFiles.Image")
			pic_recent_files.set_image (l_bitmap)
			pic_recent_files.set_location (create {DRAWING_POINT}.make (12, 84))
			pic_recent_files.set_name ("pic_recent_files")
			pic_recent_files.set_size (create {DRAWING_SIZE}.make (36, 32))
			pic_recent_files.set_tab_index (5)
			pic_recent_files.set_tab_stop (False)
			-- 
			-- gbx_data_binding
			-- 
			gbx_data_binding.controls.add (txt_data_source)
			gbx_data_binding.controls.add (label1)
			gbx_data_binding.controls.add (lbl_data_binding)
			gbx_data_binding.controls.add (pic_data_binding)
			gbx_data_binding.controls.add (txt_items)
			gbx_data_binding.controls.add (lbl_items)
			gbx_data_binding.controls.add (lbl_data_source)
			
			gbx_data_binding.set_flat_style ({WINFORMS_FLAT_STYLE}.system)
			gbx_data_binding.set_location (create {DRAWING_POINT}.make (8, 288))
			gbx_data_binding.set_name ("gbx_data_binding")
			gbx_data_binding.set_size (create {DRAWING_SIZE}.make (404, 136))
			gbx_data_binding.set_tab_index (2)
			gbx_data_binding.set_tab_stop (False)
			gbx_data_binding.set_text ("Data Binding")
			-- 
			-- label1
			-- 
			label1.set_fore_color ({DRAWING_SYSTEM_COLORS}.control_dark_dark)
			label1.set_location (create {DRAWING_POINT}.make (80, 52))
			label1.set_name ("label1")
			label1.set_size (create {DRAWING_SIZE}.make (316, 16))
			label1.set_tab_index (1)
			label1.set_text ("Press 'delete' to remove an item from the list.")
			-- 
			-- lbl_data_binding
			-- 
			lbl_data_binding.set_location (create {DRAWING_POINT}.make (80, 20))
			lbl_data_binding.set_name ("lbl_data_binding")
			lbl_data_binding.set_size (create {DRAWING_SIZE}.make (316, 32))
			lbl_data_binding.set_tab_index (0)
			lbl_data_binding.set_text ("These fields make suggestions from lists.  The first box uses the %"Items%" property, while the second links to a data source.")
			-- 
			-- pic_data_binding
			-- 
			l_bitmap ?= l_resources.get_object ("picDataBinding.Image")
			pic_data_binding.set_image (l_bitmap)
			pic_data_binding.set_location (create {DRAWING_POINT}.make (12, 20))
			pic_data_binding.set_name ("pic_data_binding")
			pic_data_binding.set_size (create {DRAWING_SIZE}.make (36, 32))
			pic_data_binding.set_tab_index (7)
			pic_data_binding.set_tab_stop (False)
			-- 
			-- lbl_items
			-- 
			lbl_items.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left)
			lbl_items.set_location (create {DRAWING_POINT}.make (8, 80))
			lbl_items.set_name ("lbl_items")
			lbl_items.set_size (create {DRAWING_SIZE}.make (68, 16))
			lbl_items.set_tab_index (2)
			lbl_items.set_text ("&Items:")
			-- 
			-- lbl_data_source
			-- 
			lbl_data_source.set_anchor ({WINFORMS_ANCHOR_STYLES}.bottom | {WINFORMS_ANCHOR_STYLES}.left)
			lbl_data_source.set_location (create {DRAWING_POINT}.make (8, 108))
			lbl_data_source.set_name ("lbl_data_source")
			lbl_data_source.set_size (create {DRAWING_SIZE}.make (68, 16))
			lbl_data_source.set_tab_index (4)
			lbl_data_source.set_text ("&Data Source:")
			-- 
			-- btn_close
			-- 
			btn_close.set_dialog_result ({WINFORMS_DIALOG_RESULT}.ok)
			btn_close.set_flat_style ({WINFORMS_FLAT_STYLE}.system)
			btn_close.set_location (create {DRAWING_POINT}.make (328, 432))
			btn_close.set_name ("btn_close")
			btn_close.set_size (create {DRAWING_SIZE}.make (84, 24))
			btn_close.set_tab_index (3)
			btn_close.set_text ("Close")
			btn_close.add_click (create {EVENT_HANDLER}.make (Current, $btn_close_click))
			-- 
			-- FORM1
			-- 
			set_auto_scale_base_size (create {DRAWING_SIZE}.make (5, 13))
			set_client_size (create {DRAWING_SIZE}.make (420, 463))
			 
			controls.add (btn_close)
			controls.add (gbx_data_binding)
			controls.add (gbx_recent_locations)
			controls.add (gbx_my_computer)
			  
			set_font (create {DRAWING_FONT}.make ("Tahoma", 8.0))
			set_form_border_style ({WINFORMS_FORM_BORDER_STYLE}.fixed_dialog)
			set_maximize_box (False)
			set_name ("REBAR_FORM")
			set_start_position ({WINFORMS_FORM_START_POSITION}.center_screen)
			set_text ("Skybound AutoComplete")
			gbx_my_computer.resume_layout (False)
			gbx_recent_locations.resume_layout (False)
			gbx_data_binding.resume_layout (False)
			resume_layout_boolean (False)
		end
	
	
feature {FORM1} -- Basic Operations

	dispose_boolean (a_disposing: BOOLEAN) is
			-- Clean up any resources being used
		do
			if a_disposing then
				if components /= Void then
					components.dispose
				end
			end
			Precursor {WINFORMS_FORM} (a_disposing)
		end
		
		
feature {NONE} -- Event Handlers
		
	auto_complete_manager_delete (sender: SYSTEM_OBJECT; e: DELETE_EVENT_ARGS) is
			-- No description available.
		local
			source: ARRAY_LIST
		do
			if (e.auto_complete = auto_complete_manager.item (txt_items)) then
			
					-- items can be removed from the "Items" collection with one method
				e.delete_item
			elseif (e.auto_complete = auto_complete_manager.item (txt_data_source)) then
			
					-- when suggestions are made from a data source, we must remove the items manually
				source ?= e.auto_complete.data_source
				source.remove (e.text)

					-- rebind
				e.auto_complete.set_data_source (Void)
				e.auto_complete.set_data_source (source)
				e.auto_complete.refresh
			end
		end

	btn_close_click (sender: SYSTEM_OBJECT; e: EVENT_ARGS) is
			-- No description available.
		do
			close
		end
		
feature {NONE} -- Implementation
	
	read_data: ILIST is
			-- No description available.
		local
			l_lines: ARRAY_LIST
			l_executing: ASSEMBLY
			l_stream: SYSTEM_STREAM
			l_reader: STREAM_READER
			l_current_line: SYSTEM_STRING
			l_res: INTEGER
			l_dr: WINFORMS_DIALOG_RESULT			
			retried: BOOLEAN
		do
			if not retried then
				create l_lines.make
				l_executing := {ASSEMBLY}.get_executing_assembly
				l_stream := l_executing.get_manifest_resource_stream_type (get_type, "Data.auto")
				create l_reader.make (l_stream)
				from
					l_current_line := l_reader.read_line
				until
					l_current_line = Void
				loop
					l_res := l_lines.add (l_current_line)
					l_current_line := l_reader.read_line
				end	
			else
				l_dr := {WINFORMS_MESSAGE_BOX}.show ("An error occured while trying to open the data file %"data.auto%". " +
				"Auto-completion will not be available in the 'Data Source' text box.%R%N%R%NMore information:%R%N" + original_tag_name,
				"AutoComplete", {WINFORMS_MESSAGE_BOX_BUTTONS}.ok, {WINFORMS_MESSAGE_BOX_ICON}.error)
			end
			Result := l_lines
		ensure
			result_not_void: Result /= Void
		rescue
			retried := True
			retry
		end
		
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


end -- class FORM1
