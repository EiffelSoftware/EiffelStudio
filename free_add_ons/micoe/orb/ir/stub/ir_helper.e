class IR_HELPER
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_GLOBALCONSTANTS;
    STANDARD_NARROW_HELPER

feature

    CORBA_Contained_narrow (o : CORBA_OBJECT) : CORBA_CONTAINED is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/Contained:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_CONTAINED_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/Contained:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_IDLType_narrow (o : CORBA_OBJECT) : CORBA_IDLTYPE is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/IDLType:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_IDLTYPE_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/IDLType:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ValueBoxDef_narrow (o : CORBA_OBJECT) : CORBA_VALUEBOXDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ValueBoxDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_VALUEBOXDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ValueBoxDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ValueDef_narrow (o : CORBA_OBJECT) : CORBA_VALUEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ValueDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_VALUEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ValueDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ValueMemberDef_narrow (o : CORBA_OBJECT) : CORBA_VALUEMEMBERDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ValueMemberDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_VALUEMEMBERDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ValueMemberDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_InterfaceDef_narrow (o : CORBA_OBJECT) : CORBA_INTERFACEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/InterfaceDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_INTERFACEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/InterfaceDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_OperationDef_narrow (o : CORBA_OBJECT) : CORBA_OPERATIONDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/OperationDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_OPERATIONDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/OperationDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_AttributeDef_narrow (o : CORBA_OBJECT) : CORBA_ATTRIBUTEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/AttributeDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_ATTRIBUTEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/AttributeDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ExceptionDef_narrow (o : CORBA_OBJECT) : CORBA_EXCEPTIONDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ExceptionDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_EXCEPTIONDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ExceptionDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ArrayDef_narrow (o : CORBA_OBJECT) : CORBA_ARRAYDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ArrayDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_ARRAYDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ArrayDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_SequenceDef_narrow (o : CORBA_OBJECT) : CORBA_SEQUENCEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/SequenceDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_SEQUENCEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/SequenceDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_FixedDef_narrow (o : CORBA_OBJECT) : CORBA_FIXEDDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/FixedDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_FIXEDDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/FixedDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_WstringDef_narrow (o : CORBA_OBJECT) : CORBA_WSTRINGDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/WstringDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_WSTRINGDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/WstringDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_StringDef_narrow (o : CORBA_OBJECT) : CORBA_STRINGDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/StringDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_STRINGDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/StringDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_PrimitiveDef_narrow (o : CORBA_OBJECT) : CORBA_PRIMITIVEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/PrimitiveDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_PRIMITIVEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/PrimitiveDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_NativeDef_narrow (o : CORBA_OBJECT) : CORBA_NATIVEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/NativeDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_NATIVEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/NativeDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_AliasDef_narrow (o : CORBA_OBJECT) : CORBA_ALIASDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/AliasDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_ALIASDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/AliasDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_EnumDef_narrow (o : CORBA_OBJECT) : CORBA_ENUMDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/EnumDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_ENUMDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/EnumDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_UnionDef_narrow (o : CORBA_OBJECT) : CORBA_UNIONDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/UnionDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_UNIONDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/UnionDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_StructDef_narrow (o : CORBA_OBJECT) : CORBA_STRUCTDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/StructDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_STRUCTDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/StructDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_TypedefDef_narrow (o : CORBA_OBJECT) : CORBA_TYPEDEFDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/TypedefDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_TYPEDEFDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/TypedefDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ConstantDef_narrow (o : CORBA_OBJECT) : CORBA_CONSTANTDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ConstantDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_CONSTANTDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ConstantDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_ModuleDef_narrow (o : CORBA_OBJECT) : CORBA_MODULEDEF is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/ModuleDef:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_MODULEDEF_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/ModuleDef:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_Container_narrow (o : CORBA_OBJECT) : CORBA_CONTAINER is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/Container:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_CONTAINER_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/Container:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_IRObject_narrow (o : CORBA_OBJECT) : CORBA_IROBJECT is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/IRObject:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_IROBJECT_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/IRObject:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

    CORBA_Repository_narrow (o : CORBA_OBJECT) : CORBA_REPOSITORY is

        local
            id : STRING

        do
            id := o.repoid
            if equal (id, "IDL:omg.org/CORBA/Repository:1.0") then
                if not local_objects.has (id) then
                    if o.simplified_is_a_remote (id) then
                        create {CORBA_REPOSITORY_STUB} result.make_with_peer (o)
                    elseif o.is_a_stub then
                        result ?= o
                    else
                        result ?= horb.bind (o, "local:")
                    end
                    local_objects.put (result, id)
                end -- if not local_objects.has (id) then ...
            end -- if equal (id, "IDL:omg.org/CORBA/Repository:1.0") then ...
            if result = void and then local_objects.has (id) then
                result ?= local_objects.at (id)
            end
        end

end -- class IR_HELPER
