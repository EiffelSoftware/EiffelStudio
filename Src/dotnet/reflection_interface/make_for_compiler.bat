cd %REFLECTION_INTERFACE%\ISE.Reflection.EiffelComponents\ace_file\EIFGEN\F_Code
del ISE.Reflection.EiffelComponents.tlb
del ISE.Reflection.EiffelComponents.idl
tlbexp ISE.Reflection.EiffelComponents.dll
REM Extract and process IDL
REM put result in %REFLECTION_INTERFACE%\ISE.Reflection.CodeGenerator\ace_file\EIFGEN\F_Code\ISE.Reflection.EiffelComponents.idl
call oleview ISE.Reflection.EiffelComponents.tlb
del ISE.Reflection.EiffelComponents.tlb
cd %REFLECTION_INTERFACE%\ISE.Reflection.CodeGenerator\ace_file\EIFGEN\F_Code
del ISE.Reflection.CodeGenerator.tlb
del ISE.Reflection.CodeGenerator.idl
tlbexp ISE.Reflection.CodeGenerator.dll
REM Extract and process IDL
REM put result in %REFLECTION_INTERFACE%\ISE.Reflection.CodeGenerator\ace_file\EIFGEN\F_Code\ISE.Reflection.CodeGenerator.idl
call oleview ISE.Reflection.CodeGenerator.tlb
call midl ISE.Reflection.EiffelComponents.idl
call midl ISE.Reflection.CodeGenerator.idl
REM Run wizard
rd /q /s generated
mkdir generated
call %ISE_EIFFEL%\wizards\com\com_wizard
REM Replace all occurrences of ECOM_VARIANT with POINTER_REF
