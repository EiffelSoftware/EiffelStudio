indexing
	description: "Support for column resizing in assembly viewer and import tool"
	external_name: "ISE.AssemblyManager.ResizingSupport"

class
	RESIZING_SUPPORT

create 
	make

feature {NONE} -- Initialization

	make (a_font: like font; a_width: like window_width) is
		indexing
			description: "Set `font' with `a_font'."
			external_name: "Make"
		require
			non_void_font: a_font /= Void
			non_void_window_width: a_width /= Void
		do
			font := a_font
			window_width := a_width
		ensure
			font_set: font = a_font
			window_width_set: window_width = a_width
		end

feature -- Access

	font: DRAWING_FONT
		indexing
			description:"Font"
			external_name: "Font"
		end
	
	window_width: INTEGER
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end
		
feature -- Basic Operations

	assembly_name_column_width_from_info (a_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR] ): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [assembly_descriptor]
		indexing
			description: "Assembly name column width from `a_list'."
			external_name: "AssemblyNameColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			a_descriptor: ASSEMBLY_DESCRIPTOR
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					a_descriptor ?= a_list.item
					if a_descriptor /= Void then
						if a_descriptor.name.count > Result then
							Result := a_descriptor.name.count
							name := a_descriptor.name
						end
					end
					a_list.forth
				end
				width := pixel_width (name)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	assembly_name_column_width_from_assemblies (a_list: LINKED_LIST [EIFFEL_ASSEMBLY]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Assembly name column width from `a_list'."
			external_name: "AssemblyNameColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assembly_descriptor.name.count > Result then
							Result := an_eiffel_assembly.assembly_descriptor.name.count
							name := an_eiffel_assembly.assembly_descriptor.name
						end
					end
					a_list.forth
				end
				width := pixel_width (name)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	assembly_version_column_width_from_info (a_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [assembly_descriptor]
		indexing
			description: "Assembly version column width from `a_list'."
			external_name: "AssemblyVersionColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			a_descriptor: ASSEMBLY_DESCRIPTOR
			version: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					a_descriptor ?= a_list.item
					if a_descriptor /= Void then
						if a_descriptor.version.count > Result then
							Result := a_descriptor.version.count
							version := a_descriptor.version
						end
					end
					a_list.forth
				end
				width := pixel_width (version)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	assembly_version_column_width_from_assemblies (a_list: LINKED_LIST [EIFFEL_ASSEMBLY]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Assembly version column width from `a_list'."
			external_name: "AssemblyVersionColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			version: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assembly_descriptor.version.count > Result then
							Result := an_eiffel_assembly.assembly_descriptor.version.count
							version := an_eiffel_assembly.assembly_descriptor.version
						end
					end
					a_list.forth
				end
				width := pixel_width (version)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	assembly_culture_column_width_from_info (a_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [assembly_descriptor]
		indexing
			description: "Assembly culture column width from `a_list'."
			external_name: "AssemblyCultureColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			a_descriptor: ASSEMBLY_DESCRIPTOR
			culture: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					a_descriptor ?= a_list.item
					if a_descriptor /= Void then
						if a_descriptor.culture.count > Result then
							Result := a_descriptor.culture.count
							culture := a_descriptor.culture
						end
					end
					a_list.forth
				end
				width := pixel_width (culture)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	assembly_culture_column_width_from_assemblies (a_list: LINKED_LIST [EIFFEL_ASSEMBLY] ): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Assembly culture column width from `a_list'."
			external_name: "AssemblyCultureColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			culture: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assembly_descriptor.culture.count > Result then
							Result := an_eiffel_assembly.assembly_descriptor.culture.count
							culture := an_eiffel_assembly.assembly_descriptor.culture
						end
					end
					a_list.forth
				end
				width := pixel_width (culture)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end
		
	assembly_public_key_column_width_from_info (a_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR] ): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [assembly_descriptor]
		indexing
			description: "Assembly public key column width from `a_list'."
			external_name: "AssemblyPublicKeyColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			a_descriptor: ASSEMBLY_DESCRIPTOR
			public_key: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					a_descriptor ?= a_list.item
					if a_descriptor /= Void then
						if a_descriptor.public_key.count > Result then
							Result := a_descriptor.public_key.count
							public_key := a_descriptor.public_key
						end
					end
					a_list.forth
				end
				width := pixel_width (public_key)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	assembly_public_key_column_width_from_assemblies (a_list: LINKED_LIST [EIFFEL_ASSEMBLY]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Assembly public key column width from `a_list'."
			external_name: "AssemblyPublicKeyColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			public_key: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assembly_descriptor.public_key.count > Result then
							Result := an_eiffel_assembly.assembly_descriptor.public_key.count
							public_key := an_eiffel_assembly.assembly_descriptor.public_key
						end
					end
					a_list.forth
				end
				width := pixel_width (public_key)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	dependancies_column_width_from_info (a_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR] ): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [assembly_descriptor]
		indexing
			description: "Dependancies column width from `a_list'."
			external_name: "DependanciesColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			support: ASSEMBLY_SUPPORT
			i: INTEGER
			a_descriptor: ASSEMBLY_DESCRIPTOR
			dependancies: ARRAY [CLI_CELL [ASSEMBLY_NAME]]
			dependancies_string: STRING
			a_string: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				create support.make
				from
					a_list.start
				until
					a_list.after
				loop
					dependancies_string := Void
					a_descriptor ?= a_list.item
					if a_descriptor /= Void then
						dependancies := support.dependancies_from_info (a_descriptor)
						if dependancies /= Void and then dependancies.count > 0 then
							dependancies_string := support.dependancies_string (dependancies)
						else
							dependancies_string := No_dependancy
						end
						if dependancies_string.count > Result then
							Result := dependancies_string.count
							a_string := dependancies_string
						end
					end
					a_list.forth
				end
				width := pixel_width (a_string)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end
		
	dependancies_column_width_from_assemblies (a_list: LINKED_LIST [EIFFEL_ASSEMBLY]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Dependancies column width from `a_list'."
			external_name: "DependanciesColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			a_descriptor: ASSEMBLY_DESCRIPTOR
			dependancies: ARRAY [CLI_CELL[ASSEMBLY_NAME]]
			dependancies_string: STRING
			a_string: STRING
			support: ASSEMBLY_SUPPORT
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				create support.make
				from
					a_list.start
				until
					a_list.after
				loop
					dependancies_string := Void
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then					
						a_descriptor := an_eiffel_assembly.assembly_descriptor
						dependancies := support.dependancies_from_info (a_descriptor)
						if dependancies /= Void and then dependancies.count > 0 then
							dependancies_string := support.dependancies_string (dependancies)
						else
							dependancies_string := No_dependancy
						end
						if dependancies_string.count > Result then
							Result := dependancies_string.count
							a_string := dependancies_string
						end					
					end
					a_list.forth
				end
				width := pixel_width (a_string)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry			
		end

	eiffel_path_column_width (a_list: LINKED_LIST [EIFFEL_ASSEMBLY]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Eiffel path column width from `a_list'."
			external_name: "EiffelPathColumnWidth"
		require
			non_void_list: a_list /= Void
		local
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			eiffel_path: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.eiffel_cluster_path.count > Result then
							Result := an_eiffel_assembly.eiffel_cluster_path.count
							eiffel_path := an_eiffel_assembly.eiffel_cluster_path
						end
					end
					a_list.forth
				end
				width := pixel_width (eiffel_path)
				Result := adapted_width (width)
			else
				Result := window_width // 5
			end
		rescue
			retried := True
			retry
		end

	eiffel_name_column_width_from_classes (a_list: LINKED_LIST [EIFFEL_CLASS]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Eiffel name column width from `a_list'."
			external_name: "EiffelNameColumnWidthFromClasses"
		require
			non_void_list: a_list /= Void
		local
			a_class: EIFFEL_CLASS
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					a_class ?= a_list.item
					if a_class /= Void then
						if a_class.eiffel_name.count > Result then
							Result := a_class.eiffel_name.count
							name := a_class.eiffel_name
						end
					end
					a_list.forth
				end
				width := pixel_width (name)
				Result := adapted_width (width)
			else
				Result := window_width // 2
			end
		rescue
			retried := True
			retry
		end

	external_name_column_width_from_classes (a_list: LINKED_LIST [EIFFEL_CLASS]): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "External name column width from `a_list'."
			external_name: "ExternalNameColumnWidthFromClasses"
		require
			non_void_list: a_list /= Void
		local
			a_class: EIFFEL_CLASS
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
					a_list.start
				until
					a_list.after
				loop
					a_class ?= a_list.item
					if a_class /= Void then
						if a_class.external_name.count > Result then
							Result := a_class.external_name.count
							name := a_class.external_name
						end
					end
					a_list.forth
				end
				width := pixel_width (name)
				Result := adapted_width (width)
			else
				Result := window_width // 2
			end
		rescue
			retried := True
			retry
		end
		
feature {NONE} -- Implementation

	No_dependancy: STRING is "No dependancy"
		indexing
			description: "Message in case assembly has no dependancy"
			external_name: "NoDependancy"
		end
	
	Margin: INTEGER is 10
		indexing
			description: "Margin"
			external_name: "Margin"
		end
		
	pixel_width (a_string: STRING): INTEGER is
		indexing
			description: "get_length in pixels of `a_string'"
			external_name: "PixelWidth"
		require
			non_void_string: a_string /= Void
			not_empty_string: a_string.count > 0
		local
			a_label: WINFORMS_LABEL
			graphics: DRAWING_GRAPHICS
			a_sizef: DRAWING_SIZE_F
		do
			create a_label.make_winforms_label 
			a_label.set_text (a_string.to_cil)
			a_label.set_font (font)
			a_label.set_auto_size (True)
			Result := a_label.get_width + Margin
			--graphics := graphics_factory.from_image (image)
			--a_sizef := graphics.measure_string (a_string, font)
			--Result := a_sizef.to_size.get_width
		end
	
--	graphics_factory: SYSTEM_DRAWING_GRAPHICS
--		indexing
--			description: "Static needed to create a graphics"
--			external_name: "GraphicsFactory"
--		end
	
	adapted_width (a_width: INTEGER): INTEGER is
		indexing
			description: "Check if `a_width' is larger than 75 percents of `window_width' and adapt it accordingly."
			external_name: "AdaptedWidth"
		local
			maximum_width: INTEGER
		do
			maximum_width := (window_width * 75) // 100
			if a_width < maximum_width then
				Result := a_width
			else
				Result := maximum_width
			end		
		end
		
end -- class RESIZING_SUPPORT
	