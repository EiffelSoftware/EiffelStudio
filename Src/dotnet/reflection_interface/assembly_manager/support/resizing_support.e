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
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
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
					i = a_list.count
				loop
					a_descriptor ?= a_list.item (i)
					if a_descriptor /= Void then
						if a_descriptor.name.length > Result then
							Result := a_descriptor.name.length
							name := a_descriptor.name
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
					i = a_list.count
				loop
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assemblydescriptor.name.length > Result then
							Result := an_eiffel_assembly.assemblydescriptor.name.length
							name := an_eiffel_assembly.assemblydescriptor.name
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
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
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
					i = a_list.count
				loop
					a_descriptor ?= a_list.item (i)
					if a_descriptor /= Void then
						if a_descriptor.version.length > Result then
							Result := a_descriptor.version.length
							version := a_descriptor.version
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
					i = a_list.count
				loop
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assemblydescriptor.version.length > Result then
							Result := an_eiffel_assembly.assemblydescriptor.version.length
							version := an_eiffel_assembly.assemblydescriptor.version
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
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
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
					i = a_list.count
				loop
					a_descriptor ?= a_list.item (i)
					if a_descriptor /= Void then
						if a_descriptor.culture.length > Result then
							Result := a_descriptor.culture.length
							culture := a_descriptor.culture
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
					i = a_list.count
				loop
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assemblydescriptor.culture.length > Result then
							Result := an_eiffel_assembly.assemblydescriptor.culture.length
							culture := an_eiffel_assembly.assemblydescriptor.culture
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
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
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
					i = a_list.count
				loop
					a_descriptor ?= a_list.item (i)
					if a_descriptor /= Void then
						if a_descriptor.publickey.length > Result then
							Result := a_descriptor.publickey.length
							public_key := a_descriptor.publickey
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
					i = a_list.count
				loop
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.assemblydescriptor.publickey.length > Result then
							Result := an_eiffel_assembly.assemblydescriptor.publickey.length
							public_key := an_eiffel_assembly.assemblydescriptor.publickey
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
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
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
				create support
				from
				until
					i = a_list.count
				loop
					dependancies_string := Void
					a_descriptor ?= a_list.item (i)
					if a_descriptor /= Void then
						dependancies := support.dependancies_from_info (a_descriptor)
						if dependancies /= Void and then dependancies.count > 0 then
							dependancies_string := support.dependancies_string (dependancies)
						else
							dependancies_string := No_dependancy
						end
						if dependancies_string.length > Result then
							Result := dependancies_string.length
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
				create support
				from
				until
					i = a_list.count
				loop
					dependancies_string := Void
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then					
						a_descriptor := an_eiffel_assembly.assemblydescriptor
						dependancies := support.dependancies_from_info (a_descriptor)
						if dependancies /= Void and then dependancies.count > 0 then
							dependancies_string := support.dependancies_string (dependancies)
						else
							dependancies_string := No_dependancy
						end
						if dependancies_string.length > Result then
							Result := dependancies_string.length
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
					i = a_list.count
				loop
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then
						if an_eiffel_assembly.eiffelclusterpath.length > Result then
							Result := an_eiffel_assembly.eiffelclusterpath.length
							eiffel_path := an_eiffel_assembly.eiffelclusterpath
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
					i = a_list.count
				loop
					a_class ?= a_list.item (i)
					if a_class /= Void then
						if a_class.eiffelname.length > Result then
							Result := a_class.eiffelname.length
							name := a_class.eiffelname
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
					i = a_list.count
				loop
					a_class ?= a_list.item (i)
					if a_class /= Void then
						if a_class.externalname.length > Result then
							Result := a_class.externalname.length
							name := a_class.externalname
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
			description: "Length in pixels of `a_string'"
			external_name: "PixelWidth"
		require
			non_void_string: a_string /= Void
			not_empty_string: a_string.length > 0
		local
			a_label: SYSTEM_WINDOWS_FORMS_LABEL
			graphics: SYSTEM_DRAWING_GRAPHICS
			a_sizef: SYSTEM_DRAWING_SIZEF
		do
			create a_label.make_label 
			a_label.set_text (a_string)
			a_label.set_font (font)
			a_label.set_autosize (True)
			Result := a_label.width + Margin
			--graphics := graphics_factory.fromimage (image)
			--a_sizef := graphics.measurestring (a_string, font)
			--Result := a_sizef.tosize.width
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
	