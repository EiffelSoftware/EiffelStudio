indexing
	description: "Information on a class of the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_CLASS

inherit
	XMI_TYPE
		redefine
			code
		end

create 
	make

feature --Initialization

	make (id: INTEGER; id_package: INTEGER c: CLASS_C) is
			-- Initialization of `Current'
			-- assign `id' to `xmi_id'
			-- assign `id_package' to `id_model'
			-- assign `c' to `compiled_class'.
		local
			c_ast: CLASS_AS
		do
			create generalizations.make
			create features.make
			xmi_id := id
			id_model := id_package
			compiled_class := c
			name := compiled_class.name_in_upper
			if compiled_class.has_ast and compiled_class.generics /= Void then
				c_ast := compiled_class.ast
				name.append (" ")
				name.append (c_ast.generics_as_string)
			end
		end

feature -- Access

	compiled_class: CLASS_C
		-- Class from which `Current' is a representation.

	generalizations: LINKED_LIST [XMI_GENERALIZATION]
		-- Relations of inheritance from which `Current' is
		-- either subtype or supertype.

	features: LINKED_LIST [XMI_FEATURE]
		-- Attributes and operations defined in `Current'.

	id_model: INTEGER
		-- Number identifying the model (package) to which `Current' belongs.

feature -- Status report

	is_subtype (g: XMI_GENERALIZATION): BOOLEAN is
			-- Is `Current' subtype of relation `g'?
		require
			current_involved_in_g:	generalizations.has (g)
		do
			Result := (g.subtype = Current)
		ensure
			result_set:	Result = (g.subtype = Current)
		end

	is_supertype (g: XMI_GENERALIZATION): BOOLEAN is
			-- Is `Current' supertype of relation `g'?
		require
			current_involved_in_g:	generalizations.has (g)
		do
			Result := (g.supertype = Current)
		ensure
			result_set:	Result = (g.supertype = Current)
		end

	is_generalized: BOOLEAN is
			-- Is `Current' subtype of an item in `generalizations'?
		do
			Result := false
			from
				generalizations.start
			until
				(Result = true) or else generalizations.after
			loop
				Result := is_subtype (generalizations.item)
				generalizations.forth
			end
		end

	is_specialized: BOOLEAN is
			-- Is `Current' subtype of an item in `generalizations'?
		do
			Result := false
			from
				generalizations.start
			until
				(Result = true) or else generalizations.after
			loop
				Result := is_supertype (generalizations.item)
				generalizations.forth
			end
		end

feature -- Element change

	add_generalization (g: XMI_GENERALIZATION) is
			-- Adds `g' to `generalization'.
		require
			new_generalization_not_void: g /= Void
			class_involved: g.subtype = Current or else g.supertype = Current
		do
			generalizations.extend (g)
		ensure
			new_generalization_added: generalizations.has (g)
		end

	add_feature (f: XMI_FEATURE) is
			-- Adds `f' to `features'.
		require
			new_feature_not_void: f /= Void
		do
			features.extend (f)
		ensure
			new_feature_added: features.has (f)
		end

feature -- Action 

	code: STRING is
			-- XMI representation of the class.
		do	
			Result := "<Foundation.Core.Class xmi.id = 'S."
			Result.append (xmi_id.out)
			Result.append ("'>%N<Foundation.Core.ModelElement.name>")
			Result.append (name)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%<Foundation.Core.ModelElement.visibility xmi.value = 'public'/>%N%
				%<Foundation.Core.GeneralizableElement.isRoot xmi.value = 'false'/>%N%
				%<Foundation.Core.GeneralizableElement.isLeaf xmi.value = 'true'/>%N%
				%<Foundation.Core.GeneralizableElement.isAbstract xmi.value = '")
			if compiled_class.is_deferred then
				Result.append ("true")
			else
				Result.append ("false")
			end
			Result.append ("'/>%N%
				%<Foundation.Core.Class.isActive xmi.value = 'false'/>%N%
				%<Foundation.Core.ModelElement.namespace>%N%
				%  <Model_Management.Package xmi.idref = 'G.")
			Result.append (id_model.out)
			Result.append ("'/> %N%
				%</Foundation.Core.ModelElement.namespace>%N")

			if is_generalized then
				from 
					generalizations.start
					Result.append ("<Foundation.Core.GeneralizableElement.generalization>%N")
				until
					generalizations.after
				loop
					if is_subtype (generalizations.item) then
						Result.append ("<Foundation.Core.Generalization xmi.idref = 'G.")
						Result.append (generalizations.item.xmi_id.out)
						Result.append ("'/> <!--{")
						Result.append (generalizations.item.subtype.name)
						Result.append ("->")
						Result.append (generalizations.item.supertype.name)
						Result.append ("}-->")
					end
					generalizations.forth
				end
				Result.append ("</Foundation.Core.GeneralizableElement.generalization>%N")
			end

			if is_specialized then
				from 
					generalizations.start
					Result.append ("<Foundation.Core.GeneralizableElement.specialization>%N")
				until
					generalizations.after
				loop
					if is_supertype (generalizations.item) then
						Result.append ("<Foundation.Core.Generalization xmi.idref = 'G.")
						Result.append (generalizations.item.xmi_id.out)
						Result.append ("'/> <!--{")
						Result.append (generalizations.item.subtype.name)
						Result.append ("->")
						Result.append (generalizations.item.supertype.name)
						Result.append ("}-->")
					end
					generalizations.forth
				end
				Result.append ("</Foundation.Core.GeneralizableElement.specialization>%N")
			end
			Result.append ("<Foundation.Core.ModelElement.taggedValue>%N%
				%<Foundation.Extension_Mechanisms.TaggedValue>%N%
				%<Foundation.Extension_Mechanisms.TaggedValue.tag>persistence</Foundation.Extension_Mechanisms.TaggedValue.tag>%N%
				%<Foundation.Extension_Mechanisms.TaggedValue.value>transient</Foundation.Extension_Mechanisms.TaggedValue.value>%N%
				%</Foundation.Extension_Mechanisms.TaggedValue>%N%
				%</Foundation.Core.ModelElement.taggedValue>%N")
			Result.append ("<Foundation.Core.Classifier.feature>%N")
			from
				features.start
			until
				features.after
			loop
				Result.append (features.item.code)
				features.forth
			end
			Result.append ("</Foundation.Core.Classifier.feature>%N%
				%</Foundation.Core.Class>%N")
		end

end -- class XMI_CLASS
