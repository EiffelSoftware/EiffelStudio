indexing
	description: "Print in output the comments corresponding to a_member."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_COMMENTS

create
	make

feature {NONE} -- Initialization

	make (a_text_area: EV_TEXT) is
			-- Initialiaze attributes with `a_parent_window'.
		require
			non_void_a_text_area: a_text_area /= Void
		do
			comments_area := a_text_area
		ensure
			comments_area_set: comments_area = a_text_area
		end

feature -- Access

	comments_area: EV_TEXT
			-- Comments area.

feature -- Basic Operations

	display_assembly_information (an_assembly: CONSUMED_ASSEMBLY) is
			-- display in `comments_area' the informations corresponding to `an_assembly'.
		require
			non_void_an_assembly: an_assembly /= Void
		do
			comments_area.enable_edit
			comments_area.text.wipe_out;
			comments_area.disable_edit
		end

	display_namespace_information (a_namespace_name: STRING) is
			-- display in `comments_area' the informations corresponding to `a_full_dotnet_type_name'.
		require
			non_void_a_namespace_name: a_namespace_name /= Void
			no_empty_a_namespace_name: not a_namespace_name.is_empty
		do
			comments_area.enable_edit
			comments_area.text.wipe_out;
			comments_area.disable_edit
		end

	display_type_information (an_assembly: CONSUMED_ASSEMBLY; a_full_dotnet_type_name: STRING) is
			-- display in `comments_area' the informations corresponding to `a_full_dotnet_type_name'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			no_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_assembly_info: ASSEMBLY_INFORMATION
			l_member_info: MEMBER_INFORMATION
		do
			if not (create {CACHE}).assemblies_informations.has (an_assembly.out) then
					-- Deserialize information of assembly.
				(create {CACHE}).deserialize_information_assembly (an_assembly)
			end
			if (create {CACHE}).assemblies_informations.has (an_assembly.out) then
				l_assembly_info := (create {CACHE}).assemblies_informations.item (an_assembly.out)
				if l_assembly_info /= Void then
					l_member_info := l_assembly_info.find_type (a_full_dotnet_type_name)
					if l_member_info /= Void then
						display (l_member_info)
					else
						clear_comments
					end
				end
			end
		end

	display_feature_information (an_assembly: CONSUMED_ASSEMBLY; a_member: CONSUMED_MEMBER; a_full_dotnet_type_name: STRING) is
			-- display in `comments_area' the informations corresponding to `a_member'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_member: a_member /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			no_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_assembly_info: ASSEMBLY_INFORMATION
			l_member_info: MEMBER_INFORMATION
			l_signature: STRING
			l_full_dotnet_type_name: STRING
			l_consumed_assembly: CONSUMED_ASSEMBLY
			l_static_type: TUPLE [CONSUMED_ASSEMBLY, STRING]
		do
			l_static_type := immediate_type_feature (an_assembly, a_member, a_full_dotnet_type_name)
			l_full_dotnet_type_name ?= l_static_type.item (2)
			l_consumed_assembly ?= l_static_type.item (1)

			if not (create {CACHE}).assemblies_informations.has (l_consumed_assembly.out) then
					-- Deserialize information of assembly.
				(create {CACHE}).deserialize_information_assembly (l_consumed_assembly)
			end
			if (create {CACHE}).assemblies_informations.has (l_consumed_assembly.out) then
				l_assembly_info := (create {CACHE}).assemblies_informations.item (l_consumed_assembly.out)
				if l_assembly_info /= Void then
					l_signature := (create {SIGNATURE}).xml_signature_member (a_member, l_full_dotnet_type_name)
					l_member_info := l_assembly_info.find_feature (l_full_dotnet_type_name, l_signature)
					if l_member_info /= Void then
						display (l_member_info)
					else
						create l_member_info.make
						l_member_info.set_name (a_full_dotnet_type_name + "." + l_signature)
						if l_signature.is_equal ((create {ENUM_TYPE}).from_integer_signature) then
							l_member_info.set_summary ((create {ENUM_TYPE}).from_integer_comment)
							display (l_member_info)
						elseif l_signature.is_equal ((create {ENUM_TYPE}).to_integer_signature) then
							l_member_info.set_summary ((create {ENUM_TYPE}).to_integer_comment)
							display (l_member_info)
						elseif l_signature.is_equal ((create {ENUM_TYPE}).or_signature) then
							l_member_info.set_summary ((create {ENUM_TYPE}).or_comment)
							display (l_member_info)
						else
							clear_comments
						end
					end
				end
			end
		end

	display_constructor_information (an_assembly: CONSUMED_ASSEMBLY; a_constructor: CONSUMED_CONSTRUCTOR; a_full_dotnet_type_name: STRING) is
			-- display in `comments_area' the informations corresponding to `a_constructor'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_constructor: a_constructor /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			no_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_assembly_info: ASSEMBLY_INFORMATION
			l_member_info: MEMBER_INFORMATION
			l_signature: STRING
		do
			if (create {CACHE}).assemblies_informations.has (an_assembly.out) then
				l_assembly_info := (create {CACHE}).assemblies_informations.item (an_assembly.out)
				if l_assembly_info /= Void then
					l_signature := (create {SIGNATURE}).xml_signature_constructor (a_constructor, a_full_dotnet_type_name)
					l_member_info := l_assembly_info.find_feature (a_full_dotnet_type_name, l_signature)
					if l_member_info /= Void then
						display (l_member_info)
					else
						clear_comments
					end
				end
			end
		end

	display_property_information (an_assembly: CONSUMED_ASSEMBLY; a_property: CONSUMED_PROPERTY; a_full_dotnet_type_name: STRING) is
			-- display in `comments_area' the informations corresponding to `a_property'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_property: a_property /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			no_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_assembly_info: ASSEMBLY_INFORMATION
			l_member_info: MEMBER_INFORMATION
			l_signature: STRING
			l_full_dotnet_type_name: STRING
			l_consumed_assembly: CONSUMED_ASSEMBLY
			l_static_type: TUPLE [CONSUMED_ASSEMBLY, STRING]
		do
			l_static_type := immediate_type_feature (an_assembly, a_property, a_full_dotnet_type_name)
			l_full_dotnet_type_name ?= l_static_type.item (2)
			l_consumed_assembly ?= l_static_type.item (1)

			if not (create {CACHE}).assemblies_informations.has (l_consumed_assembly.out) then
					-- Deserialize information of assembly.
				(create {CACHE}).deserialize_information_assembly (l_consumed_assembly)
			end
			if (create {CACHE}).assemblies_informations.has (l_consumed_assembly.out) then
				l_assembly_info := (create {CACHE}).assemblies_informations.item (l_consumed_assembly.out)
				if l_assembly_info /= Void then
					l_signature := a_property.dotnet_name
					l_member_info := l_assembly_info.find_feature (l_full_dotnet_type_name, l_signature)
					if l_member_info /= Void then
						display (l_member_info)
					else
						clear_comments
					end
				end
			end
		end

	display_event_information (an_assembly: CONSUMED_ASSEMBLY; an_event: CONSUMED_EVENT; a_full_dotnet_type_name: STRING) is
			-- display in `comments_area' the informations corresponding to `an_event'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_an_event: an_event /= Void
			non_void_a_full_dotnet_type_name: a_full_dotnet_type_name /= Void
			no_empty_a_full_dotnet_type_name: not a_full_dotnet_type_name.is_empty
		local
			l_assembly_info: ASSEMBLY_INFORMATION
			l_member_info: MEMBER_INFORMATION
			l_signature: STRING
			l_full_dotnet_type_name: STRING
			l_consumed_assembly: CONSUMED_ASSEMBLY
			l_static_type: TUPLE [CONSUMED_ASSEMBLY, STRING]
		do
			l_static_type := immediate_type_feature (an_assembly, an_event, a_full_dotnet_type_name)
			l_full_dotnet_type_name ?= l_static_type.item (2)
			l_consumed_assembly ?= l_static_type.item (1)

			if not (create {CACHE}).assemblies_informations.has (l_consumed_assembly.out) then
					-- Deserialize information of assembly.
				(create {CACHE}).deserialize_information_assembly (l_consumed_assembly)
			end
			if (create {CACHE}).assemblies_informations.has (l_consumed_assembly.out) then
				l_assembly_info := (create {CACHE}).assemblies_informations.item (l_consumed_assembly.out)
				if l_assembly_info /= Void then
					l_signature := an_event.dotnet_name
					l_member_info := l_assembly_info.find_feature (l_full_dotnet_type_name, l_signature)
					if l_member_info /= Void then
						display (l_member_info)
					else
						clear_comments
					end
				end
			end
		end

feature {NONE} -- Basic Operations

	display (a_member: MEMBER_INFORMATION) is
			-- Display in `comments_area' the informations of `a_member'.
		do
			comments_area.enable_edit
			comments_area.text.wipe_out;
			--(create {EV_ENVIRONMENT}).application.process_events

			comments_area.set_text ("Member name : " + a_member.name + "%N%N")
			comments_area.append_text ("Summary : %N" + a_member.summary )
			if a_member.parameters.count > 0 then
				comments_area.append_text ("%NParameters : %N")
			end
			from
				a_member.parameters.start
			until
				a_member.parameters.after
			loop
				comments_area.append_text (a_member.parameters.item.name + " : " + a_member.parameters.item.description + "%N")
				a_member.parameters.forth
			end
			if not a_member.returns.is_empty then
				comments_area.append_text ("%NReturns : %N" + a_member.returns + "%N")
			end
			
			comments_area.disable_edit
		end
		
	clear_comments is
			-- Clear `comment_area'.
		do
			comments_area.enable_edit
			comments_area.set_text ("")
			comments_area.disable_edit
		end
		
	immediate_type_feature (an_assembly: CONSUMED_ASSEMBLY; a_member: CONSUMED_ENTITY; a_full_dotnet_type: STRING): TUPLE [CONSUMED_ASSEMBLY, STRING] is
			-- Return the `full_dotnet_type' where `a_member' is declared.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			eac: EAC_BROWSER
			l_ancestors: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			l_entities: ARRAYED_LIST [CONSUMED_ENTITY]
			l_ancestor_assembly: CONSUMED_ASSEMBLY
			ct, ct2: CONSUMED_TYPE
			l_found: BOOLEAN
		do
			create eac
			ct := eac.consumed_type (an_assembly, a_full_dotnet_type)
			l_entities := ct.entities

			from
				l_entities.start
			until
				l_entities.after
			loop
				if l_entities.item.dotnet_name.is_equal (a_member.dotnet_name) and then
					l_entities.item.eiffel_name.is_equal (a_member.eiffel_name) then
					if l_entities.item.has_arguments and a_member.has_arguments then
						if l_entities.item.arguments.count = a_member.arguments.count then
							l_found := True	
						end
					else
						l_found := True
					end
				end
				l_entities.forth
			end

			--if l_entities.has (a_member) then
			if l_found then
				create Result.make
				Result.put (an_assembly, 1)
				Result.put (a_full_dotnet_type, 2)
			else
				l_ancestors := ct.ancestors
				from
					l_ancestors.start
				until
					l_ancestors.after or Result /= Void
				loop
					l_ancestor_assembly := eac.referenced_assembly (an_assembly, l_ancestors.item.assembly_id)
					Result := immediate_type_feature (l_ancestor_assembly, a_member, l_ancestors.item.name)
--					ct2 := eac.consumed_type (l_ancestor_assembly, l_ancestors.item.name)
--					if ct2.entities.has (a_member) then
--						Result := l_ancestors.item.name
--					end
					l_ancestors.forth
				end
			end
--		ensure
--			non_void_result: Result /= Void
		end
		

invariant
	non_void_comments_area: comments_area /= Void

end -- class DISPLAY_COMMENTS

