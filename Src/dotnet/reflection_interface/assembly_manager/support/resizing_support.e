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

	font: SYSTEM_DRAWING_FONT
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

	assembly_name_column_width_from_info (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_assembly_descriptor]
		indexing
			description: "Assembly name column width from `a_list'."
			external_name: "AssemblyNameColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					a_descriptor ?= a_list.get_item (i)
					if a_descriptor /= Void then
						if a_descriptor.get_name.get_length > Result then
							Result := a_descriptor.get_name.get_length
							name := a_descriptor.get_name
						end
					end
					i := i + 1
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

	assembly_name_column_width_from_assemblies (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Assembly name column width from `a_list'."
			external_name: "AssemblyNameColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					an_eiffel_assembly ?= a_list.get_item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.get_assembly_descriptor.get_name.get_length > Result then
							Result := an_eiffel_assembly.get_assembly_descriptor.get_name.get_length
							name := an_eiffel_assembly.get_assembly_descriptor.get_name
						end
					end
					i := i + 1
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

	assembly_version_column_width_from_info (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_assembly_descriptor]
		indexing
			description: "Assembly version column width from `a_list'."
			external_name: "AssemblyVersionColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			version: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					a_descriptor ?= a_list.get_item (i)
					if a_descriptor /= Void then
						if a_descriptor.get_version.get_length > Result then
							Result := a_descriptor.get_version.get_length
							version := a_descriptor.get_version
						end
					end
					i := i + 1
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

	assembly_version_column_width_from_assemblies (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Assembly version column width from `a_list'."
			external_name: "AssemblyVersionColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			version: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					an_eiffel_assembly ?= a_list.get_item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.get_assembly_descriptor.get_version.get_length > Result then
							Result := an_eiffel_assembly.get_assembly_descriptor.get_version.get_length
							version := an_eiffel_assembly.get_assembly_descriptor.get_version
						end
					end
					i := i + 1
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

	assembly_culture_column_width_from_info (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_assembly_descriptor]
		indexing
			description: "Assembly culture column width from `a_list'."
			external_name: "AssemblyCultureColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			culture: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					a_descriptor ?= a_list.get_item (i)
					if a_descriptor /= Void then
						if a_descriptor.get_culture.get_length > Result then
							Result := a_descriptor.get_culture.get_length
							culture := a_descriptor.get_culture
						end
					end
					i := i + 1
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

	assembly_culture_column_width_from_assemblies (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Assembly culture column width from `a_list'."
			external_name: "AssemblyCultureColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			culture: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					an_eiffel_assembly ?= a_list.get_item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.get_assembly_descriptor.get_culture.get_length > Result then
							Result := an_eiffel_assembly.get_assembly_descriptor.get_culture.get_length
							culture := an_eiffel_assembly.get_assembly_descriptor.get_culture
						end
					end
					i := i + 1
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
		
	assembly_public_key_column_width_from_info (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_assembly_descriptor]
		indexing
			description: "Assembly public key column width from `a_list'."
			external_name: "AssemblyPublicKeyColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			public_key: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					a_descriptor ?= a_list.get_item (i)
					if a_descriptor /= Void then
						if a_descriptor.get_public_key.get_length > Result then
							Result := a_descriptor.get_public_key.get_length
							public_key := a_descriptor.get_public_key
						end
					end
					i := i + 1
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

	assembly_public_key_column_width_from_assemblies (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Assembly public key column width from `a_list'."
			external_name: "AssemblyPublicKeyColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			public_key: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					an_eiffel_assembly ?= a_list.get_item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.get_assembly_descriptor.get_public_key.get_length > Result then
							Result := an_eiffel_assembly.get_assembly_descriptor.get_public_key.get_length
							public_key := an_eiffel_assembly.get_assembly_descriptor.get_public_key
						end
					end
					i := i + 1
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

	dependancies_column_width_from_info (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_assembly_descriptor]
		indexing
			description: "Dependancies column width from `a_list'."
			external_name: "DependanciesColumnWidthFromInfo"
		require
			non_void_list: a_list /= Void
		local
			support: SUPPORT
			i: INTEGER
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			dependancies_string: STRING
			a_string: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				create support.make
				from
				until
					i = a_list.get_count
				loop
					dependancies_string := Void
					a_descriptor ?= a_list.get_item (i)
					if a_descriptor /= Void then
						dependancies := support.dependancies_from_info (a_descriptor)
						if dependancies /= Void and then dependancies.count > 0 then
							dependancies_string := support.dependancies_string (dependancies)
						else
							dependancies_string := No_dependancy
						end
						if dependancies_string.get_length > Result then
							Result := dependancies_string.get_length
							a_string := dependancies_string
						end
					end
					i := i + 1
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
		
	dependancies_column_width_from_assemblies (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Dependancies column width from `a_list'."
			external_name: "DependanciesColumnWidthFromAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			dependancies_string: STRING
			a_string: STRING
			support: SUPPORT
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				create support.make
				from
				until
					i = a_list.get_count
				loop
					dependancies_string := Void
					an_eiffel_assembly ?= a_list.get_item (i)
					if an_eiffel_assembly /= Void then					
						a_descriptor := an_eiffel_assembly.get_assembly_descriptor
						dependancies := support.dependancies_from_info (a_descriptor)
						if dependancies /= Void and then dependancies.count > 0 then
							dependancies_string := support.dependancies_string (dependancies)
						else
							dependancies_string := No_dependancy
						end
						if dependancies_string.get_length > Result then
							Result := dependancies_string.get_length
							a_string := dependancies_string
						end					
					end
					i := i + 1
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

	eiffel_path_column_width (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Eiffel path column width from `a_list'."
			external_name: "EiffelPathColumnWidth"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			eiffel_path: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					an_eiffel_assembly ?= a_list.get_item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.get_eiffel_cluster_path.get_length > Result then
							Result := an_eiffel_assembly.get_eiffel_cluster_path.get_length
							eiffel_path := an_eiffel_assembly.get_eiffel_cluster_path
						end
					end
					i := i + 1
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

	eiffel_name_column_width_from_classes (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Eiffel name column width from `a_list'."
			external_name: "EiffelNameColumnWidthFromClasses"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			a_class: ISE_REFLECTION_EIFFELCLASS
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					a_class ?= a_list.get_item (i)
					if a_class /= Void then
						if a_class.get_eiffel_name.get_length > Result then
							Result := a_class.get_eiffel_name.get_length
							name := a_class.get_eiffel_name
						end
					end
					i := i + 1
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

	external_name_column_width_from_classes (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): INTEGER is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "External name column width from `a_list'."
			external_name: "ExternalNameColumnWidthFromClasses"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			a_class: ISE_REFLECTION_EIFFELCLASS
			name: STRING
			retried: BOOLEAN
			width: INTEGER
		do
			if not retried then
				from
				until
					i = a_list.get_count
				loop
					a_class ?= a_list.get_item (i)
					if a_class /= Void then
						if a_class.get_external_name.get_length > Result then
							Result := a_class.get_external_name.get_length
							name := a_class.get_external_name
						end
					end
					i := i + 1
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
			not_empty_string: a_string.get_length > 0
		local
			a_label: SYSTEM_WINDOWS_FORMS_LABEL
			graphics: SYSTEM_DRAWING_GRAPHICS
			a_sizef: SYSTEM_DRAWING_SIZEF
		do
			create a_label.make_label 
			a_label.set_text (a_string)
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
	